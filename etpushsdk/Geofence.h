//
//  Geofence.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 7/24/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import "GenericUpdate.h"

#import "Region.h"

@interface Geofence : GenericUpdate

//@property (nonatomic, strong) NSString *fenceIdentifier;
//@property (nonatomic, strong) NSNumber *latitude;
//@property (nonatomic, strong) NSNumber *longitude;
//@property (nonatomic, strong) NSNumber *radius;
//
//-(id)initFromDictionary:(NSDictionary *)dict;

-(NSArray *)regions;

+(void)retrieveGeofencesFromET;
+(Region *)getFenceByIdentifier:(NSString *)fenceIdentifier;
+(NSSet *)getFencesFromCache;


@end
