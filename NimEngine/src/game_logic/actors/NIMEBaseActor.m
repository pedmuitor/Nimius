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

@interface NIMEBaseActor (Private)

- (NSMutableDictionary*)createBasicActorEventInfo;
- (void)enqueueBasicEventWithType:(NIMEEventType)eventType propertyOldValue:(id)oldValue propertyNewValue:(id)newValue;

@end

@implementation NIMEBaseActor

@synthesize identifier          = _identifier;
@synthesize name                = _name;
@synthesize type                = _type;
@synthesize rendererIdentifier  = _rendererIdentifier;
@synthesize physicalIdentifier  = _physicalIdentifier;

@synthesize visible             = _visible;
@synthesize position            = _position;
@synthesize rotation            = _rotation;
@synthesize scale               = _scale;
@synthesize flipX               = _flipX;
@synthesize flipY               = _flipY;
@synthesize zOrder              = _zOrder;

#pragma mark
#pragma Constructors & Destructors

- (id)initWithIdentifier:(NSUInteger)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
        [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_CREATED propertyOldValue:nil propertyNewValue:nil];
        
    }
    
    return self;
}


- (void)dealloc{
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_DESTROYED propertyOldValue:nil propertyNewValue:nil];
    NIME_RELEASE_SAFETY(_name);
    NIME_RELEASE_SAFETY(_type);
    [super dealloc];
}

#pragma mark
#pragma Propierties override

- (void)setPosition:(CGPoint)position{
    _position   = position;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_MOVED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:position]];
}

- (void)setRotation:(float)rotation{
    _rotation   = rotation;
     [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_ROTATED propertyOldValue:nil propertyNewValue:[NSNumber numberWithFloat:rotation]];
}

- (void)setScale:(CGPoint)scale{
    _scale      = scale;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_SCALED propertyOldValue:nil propertyNewValue:[NSValue valueWithCGPoint:scale]];
}

- (void) setFlipX:(BOOL)flipX{
    _flipX  = flipX;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_FLIPPED_X propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:flipX]];
}

- (void) setFlipY:(BOOL)flipY{
    _flipY  = flipY;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_FLIPPED_Y propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:flipY]];
}

- (void)setZOrder:(NSInteger)z{
    _zOrder = z;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED propertyOldValue:nil propertyNewValue:[NSNumber numberWithInt:z]];
}

- (void) setVisible:(BOOL)visible{
    _visible    = YES;
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_VISIBILITY_CHANGED propertyOldValue:nil propertyNewValue:[NSNumber numberWithBool:visible]];
}

#pragma mark
#pragma Public Methods

- (void)onEnter{
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_ENTERED propertyOldValue:nil propertyNewValue:nil];
}

- (void)onExit{
    [self enqueueBasicEventWithType:NIME_EVENT_TYPE_ACTOR_EXITED propertyOldValue:nil propertyNewValue:nil];
}

- (BOOL)hasRenderer{
    return _rendererIdentifier  > 0;
}

- (BOOL)hasPhysicalRepresentation{
    return _physicalIdentifier  > 0;
}
    
#pragma mark
#pragma Private Methods

- (NSMutableDictionary*)createBasicActorEventInfo{
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    
    [info setObject:[NSNumber numberWithUnsignedInt:_identifier] forKey:NIME_EVENT_ID_INFO_KEY];
    [info setObject:_type forKey:NIME_EVENT_TYPE_INFO_KEY];
    
    if ([self hasRenderer]) {
        [info setObject:[NSNumber numberWithUnsignedInt:_rendererIdentifier] forKey:NIME_EVENT_RENDERER_ID_INFO_KEY];
    }
    
    if ([self hasPhysicalRepresentation]) {
        [info setObject:[NSNumber numberWithUnsignedInt:_physicalIdentifier] forKey:NIME_EVENT_PHYSICAL_ID_INFO_KEY];
    }
    
    return info;
}

- (void)enqueueBasicEventWithType:(NIMEEventType)eventType propertyOldValue:(id)oldValue propertyNewValue:(id)newValue{
    
    NSMutableDictionary*    info = [self createBasicActorEventInfo];
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
    
#pragma INIMEEventListener Methods
    
- (BOOL) handleEvent:(NIMEEvent *)event{
    BOOL result = NO;
    return result;
}

@end
