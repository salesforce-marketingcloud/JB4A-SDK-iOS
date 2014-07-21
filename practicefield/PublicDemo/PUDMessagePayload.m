//
//  PUDMessagePayload.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDMessagePayload.h"

@implementation PUDMessagePayload

- (NSArray *)serializableProperties {
    return @[kPUDMessagePayloadMessageTextKey
             ,kPUDMessagePayloadDeviceTokensKey
             ,kPUDMessagePayloadOverrideKey
             ,kPUDMessagePayloadSoundKey
             ,kPUDMessagePayloadBadgeKey
             ,kPUDMessagePayloadTagsKey
             ,kPUDMessagePayloadOpenDirectKey
             ,kPUDMessagePayloadCustomKeysKey
             ];
}

- (NSDictionary *)serializableDictionary {
    NSMutableDictionary *ret = [[self dictionaryWithValuesForKeys:[self serializableProperties]] mutableCopy];
    
    // remove openDirect if message is not the right type
    if (self.pushMethod == kPushMethodAlertCloudPage) {
        [ret removeObjectForKey:kPUDMessagePayloadOpenDirectKey];
    }
    
    /**
     Remove any keys that have a <null> value
     */
    NSMutableArray *keysToRemove = [NSMutableArray array];
    [ret enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == [NSNull null]) {
            [keysToRemove addObject:key];
        }
    }];
    
    [keysToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [ret removeObjectForKey:obj];
    }];
    
    return ret;
}

@end
