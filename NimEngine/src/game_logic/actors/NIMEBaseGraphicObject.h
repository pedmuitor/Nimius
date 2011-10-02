//
//  NIMEBaseGraphicObject.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"

@interface NIMEBaseGraphicObject : CCSprite {
    
    NSMutableDictionary *_animations;
    
}

- (void)addAnimation:(NSString*)animationName frames:(NSArray*)animationFrames;

@end
