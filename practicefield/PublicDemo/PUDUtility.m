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

@interface PUDUtility()

@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic, strong) NSString *appID;

@property (nonatomic, strong) NSString *openDirectDelegateClassName;

@end

@implementation PUDUtility

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)sdkVersion {
    return ETPushSDKVersionString;
}

+ (NSString *)safeAppID {
    NSString *appID = [[PUDUtility sharedInstance] appID];
    if (!appID) {
        return nil;
    }
    
    if (appID.length < 15) {
        return appID;
    }
    
    NSRange range = {11, 14};
    return [appID stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)appID {
    return [[PUDUtility sharedInstance] appID];
}

+ (void)setAppID:(NSString *)appID {
    [[PUDUtility sharedInstance] setAppID:appID];
}

+ (NSString *)safeAccessToken {
    NSString *accessToken = [[PUDUtility sharedInstance] accessToken];
    if (!accessToken) {
        return nil;
    }
    
    if (accessToken.length < 12) {
        return accessToken;
    }
    
    NSRange range = {7, 11};
    return [accessToken stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)accessToken {
    return [[PUDUtility sharedInstance] accessToken];
}

+ (void)setAccessToken:(NSString *)accessToken {
    [[PUDUtility sharedInstance] setAccessToken:accessToken];
}

+ (NSString *)safeClientID {
    NSString *clientID = [self loadClientId];
    if (!clientID) {
        return nil;
    }
    
    if (clientID.length < 12) {
        return clientID;
    }
    
    NSRange range = {7, 11};
    return [clientID stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)clientID {
    return [self loadClientId];
}

+ (NSString *)safeClientSecret {
    NSString *clientSecret = [self loadClientSecret];
    if (!clientSecret) {
        return nil;
    }
    
    NSRange range = {7, 11};
    return [clientSecret stringByReplacingCharactersInRange:range withString:@"***********"];
}

+ (NSString *)clientSecret {
    return [self loadClientSecret];
}

+ (NSString *)messageID {
    return [self loadMessageId];
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
    return [[PUDUtility sharedInstance] openDirectDelegateClassName];
}

+ (void)setOpenDirectDelegateClassName:(NSString *)openDirectDelegateClassName {
    [[PUDUtility sharedInstance] setOpenDirectDelegateClassName:openDirectDelegateClassName];
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
#else
    return @"RELEASE";
#endif
}

#pragma mark - private methods

+ (NSDictionary *)settingsPlistDictionary {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:kPUDAppSettingsPlistName];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    /**
     Raise an exception if the file cannot be found or has no data inside it
     */
    if (!plistData) {
        [NSException raise:[kPUDAppSettingsPlistName stringByAppendingString:@" Not Found"]
                    format:@"The FuelCredentials.plist file cannot be found. Make sure it is contained inside the main bundle."];
    }
    
    return plistData;
}

+ (NSString *)loadClientId {
    NSDictionary *plistData = [self settingsPlistDictionary];

    NSString *key = nil;
    
#ifdef DEBUG
    key = @"debugClientId";
#elif ADHOC
    key = @"adhocClientId";
#else
    key = @"prodClientId";
#endif
    
    return plistData[key];
}

+ (NSString *)loadClientSecret {
    NSDictionary *plistData = [self settingsPlistDictionary];
    
    NSString *key = nil;
    
#ifdef DEBUG
    key = @"debugClientSecret";
#elif ADHOC
    key = @"adhocClientSecret";
#else
    key = @"prodClientSecret";
#endif
    
    return plistData[key];
}

+ (NSString *)loadMessageId {
    NSDictionary *plistData = [self settingsPlistDictionary];
    
    NSString *key = nil;
    
#ifdef DEBUG
    key = @"debugMessageId";
#elif ADHOC
    key = @"adhocMessageId";
#else
    key = @"prodMessageId";
#endif
    
    return plistData[key];
}

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
