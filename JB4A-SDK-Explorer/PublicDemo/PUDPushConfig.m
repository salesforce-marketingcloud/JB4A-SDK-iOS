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
//  PUDPushConfig.m
//  PublicDemo
//
//  Created by Swetha Pendyala (Contractor) on 7/25/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDPushConfig.h"

//Classes
#import "PUDAppSettingConstants.h"
#import "PUDConstants.h"

//SDK
#import "ETSqliteHelper.h"
#import "ETPush.h"
#import "ETKeyValueStore.h"

@implementation PUDPushConfig

@synthesize configurationName = _configurationName;
@synthesize appID = _appID;
@synthesize clientID = _clientID;
@synthesize clientSecret = _clientSecret;
@synthesize accessToken = _accessToken;
@synthesize restUrl = _restUrl;
@synthesize standardMessageID = _standardMessageID;
@synthesize cloudpageMessageID = _cloudpageMessageID;

#pragma mark - Setters

/* This is to save the current push config every time a change happens */
+ (void) setCurrentConfigWithSelected: (PUDPushConfig *)config {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    //AppId, AccessToken and ConfigurationName are required
    if (!config.appID || !config.accessToken || !config.configurationName){
        return;
    }
    else {
        // sanity check the appID
        NSString *appIDRegex = @"[0-9a-f]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}";
        NSPredicate *appIDTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", appIDRegex];
        if (config.appID == nil || [config.appID isEqualToString:@""] || ![appIDTest evaluateWithObject:config.appID])
            return;
        
        // sanity check the accessToken
        if (config.accessToken == nil || [config.accessToken isEqualToString:@""] || config.accessToken.length != 24)
            return;
        
        [ud setObject:config.configurationName forKey:kPUDUserDefaultsConfigName];
        [ud setObject:config.appID forKey:kPUDUserDefaultsAppID];
        [ud setObject:config.accessToken forKey:kPUDUserDefaultsAccessToken];
        
        /*The following are optional, but if one exists, they all exist.  If these do not exist, then the ability to send messages in the app will be disabled and the user will only be able to send messages to the app from the ETMC. */
        
        if (config.clientID && config.clientSecret && config.standardMessageID && config.cloudpageMessageID) {
            
            [ud setObject:config.clientID forKey:kPUDUserDefaultsClientID];
            [ud setObject:config.clientSecret forKey:kPUDUserDefaultsClientSecret];
            [ud setObject:config.standardMessageID forKey:kPUDUserDefaultsMessageIDVanilla];
            [ud setObject:config.cloudpageMessageID forKey:kPUDUserDefaultsMessageIDCloudPage];
            
            
        }/* Set them empty string, displayed on PUDInfoViewController */
        else {
            [ud setObject:@"" forKey:kPUDUserDefaultsClientID];
            [ud setObject:@"" forKey:kPUDUserDefaultsClientSecret];
            [ud setObject:@"" forKey:kPUDUserDefaultsMessageIDVanilla];
            [ud setObject:@"" forKey:kPUDUserDefaultsMessageIDCloudPage];
        }
        
        /* The following is optional (and will only be documented for internal use).  It is used for QA testing to point to different servers to execute the REST calls to send messages.*/
        if (config.restUrl) {
            if ([config.restUrl isEqualToString:@"##dev##"]) {
                config.restUrl = kAppSettingDevAccessTokenUrl;
            }
            else if ([config.restUrl isEqualToString:@"##prod##"]) {
                config.restUrl = kAppSettingEtprodAccessTokenUrl;
            }
            else {
                [ud setObject:config.restUrl forKey:kPUDUserDefaultsRestUrl];
            }
        }
        else
        {
            [ud setObject:kAppSettingEtprodAccessTokenUrl forKey:kPUDUserDefaultsRestUrl];
        }
        
        [ud synchronize];
        
        [PUDPushConfig refreshDatabase];
        
        /* Posting notification to refresh views */
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUDPushConfigChangedNotification
                                                            object:self
                                                          userInfo:nil];
    }
    
}

/* This is to save the imported push configs, change of config may/maynot happen whenever a config is imported */

