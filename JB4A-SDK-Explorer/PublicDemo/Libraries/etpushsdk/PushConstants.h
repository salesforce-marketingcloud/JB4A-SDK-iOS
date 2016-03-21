//
//  PushConstants.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 9/7/12.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

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

/**
  Constants for dealing with other stuff
  */
#define AppLifecycleForeground          @"AppLifecycleForeground"
#define AppLifecycleBackground          @"AppLifecycleBackground"

/**
 Geofence Constants
 */
#define ETLargeGeofence                 433 // Get it? 433 North Capitol. It's been a long journey getting here.
#define ETLargeGeofenceIdentifier       @"ExactTargetMagicGlobalFence"

/**
 Caches
 */
#define ET_TAG_CACHE                    @"ET_TAG_CACHE"
#define ET_SUBKEY_CACHE                 @"ET_SUBKEY_CACHE"
#define ET_ATTR_CACHE                   @"ET_ATTR_CACHE"

/**
 Deprecation warning declaration
 */
#define __DEPRECATED_WARNING(message) __attribute((deprecated(message)))

// Tracks the BOOL for each in NSUserDefaults
static NSString * const ETProximityServicesActive = @"ETProximityServicesActive";
static NSString * const ETLocationServicesActive  = @"ETLocationServicesActive";
static NSString * const ETCloudPagesActive        = @"ETCloudPagesActive";
static NSString * const ETAnalyticsActive         = @"ETAnalyticsActive";
static NSString * const ETPIAnalyticsActive       = @"ETPIAnalyticsActive";

/**
 Push Origination State
 */
typedef NS_ENUM (NSUInteger, pushOriginationState){
    /** PushOriginationStateBackground  */
    PushOriginationStateBackground                    = 0,
    /** PushOriginationStateForeground  */
    PushOriginationStateForeground
};

/**
 configureSDKWithAppID errors
 */
typedef NS_ENUM(NSUInteger, configureSDKWithAppIDError) {
    /** configureSDKWithAppIDNoError  */
    configureSDKWithAppIDNoError                      = 0,
    /** configureSDKWithAppIDInvalidAppIDError  */
    configureSDKWithAppIDInvalidAppIDError,
    /** configureSDKWithAppIDInvalidAccessTokenError  */
    configureSDKWithAppIDInvalidAccessTokenError,
    /** configureSDKWithAppIDUnableToReadRandomError  */
    configureSDKWithAppIDUnableToReadRandomError,
    /** configureSDKWithAppIDDatabaseAccessError  */
    configureSDKWithAppIDDatabaseAccessError,
    /** configureSDKWithAppIDUnableToKeyDatabaseError  */
    configureSDKWithAppIDUnableToKeyDatabaseError,
    /** configureSDKWithAppIDCCKeyDerivationPBKDFError  */
    configureSDKWithAppIDCCKeyDerivationPBKDFError,
    /** configureSDKWithAppIDCCSymmetricKeyWrapError  */
    configureSDKWithAppIDCCSymmetricKeyWrapError,
    /** configureSDKWithAppIDCCSymmetricKeyUnwrapError  */
    configureSDKWithAppIDCCSymmetricKeyUnwrapError,
    /** configureSDKWithAppIDKeyChainError  */
    configureSDKWithAppIDKeyChainError,
    /** configureSDKWithAppIDUnableToReadCertificateError  */
    configureSDKWithAppIDUnableToReadCertificateError,
    /** configureSDKWithAppIDRunOnceSimultaneouslyError  */
    configureSDKWithAppIDRunOnceSimultaneouslyError,
    /** configureSDKWithAppIDRunOnceError  */
    configureSDKWithAppIDRunOnceError,
    /** configureSDKWithAppIDInvalidLocationAndProximityError  */
    configureSDKWithAppIDInvalidLocationAndProximityError
};

/**
 requestPIRecommendations errors
 */
typedef NS_ENUM(NSUInteger, requestPIRecommendationsError) {
    /** requestPIRecommendationsNoError  */
    requestPIRecommendationsNoError                   = 0,
    /** requestPIRecommendationsInvalidMidParameterError  */
    requestPIRecommendationsInvalidMidParameterError  = 1024,
    /** requestPIRecommendationsInvalidRetailerParameterError  */
    requestPIRecommendationsInvalidRetailerParameterError,
    /** requestPIRecommendationsInvalidPageParameterError  */
    requestPIRecommendationsInvalidPageParameterError,
    /** requestPIRecommendationsInvalidCompletionHandlerError  */
    requestPIRecommendationsInvalidCompletionHandlerError
};


