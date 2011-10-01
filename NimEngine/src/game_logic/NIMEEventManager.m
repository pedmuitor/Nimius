//
//  EventManager.m
//  TestStrings
//
//  Created by Pedro Muiños Tortajada on 25/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEEventManager.h"

static const NIMEEventType const   sGlobalEventType = @"#any_event#";

@implementation NIMEEvent

@synthesize type        = _type;
@synthesize timeStamp   = _timeStamp;

- (id)init{
    return [self initWithTimeStamp:0.0];
}

- (id)initWithTimeStamp:(NSTimeInterval)timeStamp{
    if ((self = [super init])) {
        _timeStamp  = timeStamp;
    }
    return self;
}

- (void)dealloc{
    NIME_RELEASE_SAFETY(_type);
    [super dealloc];
}

@end


@interface NIMEEventManager (Private)
- (BOOL)hasListeners:(NIMEEvent*)event;
@end

@implementation NIMEEventManager

- (id)init{
    self = [super init];
    if (self) {
        _eventsTypes    = [[NSMutableSet alloc]init];
        _eventsMap      = [[NSMutableDictionary alloc] init];
        
        for (int i = 0; i < NIME_EVENT_MGR_N_QUEUES; ++i) {
            _eventsQueues[i] = [[NSMutableArray alloc] init];
        }
        _activeQueue    = 0;
    }
    
    return self;
}

- (void)dealloc{
    NIME_RELEASE_SAFETY(_eventsTypes);
    NIME_RELEASE_SAFETY(_eventsMap);
    for (int i = 0; i < NIME_EVENT_MGR_N_QUEUES; ++i) {
        NIME_RELEASE_SAFETY(_eventsQueues[i]);
    }
    [super dealloc];
}

- (BOOL)addGlobalListener:(NSObject <INIMEEventListener>*)listener{
    return [self addListener:listener forEventType:sGlobalEventType];
}


- (BOOL)removeGlobalListener:(NSObject <INIMEEventListener>*)listener{
    return [self removeListener:listener forEventType:sGlobalEventType];
}

- (BOOL)addListener:(NSObject <INIMEEventListener>*)listener forEventType:(NIMEEventType)type{
    BOOL result = NO;
    
    if ([self validateType:type]) {
        [_eventsTypes addObject:type];
        
        NSMutableArray  *listeners =[_eventsMap objectForKey:type];
        if (!listeners) {
            [_eventsMap setObject:[NSMutableArray array] forKey:type];
        }
        
        if (NSNotFound == [listeners indexOfObject:listener]) {
            [listeners addObject:listener];
            result  = YES;
        }
    }
    
    return result;
}

- (BOOL)removeListener:(NSObject <INIMEEventListener>*)listener forEventType:(NIMEEventType)type{
    BOOL result = NO;
    
    if ([self validateType:type]) {
        NSMutableArray   *listeners     = [_eventsMap objectForKey:type];
        NSUInteger  index               = [listeners indexOfObject:listener];
        
        if (index != NSNotFound) {
            [listeners removeObjectAtIndex:index];
            
            if (0 == [listeners count]) {
                [_eventsMap removeObjectForKey:type];
            }
            
            result  = YES;
        }
    }
    
    return result;
}

- (BOOL)removeListener:(NSObject <INIMEEventListener>*)listener{
    BOOL result = NO;
    
    NSArray *eventsTypes = [_eventsMap allKeys];
    for (NIMEEventType eventType in eventsTypes) {
        result|=[self removeListener:listener forEventType:eventType];
        
    }
    
    return result;
}

- (BOOL)triggerEvent:(NIMEEvent*)event{
    BOOL result = NO;
    NIMEEventType eventType = event.type;
    
    if ([self validateType:eventType]) {
        
        //Listeners of any event type won't mark events as handled
        NSMutableArray  *listeners   = [_eventsMap objectForKey:sGlobalEventType];
        for (NSObject <INIMEEventListener>* listener in listeners){
           [listener handleEvent:event];
        }
        
        listeners = [_eventsMap objectForKey:eventType];
        for (NSObject <INIMEEventListener>* listener in listeners){
            result |= [listener handleEvent:event];
        }
    }
    
    return result;
}

- (BOOL)queueEvent:(NIMEEvent*)event{
    BOOL result = NO;
    NIMEEventType eventType = event.type;
    
    if ([self validateType:eventType]) {
        if ([self hasListeners:event]) {
            
            result  = YES;
            [_eventsQueues[_activeQueue]addObject:event];
        }
    }
    
    return result;
}

- (BOOL)abortEvent:(NIMEEvent*)event allOfType:(BOOL)all{
    BOOL result = NO;
    NIMEEventType eventType = event.type;
    
    if ([self validateType:eventType]) {
        if ([self hasListeners:event]) {
            NSMutableArray  *activeQueue    = _eventsQueues[_activeQueue];
            NSInteger       lenght          = [activeQueue count];
            
            for (int i = 0; i < lenght; ++i) {
                NIMEEvent* queuedEvent   = [activeQueue objectAtIndex:i];
                if (queuedEvent.type == eventType) {
                    [activeQueue removeObjectAtIndex:i];
                    if (!all) {
                        break;
                    }
                }
            }
        }
    }
    
    return result;
}

- (BOOL)validateType:(NIMEEventType)eventType{
    return YES;
}

- (BOOL)tick:(NSTimeInterval)maxMilliseconds{
    BOOL result             = NO;
    
    NSTimeInterval curMs = (NSTimeInterval) time(NULL)*1000;
    NSTimeInterval limit = curMs + maxMilliseconds;
   
    NSMutableArray  *activeQueue = _eventsQueues[_activeQueue];
    _activeQueue    = (_activeQueue+1)%NIME_EVENT_MGR_N_QUEUES;
    [_eventsQueues[_activeQueue]removeAllObjects];
    
    while ([activeQueue count]>0) {
        NIMEEvent    *event = [[activeQueue objectAtIndex:0]retain];
        [activeQueue removeObjectAtIndex:0];
        [self triggerEvent:event];
        NIME_RELEASE_SAFETY(event);
        
        curMs = (NSTimeInterval) time(NULL)*1000;
        if (curMs >= limit) {
            break;
        }
    }
    
    if (0 == [activeQueue count]) {
        result  = YES;
    }else{
        NSMutableArray  *nextQueue = _eventsQueues[_activeQueue];
        while ([activeQueue count]>0) {
            NIMEEvent    *event = [activeQueue lastObject];
            [nextQueue addObject:event];
            [activeQueue removeLastObject];
        }
    }
    
    return result;
}

#pragma mark Private

- (BOOL)hasListeners:(NIMEEvent*)event{
    BOOL result = [[_eventsMap objectForKey:event.type] count] > 0 ||[[_eventsMap objectForKey:sGlobalEventType]count] > 0;
    return result;
}

@end
