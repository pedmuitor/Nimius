//
//  NIMEPhysicsLoader.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEBasePhysicObject.h"
#import "NIMEPhysicsLoader.h"

@implementation NIMEPhysicsLoader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NIMEBasePhysicObject*)loadPhysicObjecFromData:(NSDictionary *)data {
    
    static NSUInteger identifier = 0;
    
    NIMEBasePhysicObject *result = [[NIMEBasePhysicObject alloc] initWithIdentifier:++identifier];
    
    
    return [result autorelease];
}

@end
