//
//  MyClass.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 08/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class NIMEBasePhysicObject;

@interface NIMEPhysicsManager : NSObject {
    
}

- (void)step:(float)dt;
- (void)addPhysicObject:(NIMEBasePhysicObject*)physicObject;

@end
