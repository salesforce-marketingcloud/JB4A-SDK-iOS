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
//  PUDConstants.m
//  PushDemo
//
//  Created by Matt Lathrop on 4/29/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDConstants.h"

#pragma mark - App Defaults
CGFloat const kPUDAppCustomTextSize = 15.0;
NSString *const kPUDAppBarcodeFont = @"Free3of9Extended";
NSString *const kPUDAppSettingsPlistName = @"settings.plist";

#pragma mark - Attributes
NSString *const kPUDAttributeFirstName = @"FirstName";
NSString *const kPUDAttributeLastName = @"LastName";

#pragma mark - CloudPage Inbox
NSUInteger const kPUDCloudPageFilterSegmentControlAllIndex = 0;
NSUInteger const kPUDCloudPageFilterSegmentControlUnreadIndex = 1;
NSUInteger const kPUDCloudPageFilterSegmentControlReadIndex = 2;

#pragma mark - Info Table View
NSString *const kPUDInfoAppVersion = @"k_APP_VERSION";
NSString *const kPUDInfoAppBundleID = @"k_APP_BUNDLE_ID";
NSString *const kPUDInfoBuildNumber = @"k_BUILD_NUMBER";
NSString *const kPUDInfoSDKVersion = @"k_SDK_VERSION";
NSString *const kPUDInfoBuildType = @"k_BUILD_TYPE";
NSString *const kPUDInfoConfigName = @"k_CONFIG_NAME";
NSString *const kPUDInfoAppID = @"k_APP_ID";
NSString *const kPUDInfoAccessToken = @"k_ACCESS_TOKEN";
NSString *const kPUDInfoClientID = @"k_CLIENT_ID";
NSString *const kPUDInfoClientSecret = @"k_CLIENT_SECRET";
NSString *const kPUDInfoMessageIDStandard = @"k_MESSAGE_ID_STANDARD";
NSString *const kPUDInfoMessageIDCloudPage = @"k_MESSAGE_ID_CLOUDPAGE";
NSString *const kPUDInfoMessageIDSilent = @"k_MESSAGE_ID_SILENT";
NSString *const kPUDInfoPushEnabled = @"k_PUSH_ENABLED";
NSString *const kPUDInfoBackgroundRefreshEnabled = @"k_BACKGROUND_REFRESH_ENABLED";
NSString *const kPUDInfoDeviceToken = @"k_DEVICE_TOKEN";
NSString *const kPUDInfoDeviceID = @"k_DEVICE_ID";
NSString *const kPUDInfoOpenDirectDelegate = @"k_OPENDIRECT_DELEGATE";
NSString *const kPUDInfoLocationEnabled = @"k_LOCATION_ENABLED";
NSString *const kPUDInfoAttributeFirstName = @"k_ATTR_FIRST";
NSString *const kPUDInfoAttributeLastName = @"k_ATTR_LAST";
NSString *const kPUDInfoSdkState = @"k_SDKState";
NSString *const kPUDInfoAttributeActivityTags = @"k_ACTIVITY_TAGS";

#pragma mark - Message Detail Table View

// tags
NSUInteger const kPUDMessageDetailSendButtonTag = 7645745;
NSUInteger const kPUDMessageDetailSwitchTag = 4322;
NSUInteger const kPUDMessageDetailTextFieldTag = 1234324;
NSUInteger const kPUDMessageDetailSegmentedControlTag = 7437381;

// custom keys
NSString *const kPUDMessageDetailCustomKeyDiscountCode = @"discount_code";

// textfield defaults
NSString *const kPUDAppMessageDetailDefaultMessageText = @"Type something...";
NSString *const kPUDMessageDetailDefaultOpenDirect = @"http://www.exacttarget.com";

// push method segment
NSUInteger const kPUDMessageDetailAlertSegmentIndex = 0;
NSUInteger const kPUDMessageDetailAlertCloudPageSegmentIndex = 1;

// custom sound picker
NSUInteger const kPUDMessageDetailPickerSoundDefaultIndex = 0;
NSUInteger const kPUDMessageDetailPickerSoundCustomIndex = 1;
NSUInteger const kPUDMessageDetailPickerSoundNoneIndex = 2;

// custom key picker
NSUInteger const kPUDMessageDetailPickerCustomKeyNoneIndex = 0;
NSUInteger const kPUDMessageDetailPickerCustomKey10Index = 1;
NSUInteger const kPUDMessageDetailPickerCustomKey20Index = 2;
NSUInteger const kPUDMessageDetailPickerCustomKey30Index = 3;

#pragma mark - Messages Payload
NSString *const kPUDMessagePayloadSoundKey = @"sound";
NSString *const kPUDMessagePayloadMessageTextKey = @"messageText";
NSString *const kPUDMessagePayloadOverrideKey = @"override";
NSString *const kPUDMessagePayloadDeviceTokensKey = @"deviceTokens";
NSString *const kPUDMessagePayloadBadgeKey = @"badge";
NSString *const kPUDMessagePayloadTagsKey = @"inclusionTags";
NSString *const kPUDMessagePayloadOpenDirectKey = @"openDirect";
NSString *const kPUDMessagePayloadCustomKeysKey = @"customKeys";
NSString *const kPUDMessagePayloadCloudPageKey = @"cloudPage";

