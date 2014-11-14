//
//  ETEvent.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 7/21/14.
//  Copyright (c) 2014 ExactTarget, Inc. All rights reserved.
//

#import "ETGenericUpdate.h"

/**
 Local definitions of the Middle Tier Statistic Type enumeration. 
 */
typedef NS_ENUM(NSUInteger, MobilePushStatisticType) {
    MobilePushStatisticTypeNone = 0, /** Unknown value. */
    MobilePushStatisticTypeSend __attribute__((deprecated)), /** MT - designates a push send. DO NOT USE */
    MobilePushStatisticTypeOpen, /** Push Message or Local Notification opened. Must be accompanied by a message ID in objectIds.*/
    MobilePushStatisticTypeDisplay, /** Used when we schedule a UILocalNotification for display. Must be accompanied by the ETMessage messageIdentifier and ETRegion fenceIdentifier.*/
    MobilePushStatisticTypeTimeInApp, /** How long the user was in the app. Must be accmopanied by a non-zero Value. */
    MobilePushStatisticTypeTimeInAppOpens __attribute__((deprecated)), /** MT - combined value for legacy purposes. DO NOT USE */
    MobilePushStatisticTypeFenceEntry, /** Used to mark entrance in an ETRegion. Must be accompanied by a ETRegion fenceIdentifier. */
    MobilePushStatisticTypeFenceExit, /** Used to mark exit from an ETRegion. Must be accompanied by a ETRegion fenceIdentifier. */
    MobilePushStatisticTypeActiveUsers __attribute__((deprecated)), // MT - DO NOT USE
    MobilePushStatisticTypeInactiveUsers __attribute__((deprecated)), // MT - DO NOT USE
    MobilePushStatisticTypeReceived, /** FUTURE - Use to indicate push message receipt on device. */
    MobilePushStatisticTypeTimeInLocation, /** How long the user spent in a given ETRegion - GEOFENCE ONLY. Must be accompanied by a non-zero Value. */
    MobilePushStatisticTypeBeaconInRange, /** Indicates which ETRegion iBeacon prompted the trigger. Must be accompanied by a ETRegion fenceIdentifier. */
    MobilePushStatisticTypeTimeWithBeaconInRange /** How long the user spent in *any* proximity of a known ETRegion iBeacon. Must be accompanied by a non-zero Value and an ETRegion fenceIdentifier.*/
};

/**
 ETEvent is the new form of analytics for the MobilePush SDK, replacing ETStatsUpdate. It is more flexible in that it can return multiple types of events in one pass. As such, things that are related to each other should be sent back together, and things that are not should be sent separately. It is also unique amongst the ETGenericUpdates in that it was designed to be bulk-sent back to ET, and not individually like the rest. 
 
 An ETEvent is comprised of some combination of the following: a Value, or the amount of units that we are currently measuring, zero or many ObjectIds, or the ET encoded IDs for things like messages, fences, etc, and one or many AnalyticTypes, or what analytics are contained in this update. One common use of this is time in app - If a user spends 60 seconds (1 minute) in the app, you would make an ETEvent with a value of 60 and add the analytic type MobilePushStatisticTypeTimeInApp. If you want to add a message ID for an open, add a second analyticType of MobilePushStatisticTypeOpen and add the objectId of the message ID (_m). Easy peasey.
 
 Some of the enum values are marked deprecated, which indicates that they should not be used in the SDK. These enum values are for analytics on the Middle Tier only. Do not use these in ETEvents.
 */
@interface ETEvent : ETGenericUpdate <NSCopying, ETGenericUpdateObjectProtocol>

/**
 DBID if the data was saved in the local database, or zero if this is a new object. 
 */
@property (nonatomic, assign, readonly) NSInteger identifier;

/**
 When the ETEvent happened / was created. Is set to now when the ETEvent is alloc/init-ed. 
 */
@property (nonatomic, strong, readonly) NSDate *eventDate;

/**
 The descriptive value for this ETEvent. It is relative to the analyticTypes. 
 */
@property (nonatomic, assign) NSInteger value;

/**
 The current set of analyticTypes being tracked by this ETEvent. Add new ones through addAnalyticType:
 */
@property (nonatomic, strong, readonly) NSSet *analyticTypes;

/**
 The current set of objectIds being tracked by this ETEvent. Add new ones through addObjectId:
 */
@property (nonatomic, strong, readonly) NSSet *objectIds;

/**
 Designated Initializer. Pass in an NSDictionary (usually from the cache db) to create an ETEvent.
 @param dict A dictionary of values 
 @return id An ETEvent
 */
-(id)initFromDictionary:(NSDictionary *)dict;

/**
 Adds a specific analyticType to the current set. You may add zero to many, relative to what you're reporting. 
 @param statType The analyticType you wish to add. See MobilePushStatisticType enumeration for values.
 */
-(void)addAnalyticType:(MobilePushStatisticType)statType;

/**
 Removes an analytic type from the current set. It will echo out if it was removed, or nil if the value wasn't in there.
 @param statType The type to remove. 
 @return An echo of statType if the value was removed, or nil if not. 
 */
-(MobilePushStatisticType)removeAnalyticType:(MobilePushStatisticType)statType;

/**
 Adds a specific ObjectID to the current set. These values are all encoded by the time they're on the device, so you can add any of them, regardless of what they are - meaning, Message ID (_m), Fence ID (ETRegion fenceIdentifier), etc. Just throw them in. 
 @param objectId An objectID to add
 */
-(void)addObjectId:(NSString *)objectId;

/**
 Removes a specific ObjectID from the set, and echoes it if it was removed, or nil if the value wasn't in there.
 @param objectId The objectId to add
 @return An echo of objectId if it was removed, or nil if it wasn't found.
 */
-(NSString *)removeObjectId:(NSString *)objectId;

@end
