//
//  PUDFuelServiceProtocol.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PUDMessagePayload;

@protocol PUDFuelServiceProtocol <NSObject>

/**
 Makes a message contact api request using the data provided inside the PUDMessagePayload object.
 
 @param payload PUDMessagePayload object that will be serializable to JSON and specified as the post data.
 @param success The block that will be called if the request succeeds.
 @param failure The block that will be called if the request fails.
 */
- (void)postMessageContactSendWithPayload:(PUDMessagePayload *)payload
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError *error))failure;

@end
