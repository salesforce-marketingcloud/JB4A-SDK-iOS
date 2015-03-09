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
//  PUDMessagePayload.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDMessagePayload : NSObject

typedef enum {
    kPushMethodAlert,
    kPushMethodAlertCloudPage
} PushMethod;

/**
 The text that will be sent as the message.
 */
@property (nonatomic, strong) NSString *messageText;

/**
 YES if the message text of the originally created message will be overridden, NO if the original message text should be used.
 */
@property (nonatomic, strong) NSNumber *override;

/**
 An array containing the device tokens of devices that should be sent the message.
 */
@property (nonatomic, strong) NSArray *deviceTokens;

/**
 The custom sound that should be played on the device when a message is received
 */
@property (nonatomic, strong) NSString *sound;

/**
 String representing how much to increment or decrement the badge count
 */
@property (nonatomic, strong) NSString *badge;

/**
 An array containing the tags that the message should be sent to
 */
@property (nonatomic, strong) NSArray *inclusionTags;

/**
 String value of the OpenDirect payload
 */
@property (nonatomic, strong) NSString *openDirect;

/**
 Dictionary of custom keys that can be sent inside the push payload
 */
@property (nonatomic, strong) NSDictionary *customKeys;

/**
 The push message type
 */
@property (nonatomic) PushMethod pushMethod;

/**
 The name of the properties on the object should be serialized.
 */
- (NSArray *)serializableProperties;

/**
 Returns a dictionary containing the property values identified by each of the keys inside the serializableProperties method.
 */
- (NSDictionary *)serializableDictionary;

@end
