//
//  PUDCloudPageInboxDataSource.h
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

// Libraries
#import "ExactTargetEnhancedPushDataSource.h"

@class ETMessage;

/**
 *  ET_NOTE: This class inherits from the ExactTargetEnhancedPushDataSource class. You don't have to do this in order to use CloudPages. If you would like to use CloudPages with the default look and datasource handling you can just create an instance of the ExactTargetEnhancedPushDataSource class and set it as your table view's datasource
 */
@interface PUDCloudPageInboxDataSource : ExactTargetEnhancedPushDataSource

/**
 *  This enum is used in order to control filtering of messages
 */
typedef enum {
    kCloudPageInboxFilterAll,
    kCloudPageInboxFilterUnread,
    kCloudPageInboxFilterRead
} kCloudPageInboxFilter;

/**
 *  This is used to control cloudpage message filtering inside the UI
 *
 *  @param filter The enum corresponding to the filter that is currently selected
 */
- (void)setCloudPageInboxFilter:(kCloudPageInboxFilter)filter;

/**
 *  Helper method providing a quick way to retrieve the ETMessage that is at the current indexPath. This class provides this method due to the way the filtering is handled
 *
 *  @param indexPath The indexPath of the message to retrieve
 *
 *  @return The ETMessage object containing the CloudPage message along with other good stuff
 */
- (ETMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
