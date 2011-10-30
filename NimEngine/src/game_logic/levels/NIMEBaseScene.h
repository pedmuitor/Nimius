//
//  NIMEBaseScene.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 30/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CCScene.h"

@class NIMEBaseSceneBackgroundLayer;

@interface NIMEBaseScene : CCScene {
    
    NSUInteger      _identifier;
    
    CCParallaxNode *_background;
    NSMutableArray *_backgroundLayers;
    
    CCNode         *_cameraNode;
}

@property (nonatomic, readonly) NSUInteger identifier;

- (id)initWithIdentifier:(NSUInteger)identifier;
- (void)addBackgroundLayer:(NIMEBaseSceneBackgroundLayer*)backgroundLayer zIndex:(NSUInteger)zIndex parallaxRatio:(CGPoint)parallaxRatio;

@end


@interface NIMEBaseSceneBackgroundLayer : CCNode {
    
    NSMutableArray *_backgroundSprites;
}

- (id)initWithImage:(NSString*)image position:(CGPoint)position;
- (id)initWithImages:(NSArray*)images positions:(NSArray*)positions;

@end
