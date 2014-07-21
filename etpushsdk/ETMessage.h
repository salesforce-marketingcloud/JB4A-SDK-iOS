//
//  Message.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 7/24/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import "GenericUpdate.h"
#import "Geofence.h"
#import "Region.h"

/**
 Enumeration of possible message types. This corresponds to the template types available through the MobilePush UI. 
 
 Note that MobilePushMessageTypeEnhanced is not used. To determine if a message has a CloudPage component, check MobilePushContentType.
 */
typedef NS_ENUM(NSUInteger, MobilePushMessageType){
    MobilePushMessageTypeUnknown,
    MobilePushMessageTypeBasic,
    MobilePushMessageTypeEnhanced,
    MobilePushMessageTypeFenceEntry,
    MobilePushMessageTypeFenceExit
};

/**
 Bitmask determining the features of a particular message. 
 */
typedef NS_OPTIONS(NSUInteger, MobilePushContentType){
    MobilePushContentTypeNone           = 0,
    MobilePushContentTypeAlertMessage   = 1 << 0,
    MobilePushContentTypePage           = 1 << 1
};

/**
 Enumeration of the frequency units used in message limiting. 
 */
typedef NS_ENUM(NSInteger, MobilePushMessageFrequencyUnit){
    MobilePushMessageFrequencyUnitNone,
    MobilePushMessageFrequencyUnitYear,
    MobilePushMessageFrequencyUnitMonth,
    MobilePushMessageFrequencyUnitWeek,
    MobilePushMessageFrequencyUnitDay,
    MobilePushMessageFrequencyUnitHour
};

/**
 Enumeration used to track the source of a message. Used internally. 
 */
typedef NS_ENUM(NSInteger, MPMessageSource){
    MPMessageSourceDatabase,
    MPMessageSourceRemote
};

/**
 ETMessage is a representation of the messages sent by ExactTarget. It's a flexible object that can define various types of messages (standard push, geofenced, proximity, CloudPages, etc), but this means that sometimes not all properties will be set. 
 
 The most public use of ETMessage is in the CloudPages inbox implementation. The ExactTargetEnhancedPushDataSource object has an array of ETMessages by the name of messages. These are used in populating the inbox.
 
 */
@interface ETMessage : GenericUpdate

/**
 Unique identifier for a message. This originates from ExactTarget and will match Message ID on the server.
 */
@property (nonatomic, strong, readonly) NSString *messageIdentifier;

/**
  Identifies this type of message more specifically. See the MobilePushMessageType enumeration for types.
 */
@property (nonatomic, readonly) MobilePushMessageType messageType;

/**
 Identifies the content type of the message. This is an enum used to differentiate types of messages.
 */
@property (nonatomic, readonly) MobilePushContentType contentType;

/**
 The message alert text.
 */
@property (nonatomic, strong, readonly) NSString *alert;

/**
 The name of the sound to play on alert. Either nil, "default," "custom.caf," or something custom and unsupported by the MobilePush UI.
 */
@property (nonatomic, strong, readonly) NSString *sound;

/**
 The amount to modify the badge icon. Usually nil or "+1".
 */
@property (nonatomic, strong, readonly) NSNumber *badge;

/**
 An array of NSDictionaries of the Custom Keys sent by ExactTarget.
 */
@property (nonatomic, strong, readonly) NSArray *keyValuePairs;

/**
 The effective scheduling date for a message. 
 */
@property (nonatomic, strong, readonly) NSDate *startDate;

/**
 The date a message should stop being shown/fired. 
 */
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 Used by CloudPages, this is the unique ID of the site associated to the message. May be null.
 */
@property (nonatomic, strong, readonly) NSString *siteIdentifier;

/** 
 A string of the CloudPage URL. May be null if this isn't an Enhanced Push message.
 */
@property (nonatomic, strong, readonly) NSString *siteUrlAsString;

/**
 The OpenDirect payload specified at message activiation time. This will ultimately be passed to the OpenDirect delegate if set, or will open a webpage if not.
 */
@property (nonatomic, strong, readonly) NSString *openDirectPayload;

