//
//  Message.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"
#import "ETRegion.h"
#import "ETEventMessage.h"
#import "ETCloudPage.h"
#import "PushConstants.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *kMessagesTableName = @"messages";
static NSString *kMessagesPreferencesKey = @"messagesPreferencesKey";

/**
 Tracks where the currently parsing dictionary came from, because we run the values through twice to merge them together. 
 */
typedef NS_ENUM(NSInteger, MPMessageSource)
{
    /** Database */
    MPMessageSourceDatabase,
    /** Salesforce via REST */
    MPMessageSourceRemote
};


/**
 ETMessage is the local representation of a Message from Salesforce. They are multipurpose, sometimes representing a message that should be scheduled because of the entrance or exit of a Geofence, the proximal arrival to an iBeacon, or a CloudPage message downloaded from ET. Because of their multipurpose nature, there are a lot of different attributes on them, many of which may be null at any give time depending on the type of message.
 
 ETMessages also feature Message Limiting, a system of preventing a given message from firing too often. If described in a sentence with the parameters interlaced, it would read "show this message only 1 (messagesPerPeriod) time per 1 (numberOfPeriods) hour (periodType). As of a recent release, messagesPerPeriod will be defaulted to 1 on the Middle Tier, so if it is null or absent, we assume 1, otherwise take the given value.
 
 Many of these accessors are readonly because the value should be trusted and not changed. There are specific methods to modify the message, such as markAsRead or markAsDeleted. Also, unless specifically marked in a method, only active methods are returned through the getter methods. 
 */
@interface ETMessage : ETGenericUpdate

/**
 Encoded ID from Salesforce. Will match the ID in MobilePush. This is the primary key.
 */
@property (nonatomic, strong, readonly, nullable) NSString *messageIdentifier;

/**
 This is the name which is set on SalesforceMarketingCloud, while setting the ETMessage
 */
@property (nonatomic, strong, nullable) NSString *messageName;

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
@property (nonatomic, strong, readonly, nullable) NSString *alert;

/**
 The sound that should play, if any. Most of the time, either "default" or "custom.caf", conventions enforced in MobilePush. 
 */
@property (nonatomic, strong, readonly, nullable) NSString *sound;

/**
 The badge modifier. This should be a NSString in the form of "+1" or nothing at all. It's saved as a string because of that.
 */
@property (nonatomic, strong, readonly, nullable) NSString *badge;

/**
 The category name for an interactive notification if it has one.
 */
@property (nonatomic, strong, readonly, nullable) NSString *category;

/**
 An array of Key Value Pairs, or Custom Keys in local parlance, for this message. This will contain NSDictionary objects.
 */
@property (nonatomic, strong, readonly, nullable) NSArray *keyValuePairs;

/**
 The message's start date. Messages shouldn't show before this time. 
 */
@property (nonatomic, strong, readonly, nullable) NSDate *startDate;

/** 
 The message's end date. Messages shouldn't show after this time.
 */
@property (nonatomic, strong, readonly, nullable) NSDate *endDate;

/** 
 The Site ID for the CloudPage attached to this message. 
 */
@property (nonatomic, strong, readonly, nullable) NSString *siteIdentifier;

/** 
 The Site URL for the ClouePage attached to this message. It is saved as an NSString and converted later to NSURL.
 */
@property (nonatomic, strong, readonly, nullable) NSString *siteUrlAsString;

/**
 OpenDirect payload for this message, if there is one. 
 */
@property (nonatomic, strong, readonly, nullable) NSString *openDirectPayload;

/**
 DEPRECTED. The related ETRegion for this message. This is a remnant of days when the relationship was one to one. It is not anymore. 
 */
@property (nonatomic, strong, readonly, nullable) ETRegion *relatedFence;

/**
 The total number of times, ever, that a message will show on a device. 
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *messageLimit;

/**
 The total number of times for a given number of time units that a message can be shown. In the statement "show 1 time per 2 hours", this is the "1" part.
 
 This defaults to 1 if it is not set in the received payload from Salesforce.
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *messagesPerPeriod;

/**
 The number of time periods in which a message should be limited. In the statement "show 1 time per 2 hours", this is the "2" part.
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *numberOfPeriods;

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
 The number of times an ETRegion must be tripped before the message shows. This is not currently used, and is a placeholder for future functionality. 
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *minTripped;

/**
 Ephemeral Messages disappear when the user walks away from the iBeacon that tripped the message. The default value is NO.
 */
@property (nonatomic, readonly, getter = isEphemeralMessage) BOOL ephemeralMessage;

/**
 For iBeacon messages, the proximity the user must arrive in before the message is fired. It is treated as a "less than" value, meaning if the message is set to Far, the message can be shown in Far, Near or Immediate.
 */
@property (nonatomic, readonly) CLProximity proximity;

/**
 The number of seconds the user must stand near an iBeacon before the message is displayed. This is treated as an offset in scheduling the UILocalNotification, which will be cancelled if the user walks away too early. 
 */
@property (nonatomic, readonly) NSInteger loiteringSeconds;

/**
 Whether or not the message has been read. This must be set through markAsRead by the developer.
 */
@property (nonatomic, getter = isRead, readonly) BOOL read;

/**
 Whether or not the message is active in the local database. 
 */
@property (nonatomic, getter = isActive, readonly) BOOL active;

/**
 A reference to a unique notification identifer which corresponds to the notifcation triggered for this message. It is used later to cancel the message if need be.
 */
@property (nonatomic, copy, nullable) NSString *notificationID;

