//
//  NIMEBasePhysicObject.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 08/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"

@interface NIMEBasePhysicObject : NSObject {
    
    NSUInteger _identifier;
    
    
}

@property (nonatomic, readonly) NSUInteger identifier;

- (id)initWithIdentifier:(NSUInteger)identifier;
- (void)addFixture:(NSDictionary*)fixtureDefinition;
- (void)addJoint:(NSDictionary*)jointDefinition;

@end
