//
//  PUDPageVIewController.h
//  PublicDemo
//
//  Created by Matt Lathrop on 6/13/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PUDPageContentViewController;

@interface PUDAbstractPageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (NSString *)htmlPrefix;
- (NSArray *)pageHtml;
- (PUDPageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
