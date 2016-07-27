//
//  PICartItem.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

/*!
 @class PICartItem
 
 Wrapper class for sending WAMA PI Analytic eCommerce shopping carts using a public interface.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PICartItem : NSObject <NSCoding, NSCopying>

/**
 Initialize a Cart Item object for use in analytics.
 
 @param price The price amount (USD) of this item (non-nil value; 0 permissable)
 @param quantity The count of items in the cart for this particular product (non-nil value; 0 permissable)
 @param item The unique product code from the e-commerce system representing this cart item (non-nil string value)
 @return instancetype
 */
- (instancetype)initWithPrice:(NSNumber *)price quantity:(NSNumber *)quantity item:(NSString *)item NS_DESIGNATED_INITIALIZER;

/**
 Convert PICartItem to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END