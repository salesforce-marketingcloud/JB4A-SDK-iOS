//
//  PUDAppDelegate.h
//  PushDemo
//
//  Created by Matt Lathrop on 4/29/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

// Libraries
#import "ETPush.h"

/**
 *  ET_NOTE: To display/handle OpenDirect links other than http or https you have to implement the ExactTargetOpenDirectDelegate protocol. If you only plan on sending http or https OpenDirect links then you don't have to specify an ExactTargetOpenDirectDelegate as the SDK can display these schemes automatically
 */
@interface PUDAppDelegate : UIResponder <UIAlertViewDelegate, UIApplicationDelegate, ExactTargetOpenDirectDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
