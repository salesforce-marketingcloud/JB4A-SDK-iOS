//
//  PUDUtility.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/15/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDUtility : NSObject

+ (NSString *)appVersion;

+ (NSString *)sdkVersion;

+ (NSString *)safeAppID;

+ (NSString *)appID;

+ (void)setAppID:(NSString *)appID;

+ (NSString *)safeAccessToken;

+ (NSString *)accessToken;

+ (void)setAccessToken:(NSString *)accessToken;

+ (NSString *)safeClientID;

+ (NSString *)clientID;

+ (NSString *)safeClientSecret;

+ (NSString *)clientSecret;

+ (NSString *)messageID;

+ (NSString *)isPushEnabled;

+ (NSString *)deviceToken;

+ (NSString *)deviceID;

+ (NSString *)openDirectDelegateClassName;

+ (void)setOpenDirectDelegateClassName:(NSString *)openDirectDelegateClassName;

+ (NSString *)isLocationEnabled;

+ (NSString *)buildNumber;

+ (NSString *)bundleID;

+ (NSString *)buildType;

+ (NSString *)attributeFirstName;

+ (NSString *)attributeLastName;

+ (NSString *)activeNFLTags;

+ (NSString *)activeFCTags;

@end
