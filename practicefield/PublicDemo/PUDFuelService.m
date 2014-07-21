//
//  PUDFuelService.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
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
                   numberOfRetries:3
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
