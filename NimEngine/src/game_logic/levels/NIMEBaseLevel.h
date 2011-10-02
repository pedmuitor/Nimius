//
//  NIMEBaseLevel.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class NIMEBaseActor;

@interface NIMEBaseLevel : NSObject {
    
    NSMutableDictionary *_loadedActors;
    
}

- (void)addActor:(NIMEBaseActor*)actor;

@end
