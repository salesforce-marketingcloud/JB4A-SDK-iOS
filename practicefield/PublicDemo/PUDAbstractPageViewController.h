//
//  PUDPageVIewController.h
//  PublicDemo
//
//  Created by Matt Lathrop on 6/13/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PUDPageContentViewController;

/**
 *  This class is responsible for displaying the PageViewControllers that are seen throughout the app
 */
@interface PUDAbstractPageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

/**
 *  The prefix that should be prepending to the beginning of every page's html
 */
- (NSString *)htmlPrefix;

/**
 *  The html that is displayed on the page
 */
- (NSArray *)pageHtml;

@end
