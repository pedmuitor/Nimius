//
//  NIMEBaseGraphicObject.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"

@interface NIMEBaseGraphicObject : CCSprite {
    
    NSUInteger          _identifier;
    NSMutableDictionary *_animations;
    
}

@property (nonatomic, readonly) NSUInteger identifier;

- (id)initWithIdentifier:(NSUInteger)identifier;
- (void)addAnimation:(NSString*)animationName frames:(NSArray*)animationFrames;

@end
