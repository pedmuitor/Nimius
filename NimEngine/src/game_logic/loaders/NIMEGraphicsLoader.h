//
//  NIMEGraphicsLoader.h
//  NimEngine
//
//  Created by Jesús Bartús Sancho on 02/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define GRAPHIC_OBJECT_CONFIGURATION_KEY_ANIMATIONS         @"animations"
#define GRAPHIC_OBJECT_CONFIGURATION_KEY_BACKGROUND_LAYERS  @"backgroundLayers"
#define GRAPHIC_OBJECT_CONFIGURATION_KEY_LAYER_IMAGES       @"images"
#define GRAPHIC_OBJECT_CONFIGURAITON_KEY_LAYER_POSITIONS    @"positions"
#define GRAPHIC_OBJECT_CONFIGURATION_KEY_LAYER_PARALLAX     @"parallaxRatio"



@class NIMEBaseGraphicObject;
@class NIMEBaseScene;

@interface NIMEGraphicsLoader : NSObject

- (NIMEBaseGraphicObject*)loadGraphicObjectFromData:(NSDictionary*)data;
- (NIMEBaseScene*)loadSceneFromData:(NSDictionary*)data;

@end
