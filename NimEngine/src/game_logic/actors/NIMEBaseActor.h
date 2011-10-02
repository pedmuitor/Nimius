//
//  NIMEBaseActor.h
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "NIMEEventManager.h"

typedef NSString*   NIMEActorType;

@interface NIMEBaseActor : CCNode{
    NIMEActorType   _type;  
    
    BOOL            _flipX;
    BOOL            _flipY;
}

@property (nonatomic,readonly)NIMEActorType type;
@property (nonatomic, assign)BOOL           flipX;
@property (nonatomic, assign)BOOL           flipY;

- (NSMutableDictionary*)createBasicActorEventInfo:(NSUInteger)parametersCount;
- (void)enqueueBasicEventWithType:(NIMEEventType)eventType propertyOldValue:(id)oldValue propertyNewValue:(id)newValue;

@end
