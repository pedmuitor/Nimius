//
//  NIMEBaseScene.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 30/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEBaseScene.h"

@implementation NIMEBaseScene

@synthesize identifier = _identifier;

- (id)initWithIdentifier:(NSUInteger)identifier {
    
    if (self = [super init]) {
        
        _identifier         = identifier;
        _background         = [[CCParallaxNode alloc] init];
        _cameraNode         = [[CCNode alloc] init];
    }
    
    return self;
}

#pragma mark CCScene overwritten methods

- (void)onEnter {
    [self runAction:[CCFollow actionWithTarget:_cameraNode]];
}

#pragma mark Public methods

- (void)addBackgroundLayer:(NIMEBaseSceneBackgroundLayer*)backgroundLayer zIndex:(NSUInteger)zIndex parallaxRatio:(CGPoint)parallaxRatio {
    
    [_background addChild:backgroundLayer z:zIndex parallaxRatio:parallaxRatio positionOffset:CGPointZero];
}

- (void)dealloc {
    NIME_RELEASE_SAFETY(_background);
    NIME_RELEASE_SAFETY(_cameraNode);
    [super dealloc];
}

@end

@implementation NIMEBaseSceneBackgroundLayer

- (id)initWithImage:(NSString *)image position:(CGPoint)position {
    return [self initWithImages:[NSArray arrayWithObject:image] positions:[NSArray arrayWithObject:[NSValue valueWithCGPoint:position]]];
}

- (id)initWithImages:(NSArray *)images positions:(NSArray *)positions {
    
    self = [super init];
    if (self) {
        
        int nImages = [images count];
        NSAssert(nImages == [positions count], @"Number of images is different of positions");
        
        CCSprite *node;
        NSString *image;
        CGPoint  position;
        for (int i = 0; i < nImages; i++) {
            image     = [images objectAtIndex:i];
            position  = [(NSValue*)[positions objectAtIndex:i] CGPointValue];
            
            node = [CCSprite spriteWithFile:image];
            node.position = position;
            
            [self addChild:node];
        }
        
    }
    return self;
}

@end
