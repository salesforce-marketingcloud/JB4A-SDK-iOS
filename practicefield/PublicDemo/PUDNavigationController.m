//
//  PUDNavigationController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/13/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDNavigationController.h"

@interface PUDNavigationController ()

@end

@implementation PUDNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS_PRE_7_0) {
        self.navigationBar.tintColor = [UIColor etPrimaryOrange];
    } else {
        self.navigationBar.barTintColor = [UIColor etPrimaryOrange];
        self.navigationBar.tintColor = [UIColor whiteColor];
    }

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
