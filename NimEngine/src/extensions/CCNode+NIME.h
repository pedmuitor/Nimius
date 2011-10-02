//
//  CCNode + NIME.h
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "NIMEEventManager.h"

@interface CCNode(NIME) <INIMEEventListener>

- (NSString*)identifier;
- (void)setIdentifier:(NSString*)identifier;
- (NSString*)name;
- (void)setName:(NSString*)name;
- (NSString*)renderedActorId;
- (void)setRenderedActorId:(NSString*)actorId;
- (BOOL)handleEvent:(NIMEEvent*)event;

@end
