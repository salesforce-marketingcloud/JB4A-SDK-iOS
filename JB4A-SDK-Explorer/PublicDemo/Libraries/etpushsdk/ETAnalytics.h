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
 Set PIEvent (WAMA) Web Analytics Mobile Analytics
 */
+(void)trackPageView:(NSString*)url andTitle:(NSString*)title andItem:(NSString *)item andSearch:(NSString*)search;

@end
