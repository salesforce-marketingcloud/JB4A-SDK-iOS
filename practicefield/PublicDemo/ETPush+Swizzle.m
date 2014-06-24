//
//  ETPush+Swizzle.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/16/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "ETPush+Swizzle.h"

#import <objc/runtime.h>

/**
 *  This is not needed for the SDK to function. This swizzling has been done in order to grab specific configuration settings from SDK methods
 */
@implementation ETPush (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        /**
         Swizzle configureSDKWithAppID:andAccessToken:withAnalytics:andLocationServices:andCloudPages:
         */
        {
            SEL originalSelector = @selector(configureSDKWithAppID:andAccessToken:withAnalytics:andLocationServices:andCloudPages:);
            SEL swizzledSelector = @selector(pud_configureSDKWithAppID:andAccessToken:withAnalytics:andLocationServices:andCloudPages:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod =
            class_addMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            }
            else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
        
        /**
         Swizzle setOpenDirectDelegate
         */
        {
            SEL originalSelector = @selector(setOpenDirectDelegate:);
            SEL swizzledSelector = @selector(pud_setOpenDirectDelegate:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod =
            class_addMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            }
            else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

#pragma mark - Swizzled Methods

- (void)pud_configureSDKWithAppID:(NSString *)etAppID
                   andAccessToken:(NSString *)accessToken
                    withAnalytics:(BOOL)analyticsState
              andLocationServices:(BOOL)locState
                    andCloudPages:(BOOL)cpState {
    
    /**
     Save app id and access token. This is done so that we can retrieve and display them on the info view at a later time
     */
    [PUDUtility setAppID:etAppID];
    [PUDUtility setAccessToken:accessToken];
    
    [self pud_configureSDKWithAppID:etAppID
                     andAccessToken:accessToken
                      withAnalytics:analyticsState
                andLocationServices:locState
                      andCloudPages:cpState];
}

-(void)pud_setOpenDirectDelegate:(id<ExactTargetOpenDirectDelegate>)delegate {
    
    /**
     Save delegate class name. This is done so that we can retrieve and display them on the info view at a later time
     */
    NSString *delegateClassName = NSStringFromClass([delegate class]);
    [PUDUtility setOpenDirectDelegateClassName:delegateClassName];
    
    [self pud_setOpenDirectDelegate:delegate];
}

@end
