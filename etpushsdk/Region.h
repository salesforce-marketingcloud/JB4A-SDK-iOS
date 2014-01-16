//
//  Region.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 8/8/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GenericUpdate.h"

@interface Region : GenericUpdate

@property (nonatomic, strong) NSString *fenceIdentifier;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSMutableArray *messages; /* Message */

-(id)initFromDictionary:(NSDictionary *)dict;

-(CLLocation *)regionAsLocation;
+(Region*)getRegionByIdentifier:(NSString *)identifier;
+(BOOL)generatePersistentDataSchemaInDatabase;
+(BOOL)invalidateAllRegions;
@end
