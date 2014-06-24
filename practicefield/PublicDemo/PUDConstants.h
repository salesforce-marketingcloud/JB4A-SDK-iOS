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
typedef void (^SwitchValueChangedBlock)(UISwitch *);
typedef CGFloat (^CellHeightBlock)();
typedef void (^ConfigureCellBlock)(UITableViewCell *);
typedef void (^PickerViewRowSelectedBlock)(UIPickerView *);
typedef void (^TextFieldDidEndEditingBlock)(UITextField *);

#pragma mark - App Defaults
extern CGFloat const kPUDAppCustomTextSize;
extern NSString *const kPUDAppBarcodeFont;
extern NSString *const kPUDAppSettingsPlistName;

#pragma mark - Attributes
extern NSString *const kPUDAttributeFirstName;
extern NSString *const kPUDAttributeLastName;

#pragma mark - Info Table View
extern NSString *const kPUDInfoAppVersion;
extern NSString *const kPUDInfoAppBundleID;
extern NSString *const kPUDInfoBuildNumber;
extern NSString *const kPUDInfoSDKVersion;
extern NSString *const kPUDInfoBuildType;
extern NSString *const kPUDInfoAppID;
extern NSString *const kPUDInfoAccessToken;
extern NSString *const kPUDInfoClientID;
extern NSString *const kPUDInfoClientSecret;
extern NSString *const kPUDInfoMessageID;
extern NSString *const kPUDInfoPushEnabled;
extern NSString *const kPUDInfoDeviceToken;
extern NSString *const kPUDInfoDeviceID;
extern NSString *const kPUDInfoOpenDirectDelegate;
extern NSString *const kPUDInfoLocationEnabled;
extern NSString *const kPUDInfoAttributeFirstName;
extern NSString *const kPUDInfoAttributeLastName;
extern NSString *const kPUDInfoAttributeNFLTeamTags;
extern NSString *const kPUDInfoAttributeFCTeamTags;

#pragma mark - Message Detail Table View
extern NSUInteger const kPUDMessageDetailCustomSoundSectionIndex;
extern NSUInteger const kPUDMessageDetailCustomKeySectionIndex;
extern NSUInteger const kPUDMessageDetailMessageTextSectionIndex;
extern NSUInteger const kPUDMessageDetailOpenDirectSectionIndex;
extern NSUInteger const kPUDMessageDetailPayloadSectionIndex;
extern NSUInteger const kPUDMessageDetailSendMessageSectionIndex;
extern NSUInteger const kPUDMessageDetailTagsSectionIndex;
extern NSUInteger const kPUDMessageDetailUpdateBadgeSectionIndex;

extern NSUInteger const kPUDMessageDetailSendButtonTag;
extern NSUInteger const kPUDMessageDetailSwitchTag;
extern NSUInteger const kPUDMessageDetailTextFieldTag;

extern NSString *const kPUDMessageDetailCustomKeyDiscountCode;

extern NSString *const kPUDAppMessageDetailDefaultMessageText;
extern NSString *const kPUDMessageDetailDefaultOpenDirect;

#pragma mark - Messages Payload
extern NSString *const kPUDMessagePayloadSoundKey;
extern NSString *const kPUDMessagePayloadMessageTextKey;
extern NSString *const kPUDMessagePayloadOverrideKey;
extern NSString *const kPUDMessagePayloadDeviceTokensKey;
extern NSString *const kPUDMessagePayloadBadgeKey;
extern NSString *const kPUDMessagePayloadTagsKey;
extern NSString *const kPUDMessagePayloadOpenDirectKey;
extern NSString *const kPUDMessagePayloadCustomKeysKey;

extern NSString *const kPUDMessagePayloadDefaultBadgeValue;

#pragma mark - Messages Table View
extern NSUInteger const kPUDMessagesLastReceivedSectionIndex;
extern NSUInteger const kPUDMessagesPushTestsSectionIndex;

#pragma mark - Message Types
extern NSString *const kPUDMessageTypeLocation;
extern NSString *const kPUDMessageTypeOutbound;

#pragma mark - Push Defines
extern NSString *const kPUDPushDefineOpenDirectPayloadKey;

#pragma mark - Reuse Identifiers
extern NSString *const kPUDReuseIdentifierDiscountCell;
extern NSString *const kPUDReuseIdentifierInfoCell;
extern NSString *const kPUDReuseIdentifierMessageCell;
extern NSString *const kPUDReuseIdentifierMessageDetailCell;
extern NSString *const kPUDReuseIdentifierPushReceivedCell;
extern NSString *const kPUDReuseIdentifierSettingCell;
extern NSString *const kPUDReuseIdentifierTagCell;

#pragma mark - Segues
extern NSString *const kPUDSegueMessagesToLastReceivedPush;
extern NSString *const kPUDSegueMessagesToMessageDetail;
extern NSString *const kPUDSeguePushReceivedToDiscount;

#pragma mark - Settings Table View
extern NSUInteger const kPUDSettingsPersonalInformationSectionIndex;
extern NSUInteger const kPUDSettingsFootballSectionIndex;
extern NSUInteger const kPUDSettingsSoccerSectionIndex;

#pragma mark - Storyboard Identifiers
extern NSString *const kPUDStoryboardIdentifierPushReceivedTableViewController;
extern NSString *const kPUDStoryboardIdentifierDiscountCodeViewController;

#pragma mark - Storyboard Name
extern NSString *const kPUDStoryboardMain;

#pragma mark - Tags
extern NSString *const kPUDTagCowboys;
extern NSString *const kPUDTagPackers;
extern NSString *const kPUDTagGiants;
extern NSString *const kPUDTagSteelers;
extern NSString *const kPUDTagColts;
extern NSString *const kPUDTagArsenal;
extern NSString *const kPUDTagChelsea;
extern NSString *const kPUDTagManu;
extern NSString *const kPUDTagMadrid;
extern NSString *const kPUDTagFcbarc;

#pragma mark - User Defaults
extern NSString *const kPUDUserDefaultsFirstName;
extern NSString *const kPUDUserDefaultsLastName;
extern NSString *const kPUDUserDefaultsLastPushReceivedDate;
extern NSString *const kPUDUserDefaultsPushUserInfo;
extern NSString *const kPUDUserDefaultsMessageType;
extern NSString *const kPUDUserDefaultsAlertText;