+(PUDPushConfig *)pushConfigFromDictionary:(NSDictionary *)dict
{
    PUDPushConfig *_lastPushConfig = [[PUDPushConfig alloc] init];
    
    if (![dict objectForKey:@"configurationName"] || ![dict objectForKey:@"appId"] || ![dict objectForKey:@"accessToken"]) {
        return NULL;
    }
    else {
        _lastPushConfig.configurationName = [dict objectForKey:@"configurationName"];
        _lastPushConfig.appID = [dict objectForKey:@"appId"];
        _lastPushConfig.accessToken = [dict objectForKey:@"accessToken"];
        
        if ([dict objectForKey:@"client_id"] && [dict objectForKey:@"client_secret"] && [dict objectForKey:@"standard_message_id"] && [dict objectForKey:@"cloudpage_message_id"]) {
            
            _lastPushConfig.clientID = [dict objectForKey:@"client_id"];
            _lastPushConfig.clientSecret = [dict objectForKey:@"client_secret"];
            _lastPushConfig.standardMessageID = [dict objectForKey:@"standard_message_id"];
            _lastPushConfig.cloudpageMessageID = [dict objectForKey:@"cloudpage_message_id"];
        } /* Set them to empty strings */
        else {
            _lastPushConfig.clientID = @"";
            _lastPushConfig.clientSecret = @"";
            _lastPushConfig.standardMessageID = @"";
            _lastPushConfig.cloudpageMessageID = @"";
        }
        
        if ([dict objectForKey:@"rest_url"]) {
            if ([[dict objectForKey:@"rest_url"] isEqualToString:@"##dev##"]) {
                _lastPushConfig.restUrl = kAppSettingDevAccessTokenUrl;
            }
            else if ([[dict objectForKey:@"rest_url"] isEqualToString:@"##prod##"]) {
                _lastPushConfig.restUrl = kAppSettingEtprodAccessTokenUrl;
            }
            else {
                _lastPushConfig.restUrl = [dict objectForKey:@"rest_url"]; }
        }
        else {
            _lastPushConfig.restUrl = kAppSettingEtprodAccessTokenUrl;
        }
        return _lastPushConfig;
    }
}

#pragma mark - Getters

+ (PUDPushConfig * ) getCurrentConfig {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    PUDPushConfig *push = [[PUDPushConfig alloc] init];
    
    push.configurationName = [ud objectForKey:kPUDUserDefaultsConfigName];
    push.appID = [ud objectForKey:kPUDUserDefaultsAppID];
    push.accessToken = [ud objectForKey:kPUDUserDefaultsAccessToken];
    push.clientID = [ud objectForKey:kPUDUserDefaultsClientID];
    push.clientSecret = [ud objectForKey:kPUDUserDefaultsClientSecret];
    push.standardMessageID = [ud objectForKey:kPUDUserDefaultsMessageIDVanilla];
    push.cloudpageMessageID = [ud objectForKey:kPUDUserDefaultsMessageIDCloudPage];
    push.restUrl = [ud objectForKey:kPUDUserDefaultsRestUrl];
    
    // warning - HACK oncoming --- if there's no AppID, just return null.
    if (push.appID == NULL) {
        return NULL;
    }
    return push;
}

+ (PUDPushConfig *) getDefaultPushConfig
{
    PUDPushConfig *defaultPushConfig;
    
#ifdef QA
    
    defaultPushConfig = [[PUDPushConfig alloc] init];
    defaultPushConfig.configurationName = kAppSettingEtprodConfigName;
    defaultPushConfig.appID = kAppSettingEtprodAppId;
    defaultPushConfig.accessToken = kAppSettingEtprodAccessToken;
    defaultPushConfig.clientID = kAppSettingEtprodClientId ;
    defaultPushConfig.clientSecret = kAppSettingEtprodClientSecret;
    defaultPushConfig.standardMessageID = kAppSettingEtprodOutboundMessageIdVanilla;
    defaultPushConfig.cloudpageMessageID = kAppSettingEtprodOutboundMessageIdCloudPage;
    defaultPushConfig.restUrl = kAppSettingEtprodAccessTokenUrl;
    
#elif DEBUG
    
    defaultPushConfig = [[PUDPushConfig alloc] init];
    defaultPushConfig.configurationName = kAppSettingDevConfigName;
    defaultPushConfig.appID = kAppSettingDevAppId;
    defaultPushConfig.accessToken = kAppSettingDevAccessToken;
    defaultPushConfig.clientID = kAppSettingDevClientId ;
    defaultPushConfig.clientSecret = kAppSettingDevClientSecret;
    defaultPushConfig.standardMessageID = kAppSettingDevOutboundMessageIdVanilla;
    defaultPushConfig.cloudpageMessageID = kAppSettingDevOutboundMessageIdCloudPage;
    defaultPushConfig.restUrl = kAppSettingDevAccessTokenUrl;
    
#endif
    
    return defaultPushConfig;
}

