//
//  ETDataConnector.h
//  etpi
//
//  Created by Christopher Keaney on 7/31/12.
//  Copyright (c) 2012 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ETData.h"

@interface ETDataConnector : NSObject {
    NSMutableData *_responseData;
    NSString *_lastMessage;
    
    NSString *_appData;
    int _httpStatusCode;
    
    
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskID;


/**
 Send update is the main method responsible for beginning a call to ExactTarget. It checks for the presence of a valid access token and either initiates a data call for a new token, or begins the request to ET if the token is valid.
 
 @param appData A stringified representation of the ETData object, ready to be sent in.
 @return Doesn't return anything.
 */
- (void)sendUpdate:(NSString *)appData;


- (NSString *)urlEncodeString:(NSString *)urlstring UsingEncoding:(NSStringEncoding)encoding;

@end
