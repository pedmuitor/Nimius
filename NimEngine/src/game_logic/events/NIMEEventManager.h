//
//  EventManager.h
//  TestStrings
//
//  Created by Pedro Muiños Tortajada on 25/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define NIME_EVENT_MGR_N_QUEUES  2

typedef NSString*   NIMEEventType;

@interface NIMEEvent:NSObject{
    NIMEEventType           _type;
    NSTimeInterval          _timeStamp;
    NSMutableDictionary*    _info;
}
@property (nonatomic, copy)NIMEEventType            type;
@property (nonatomic, assign)NSTimeInterval         timeStamp;
@property (nonatomic, retain)NSMutableDictionary* info;

- (id)initWithTimeStamp:(NSTimeInterval)timeStamp;

@end

@protocol INIMEEventListener <NSObject>
- (NSUInteger)identifier;
- (BOOL)handleEvent:(NIMEEvent*) event;
@end

@interface NIMEEventManager : NSObject{
    NSMutableSet*           _eventsTypes;
    NSMutableDictionary*    _eventsMap;
    NSMutableArray*         _eventsQueues[NIME_EVENT_MGR_N_QUEUES];
    NSInteger               _activeQueue;
}

- (BOOL)addGlobalListener:(NSObject <INIMEEventListener>*)listener;
- (BOOL)removeGlobalListener:(NSObject <INIMEEventListener>*)listener;
- (BOOL)addListener:(NSObject <INIMEEventListener>*)listener forEventType:(NIMEEventType)type;
- (BOOL)addListener:(NSObject <INIMEEventListener>*)listener forEventsTypes:(NIMEEventType)type1, ... NS_REQUIRES_NIL_TERMINATION;
- (BOOL)removeListener:(NSObject <INIMEEventListener>*)listener forEventType:(NIMEEventType)type;
- (BOOL)removeListener:(NSObject <INIMEEventListener>*)listener forEventsTypes:(NIMEEventType)type1, ... NS_REQUIRES_NIL_TERMINATION;
- (BOOL)removeListener:(NSObject <INIMEEventListener>*)listener;
- (BOOL)triggerEvent:(NIMEEvent*)event;
- (BOOL)queueEvent:(NIMEEvent*)event;
- (BOOL)abortEvent:(NIMEEvent*)event allOfType:(BOOL)all;
- (BOOL)validateType:(NIMEEventType)eventType;
- (BOOL)tick:(NSTimeInterval)maxMilliseconds;

@end

NIMEEventManager*   gEventManager;
