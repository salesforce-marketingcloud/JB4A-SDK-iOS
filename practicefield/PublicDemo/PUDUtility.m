//
//  PUDUtility.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/15/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDUtility.h"

// Libraries
#import "ETPush.h"

// Other
#import "PUDAppSettingConstants.h"

@interface PUDUtility()

@end

@implementation PUDUtility

#pragma mark - App Settings

+ (NSString *)accessToken {
#ifdef DEBUG
    return kAppSettingDebugAccessToken;
#elif ADHOC
    return kAppSettingAdHocAccessToken;
#elif QA
    return kAppSettingQAAccessToken;
#else
    return kAppSettingReleaseAccessToken;
#endif
}

+ (NSString *)appID {
#ifdef DEBUG
    return kAppSettingDebugAppId;
#elif ADHOC
    return kAppSettingAdHocAppId;
#elif QA
    return kAppSettingQAAppId;
#else
    return kAppSettingReleaseAppId;
#endif
}

+ (NSString *)clientID {
#ifdef DEBUG
    return kAppSettingDebugClientId;
#elif ADHOC
    return kAppSettingAdHocClientId;
#elif QA
    return kAppSettingQAClientId;
#else
    return kAppSettingReleaseClientId;
#endif
}

+ (NSString *)clientSecret {
#ifdef DEBUG
    return kAppSettingDebugClientSecret;
#elif ADHOC
    return kAppSettingAdHocClientSecret;
#elif QA
    return kAppSettingQAClientSecret;
#else
    return kAppSettingReleaseClientSecret;
#endif
}

+ (NSString *)messageIdVanilla {
#ifdef DEBUG
    return kAppSettingDebugOutboundMessageIdVanilla;
#elif ADHOC
    return kAppSettingAdHocOutboundMessageIdVanilla;
#elif QA
    return kAppSettingQAOutboundMessageIdVanilla;
#else
    return kAppSettingReleaseOutboundMessageIdVanilla;
#endif
}

+ (NSString *)messageIdCloudPage {
#ifdef DEBUG
    return kAppSettingDebugOutboundMessageIdCloudPage;
#elif ADHOC
    return kAppSettingAdHocOutboundMessageIdCloudPage;
#elif QA
    return kAppSettingQAOutboundMessageIdCloudPage;
#else
    return kAppSettingReleaseOutboundMessageIdCloudPage;
#endif
}

#pragma mark - public methods

+ (NSString *)fuelAccessTokenRoute {
#if QA
    return @"";
#else
    return @"https://auth.exacttargetapis.com/v1/requestToken";
#endif
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)sdkVersion {
    return ETPushSDKVersionString;
}

+ (NSString *)safeAppID {
    NSString *appID = [self appID];
    if (!appID) {
        return nil;
    }
    
    if (appID.length < 15) {
        return appID;
    }
    
    NSRange range = {11, 14};
    return [appID stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)safeAccessToken {
    NSString *accessToken = [self accessToken];
    if (!accessToken) {
        return nil;
    }
    
    if (accessToken.length < 12) {
        return accessToken;
    }
    
    NSRange range = {7, 11};
    return [accessToken stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)safeClientID {
    NSString *clientID = [self clientID];
    if (!clientID) {
        return nil;
    }
    
    if (clientID.length < 12) {
        return clientID;
    }
    
    NSRange range = {7, 11};
    return [clientID stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)safeClientSecret {
    NSString *clientSecret = [self clientSecret];
    if (!clientSecret) {
        return nil;
    }
    
    NSRange range = {7, 11};
    return [clientSecret stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)isPushEnabled {
    /**
     *  ET_NOTE: This demonstrates how to see if the current device has opted in to receive pushes. This method must return YES or the device will not receive push messages
     */
    BOOL isPushEnabled = [ETPush isPushEnabled];
    
    if (isPushEnabled) {
        return @"YES";
    }
    else {
        return @"NO";
    }
}

+ (NSString *)deviceToken {
    /**
     *  ET_NOTE: This demonstrates how to see if the current device has opted in to receive pushes
     */
    NSString *formattedDeviceToken = [[ETPush pushManager] deviceToken];
    return formattedDeviceToken;
}

+ (NSString *)deviceID {
    /**
     *  ET_NOTE: This demonstrates how to retrieve the current device id
     */
    return [ETPush safeDeviceIdentifier];
}

+ (NSString *)openDirectDelegateClassName {
    id openDirectDelegate = [[ETPush pushManager] openDirectDelegate];
    if (!openDirectDelegate) {
        return nil;
    }
    
    return NSStringFromClass([openDirectDelegate class]);
}

+ (NSString *)isLocationEnabled {
    /**
     *  ET_NOTE: This demonstrates how to see if location services are enabled
     */
    BOOL isLocationEnabled = [[ETLocationManager locationManager] locationEnabled];
    
    if (isLocationEnabled) {
        return @"YES";
    }
    else {
        return @"NO";
    }
}

+ (NSString *)buildNumber {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)buildType {
#ifdef DEBUG
    return @"DEBUG";
#elif ADHOC
    return @"ADHOC";
#elif QA
    return @"QA";
#else
    return @"RELEASE";
#endif
}

#pragma mark - private methods

+ (NSString *)attributeFirstName {
    NSString *firstName = [[[ETPush pushManager] allAttributes] objectForKey:kPUDAttributeFirstName];
    return firstName;
}

+ (NSString *)attributeLastName {
    NSString *lastName = [[[ETPush pushManager] allAttributes] objectForKey:kPUDAttributeLastName];
    return lastName;
}

+ (NSString *)activeNFLTags {
    NSString *tags = @"";
    
    NSSet *allTags = [[ETPush pushManager] allTags];
    
    if ([allTags containsObject:kPUDTagCowboys.lowercaseString]) {
        tags = [tags stringByAppendingString:@"Dallas Cowboys"];
    }
    
    if ([allTags containsObject:kPUDTagPackers.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Green Bay Packers"];
    }
    
    if ([allTags containsObject:kPUDTagGiants.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"New York Giants"];
    }
    
    if ([allTags containsObject:kPUDTagSteelers.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Pittsburgh Steelers"];
    }
    
    if ([allTags containsObject:kPUDTagColts.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Indianapolis Colts"];
    }
    
    if ([tags isEqualToString:@""]) {
        tags = nil;
    }
    
    return tags;
}

+ (NSString *)activeFCTags {
    NSString *tags = @"";
    
    NSSet *allTags = [[ETPush pushManager] allTags];
    
    if ([allTags containsObject:kPUDTagArsenal.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Arsenal FC"];
    }
    
    if ([allTags containsObject:kPUDTagChelsea.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Chelsea FC"];
    }
    
    if ([allTags containsObject:kPUDTagManu.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Manchester United FC"];
    }
    
    if ([allTags containsObject:kPUDTagMadrid.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"Real Madrid FC"];
    }
    
    if ([allTags containsObject:kPUDTagFcbarc.lowercaseString]) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@", "];
        }
        
        tags = [tags stringByAppendingString:@"FC Barecelona"];
    }
    
    if ([tags isEqualToString:@""]) {
        tags = nil;
    }
    
    return tags;
}

@end
