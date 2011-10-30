//
//  NIMEBaseLevel.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class NIMEBaseActor;
@class NIMEBackgroundLayer;

@interface NIMEBaseLevel : NSObject {
    
    NSString            *_name;
    NSMutableDictionary *_loadedActors;
    
    NSUInteger          _renderedIdentifier;
    NSUInteger          _physicalIdentifier;
}

@property (nonatomic, readonly) NSString    *name;
@property (nonatomic, assign)   NSUInteger  renderedIdentifier;
@property (nonatomic, assign)   NSUInteger  physicalIdentifier;

- (id)initWithName:(NSString*)aName;
- (void)addActor:(NIMEBaseActor*)actor;

@end