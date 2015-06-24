//
//  FenceMessage.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 11/4/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"

#import "ETRegion.h"
#import "ETMessage.h"

/**
 ETFenceMessage is a middle class that joins together ETRegions and ETMessages, which exist in a many-to-many relationship with each other.
 
 The SQL of this is set to ON CONFLICT REPLACE, meaning the pair of values will only ever be in there once. 
 
 ETFenceMessages should be passed to ETPhoneHome through saveToDatabaseInstead: only. They shouldn't be sent to phoneHome:.
 */
@interface ETFenceMessage : ETGenericUpdate

/** 
 The ETRegion for this relationship.
 */
@property (nonatomic, strong) ETRegion *region;

/**
 The ETMessage for this relationship.
 */
@property (nonatomic, strong) ETMessage *message;

/**
 Creates a new ETFenceMessage for a specific ETRegion and ETMessage. 
 
 @param region The ETRegion half of this relationship
 @param message The ETMessage half of this relationship. 
 @return A new ETFenceMessage.
 */
-(instancetype)initWithRegion:(ETRegion *)region andMessage:(ETMessage *)message;

@end
