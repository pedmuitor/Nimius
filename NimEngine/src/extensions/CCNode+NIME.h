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

- (NSUInteger)identifier;
- (void)setIdentifier:(NSUInteger)identifier;
- (BOOL)handleEvent:(NIMEEvent*)event;

@end