+ (NSArray *) availableDefaultPushConfigs {
    
    PUDPushConfig *etprodPushConfig;
    
    return @[etprodPushConfig];
}


# pragma mark - Custom Methods

+ (void) refreshDatabase {
    
    // Stop watching for updates
    [[ETLocationManager locationManager] stopWatchingLocation];
    
    //Delete tags
    NSSet *tagSet = [[ETPush pushManager] allTags];
    [tagSet enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
        [[ETPush pushManager]removeTag:tag];
    }];
    
    //Remove Attribute
    [[ETPush pushManager] removeAttributeNamed:kPUDAttributeFirstName];
    [[ETPush pushManager] removeAttributeNamed:kPUDAttributeLastName];
    
    //Reset Attributes
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kPUDUserDefaultsLastName];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kPUDUserDefaultsFirstName];
    
    // Close the database
    [[ETSqliteHelper database]close];
    
    // Delete the database
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalPath = [paths stringByAppendingPathComponent:@"JB4ASDK"];
    NSError *error;
    
    BOOL success = [fileManager removeItemAtPath:finalPath error:&error];
    
    if (success) {
        NSLog(@"Database cleared");
    }
    else {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
    
    // reconfigure the SDK
    PUDPushConfig *pushConfig = [PUDPushConfig getCurrentConfig];

    error = nil;
    BOOL configOK = [[ETPush pushManager] configureSDKWithAppID:pushConfig.appID
                                                 andAccessToken:pushConfig.accessToken
                                                  withAnalytics:YES
                                            andLocationServices:YES
                                                  andCloudPages:YES
                                                withPIAnalytics:YES
                                                          error:&error];
    if (!configOK) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // something went wrong in the config call - show what the error is
            [[[UIAlertView alloc] initWithTitle:@"Failed configureSDKWithAppID!"
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                              otherButtonTitles:nil] show];
        });
    }
    else {
        // See ETPush.h for reasoning behind this #if logic
        // IPHONEOS_DEPLOYMENT_TARGET = 6.X or 7.X
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        // Supports IOS SDK 8.X (i.e. XCode 6.X and up)
        // are we running on IOS8 and above?
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
            // get the current settings to reapply them
            UIUserNotificationSettings *settings = [[ETPush pushManager] currentUserNotificationSettings];
            
            // we have to have something or we won't get any notifications on the first install on a new device
            if (settings.types == UIUserNotificationTypeNone) {
                settings = [UIUserNotificationSettings settingsForTypes:
                            UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                                             categories:nil];
            }
            
            [[ETPush pushManager] registerUserNotificationSettings:settings];
            [[ETPush pushManager] registerForRemoteNotifications];
        }
        else {
            [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
        }
#else
        // Supports IOS SDKs < 8.X (i.e. XCode 5.X or less)
        [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
#endif
#else
        // IPHONEOS_DEPLOYMENT_TARGET >= 8.X
        // Supports IOS SDK 8.X (i.e. XCode 6.X and up)
        UIUserNotificationSettings *settings = [[ETPush pushManager] currentUserNotificationSettings];
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
#endif
        
        // Start watching for updates. Delay is introduced to allow enough time for alert views
        [[ETLocationManager locationManager] performSelector:@selector(startWatchingLocation) withObject:nil afterDelay:1.0];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Push Config: %@", _configurationName];
}

@end

