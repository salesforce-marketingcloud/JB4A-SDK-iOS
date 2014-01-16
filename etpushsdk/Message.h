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

#import "PushConstants.h"


typedef NS_ENUM(NSUInteger, MobilePushMessageType)
{
    MobilePushMessageTypeUnknown,
    MobilePushMessageTypeBasic,
    MobilePushMessageTypeEnhanced,
    MobilePushMessageTypeFenceEntry,
    MobilePushMessageTypeFenceExit
};


typedef NS_OPTIONS(NSUInteger, MobilePushContentType) {
    MobilePushContentTypeNone           = 0,
    MobilePushContentTypeAlertMessage   = 1 << 0,
    MobilePushMessageTypePage           = 1 << 1
};

typedef NS_ENUM(NSInteger, MPMessageSource)
{
    MPMessageSourceDatabase,
    MPMessageSourceRemote
};

@interface Message : GenericUpdate

@property (nonatomic, strong, readonly) NSString *messageIdentifier;
@property (nonatomic, readonly) MobilePushMessageType messageType;
@property (nonatomic, readonly) MobilePushContentType contentType;
@property (nonatomic, strong, readonly) NSString *alert;
@property (nonatomic, strong, readonly) NSString *sound;
@property (nonatomic, strong, readonly) NSNumber *badge;
@property (nonatomic, strong, readonly) NSArray *keyValuePairs;
@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;
@property (nonatomic, strong, readonly) NSString *siteIdentifier;
//@property (nonatomic, strong, readonly) NSString *subject;
@property (nonatomic, strong, readonly) NSString *siteUrlAsString;
@property (nonatomic, strong, readonly) NSString *openDirectPayload;
@property (nonatomic, strong, readonly) Region *relatedFence;

// Things for frequency
@property (nonatomic, strong, readonly) NSNumber *messageLimit;
@property (nonatomic, strong, readonly) NSNumber *messagesPerPeriod;
@property (nonatomic, strong, readonly) NSNumber *numberOfPeriods;
@property (nonatomic, readonly) PushMessageFrequencyUnit periodType;
@property (nonatomic, readonly, getter = isRollingPeriod) BOOL rollingPeriod;


@property (nonatomic, getter = isRead, readonly) BOOL read;
@property (nonatomic, getter = isActive, readonly) BOOL active;

-(id)initFromDictionary:(NSDictionary *)dict;
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

+(Message *)getMessageByIdentifier:(NSString *)identifier;
+(NSArray *)getMessagesByType:(MobilePushMessageType)type;
+(NSArray *)getMessagesForGeofence:(Region *)fence;
+(NSArray *)getMessagesForGeofence:(Region *)fence andMessageType:(MobilePushMessageType)type;
+(void)getMessagesFromExactTargetOfMessageType:(MobilePushMessageType)messageType andContentType:(MobilePushContentType)contentType;

+(BOOL)invalidateAllMessagesForType:(MobilePushMessageType)type;

@end
