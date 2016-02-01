//
//  ETAnalytics.h
//  JB4A-SDK-iOS
//
//  Created by Barry Geipel on 12/16/15.
//  Copyright © 2015 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETAnalytics : NSObject

/**
 Set Web Analytics Mobile Analytics, Track page views within your application.
 @param url - a non-nil NSString to identify the location within your app traversed by your customers.  For example: com.yourpackage.viewcontrollername
 @param title - a NSString (nil if n/a) to identify the title of the location within your app traversed by your customers. For example: Screen Name
 @param item - a NSString (nil if n/a) to identify an item viewed by your customer.  For example: UPC-1234
 @param search - a NSString (nil if n/a) to identify search terms used by your customer.  For example: blue jeans.
 @return void
 */
+(void)trackPageView:(NSString*)url andTitle:(NSString*)title andItem:(NSString *)item andSearch:(NSString*)search;

@end
