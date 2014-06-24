//
//  AFHTTPRequestOperationManager+AuthenticatedFuelRequest.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

/**
 *  This is not required for the SDK to work properly. This is used to make the Fuel api calls that initiate message sends directly from a device
 */
@interface AFHTTPRequestOperationManager (AuthenticatedFuelRequest)

/**
 Makes an authenticated fuel request by using the credentials that are present in a file named settings.plist. If the file is not present and this method is called an exception will occur. Using the credentials, this will request an access token from the Fuel service and save the access token into NSUSerDefaults for use at a later time. If an access token is already present when this is called then the request specified will be attempted using the access token that is already saved in NSUserDefaults. If the request attempt fails, this method will retrieve a new access token and attempt the request again.
 
 @param method The HTTP method (GET, POST, etc) to perform on the specified URL.
 @param numberOfRetries The number of times that the request should be retried in the event of an error. The max amount of retries is capped at ten.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be either set as a query string for `GET` requests, or the request HTTP body.
 @param success The block to be called if the request succeeded.
 @param failure The block to be called if the request failed.
 */
- (AFHTTPRequestOperation *)fuelRequestWithMethod:(NSString *)method
                                  numberOfRetries:(NSInteger)numberOfRetries
                                        URLString:(NSString *)URLString
                                       parameters:(id)parameters
                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
