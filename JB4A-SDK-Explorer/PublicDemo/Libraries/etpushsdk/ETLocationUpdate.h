//
//  LocationUpdate.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 7/17/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

/*
 { "deviceid", "required, unique id for the device. (string)" },
 { "latitude", "required, the latitude value for the location. (double)" },
 { "longitude", "required, the longitude value for the location. (double)" },
 { "accuracy", "required, the accuracy of the location data, in meters. (int)" },
 { "location_datetime_utc", "optional, the time the location data was recorded, in ISO 8601 UTC format. If not provided, current time is used. (string)" },
 */

typedef NS_ENUM(NSInteger, LocationUpdateAppState)
{
    LocationUpdateAppStateBackground,
    LocationUpdateAppStateForeground
};

#import "ETGenericUpdate.h"
#import <CoreLocation/CoreLocation.h>

@interface ETLocationUpdate : ETGenericUpdate

@property (nonatomic) CLLocation *location;
@property (nonatomic, strong) NSDate *eventDateTime;

// So, I hate to use these. But I have to. Because sometimes I need to fake a location update.
// Upside: Because they're NSObjects, they are arguably more useful than CLLocation or int. Arguably. I mean, you can put them in Arrays and Dictionaries.
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSNumber *accuracy;
@property (nonatomic) LocationUpdateAppState appState;


+(BOOL)generatePersistentDataSchemaInDatabase;
-(NSString *)tableName;
+(NSString *)tableName; // both, because they're in different ways and places. Don't worry, they're CONSTANT POWERED!

-(id)initWithLocation:(CLLocation *) location forAppState:(LocationUpdateAppState)state;
-(NSString *)remoteRoutePath;
-(NSString *)formattedDate;
-(NSString *)jsonPayloadAsString;

@end
