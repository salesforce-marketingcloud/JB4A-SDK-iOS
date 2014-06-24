//
//  PUDMessagePayload.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDMessagePayload : NSObject

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
 The name of the properties on the object should be serialized.
 */
- (NSArray *)serializableProperties;

/**
 Returns a dictionary containing the property values identified by each of the keys inside the serializableProperties method.
 */
- (NSDictionary *)serializableDictionary;

@end
