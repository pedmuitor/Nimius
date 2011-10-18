//
//  NIMEActorLoader.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEActorLoader.h"
#import "NIMEBaseActor.h"

#define CONFIGURATION_KEY_NAME @"name"

@implementation NIMEActorLoader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NIMEBaseActor*)loadActorFromData:(NSDictionary*)data {
    
    static NSUInteger identifier    = 0;
    
    NIMEBaseActor* result           = nil;
    
    result = [[NIMEBaseActor alloc] initWithIdentifier:++identifier];
#warning TODO implementar loader
    
    return [result autorelease];
}

@end
