//
//  ETURLConnection.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 9/24/12.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETGenericUpdate.h"

/**
 ETURLConnection is a wrapper around vanilla NSURLConnections that is useful because it adds things that Apple should have (tags) or things needed for ETPhoneHome to work correctly (reference to the sending object. Otherwise, it's just a regular NSURLConnection.
 */
@interface ETURLConnection : NSURLConnection

/**
 The tag of this particular connection. Usually the BackgroundTaskID from iOS.
 */
@property (nonatomic) int tag;

/**
 A reference to the sendingObject for this connection. That object will save the response data and status code, etc. This allows us to fire off a bunch of these things in parallel. 
 */
@property (nonatomic, strong) ETGenericUpdate *sendingObject;

@end
