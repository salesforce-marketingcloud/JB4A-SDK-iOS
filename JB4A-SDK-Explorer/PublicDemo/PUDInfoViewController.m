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
//  PUDInfoWebViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/15/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDInfoViewController.h"

// Controllers
#import "PUDPageContentViewController.h"

@interface PUDInfoViewController ()

@end

@implementation PUDInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // for WAMA tracking purposes
    [ETAnalytics trackPageView:[[NSBundle mainBundle] bundleIdentifier] andTitle:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] andItem:nil andSearch:nil];
}

- (NSString *)htmlPrefix {
    return @"<html style=\"margin:10px; font-size:16px; word-wrap: break-word;\"><font color=\"black\" face=\"Avenir Next\">";
}

- (NSArray *)pageHtml {
    return [self pageHtmlWithHeader:YES];
}

- (NSArray *)pageHtmlWithHeader:(BOOL)hasHeader {
    NSString *headerHtml = @"<h3 style=\"text-align:center;\">Journey Builder for Apps (JB4A) IOS SDK</h3>";
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[[self appDetailsHtml],
                                                             [self appKeysHtml],
                                                             [self sdkStateHtml],
                                                             [self attributesHtml],
                                                             [self notificationSettingsHtml],
                                                             [self deviceTokenHtml],
                                                             [self openDirectRecipientHtml],
                                                             [self tagsHtml]]];
    
    if (hasHeader) {
        NSMutableArray *newArray = [NSMutableArray array];
        
        for (NSString *str in array) {
            [newArray addObject:[headerHtml stringByAppendingString:str]];
        }
        
        array = newArray;
    }
    
    return array;
}

#pragma mark - page content

- (NSString *)appDetailsHtml {
    
    NSString *ret = [self.htmlPrefix stringByAppendingString:
                     @"<b>App Details</b><hr>"
                     "<i>App Bundle Id:</i> k_APP_BUNDLE_ID<br>"
                     "<i>App Version:</i> k_APP_VERSION<br>"
                     "<i>Bundle Version:</i> k_BUILD_NUMBER<br>"
                     "<i>SDK Version:</i> k_SDK_VERSION<br>"];
    
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAppVersion withString:[PUDUtility appVersion]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAppBundleID withString:[PUDUtility bundleID]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoBuildNumber withString:[PUDUtility buildNumber]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoSDKVersion withString:[PUDUtility sdkVersion]];
    
    
    return ret;
}

- (NSString *)appKeysHtml {
    
    NSString *ret = @"<b>App Keys</b><hr>"
    "The App Keys are used to uniquely identify your app within the Marketing Cloud.</p>"
    "<b>App Id:</b> k_APP_ID<br>"
    "<b>Access Token:</b> k_ACCESS_TOKEN<br><br>"
    "The following values are needed to send messages from this app. These are not normally found in an app that catches Push Notifications. But it provides a way to test this app directly.</p>The clientId and the clientSecret are the values found in the Marketing Cloud App Center for the Server to Server App.</p>"
    "<b>Client Id:</b> k_CLIENT_ID<br>"
    "<b>Client Secret:</b> k_CLIENT_SECRET<br><br>"
    "The messageId is found in the Marketing Cloud Message Center for the API Message which is a template for the message to send. This app overrides the values in the message to customize who receives the message as well as what is included in the message.</p>"
    "<b>Message Id, Standard:</b> k_MESSAGE_ID_STANDARD<br>"
    "<b>Message Id, CloudPage:</b> k_MESSAGE_ID_CLOUDPAGE<br>";
    
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAppID withString:[PUDUtility safeAppID]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAccessToken withString:[PUDUtility safeAccessToken]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoClientID withString:[PUDUtility safeClientID]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoClientSecret withString:[PUDUtility safeClientSecret]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoMessageIDStandard withString:[PUDUtility messageIdStandard]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoMessageIDCloudPage withString:[PUDUtility messageIdCloudPage]];
    
    return ret;
}

- (NSString *)sdkStateHtml {
    
    NSString *ret = @"<b>JB4A SDK State</b><hr>"
    "k_SDKState";
    
    NSString *sdkState = [PUDUtility sdkState];
    
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoSdkState withString:sdkState];
    
    return ret;
}

