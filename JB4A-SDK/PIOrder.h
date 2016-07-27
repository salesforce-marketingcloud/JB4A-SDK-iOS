//
//  PIOrder.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce Marketing Cloud. All rights reserved.
//

/*!
 @class PIOrder
 
 Wrapper class for sending WAMA PI Analytic eCommerce shopping cart using a public interface.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PICart;

@interface PIOrder : NSObject <NSCoding, NSCopying>

/**
 Initialize an Order object for use in analytics.
 
 @param orderNumber The order number of from the e-commerce system (non-nil string)
 @param shipping The shipping amount (USD) of this order (non-nil value; 0 permissable)
 @param discount The discount amount (USD) of this order (non-nil value; 0 permissable)
 @param cart The order's shopping cart object (non-nil object)
 @return instancetype
 */
- (instancetype)initWithOrderNumber:(NSString *) orderNumber shipping:(NSNumber *) shipping discount:(NSNumber *) discount cart:(PICart *) cart NS_DESIGNATED_INITIALIZER;

/**
 Convert PIOrder to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END