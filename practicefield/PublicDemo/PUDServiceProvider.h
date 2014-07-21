//
//  PUDServiceProvider.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

// Protocols
#import "PUDFuelServiceProtocol.h"

@interface PUDServiceProvider : NSObject

/**
 Returns service singleton that provides access to fuel rest routes. This is lazily created.
 */
+ (id<PUDFuelServiceProtocol>)fuelService;

@end
