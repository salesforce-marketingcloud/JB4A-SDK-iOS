//
//  KeyValueStore.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 8/22/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
@interface ETKeyValueStore : NSObject

/**
 Sets the value for a specific key into the ETKeyValueStore. Both things are NSString objects. 

 @param key The key to save
 @param value The value to save
 @return T/F if the save worked
 */
+(BOOL)setValue:(NSString *)value forKey:(NSString *)key;

/** 
 Retrieves a value for a given key from the database, or nil if it's not in there. 
 
 @param key The key to retrieve
 @return The value, or nil if it's not there. 
 */
+(NSString *)valueForKey:(NSString *)key;

@end
