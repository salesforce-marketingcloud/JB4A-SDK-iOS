//
//  ETPush+Swizzle.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/16/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "ETPush.h"

/**
 *  This is not needed for the SDK to function. This swizzling has been done in order to grab specific configuration settings from SDK methods
 */
@interface ETPush (Swizzle)

@end
