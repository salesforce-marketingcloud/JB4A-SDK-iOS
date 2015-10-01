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
//  PUDFuelService.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDFuelService.h"

// Categories
#import "AFHTTPRequestOperationManager+AuthenticatedFuelRequest.h"

// Libraries
#import "AFNetworking.h"

// Models
#import "PUDMessagePayload.h"

@interface PUDFuelService()

@end

@implementation PUDFuelService

NSString *messageContactURLString = @"https://www.exacttargetapis.com/push/v1/messageContact/%@/send";

- (void)postMessageContactSendWithPayload:(PUDMessagePayload *)payload
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure {
    
    /**
     *  Get the message id to use in URL
     */
    NSString *messageId = nil;
    if (payload.pushMethod == kPushMethodAlert) {
        messageId = [PUDUtility messageIdVanilla];
    }
    else if (payload.pushMethod == kPushMethodAlertCloudPage) {
        messageId = [PUDUtility messageIdCloudPage];
    }
    
    NSString *urlString = [NSString stringWithFormat:messageContactURLString, messageId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager fuelRequestWithMethod:@"POST"
                   numberOfRetries:1
                         URLString:urlString
                        parameters:[payload serializableDictionary]
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSLog(@"== API SUCCESS ==");
                               if (success) {
                                   success(responseObject);
                               }
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"== API FAILED ==\n\n%@\n\n%@\n\n", operation.description, error);
                               if (failure) {
                                   failure(error);
                               }
                           }];
}

@end
