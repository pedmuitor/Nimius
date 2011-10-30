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
        _name           = [aName copy];
        _loadedActors   = [[NSMutableDictionary alloc] init];
        
        _renderedIdentifier = -1;
        _physicalIdentifier = -1;
    }
    
    return self;
}

- (void)addActor:(NIMEBaseActor *)actor {
    [_loadedActors setObject:actor forKey:[NSNumber numberWithUnsignedInt:actor.identifier]];
}

- (void)dealloc {
    NIME_RELEASE_SAFETY(_name);
    NIME_RELEASE_SAFETY(_loadedActors);
    [super dealloc];
}

@end