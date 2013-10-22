//
//  etpushsdk.h
//  etpushsdk
//
//  Created by Eddie Roger on 9/7/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

// SDK Version
#define ETPushSDKVersionString @"2.1.`"
#define ETPushSDKVersionNumber 2110

/** 
 Helpers.
 */
#define ETNotify(notification) \
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];

/**
 Notification that is sent when a push fails for some reason.
 */
/** @constant ETPush Notifications Sent when the data request process has started */
#define ETRequestStarted                @"ETRequestStarted"
#define ETRequestNoData                 @"ETRequestNoData"
#define ETRequestFailed                 @"ETRequestFailed"
#define ETRequestComplete               @"ETRequestComplete"
#define ETRequestFailedOnLoadingResult  @"ETRequestFailedOnLoadingResult"
#define ETRequestServiceReturnedError   @"ETRequestServiceReturnedError"
#define ETRequestServiceResponseSuccess @"ETRequestServiceResponseSuccess"
#define ETRequestFinishedWithFailure    @"ETRequestFinishedWithFailure"

#define ETAuthRequestStarted            @"ETAuthRequestStarted"
#define ETAuthRequestFailed             @"ETAuthRequestFailed"
#define ETAuthRequestSuccess            @"ETAuthRequestSuccess"
#define ETAuthRequestFinishedWithFailure    @"ETAuthRequestFinishedWithFailure"

/**
 Constants for interacting with User Defaults. 
 */
#define ETFuelAuthToken                 @"ETFuelAuthToken"
#define ETFuelAuthTokenExpiration          @"ETFuelAuthTokenExpiration"

/**
  Constants for dealing with other stuff
  */
#define AppLifecycleForeground              @"AppLifecycleForeground"
#define AppLifecycleBackground              @"AppLifecycleBackground"

/**
 Deprecation warning declaration
 */
#define __DEPRECATED_WARNING(message) __attribute((deprecated(message)))

/**
 Private typedef for using QA.
 
 This is used to determine where the SDK should point, and should NEVER be changed by clients. It is for INTERNAL USE ONLY.
 */
typedef enum {
    ETPushModeProduction = 0, // Duh
    ETPushModeQA1, // Points to the QA1 URL
    ETPushModeQA2, // Points to the QA2 URL
    ETPushModeSilent // Won't actually phone home. Just goes through the motions
} ETPushMode;

typedef enum {
    PushOriginationStateBackground = 0,
    PushOriginationStateForeground
} PushOriginationState;

