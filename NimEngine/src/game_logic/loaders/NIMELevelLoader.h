//
//  NIMELevelLoader.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define LEVEL_CONFIGURATION_KEY_LEVEL_NAME          @"levelName"
#define LEVEL_CONFIGURATION_KEY_LEVEL_CLASS         @"levelClass"
#define LEVEL_CONFIGURATION_KEY_TERRAIN_CLASS       @"terrainClass"
#define LEVEL_CONFIGURATION_KEY_ACTOR_LIST          @"actorList"

@class NIMEBaseLevel;

@interface NIMELevelLoader : NSObject

- (NIMEBaseLevel*)loadLevelFromData:(NSDictionary*)data;

@end
