//
//  KeyValueStore.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 8/22/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ETAppId = @"ETAppID";
static NSString * const AccessToken = @"AccessToken";
static NSString * const DeviceToken = @"DeviceToken";
static NSString * const DeviceIdentifier = @"DeviceID";
static NSString * const SubscriberKey = @"SubscriberKey";

static NSString * const Tags = @"Tags";
static NSString * const Attributes = @"Attributes";

static NSString * const CacheDelimeter = @"|^|";
static NSString * const CacheKeyValueDelimeter = @"|:|";

/**
 This is a simple little database wrapper that lets us persist data in a generic place and way. Because sometimes we need to do that, and clustering up NSUserDefaults is silly. 
 
 For the sake of simplicity, this store only deals with NSStrings. Please plan accordingly. 
 */
@interface KeyValueStore : NSObject

+(BOOL)setValue:(NSString *)value forKey:(NSString *)key;
+(NSString *)valueForKey:(NSString *)key;

@end
