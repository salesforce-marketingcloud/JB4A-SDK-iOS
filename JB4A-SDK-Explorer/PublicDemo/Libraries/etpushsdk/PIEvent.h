//
//  PIEvent.h
//  JB4A-SDK-iOS
//
//  Created by Tom Brooks (Contractor) on 1/13/15.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"

static NSString * const PIEVENT_APP_OPEN = @"app_open";
static NSString * const PIEVENT_APP_CLOSE = @"app_close";

static NSString * const PIEVENT_OPEN_FROM_PUSH_TRUE = @"TRUE";
static NSString * const PIEVENT_OPEN_FROM_PUSH_FALSE = @"FALSE";

@interface PIEvent : ETGenericUpdate <NSCopying, ETGenericUpdateObjectProtocol>

//@property static NSString * const APP_OPEN = @"app_open";
//static NSString * const APP_CLOSE = @"app_close";

/**
 DBID if the data was saved in the local database, or zero if this is a new object.
 */
@property (nonatomic, assign, readonly) NSInteger identifier;

/**
 The descriptive value for this detail.
 */
@property (nonatomic, assign) NSInteger detail;

/**
 When the PIEvent happened / was created. Is set to now when the PIEvent is alloc/init-ed.
 */
@property (nonatomic, strong) NSDate *eventDate;

/**
 The descriptive value for this userID.
 */
@property (nonatomic, strong) NSString *userID;

/**
 The descriptive value for this sessionID.
 */
@property (nonatomic, strong) NSString *sessionID;

/**
 The descriptive value for this openFromPush.
 */
@property (nonatomic, strong) NSString *openFromPush;

/**
 The current set of events being tracked by this PIEvent. Add new ones through addEvents:
 */
@property (nonatomic, strong, readonly) NSSet *events;

/**
 The current set of analytics being tracked by this PIEvent.
 */
@property (nonatomic, strong) NSSet *analyticTypes;

/**
 Designated Initializer. Pass in an NSDictionary (usually from the cache db) to create an PIEvent.
 @param dict A dictionary of values
 @return id An PIEvent
 */
-(id)initFromDictionary:(NSDictionary *)dict;

/**
 Adds a specific analyticType to the current set. You may add zero to many, relative to what you're reporting.
 @param statType The analyticType you wish to add. See MobilePushStatisticType enumeration for values.
 */
-(void)addAnalyticType:(NSString *)statType;

/**
 Removes an analytic type from the current set. It will echo out if it was removed, or nil if the value wasn't in there.
 @param statType The type to remove.
 @return An echo of statType if the value was removed, or nil if not.
 */
-(NSString *)removeAnalyticType:(NSString *)statType;

@end
