//
//  PICart.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

/*!
 @class PICart
 
 Wrapper class for sending WAMA PI Analytic eCommerce shopping carts using a public interface.
 */

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface PICart : NSObject <NSCoding, NSCopying>

/**
 Initialize a Cart object for use in analytics.
 
 @param cartItems An array of PICartItem objects (non-nil array). An empty array indicates an empty cart, and will be used to indicate a cleared cart to the analytics system.
 @return instancetype
 */
- (instancetype)initWithCartItems:(NSArray *) cartItems NS_DESIGNATED_INITIALIZER;

/**
 Convert PICart to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END