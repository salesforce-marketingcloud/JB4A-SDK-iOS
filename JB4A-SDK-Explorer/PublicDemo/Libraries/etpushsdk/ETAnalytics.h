//
//  ETAnalytics.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/

//  Copyright © 2016 Salesforce. All rights reserved.
//

/*!
 @class ETAnalytics
 
 Wrapper class for sending WAMA PI Analytic values using a public interface.
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETAnalytics : NSObject

/**
 Set Web Analytics Mobile Analytics, Track page views within your application.
 @param url a non-nil NSString to identify the location within your app traversed by your customers.  For example: com.yourpackage.viewcontrollername
 @param title a NSString (nil if n/a) to identify the title of the location within your app traversed by your customers. For example: Screen Name
 @param item a NSString (nil if n/a) to identify an item viewed by your customer.  For example: UPC-1234
 @param search a NSString (nil if n/a) to identify search terms used by your customer.  For example: blue jeans.
 @return void
 */
+(void)trackPageView:(NSString*)url andTitle:(nullable NSString*)title andItem:(nullable NSString *)item andSearch:(nullable NSString*)search;

@end
NS_ASSUME_NONNULL_END