/**
 A remnant of when messages to fences were one to one. This can be disregarded. 
 */
@property (nonatomic, strong, readonly) Region *relatedFence;

/**
 The total number of times a message should be shown. 
 */
@property (nonatomic, strong, readonly) NSNumber *messageLimit;

/**
 The number of times per one period that a message should show. ET default is 1.
 */
@property (nonatomic, strong, readonly) NSNumber *messagesPerPeriod;

/**
 The number of time units that a message should wait between fires. 
 */
@property (nonatomic, strong, readonly) NSNumber *numberOfPeriods;

/**
 The type of time unit that describes numberOfPeriods. 
 */
@property (nonatomic, readonly) MobilePushMessageFrequencyUnit periodType;

/**
 Whether or not the period is rolling. What this means is whether or not the next period starts at a zero unit for the next window, or just add the number of units * period type.
 
 For example, consider a message that should show once per one hour, and that message fires at 11:53am. If the period is rolling, the next earliest time it can fire is 12:53pm. If it is *not* rolling, it can fire again at 12:00pm, because that is the start of a new hour.
 */
@property (nonatomic, readonly, getter = isRollingPeriod) BOOL rollingPeriod;

/**
 Whether or not the message has been marked read. This applies to CloudPages.
 */
@property (nonatomic, getter = isRead, readonly) BOOL read;

/**
 Whether or not the message was marked deleted. This applies to CloudPage messages only.
 */
@property (nonatomic, getter = isMessageDeleted, readonly) BOOL messageDeleted;

/**
 Whether or not the message is marked active. This reflects it's state on ExactTarget's server.
 */
@property (nonatomic, getter = isActive, readonly) BOOL active;


/**
 This will return a new, populated ETMessage from a dictionary. Third party developers shouldn't call this method on their own.
 */
-(id)initFromDictionary:(NSDictionary *)dict;

/**
 Designated initializer. Returns a new ETMessage for a specific fence fromm a dictionary. 
 */
-(id)initFromDictionary:(NSDictionary *)dict forFence:(Region *)region;

/**
 This is an overridden accessor for subject to handle some business logic around what to show. Use this for display in an inbox.
 */
-(NSString *)subject; // Public getter, now with logic.

/**
 Cleanses and returns the Sites URL as a proper NSURL. This is mostly for convenience.
 */
-(NSURL *)siteURL;

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
 Marks a message as deleted. There is no coming back from this. 
 */
-(BOOL)markAsDeleted;

/**
 Returns a specific message (or nil) got a given identifier. The Identifier is the ET Message ID.
 
 @param identifier A string Message ID from ET
 @return An ETMessage generated.
 */
+(ETMessage *)getMessageByIdentifier:(NSString *)identifier;

/**
 Return all messages by specific content type.
 
 @param contentType The MobilePushContentType that you would like messages for.
 @return An array of ETMessages that have the content type you asked for.
 */
+(NSArray *)getMessagesByContentType:(MobilePushContentType)contentType;

/**
 Returns messages by message type. A message type can be standard push, loc entry or exit, or proximity. 
 
 @param type The MobilePushMessageType you would like messages for. 
 @return An array of ETMessages that meet that criteria.
 */
+(NSArray *)getMessagesByType:(MobilePushMessageType)type;

/**
 Returns all messages for a specific region.
 */
+(NSArray *)getMessagesForGeofence:(Region *)fence;

/**
 Returns all messages for a specific region of a specific kind (like, loc entry or exit).
 */
+(NSArray *)getMessagesForGeofence:(Region *)fence andMessageType:(MobilePushMessageType)type;

/**
 Triggers a message request from ExactTarget's servers. Please do not call this one.
 */
+(void)getMessagesFromExactTargetOfMessageType:(MobilePushMessageType)messageType andContentType:(MobilePushContentType)contentType;

/**
 Invalidates all messages in the cache for a speecific message type. 
 
 @param type The type of message to invalidate. 
 @return Successfulness of the request.
 */
+(BOOL)invalidateAllMessagesForType:(MobilePushMessageType)type;

@end
