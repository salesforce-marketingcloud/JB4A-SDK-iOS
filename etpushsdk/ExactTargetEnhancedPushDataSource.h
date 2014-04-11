//
//  ExactTargetEnhancedPushDataSource.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 8/23/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import <UIKit/UIKit.h> // need UITableViewDataSource, so we use UIKit, not Foundation

/**
 The ExactTargetEnhancedPushDataSource is an interface object for CloudPage support. It was designed to be used as the datasource for a UITableView, and can be allocated and used as such without too much other customization. Of course, you are welcomed to use it any way you want other than that.
 
 */
@interface ExactTargetEnhancedPushDataSource : NSObject <UITableViewDataSource>

/**
 This array contains EnhancedMessages, suitable for display in a UITableView or other presentation apparatus of your liking. Please see EnhancedMessage for a list of properties available.
 */
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, weak) UITableView *inboxTableView;

@end
