//
//  NIMEBaseGraphicObject.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEBaseGraphicObject.h"

@implementation NIMEBaseGraphicObject

@synthesize identifier = _identifier;

- (id)initWithIdentifier:(NSUInteger)identifier
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _animations = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)addAnimation:(NSString *)animationName frames:(NSArray *)animationFrames {
    [_animations setObject:animationFrames forKey:animationName];
}

- (void)dealloc {
    NIME_RELEASE_SAFETY(_animations);
    [super dealloc];
}

@end
