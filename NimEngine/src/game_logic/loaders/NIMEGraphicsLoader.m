//
//  NIMEGraphicsLoader.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "CCNode+NIME.h"
#import "NIMEBaseGraphicObject.h"
#import "NIMEGraphicsLoader.h"

#define CONFIGURATION_KEY_ANIMATIONS @"animations"

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
    static NSUInteger identifier    = 0;

    result = [[NIMEBaseGraphicObject alloc] init];
    result.identifier = ++identifier;
    
    NSDictionary *animations = [data objectForKey:CONFIGURATION_KEY_ANIMATIONS];
    for (NSString *animationName in animations) {
        NSArray *animationFrames = [animations objectForKey:animationName];
        [result addAnimation:animationName frames:animationFrames];
    }
    
    return [result autorelease];
}

@end
