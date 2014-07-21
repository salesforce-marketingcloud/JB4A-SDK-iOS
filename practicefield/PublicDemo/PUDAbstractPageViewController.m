//
//  PUDPageVIewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 6/13/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDAbstractPageViewController.h"

// Controllers
#import "PUDPageContentViewController.h"

@interface PUDAbstractPageViewController ()

@end

@implementation PUDAbstractPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  Handle layout differences between iOS 6 and 7
     */
    NSUInteger heightDifference = 49;
    if (IOS_PRE_7_0) {
        heightDifference = 0;
    }
    
    // Create page view controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    
    PUDPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - heightDifference);
    
    // set up background colors
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (NSString *)htmlPrefix {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSArray *)pageHtml {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (PUDPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([[self pageHtml] count] == 0) || (index >= [[self pageHtml] count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PUDPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PUDPageContentViewController"];
    pageContentViewController.html = [self.htmlPrefix stringByAppendingString:[[self pageHtml]  objectAtIndex:index]];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PUDPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PUDPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [[self pageHtml] count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [[self pageHtml] count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
