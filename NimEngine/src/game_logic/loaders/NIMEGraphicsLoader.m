//
//  NIMEGraphicsLoader.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "CCNode+NIME.h"
#import "NIMEBaseScene.h"
#import "NIMEBaseGraphicObject.h"
#import "NIMEGraphicsLoader.h"

static NSUInteger identifier    = 0;

@implementation NIMEGraphicsLoader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NIMEBaseGraphicObject*)loadGraphicObjectFromData:(NSDictionary *)data {
    NIMEBaseGraphicObject  *result  = nil;

    result = [[NIMEBaseGraphicObject alloc] initWithIdentifier:++identifier];
    
    NSDictionary *animations = [data objectForKey:GRAPHIC_OBJECT_CONFIGURATION_KEY_ANIMATIONS];
    for (NSString *animationName in animations) {
        NSArray *animationFrames = [animations objectForKey:animationName];
        [result addAnimation:animationName frames:animationFrames];
    }
    
    return [result autorelease];
}

- (NIMEBaseScene*)loadSceneFromData:(NSDictionary *)data {
    
    NIMEBaseScene *result = nil;
    
    result = [[NIMEBaseScene alloc] initWithIdentifier:++identifier];
    
    NSArray *layers = [data objectForKey:GRAPHIC_OBJECT_CONFIGURATION_KEY_BACKGROUND_LAYERS];
    NIMEBaseSceneBackgroundLayer *layer;
    
    NSArray *layerImages;
    NSArray *layerPositions;
    CGPoint layerParallax;
    
    int i = 0;
    for (NSDictionary *layerData in layers) {
        
        layerImages     = [layerData objectForKey:GRAPHIC_OBJECT_CONFIGURATION_KEY_LAYER_IMAGES];
        layerPositions  = [layerData objectForKey:GRAPHIC_OBJECT_CONFIGURAITON_KEY_LAYER_POSITIONS];
        layerParallax   = [(NSValue*)[layerData objectForKey:GRAPHIC_OBJECT_CONFIGURATION_KEY_LAYER_PARALLAX] CGPointValue];
        
        layer = [[NIMEBaseSceneBackgroundLayer alloc] initWithImages:layerImages positions:layerPositions];
        [result addBackgroundLayer:layer zIndex:i++ parallaxRatio:layerParallax];
        [layer release];
    }
    
    return result;
}

@end
