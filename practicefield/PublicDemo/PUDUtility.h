//
//  PUDUtility.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/15/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDUtility : NSObject

#pragma mark - App Settings

+ (NSString *)accessToken;

+ (NSString *)appID;

+ (NSString *)clientID;

+ (NSString *)clientSecret;

+ (NSString *)messageIdVanilla;

+ (NSString *)messageIdCloudPage;

#pragma mark - Other

+ (NSString *)fuelAccessTokenRoute;

+ (NSString *)appVersion;

+ (NSString *)sdkVersion;

+ (NSString *)safeAppID;

+ (NSString *)safeAccessToken;

+ (NSString *)safeClientID;

+ (NSString *)safeClientSecret;

+ (NSString *)isPushEnabled;

+ (NSString *)deviceToken;

+ (NSString *)deviceID;

+ (NSString *)openDirectDelegateClassName;

+ (NSString *)isLocationEnabled;

+ (NSString *)buildNumber;

+ (NSString *)bundleID;

+ (NSString *)buildType;

+ (NSString *)attributeFirstName;

+ (NSString *)attributeLastName;

+ (NSString *)activeNFLTags;

+ (NSString *)activeFCTags;

@end
