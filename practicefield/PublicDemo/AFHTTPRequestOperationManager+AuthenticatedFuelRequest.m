//
//  AFHTTPRequestOperationManager+AuthenticatedFuelRequest.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "AFHTTPRequestOperationManager+AuthenticatedFuelRequest.h"

// Other
#import "PUDUtility.h"

@implementation AFHTTPRequestOperationManager (AuthenticatedFuelRequest)

/**
 The key that is used to store the access token inside NSUserDefaults
 */
NSString *fuelRequestAccessTokenKey = @"AuthenticatedFuelRequest_AccessToken";

/**
 The name of the access token string as returned by the auth route
 */
NSString *accessTokenResponseObjectKey = @"accessToken";

- (AFHTTPRequestOperation *)fuelRequestWithMethod:(NSString *)method
                                  numberOfRetries:(NSInteger)numberOfRetries
                                        URLString:(NSString *)URLString
                                       parameters:(id)parameters
                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    __block NSInteger blockNumberOfRetries = numberOfRetries + 1;
    
    // don't allow more than ten retries
    if (blockNumberOfRetries > 10) {
        blockNumberOfRetries = 10;
    }
    
    // retrieve the access token from user defaults
    __block NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:fuelRequestAccessTokenKey];
    
    if (accessToken) {
        NSString *authenticatedURLString = [URLString stringByAppendingFormat:@"?access_token=%@", accessToken];
        
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                       URLString:[[NSURL URLWithString:authenticatedURLString
                                                                                         relativeToURL:self.baseURL] absoluteString]
                                                                      parameters:parameters
                                                                           error:nil];
        
        NSLog(@"%@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
        
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                          success:success
                                                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                              if (blockNumberOfRetries <=0) {
                                                                                  if (failure) {
                                                                                      failure(operation, error);
                                                                                      return;
                                                                                  }
                                                                              }
                                                                              else {
                                                                                  AFHTTPRequestOperation *innerOperation = [self getAccessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                      [self fuelRequestWithMethod:method
                                                                                                  numberOfRetries:--blockNumberOfRetries
                                                                                                        URLString:URLString
                                                                                                       parameters:parameters
                                                                                                          success:success
                                                                                                          failure:failure];
                                                                                  } failure:failure];
                                                                                  
                                                                                  [self.operationQueue addOperation:innerOperation];
                                                                              }
                                                                          }];
        
        [self.operationQueue addOperation:operation];
        
        return operation;
    }
    else {
        AFHTTPRequestOperation *operation = [self getAccessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self fuelRequestWithMethod:method
                        numberOfRetries:blockNumberOfRetries
                              URLString:URLString
                             parameters:parameters
                                success:success
                                failure:failure];
        } failure:failure];
        
        [self.operationQueue addOperation:operation];
        
        return operation;
    }
}

#pragma mark - private methods

- (AFHTTPRequestOperation *)getAccessTokenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSLog(@"== GETTING NEW ACCESS TOKEN ==");
    
    NSDictionary *parameters = @{ @"clientId" : [PUDUtility clientID], @"clientSecret" : [PUDUtility clientSecret] };
    NSString *URLString = [PUDUtility fuelAccessTokenRoute];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters
                                                                       error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // save the access token to user defaults
        NSString *accessToken = responseObject[accessTokenResponseObjectKey];
        [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:fuelRequestAccessTokenKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // call the success block
        if (success) {
            success(operation, success);
        }
    } failure:failure];
    
    return operation;
}

@end
