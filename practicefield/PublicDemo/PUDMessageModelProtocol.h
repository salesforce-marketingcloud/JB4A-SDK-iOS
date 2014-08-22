/**
 * Copyright (c) 2014 ExactTarget, Inc.
 * All rights reserved.
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
