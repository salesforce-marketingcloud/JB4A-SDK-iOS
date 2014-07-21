//
//  FenceMessage.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 11/4/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import "GenericUpdate.h"

#import "Region.h"
#import "ETMessage.h"

/**
 FenceMessage is a middle class that joins together fences and messages, which exist in a many-to-many relationship with each other. 
 */
@interface FenceMessage : GenericUpdate

@property (nonatomic, strong) Region *region;
@property (nonatomic, strong) ETMessage *message;

-(id)initWithRegion:(Region *)region andMessage:(ETMessage *)message;

@end
