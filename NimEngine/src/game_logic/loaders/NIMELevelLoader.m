//
//  NIMELevelLoader.m
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NIMEActorLoader.h"
#import "NIMEBaseActor.h"
#import "NIMEBaseLevel.h"
#import "NIMEGraphicsLoader.h"
#import "NIMELevelLoader.h"
#import "NIMEBaseScene.h"

@implementation NIMELevelLoader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NIMEBaseLevel*)loadLevelFromData:(NSDictionary *)data {

    NIMEBaseLevel *result = nil;
    
#warning TODO: cambiar por singletons
    NIMEGraphicsLoader *graphicsLoader  = [[NIMEGraphicsLoader alloc] init];
    NIMEActorLoader *actorLoader        = [[NIMEActorLoader alloc] init];
    
    NSString *levelName     = [data objectForKey:LEVEL_CONFIGURATION_KEY_LEVEL_NAME];
    //NSString *levelClass    = [data objectForKey:LEVEL_CONFIGURATION_KEY_LEVEL_CLASS];
    //NSString *terrainClass  = [data objectForKey:LEVEL_CONFIGURATION_KEY_TERRAIN_CLASS];
    
    NSArray  *actorList     = [data objectForKey:LEVEL_CONFIGURATION_KEY_ACTOR_LIST];
    
#warning TODO: inicializar con la clase correcta
    result = [[NIMEBaseLevel alloc] initWithName:levelName];
    
    NIMEBaseScene *scene;
    scene = [graphicsLoader loadSceneFromData:data];
    [result setRenderedIdentifier:scene.identifier];
    
    NIMEBaseActor *actor;
    for (NSDictionary *actorData in actorList) {
        actor    = [actorLoader loadActorFromData:actorData];
        [result addActor:actor];
    }
    return result;
}

@end
