//
//  NIMEEventsTypes.h
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


//---------------------
// GENERIC INFO KEYS
//---------------------
#define NIME_EVENT_ID_INFO_KEY                  @"id"
#define NIME_EVENT_TYPE_INFO_KEY                @"type"
#define NIME_EVENT_OLD_PROPERTY_VALUE_INFO_KEY  @"old_value"
#define NIME_EVENT_NEW_PROPERTY_VALUE_INFO_KEY  @"new_value"


//---------------------
// ACTOR EVENTS TYPES & KEYS
//---------------------
#define NIME_EVENT_TYPE_ACTOR_PREFIX                @"actor_"
#define NIME_EVENT_IS_TYPE_ACTOR(event)             [event.type hasPrefix:NIME_EVENT_TYPE_ACTOR_PREFIX]
#define NIME_EVENT_TYPE_ACTOR_CREATED               @"actor_created"
#define NIME_EVENT_TYPE_ACTOR_DESTROYED             @"actor_destroyed"
#define NIME_EVENT_TYPE_ACTOR_ENTERED               @"actor_entered"
#define NIME_EVENT_TYPE_ACTOR_EXITED                @"actor_exited"
#define NIME_EVENT_TYPE_ACTOR_MOVED                 @"actor_moved"
#define NIME_EVENT_TYPE_ACTOR_ROTATED               @"actor_rotated"
#define NIME_EVENT_TYPE_ACTOR_SCALED                @"actor_scaled"
#define NIME_EVENT_TYPE_ACTOR_FLIPPED_X             @"actor_flipped_x"
#define NIME_EVENT_TYPE_ACTOR_FLIPPED_Y             @"actor_flipped_y"
#define NIME_EVENT_TYPE_ACTOR_Z_ORDED_CHANGED       @"actor_z_order_changed"
#define NIME_EVENT_TYPE_ACTOR_VISIBILITY_CHANGED    @"actor_visibility_changed"
#define NIME_EVENT_RENDERER_ID_INFO_KEY             @"renderer_id"
#define NIME_EVENT_PHYSICAL_ID_INFO_KEY             @"physical_id"