/**
 Used while ranging beacons to determine if a message for a beacon has been shown based on the proximity trigger.
 */
@property (nonatomic) BOOL hasShownForBeacon;

/**
 Creates a new ETMessage with values in the given NSDictionary. 
 @param dict A dictionary of values to apply to the ETMessage
 @return A new ETMessage
 */
-(nullable instancetype)initFromDictionary:(NSDictionary<__kindof NSString *, id> *)dict;

/**
 Designated Initializer. Creates a new ETMessage with values from an NSDictionary for a specific ETRegion. 
 @param dict A dictionary of values to apply to the ETMessage
 @param region The ETRegion that prompted the creation of this ETMessage
 @return A new ETMessage
 */
-(nullable instancetype)initFromDictionary:(NSDictionary<__kindof NSString *, id> *)dict forFence:(nullable ETRegion *)region;

/**
 This is an overridden accessor for subj ect to handle some business logic around what to show. Use this for display in an inbox.
 */
-(nullable NSString *)subject; // Public getter, now with logic.

/**
 Cleanses and returns the Sites URL as a proper NSURL. This is mostly for convenience.
 */
-(nullable NSURL *)siteURL;

/**
 Marks a message as read in the local cache. Read messages do not show up in the Inbox.
 */
-(BOOL)markAsRead;

/**
 Records a message as scheduled, and updates the fun, fun logic around when it should again, if it should of course. 
 */
-(BOOL)messageScheduledForDisplay;

/**
 Marks a message as unread. Just for convenience. 
 */
-(BOOL)markAsUnread;

/**
 Marks a message as deleted. They will not be returned after this, and it's irreversable.
 */
-(BOOL)markAsDeleted;

/** Methods for testing */
/**
 Getter for a private value, lastShownDate.
 @return The Last Shown Date, if any.
 */
- (nullable NSDate *) getLastShownDate;

/**
 Getter for a private value, showCount.
 @return The show count for this message. 
 */
- (int) getShowCount;

/**---------------------------------------------------------------------------------------
 * @name Message Retrieval Helpers
 *  ---------------------------------------------------------------------------------------
 */

/**
 Gets all active messages for a specific contentType, usually Cloud Pages.
 
 @param contentType a MobilePushContentType value.
 @return NSArray value. An NSArray of ETMessages
 */
+(nullable NSArray<__kindof ETMessage*> *)getMessagesByContentType:(MobilePushContentType)contentType;

/**
 Gets a specific ETMessage for a given identifer. 
 
 @param identifier a NSString value. The Message ID to retrieve
 @return The ETMessage, or nil if not found in the database.
 */
+(nullable ETMessage *)getMessageByIdentifier:(NSString *)identifier;

/**
 Gets all active ETMessages for a specific message type, like Fence Entry, Exit or Proximity.
 @param type The MobilePushMessageType you'd like back
 @return An array of ETMessages.
 */
+(nullable NSArray<__kindof ETMessage*> *)getMessagesByType:(MobilePushMessageType)type;

/**
 Gets all active ETMessages tied to a specific ETRegion (Geofence).
 @param fence The ETRegion for which you would like messages
 @return An NSArray of ETMessages
 */
+(nullable NSArray<__kindof ETMessage*> *)getMessagesForGeofence:(ETRegion *)fence;

/**
 Gets all active ETMessages tied to a specific ETRegion (Geofence) and MobilePushMessageType, like Entry ot Exit.
 @param fence The ETRegion for which you would like messages
 @param type The MobilePushMessageType that describes the messages you want
 @return An NSArray of ETMessages that meet the criteria asked for.
 */
+(nullable NSArray<__kindof ETMessage*> *)getMessagesForGeofence:(ETRegion *)fence andMessageType:(MobilePushMessageType)type;

/**
 Gets all active ETMessages for a specific ETRegion (Proximity). 
 @param region The ETRegion for which you would like messages
 @return An NSArray of ETMessages
 */
+(nullable NSArray<__kindof ETMessage*> *)getProximityMessagesForRegion:(ETRegion *)region; // withRangedBeaconProximity:(CLProximity)prox;

/**
 Triggeres a data pull from Salesforce for messages that meet the supplied requirements.
 @param messageType The Message Type you wish to retrieve
 @param contentType The Content Type you wish to retrieve
 @return Doesn't return a value, but has delegate callbacks. 
 */
+(void)getMessagesFromExactTargetOfMessageType:(MobilePushMessageType)messageType andContentType:(MobilePushContentType)contentType;

/**
 Marks all messages for a given type as inactive. This is done prior to processing new messages just received from Salesforce. 
 @param type The MobilePushMessageType you wish to invalidate
 @return T/F if the invalidation query worked
 */
+(BOOL)invalidateAllMessagesForType:(MobilePushMessageType)type;

/**
 Marks all messages for a given content type as inactive. This is done prior to processing new messages just received from Salesforce.
 @param type The MobilePushContentType you wish to invalidate
 @return T/F if the invalidation query worked
 */
+(BOOL)invalidateAllMessagesForContentType:(MobilePushContentType)type;

/**
 ETMessage equality. Since object equality won't always work, this compares messageIdentifiers to determine equality.
 @param message The ETMessage to compare self to
 @return T/F if the messages are equal.
 */
-(BOOL)isEqualToMessage:(ETMessage *)message;

-(nullable ETEventMessage *) messageAsETEventMessage;
-(nullable ETCloudPage *) messageAsETCloudPage;


@end
NS_ASSUME_NONNULL_END
