//
//  NIMELevelLoader.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class NIMEBaseLevel;

@interface NIMELevelLoader : NSObject

- (NIMEBaseLevel*)loadLevelFromData:(NSDictionary*)data;

@end
