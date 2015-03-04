/**
 * Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation and/or
 * other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//
//  PUDMessagePayload.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
