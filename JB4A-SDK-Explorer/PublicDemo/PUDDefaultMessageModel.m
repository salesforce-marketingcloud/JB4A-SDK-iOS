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
//  PUDDeviceTokenMessage.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/6/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDDefaultMessageModel.h"

// Models
#import "PUDMessagePayload.h"

// Services
#import "PUDServiceProvider.h"

// Views
#include "JDStatusBarNotification.h"

@interface PUDDefaultMessageModel()

@property (nonatomic, strong) PUDMessagePayload *messagePayload;

@end

@implementation PUDDefaultMessageModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initMessagePayload];
    }
    return self;
}

- (void)initMessagePayload {
    _messagePayload = [[PUDMessagePayload alloc] init];
    _messagePayload.override = @(YES);
    _messagePayload.badge = kPUDMessagePayloadDefaultBadgeValue;
    _messagePayload.sound = @"default";
    _messagePayload.pushMethod = kPushMethodAlert;
    [self setDeviceTokenOnMessagePayload];
}

- (void)resetMessagePayload {
    [self initMessagePayload];
}

- (NSString *)messageActionString {
    return @"Send Now";
}

- (NSString *)restPathString {
    return @"/push/v1/messageContact/{messageId}/send";
}

- (NSString *)parametersString {
    return @"messageId - the encoded id of the message that was created in the UI";
}

- (NSString *)restPayloadString {
    return [[self.messagePayload serializableDictionary] description];
}

- (NSString *)messageText {
    return self.messagePayload.messageText;
}

- (void)setMessageText:(NSString *)messageText {
    self.messagePayload.messageText = messageText;
}

- (void)sendMessage {
    
    /**
     Set device token to latest value before attempting a send
     */
    [self setDeviceTokenOnMessagePayload];
    
    /**
     Don't send the message if a device token hasn't been set yet
     */
    if (!self.messagePayload.deviceTokens || self.messagePayload.deviceTokens.count < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Device Token Not Received"
                                                        message:@"The send cannot proceed until a device token has been received from Apple. Ensure that the app is not running in the Simulator and that you have an internet connection. Then try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        [JDStatusBarNotification showWithStatus:@"Making fuel request..."
                                      styleName:JDStatusBarStyleDark];
        
        [[PUDServiceProvider fuelService] postMessageContactSendWithPayload:self.messagePayload
                                                                    success:^(id responseObject) {
                                                                        [JDStatusBarNotification showWithStatus:@"Success! Push incoming..."
                                                                                                   dismissAfter:2.0f
                                                                                                      styleName:JDStatusBarStyleDark];
                                                                    }
                                                                    failure:^(NSError *error) {
                                                                        [JDStatusBarNotification dismissAnimated:YES];
                                                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fuel Request Failed"
                                                                                                                        message:error.description
                                                                                                                       delegate:nil
                                                                                                              cancelButtonTitle:@"OK"
                                                                                                              otherButtonTitles:nil];
                                                                        [alert show];
                                                                    }];
    }
}

- (NSString *)validationErrorMessage {
    BOOL isMessageValid = YES;
    NSString *errorMessage = @"The following must be fixed:\n\n";
    
    if (!self.messagePayload.messageText || [self.messagePayload.messageText isEqualToString:@""]) {
        isMessageValid = NO;
        errorMessage = [errorMessage stringByAppendingString:@"\u2022 Message text cannot be blank"];
    }
    
    if (isMessageValid) {
        errorMessage = nil;
    }
    
    return errorMessage;
}

#pragma mark - non protocol methods

- (void)setDeviceTokenOnMessagePayload {
    NSString *deviceToken = [PUDUtility deviceToken];
    if (deviceToken) {
        _messagePayload.deviceTokens = @[deviceToken];
    }
}

@end
