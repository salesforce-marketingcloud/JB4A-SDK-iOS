//
//  ETData.h
//  etpi
//
//  Created by Jack Fisher on 7/16/12.
//  Copyright (c) 2012 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIDevice+Identifier.h"

@interface ETData : NSObject {
    @private
        NSString *_platform;
        NSString *_platformVersion;
}

@property (nonatomic, copy) NSString *etAppID;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSData *deviceToken;
@property (nonatomic, copy) NSString *deviceID;
@property (nonatomic, copy) NSString *deviceAlias;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *subscriberKey;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) int badgeCount;
@property (nonatomic, copy) NSString *timeZone;
@property (nonatomic, assign) BOOL daylightSavingsTime;
@property (nonatomic, copy) NSString *quietStart;
@property (nonatomic, copy) NSString *quietEnd;
@property (nonatomic, retain) NSMutableSet *tagsSet;
@property (nonatomic, retain) NSMutableDictionary *attributes;
@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSString *messageID;
@property (nonatomic, assign) int secondsInApp;

/**
 Getter for the main ETData object. As this is a singleton, this method is the designated initializer. 
 */
+ (ETData *)sharedETData;
- (id)init;
- (void)setQuietTimeStart:(NSString*)start end:(NSString*)end;
- (void)addTag:(NSString*)tag;
- (void)removeTag:(NSString*)tag;
- (void)addAttributeNamed:(NSString*)name value:(NSString*)value;
- (NSString*)removeAttributeNamed:(NSString*)name;
- (BOOL)sendToET;
- (NSString *)etDataToJson;
- (void)resetTrackingData; 

@end
