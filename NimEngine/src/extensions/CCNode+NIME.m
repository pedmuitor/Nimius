//
//  CCNode + NIME.m
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <objc/runtime.h>

#import "CCNode+NIME.h"
#import "CCSprite.h"
#import "NIMEEventsTypes.h"

extern NIMEEventManager*    gEventManager;

static char key_identifier;
static char key_name;
static char key_rendered_actor_id;

@interface CCNode(NIME_Private)
- (BOOL)handleActorEvent:(NIMEEvent*)event;
@end

@implementation CCNode(NIME)

+ (void) load{
    //This will only affect to renderable CCNodes
    if ([self class] != [CCNode class]) {
        Method cc2dInit = class_getInstanceMethod([self class], NSSelectorFromString(@"init"));
        Method nimeInit = class_getInstanceMethod([self class], NSSelectorFromString(@"initNime"));
        method_exchangeImplementations(cc2dInit, nimeInit);  
    }
        
        Method cc2dDealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method nimeDealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"deallocNime"));
        method_exchangeImplementations(cc2dDealloc, nimeDealloc); 
}

- (id)initNime{
    [self initNime];
    if (self) {
        [gEventManager addListener:self forEventsTypes:NIME_EVENT_TYPE_ACTOR_MOVED,NIME_EVENT_TYPE_ACTOR_ROTATED,NIME_EVENT_TYPE_ACTOR_SCALED,NIME_EVENT_TYPE_ACTOR_FLIPPED_X,NIME_EVENT_TYPE_ACTOR_FLIPPED_Y,NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED,NIME_EVENT_TYPE_ACTOR_EXITED, nil];
    }
    return self;
}

- (void)deallocNime{
     objc_setAssociatedObject(self, &key_identifier, nil, OBJC_ASSOCIATION_COPY);
     objc_setAssociatedObject(self, &key_name, nil, OBJC_ASSOCIATION_COPY);
     objc_setAssociatedObject(self, &key_rendered_actor_id, nil, OBJC_ASSOCIATION_RETAIN);
    [self deallocNime];
}

- (NSString*)identifier{
    return (NSString*)objc_getAssociatedObject(self, &key_identifier);
}
- (void)setIdentifier:(NSString*)identifier{
     objc_setAssociatedObject(self, &key_identifier, identifier, OBJC_ASSOCIATION_COPY);
}

- (NSString*)name{
    return (NSString*)objc_getAssociatedObject(self, &key_name);
}

- (void)setName:(NSString*)name{
    objc_setAssociatedObject(self, &key_name, name, OBJC_ASSOCIATION_COPY);
}

- (NSString*)renderedActorId{
    return (NSString*)objc_getAssociatedObject(self, &key_rendered_actor_id);
}

- (void)setRenderedActorId:(NSString*)actorId{
    objc_setAssociatedObject(self, &key_rendered_actor_id, actorId, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)handleEvent:(NIMEEvent*) event{
    BOOL result = NO;

    if (NIME_EVENT_IS_TYPE_ACTOR(event)) {
        result = [self handleActorEvent:event];
    }
     
    return result;
}

#pragma mark
#pragma mark Private Methods

- (BOOL)handleActorEvent:(NIMEEvent*)event{
    BOOL result = NO;
    
    NSString    *renderedActorId    = [self renderedActorId];
    
    NSMutableDictionary *eventInfo  = event.info;
    NSString    *actorId            = [eventInfo objectForKey:NIME_EVENT_ID_INFO_KEY];
    
    
    
    if ([actorId isEqual:renderedActorId]) {
        id newValue                     = [eventInfo objectForKey:NIME_EVENT_NEW_PROPERTY_VALUE_INFO_KEY];
        
        if ([event.type isEqual:NIME_EVENT_TYPE_ACTOR_MOVED]) {
            CGPoint newPosition = [(NSValue*)newValue CGPointValue];
            self.position       = newPosition;
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_ROTATED]) {
            CGFloat newRotation = [(NSNumber*)newValue floatValue];
            self.rotation       = newRotation;
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_SCALED]){
            CGPoint newScale    = [(NSValue*)newValue CGPointValue];
            self.scaleX         = newScale.x;
            self.scaleY         = newScale.y;
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_FLIPPED_X] && [self isKindOfClass:[CCSprite class]]){
            BOOL flipX = [(NSNumber*)newValue boolValue];
            [(CCSprite*)self setFlipX:flipX];
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_FLIPPED_Y] && [self isKindOfClass:[CCSprite class]]){
            BOOL flipY = [(NSNumber*)newValue boolValue];
            [(CCSprite*)self setFlipY:flipY];
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED]){
            NSInteger           newZIndex = [(NSNumber*)newValue intValue];
            [self.parent reorderChild:self z:newZIndex];
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED]){
            BOOL           visible  = [(NSNumber*)newValue boolValue];
            self.visible            = visible;
        }else if([event.type isEqual:NIME_EVENT_TYPE_ACTOR_EXITED]){
            [gEventManager removeListener:self];
        }
    }
    
    return result;
}

@end
