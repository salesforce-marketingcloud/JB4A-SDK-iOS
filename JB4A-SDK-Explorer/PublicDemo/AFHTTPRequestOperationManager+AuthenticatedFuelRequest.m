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
//  AFHTTPRequestOperationManager+AuthenticatedFuelRequest.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/9/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