- (NSString *)attributesHtml {
    
    NSString *ret = @"<b>Attributes</b><hr>"
    "Attributes contain specific information about your subscribers, such as first and last name, gender, and geographical location.</p>You can assign specific information as part of a subscriber attribute to be used as part of sends or subscriber management.</p>This Journey Builder for Apps (JB4A) IOS SDK app stores first name and last name as attributes.</p>"
    "<b>First Name:</b> k_ATTR_FIRST<br>"
    "<b>Last Name:</b> k_ATTR_LAST<br>";
    
    NSString *firstName = [PUDUtility attributeFirstName];
    if (!firstName || [firstName isEqualToString:@""]) {
        firstName = @"NOT SET";
    }
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAttributeFirstName withString:firstName];
    
    NSString *lastName = [PUDUtility attributeLastName];
    if (!lastName || [lastName isEqualToString:@""]) {
        lastName = @"NOT SET";
    }
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAttributeLastName withString:lastName];
    
    return ret;
}

- (NSString *)notificationSettingsHtml {
    
    NSString *ret = @"<b>Notification Settings</b><hr>"
    "Push and Location notifications are used to indicate whether this device is interested in receiving notifications or location messages.</p>"
    "<b>Push Enabled:</b> k_PUSH_ENABLED<br>"
//    "<b>Background Refresh Enabled:</b> k_BACKGROUND_REFRESH_ENABLED<br>"
    "<b>Location Geo Fencing Enabled:</b> k_LOCATION_ENABLED<br>";
    
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoPushEnabled withString:[PUDUtility isPushEnabled]];
//    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoBackgroundRefreshEnabled withString:[PUDUtility isBackgroundRefreshEnabled]];
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoLocationEnabled withString:[PUDUtility isLocationEnabled]];
    
    return ret;
}

- (NSString *)deviceTokenHtml {
    
    NSString *ret = @"<b>Device Token</b><hr>"
    "The Device Token is the unique value generated by Apple that is received in the application:didRegisterForRemoteNotificationsWithDeviceToken: method.</p>"
    "<b>Current Device Token:</b> k_DEVICE_TOKEN<br><br>"
    "<b>Device Id</b><hr>"
    "The Device Id is a unique identifier for this device and is can be used by the Marketing Cloud to push messages to specific devices.</p>"
    "<b>Current Device Id:</b> k_DEVICE_ID<br>";
    
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoDeviceID withString:[PUDUtility deviceID]];
    
    NSString *deviceToken = [PUDUtility deviceToken];
    if (!deviceToken) {
        ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoDeviceToken withString:@"NOT SET"];
    }
    else {
        ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoDeviceToken withString:deviceToken];
    }
    
    return ret;
}

- (NSString *)openDirectRecipientHtml {
    
    NSString *ret = @"<b>OpenDirect Delegate</b><hr>"
    "The OpenDirect delegate will be used whenever an OpenDirect url is included with a message and the customer clicks on that message.</p>"
    "<b>Current OpenDirect Delegate:</b> k_OPENDIRECT_DELEGATE<br>";
    
    NSString *openDirectDelegate = [PUDUtility openDirectDelegateClassName];
    if (!openDirectDelegate) {
        ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoOpenDirectDelegate withString:@"NOT SET"];
    }
    else {
        ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoOpenDirectDelegate withString:openDirectDelegate];
    }
    
    return ret;
}

- (NSString *)tagsHtml {
    
    NSString *ret = @"<b>Tags</b><hr>"
    "Tags are used to specify which messages a customer wishes to receive. For example to receive messages for an interest  in a particular activity.</p>"
    "<b>Activity Tags:</b><br>"
    "k_ACTIVITY_TAGS<br>"
    "<br>"
    "<br><br><br><br>";
    
    NSString *activityTags = [PUDUtility activeActivityTags];
    if (!activityTags) {
        activityTags = @"NONE";
    }
    ret = [ret stringByReplacingOccurrencesOfString:kPUDInfoAttributeActivityTags withString:activityTags];
    
    return ret;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)emailHtml {
    NSMutableString *ret = [NSMutableString stringWithString:self.htmlPrefix];
    
    for (NSString *str in [self pageHtmlWithHeader:NO]) {
        [ret appendString:@"<br>"];
        [ret appendString:str];
    }
    
    return ret;
}

#pragma mark - email actions

- (IBAction)actionButtonTapped:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"Journey Builder for Apps (JB4A) IOS SDK"];
        [mailComposer setToRecipients:@[@"MobilePushSupport@exacttarget.com"]];
        [mailComposer setMessageBody:[self emailHtml] isHTML:YES];
        self.navigationItem.rightBarButtonItem.customView = nil;
        
        NSData *etLocationDatabase = [self etLocationDatabaseData];
        if (etLocationDatabase) {
            [mailComposer addAttachmentData:[self etLocationDatabaseData] mimeType:@"application/x-sqlite3" fileName:@"etdb.db"];
        }
        
        [self.navigationController presentViewController:mailComposer
                                                animated:YES
                                              completion:^{
                                              }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSData *)etLocationDatabaseData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"etdb.db"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

@end
