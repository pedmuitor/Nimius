//
//  NIMEBaseLevel.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode+NIME.h"
#import "NIMEBaseActor.h"
#import "NIMEBaseLevel.h"

@implementation NIMEBaseLevel

@synthesize name                = _name;
@synthesize renderedIdentifier  = _renderedIdentifier;
@synthesize physicalIdentifier  = _physicalIdentifier;

- (id)initWithName:(NSString *)aName
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _backgroundLayers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addBackgroundLayer:(NIMEBackgroundLayer *)backgroundLayer {
    [_backgroundLayers addObject:backgroundLayer];
}

- (void)addActor:(NIMEBaseActor *)actor {
    [_loadedActors setObject:actor forKey:[NSNumber numberWithUnsignedInt:actor.identifier]];
}

- (void)dealloc {
    NIME_RELEASE_SAFETY(_name);
    NIME_RELEASE_SAFETY(_loadedActors);
    NIME_RELEASE_SAFETY(_backgroundLayers);
    [super dealloc];
}

@end


@implementation NIMEBackgroundLayer

@synthesize renderedIdentifier = _renderedIdentifier;

- (id)initWithImages:(NSArray *)images positions:(NSArray *)positions layerParllax:(float)layerParallax {
    if (self = [super init]) {
        
        NSAssert([images count] == [positions count], @"Number of images is different from positions");
        
        _images             = [images retain];
        _imagesPositions    = [positions retain];
        _layerParallax      = layerParallax;
    }
    
    return self;
}

- (void)dealloc {
    NIME_RELEASE_SAFETY(_images);
    NIME_RELEASE_SAFETY(_imagesPositions);
    [super dealloc];
}

@end