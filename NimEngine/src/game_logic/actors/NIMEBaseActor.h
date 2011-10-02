//
//  NIMEBaseActor.h
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "NIMEEventManager.h"

typedef NSString*   NIMEActorType;

@interface NIMEBaseActor : NSObject <INIMEEventListener>{
    NSUInteger      _identifier;
    NSString*       _name;
    NIMEActorType   _type;
    NSUInteger      _rendererIdentifier;
    NSUInteger      _physicalIdentifier;
    
    BOOL            _visible;
    CGPoint         _position;
    CGFloat         _rotation;
    CGPoint         _scale;
    BOOL            _flipX;
    BOOL            _flipY;
    NSInteger       _zOrder;
}


@property (nonatomic, assign)NSUInteger     identifier;
@property (nonatomic, copy)NSString*        name;
@property (nonatomic,readonly)NIMEActorType type;
@property (nonatomic, assign)NSUInteger     rendererIdentifier;
@property (nonatomic, assign)NSUInteger     physicalIdentifier;

@property (nonatomic, assign)BOOL           visible;
@property (nonatomic, assign)CGPoint        position;
@property (nonatomic, assign)CGFloat        rotation;
@property (nonatomic, assign)CGPoint        scale;
@property (nonatomic, assign)BOOL           flipX;
@property (nonatomic, assign)BOOL           flipY;
@property (nonatomic, assign)NSInteger      zOrder;

- (void)onEnter;
- (void)onExit;
- (BOOL)hasRenderer;
- (BOOL)hasPhysicalRepresentation;

@end
