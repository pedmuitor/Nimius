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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)addActor:(NIMEBaseActor *)actor {
    
    static NSUInteger identifier;
    
    if (actor.identifier != 0) {
        //Trying to add an added actor
    }
    else {
        //Adding new actor
        actor.identifier = ++identifier;
        [_loadedActors setObject:actor forKey:[NSNumber numberWithUnsignedInt:actor.identifier]];
    }
}

@end
