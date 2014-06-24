//
//  PUDMessageProtocol.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/6/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PUDMessagePayload;

@protocol PUDMessageModelProtocol <NSObject>

/**
 Resets the message to a base state where override is set to TRUE and the badge update is set to "+0"
 */
- (void)resetMessagePayload;

/**
 Retruns a string describing what action the message object represents.
 */
- (NSString *)messageActionString;

/**
 Returns a string containing the rest path that will be called in order to send the message.
 */
- (NSString *)restPathString;

/**
 Returns a JSON string representation of the payload that will be specified when the route is POSTed to.
 */
- (NSString *)restPayloadString;

/**
 Returns a string description of the query string parameters required by the rest route.
 */
- (NSString *)parametersString;

/**
 Returns a message payload object representing the data of the sent message
 */
- (PUDMessagePayload *)messagePayload;

/**
 Initiates the fuel send message request that will result in a push message being sent to the device.
 */
- (void)sendMessage;

/**
 Returns a string if there is a validation problem with the current state of the message. If there is no problem then nil is returned
 */
- (NSString *)validationErrorMessage;

@end
