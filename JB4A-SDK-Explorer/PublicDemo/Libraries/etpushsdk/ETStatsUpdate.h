//
//  StatsUpdate.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 8/2/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"
#import "ETMessage.h"

@interface ETStatsUpdate : ETGenericUpdate <NSCopying>

@property (nonatomic) NSInteger secondsInApp; /* time in app, in seconds */
@property (nonatomic, strong) NSString *messageID; /* from ET, the message identifier. */
@property (nonatomic, strong) NSString *fenceID; /* which fence got broken */
@property (nonatomic, strong) NSDate *displayDate; /* for local notifications, this is shown when they fire. ie, firedate */
@property (nonatomic, strong) NSDate *openDate; /* generic open date, maybe null usually, since no one opens our apps */
@property (nonatomic) MobilePushMessageType messageType;

@end
