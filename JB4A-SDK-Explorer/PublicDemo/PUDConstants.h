/**
 * Copyright (c) 2014 ExactTarget, Inc.
 * All rights reserved.
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
//  PUDConstants.h
//  PushDemo
//
//  Created by Matt Lathrop on 4/29/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#pragma mark - Defines

#define IOS_PRE_7_0 (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)

#pragma mark - TypeDefs
typedef CGFloat (^CellHeightBlock)();
typedef void (^ConfigureCellBlock)(UITableViewCell *);
typedef void (^PickerViewRowSelectedBlock)(UIPickerView *);
typedef void (^SwitchValueChangedBlock)(UISwitch *);
typedef void (^TextFieldDidEndEditingBlock)(UITextField *);
typedef void (^SegmentedControlerValueChangedBlock)(UISegmentedControl *);

#pragma mark - App Defaults
extern CGFloat const kPUDAppCustomTextSize;
extern NSString *const kPUDAppBarcodeFont;
extern NSString *const kPUDAppSettingsPlistName;

#pragma mark - Attributes
extern NSString *const kPUDAttributeFirstName;
extern NSString *const kPUDAttributeLastName;

#pragma mark - CloudPage Inbox
extern NSUInteger const kPUDCloudPageFilterSegmentControlAllIndex;
extern NSUInteger const kPUDCloudPageFilterSegmentControlUnreadIndex;
extern NSUInteger const kPUDCloudPageFilterSegmentControlReadIndex;

#pragma mark - Info Table View
extern NSString *const kPUDInfoAppVersion;
extern NSString *const kPUDInfoAppBundleID;
extern NSString *const kPUDInfoBuildNumber;
extern NSString *const kPUDInfoSDKVersion;
extern NSString *const kPUDInfoBuildType;
extern NSString *const kPUDInfoConfigName;
extern NSString *const kPUDInfoAppID;
extern NSString *const kPUDInfoAccessToken;
extern NSString *const kPUDInfoClientID;
extern NSString *const kPUDInfoClientSecret;
extern NSString *const kPUDInfoMessageIDVanilla;
extern NSString *const kPUDInfoMessageIDCloudPage;
extern NSString *const kPUDInfoPushEnabled;
extern NSString *const kPUDInfoDeviceToken;
extern NSString *const kPUDInfoDeviceID;
extern NSString *const kPUDInfoOpenDirectDelegate;
extern NSString *const kPUDInfoLocationEnabled;
extern NSString *const kPUDInfoAttributeFirstName;
extern NSString *const kPUDInfoAttributeLastName;
extern NSString *const kPUDInfoAttributeActivityTags;

#pragma mark - Message Detail Table View

// tags
extern NSUInteger const kPUDMessageDetailSendButtonTag;
extern NSUInteger const kPUDMessageDetailSwitchTag;
extern NSUInteger const kPUDMessageDetailTextFieldTag;
extern NSUInteger const kPUDMessageDetailSegmentedControlTag;

// custom keys
extern NSString *const kPUDMessageDetailCustomKeyDiscountCode;

// textfield defaults
extern NSString *const kPUDAppMessageDetailDefaultMessageText;
extern NSString *const kPUDMessageDetailDefaultOpenDirect;

// push method segment
extern NSUInteger const kPUDMessageDetailAlertSegmentIndex;
extern NSUInteger const kPUDMessageDetailAlertCloudPageSegmentIndex;

// custom sound picker
extern NSUInteger const kPUDMessageDetailPickerSoundDefaultIndex;
extern NSUInteger const kPUDMessageDetailPickerSoundCustomIndex;
extern NSUInteger const kPUDMessageDetailPickerSoundNoneIndex;

// custom key picker
extern NSUInteger const kPUDMessageDetailPickerCustomKeyNoneIndex;
extern NSUInteger const kPUDMessageDetailPickerCustomKey10Index;
extern NSUInteger const kPUDMessageDetailPickerCustomKey20Index;
extern NSUInteger const kPUDMessageDetailPickerCustomKey30Index;

#pragma mark - Messages Payload
extern NSString *const kPUDMessagePayloadSoundKey;
extern NSString *const kPUDMessagePayloadMessageTextKey;
extern NSString *const kPUDMessagePayloadOverrideKey;
extern NSString *const kPUDMessagePayloadDeviceTokensKey;
extern NSString *const kPUDMessagePayloadBadgeKey;
extern NSString *const kPUDMessagePayloadTagsKey;
extern NSString *const kPUDMessagePayloadOpenDirectKey;
extern NSString *const kPUDMessagePayloadCustomKeysKey;
extern NSString *const kPUDMessagePayloadCloudPageKey;

// badge values
extern NSString *const kPUDMessagePayloadDefaultBadgeValue;

// sound values
extern NSString *const kPUDMessagePayloadSoundDefault;
extern NSString *const kPUDMessagePayloadSoundCustom;
extern NSString *const kPUDMessagePayloadSoundNone;

// custom key values
extern NSString *const kPUDMessagePayloadCustomKeyNone;
extern NSString *const kPUDMessagePayloadCustomKey10;
extern NSString *const kPUDMessagePayloadCustomKey20;
extern NSString *const kPUDMessagePayloadCustomKey30;

#pragma mark - Messages Table View
extern NSUInteger const kPUDMessagesLastReceivedSectionIndex;
extern NSUInteger const kPUDMessagesPushTestsSectionIndex;

#pragma mark - Message Types
extern NSString *const kPUDMessageTypeLocation;
extern NSString *const kPUDMessageTypeOutbound;

#pragma mark - Push Defines
extern NSString *const kPUDPushDefineOpenDirectPayloadKey;
extern NSString *const kPUDPushDefineCloudPagePayloadKey;

#pragma mark - Reuse Identifiers
extern NSString *const kPUDReuseIdentifierDiscountCell;
extern NSString *const kPUDReuseIdentifierInfoCell;
extern NSString *const kPUDReuseIdentifierMessageCell;
extern NSString *const kPUDReuseIdentifierMessageDetailCell;
extern NSString *const kPUDReuseIdentifierPushReceivedCell;
extern NSString *const kPUDReuseIdentifierSettingCell;
extern NSString *const kPUDReuseIdentifierTagCell;
extern NSString *const kPUDReuseIdentifierCloudPageInboxCell;
extern NSString *const kPUDReuseIdentifierPushConfigCell;

#pragma mark - Segues
extern NSString *const kPUDSegueMessagesToLastReceivedPush;
extern NSString *const kPUDSegueMessagesToMessageDetail;
extern NSString *const kPUDSeguePushReceivedToDiscount;

#pragma mark - Settings Table View
extern NSUInteger const kPUDSettingsPersonalInformationSectionIndex;
extern NSUInteger const kPUDSettingsActivitySectionIndex;

#pragma mark - Storyboard Identifiers
extern NSString *const kPUDStoryboardIdentifierPushReceivedTableViewController;
extern NSString *const kPUDStoryboardIdentifierDiscountCodeViewController;
extern NSString *const kPUDStoryboardIdentifierPushConfigTable;

#pragma mark - Storyboard Name
extern NSString *const kPUDStoryboardMain;

#pragma mark - Tags
extern NSString *const kPUDTagCampingGear;
extern NSString *const kPUDTagHikingSupplies;
extern NSString *const kPUDTagBoatingGear;
extern NSString *const kPUDTagFishingSupplies;
extern NSString *const kPUDTagHuntingGear;

#pragma mark - User Defaults
extern NSString *const kPUDUserDefaultsFirstName;
extern NSString *const kPUDUserDefaultsLastName;
extern NSString *const kPUDUserDefaultsLastPushReceivedDate;
extern NSString *const kPUDUserDefaultsPushUserInfo;
extern NSString *const kPUDUserDefaultsMessageType;
extern NSString *const kPUDUserDefaultsAlertText;

#pragma mark - Configs Table View
extern NSUInteger const kPUDConfigsDefaultIndex;
//extern NSUInteger const kPUDConfigsCustomIndex;

#pragma mark - Configs UserDefaults
extern NSString *const kPUDUserDefaultsConfigName;
extern NSString *const kPUDUserDefaultsAppID;
extern NSString *const kPUDUserDefaultsAccessToken;
extern NSString *const kPUDUserDefaultsClientID;
extern NSString *const kPUDUserDefaultsClientSecret;
extern NSString *const kPUDUserDefaultsMessageIDVanilla;
extern NSString *const kPUDUserDefaultsMessageIDCloudPage;
extern NSString *const kPUDUserDefaultsRestUrl;

#pragma mark - Notifications
extern NSString *const kPUDPushConfigChangedNotification;
extern NSString *const kPUDNewPushConfigAddedNotication;
extern NSString *const kPUDPreferencesChanged;

