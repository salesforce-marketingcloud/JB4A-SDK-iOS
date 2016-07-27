//
//  ETEventMessage.h
//  JB4A-SDK-iOS
//
//  Copyright © 2016 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushConstants.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ETEventMessage is the local representation of a Message from Salesforce. They are multipurpose, sometimes representing a message that should be scheduled because of the entrance or exit of a Geofence, the proximal arrival to an iBeacon, or a CloudPage message downloaded from ET. Because of their multipurpose nature, there are a lot of different attributes on them, many of which may be null at any give time depending on the type of message.
 */

@interface ETEventMessage : NSObject

/**
 Encoded ID from Salesforce. Will match the ID in MobilePush. This is the primary key.
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageIdentifier;

/**
 This is the name which is set on SalesforceMarketingCloud, while setting the ETMessage
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageName;

/**
 The type of ETMessage being represented.
 */
@property (nonatomic, readonly) MobilePushMessageType messageType;

/**
 Bitmask of features that this message has on it (CloudPage, Push only)
 */
@property (nonatomic, readonly) MobilePushContentType contentType;

/**
 The alert text of the message. This displays on the screen.
 */
@property (nonatomic, readonly, copy, nullable) NSString *alert;

/**
 The sound that should play, if any. Most of the time, either "default" or "custom.caf", conventions enforced in MobilePush.
 */
@property (nonatomic, readonly, copy, nullable) NSString *sound;

/**
 The badge modifier. This should be a NSString in the form of "+1" or nothing at all. It's saved as a string because of that.
 */
@property (nonatomic, readonly, copy, nullable) NSString *badge;

/**
 The category name for an interactive notification if it has one.
 */
@property (nonatomic, readonly, copy, nullable) NSString *category;

/**
 An array of Key Value Pairs, or Custom Keys in local parlance, for this message. This will contain NSDictionary objects.
 */
@property (nonatomic, readonly, copy, nullable) NSArray *keyValuePairs;

/**
 The message's start date. Messages shouldn't show before this time.
 */
@property (nonatomic, readonly, copy, nullable) NSDate *startDate;

/**
 The message's end date. Messages shouldn't show after this time.
 */
@property (nonatomic, readonly, copy, nullable) NSDate *endDate;


/**
 The Site URL for the CloudPage attached to this message. 
 */
@property (nonatomic, readonly, copy, nullable) NSString *siteUrlAsString;

/**
 OpenDirect payload for this message, if there is one.
 */
@property (nonatomic, readonly, copy, nullable) NSString *openDirectPayload;


/**
 The total number of times, ever, that a message will show on a device.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *messageLimit;

/**
 The total number of times for a given number of time units that a message can be shown. In the statement "show 1 time per 2 hours", this is the "1" part.
 
 This defaults to 1 if it is not set in the received payload from Salesforce.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *messagesPerPeriod;

/**
 The number of time periods in which a message should be limited. In the statement "show 1 time per 2 hours", this is the "2" part.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *numberOfPeriods;

/**
 The time unit counted in numberOfPeriods. In the statement "show 1 time per 2 hours", this is the "hours" part.
 */
@property (nonatomic, readonly) MobilePushMessageFrequencyUnit periodType;

/**
 Whether or not the period is a rolling period. Defaults to YES through code.
 
 Consider a message being fired at 2:19PM, and it may only be shown once per hour. In a rolling period, the next time it may show is 3:19PM. In a non-rolling period, the next earliest showing time is 3:00PM, the start of the next hour.
 */
@property (nonatomic, readonly, getter = isRollingPeriod) BOOL rollingPeriod;


/**
 Use this for display in an inbox.
 */
@property (nonatomic, readonly, copy, nullable) NSString *subject;

/**
 A Cleansed Site URL as a proper NSURL. This is mostly for convenience.
 */
@property (nonatomic, readonly, copy, nullable) NSURL *siteURL;



@end
NS_ASSUME_NONNULL_END