// badge values
NSString *const kPUDMessagePayloadDefaultBadgeValue = @"+0";

// sound values
NSString *const kPUDMessagePayloadSoundDefault = @"default";
NSString *const kPUDMessagePayloadSoundCustom = @"custom.caf";
NSString *const kPUDMessagePayloadSoundNone = nil;

// custom key values
NSString *const kPUDMessagePayloadCustomKeyNone = @"None";
NSString *const kPUDMessagePayloadCustomKey10 = @"10%";
NSString *const kPUDMessagePayloadCustomKey20 = @"20%";
NSString *const kPUDMessagePayloadCustomKey30 = @"30%";

#pragma mark - Messages Table View
NSUInteger const kPUDMessagesLastReceivedSectionIndex = 0;
NSUInteger const kPUDMessagesPushTestsSectionIndex = 1;

#pragma mark - Message Types
NSString *const kPUDMessageTypeLocation = @"Location";
NSString *const kPUDMessageTypeOutbound = @"Outbound";

#pragma mark - Push Defines
NSString *const kPUDPushDefineOpenDirectPayloadKey = @"_od";
NSString *const kPUDPushDefineCloudPagePayloadKey = @"_x";

#pragma mark - Reuse Identifiers
NSString *const kPUDReuseIdentifierDiscountCell = @"ruid_discountCell";
NSString *const kPUDReuseIdentifierInfoCell = @"ruid_infoCell";
NSString *const kPUDReuseIdentifierMessageCell = @"ruid_messageCell";
NSString *const kPUDReuseIdentifierMessageDetailCell = @"ruid_messageDetailCell";
NSString *const kPUDReuseIdentifierPushReceivedCell = @"ruid_pushReceivedCell";
NSString *const kPUDReuseIdentifierSettingCell = @"ruid_settingCell";
NSString *const kPUDReuseIdentifierTagCell = @"ruid_tagCell";
NSString *const kPUDReuseIdentifierCloudPageInboxCell = @"ruid_cloudPageInboxCell";

#pragma mark - Segues
NSString *const kPUDSegueMessagesToLastReceivedPush = @"seg_messagesToLastReceivedPush";
NSString *const kPUDSegueMessagesToMessageDetail = @"seg_messagesToMessagesDetail";
NSString *const kPUDSeguePushReceivedToDiscount = @"seg_pushReceivedToDiscount";

#pragma mark - Settings Table View
NSUInteger const kPUDSettingsPersonalInformationSectionIndex = 0;
NSUInteger const kPUDSettingsActivitySectionIndex = 1;

#pragma mark - Storyboard Identifiers
NSString *const kPUDStoryboardIdentifierPushReceivedTableViewController = @"sb_pushReceivedTableViewController";
NSString *const kPUDStoryboardIdentifierDiscountCodeViewController = @"sb_discountCodeViewController";

#pragma mark - Storyboard Name
NSString *const kPUDStoryboardMain = @"Main";

#pragma mark - Tags
NSString *const kPUDTagCampingGear = @"Camping Gear";
NSString *const kPUDTagHikingSupplies= @"Hiking Supplies";
NSString *const kPUDTagBoatingGear = @"Boating Gear";
NSString *const kPUDTagFishingSupplies = @"Fishing Supplies";
NSString *const kPUDTagHuntingGear = @"Hunting Gear";

#pragma mark - User Defaults
NSString *const kPUDUserDefaultsFirstName = @"ud_firstName";
NSString *const kPUDUserDefaultsLastName = @"ud_lastName";
NSString *const kPUDUserDefaultsLastPushReceivedDate = @"ud_lastPushReceivedDate";
NSString *const kPUDUserDefaultsPushUserInfo = @"ud_pushUserInfo";
NSString *const kPUDUserDefaultsMessageType = @"ud_messageType";
NSString *const kPUDUserDefaultsAlertText = @"ud_alertText";

#pragma mark - Configs UserDefaults
NSString *const kPUDUserDefaultsConfigName = @"ud_configName";
NSString *const kPUDUserDefaultsAppID = @"ud_appId";
NSString *const kPUDUserDefaultsAccessToken = @"ud_accessToken";
NSString *const kPUDUserDefaultsClientID = @"ud_clientId";
NSString *const kPUDUserDefaultsClientSecret = @"ud_clientSecret";
NSString *const kPUDUserDefaultsMessageIDStandard = @"ud_standardMessageId";
NSString *const kPUDUserDefaultsMessageIDCloudPage = @"ud_CloudpageMessageId";
NSString *const kPUDUserDefaultsMessageIDSilent = @"ud_SilentMessageId";
NSString *const kPUDUserDefaultsRestUrl = @"ud_RestUrl";

#pragma mark - Configs Table View
NSUInteger const kPUDConfigsDefaultIndex = 0;
//NSUInteger const kPUDConfigsCustomIndex = 1;

#pragma mark - Notifications
NSString *const kPUDPreferencesChanged =  @"PreferencesChanged";


