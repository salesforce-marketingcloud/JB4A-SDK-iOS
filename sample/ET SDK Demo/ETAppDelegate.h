//
//  ETAppDelegate.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 9/5/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPush.h"


@class ETViewController;

@interface ETAppDelegate : UIResponder <UIApplicationDelegate, ExactTargetOpenDirectDelegate>
{
    ETData *etData;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ETViewController *viewController;

@end
