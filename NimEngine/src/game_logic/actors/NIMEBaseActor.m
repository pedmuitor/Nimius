//
//  NIMEBaseActor.m
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "CCNode+NIME.h"
#import "NIMEBaseActor.h"
#import "NIMEEventsTypes.h"

extern NIMEEventManager*    gEventManager;

@implementation NIMEBaseActor

@synthesize type    = _type; 
@synthesize flipX   = _flipX;
@synthesize flipY   = _flipY;

#pragma mark
#pragma mark Constructors & Destructors

- (id)init{
    self = [super init];
    if (self) {
          [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_CREATED propertyOldValue:nil propertyNewValue:nil];
    }
    
    return self;
}

- (void)dealloc{
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_DESTROYED propertyOldValue:nil propertyNewValue:nil];
    NIME_RELEASE_SAFETY(_type);
    [super dealloc];
}

#pragma mark
#pragma mark Propierties override

- (void)setPosition:(CGPoint)position{
    [super setPosition:position];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_MOVED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:position]];
}

- (void)setRotation:(float)rotation{
    [super setRotation:rotation];
     [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_ROTATED propertyOldValue:nil propertyNewValue:[NSNumber numberWithFloat:rotation]];
}

- (void)setScale:(float)scale{
    [super setScale:scale];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_SCALED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:CGPointMake(scale, scale)]];
}

- (void)setScaleX:(float)scaleX{
    [super setScaleX:scaleX];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_SCALED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:CGPointMake(scaleX_, scaleY_)]];
}

- (void)setScaleY:(float)scaleY{
    [super setScaleY:scaleY];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_SCALED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:CGPointMake(scaleX_, scaleY_)]];
}

- (void) setFlipX:(BOOL)flipX{
    _flipX  = flipX;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_FLIPPED_X propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:flipX]];
}

- (void) setFlipY:(BOOL)flipY{
    _flipY  = flipY;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_FLIPPED_Y propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:flipY]];
}

- (void)_setZOrder:(NSInteger)z{
    [super _setZOrder:z];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED propertyOldValue:nil propertyNewValue:[NSNumber numberWithInt:z]];
}

- (void) setVisible:(BOOL)visible{
    [super setVisible:visible];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_VISIBILITY_CHANGED propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:visible]];
}

#pragma mark
#pragma mark CCNode Methods override

- (void)onEnter{
    [super onEnter];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_ENTERED propertyOldValue:nil propertyNewValue:nil];
}

- (void)onExit{
    [super onExit];
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_EXITED propertyOldValue:nil propertyNewValue:nil];
}


#pragma mark
#pragma Public Methods

- (NSMutableDictionary*)createBasicActorEventInfo:(NSUInteger)parametersCount{
    NSMutableDictionary* info = [NSMutableDictionary dictionaryWithCapacity:parametersCount];
    [info setObject:[self identifier] forKey:NIME_EVENT_ID_INFO_KEY];
    [info setObject:_type forKey:NIME_EVENT_TYPE_INFO_KEY];
    return info;
}

- (void)enqueueBasicEventWithType:(NIMEEventType)eventType propertyOldValue:(id)oldValue propertyNewValue:(id)newValue{
    
    NSMutableDictionary*    info = [self createBasicActorEventInfo:4];
    if (oldValue) {
        [info setObject:oldValue forKey:NIME_EVENT_OLD_PROPERTY_VALUE_INFO_KEY];
    }
    if (newValue) {
        [info setObject:newValue forKey:NIME_EVENT_NEW_PROPERTY_VALUE_INFO_KEY];
    }

    
    NIMEEvent   *event  = [[NIMEEvent alloc] init];
    event.type          = eventType;
    event.info     = info;
    [gEventManager queueEvent:event];
    NIME_RELEASE_SAFETY(event);
}

@end
