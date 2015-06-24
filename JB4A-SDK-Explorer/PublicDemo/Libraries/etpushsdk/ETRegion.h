//
//  Region.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 8/8/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ETGenericUpdate.h"

/**
 Enumeration to keep track of if the request is for Geofences or Proximity messages. 
 */
typedef NS_ENUM(NSUInteger, ETRegionRequestType) {
    ETRegionRequestTypeUnknown,
    ETRegionRequestTypeGeofence,
    ETRegionRequestTypeProximity
};

/**
 Enumeration of the type of ETRegion that this is - Circle (Geofence) or Proximity (ibeacon). Polygon is not currently used. 
 */
typedef NS_ENUM(NSUInteger, MobilePushGeofenceType) {
    MobilePushGeofenceTypeNone = 0,
    MobilePushGeofenceTypeCircle,
    MobilePushGeofenceTypePolygon __attribute__((deprecated)), // Not currently in use.
    MobilePushGeofenceTypeProximity
};

/**
 ETRegion is a representation of a physical region that should trigger a message to be presented to the user. This could be either macro, a geofence, or micro, an iBeacon (marketing name: Proximity), but both go through iOS' Location Manager, and are reported back to the SDK through the CLLocationManagerDelegate (which is currently always ETLocationManager). 
 
 Geofences will have a latitude and longitude and radius, but will be notably absent of a proximity UUID, major and minor number. Beacons also have latitude and longitude (but no radius) because of a decision to track their physical location in the world, but it is inconsequential to functionality. A beacon is functional because of the Proximity UUID. Major and Minor number. The three of these uniquely identify a physical beacon. Per Apple's best practices (WWDC 2013), a single UUID should be used commonly amongst an entire Enterprise (example: All Starbucks locations share a UUID). Major numbers should designate a single location within the UUID (Starbucks #1234, 15th and College, Indianapolis), and a Minor number can indicate the beacon within the location designated in the Major (Point of Sale). Salesforce suggests following this pattern when configuring beacons.
 
 ETRegions will has a zero-to-many relationship with ETMessage, which in turn, has a zero-to-many relationship with ETRegion. In plain English, one region can have many messages, and one message can belong to many regions. This is handled through ETFenceMessage.
 */
@interface ETRegion : ETGenericUpdate

/**
 ET-generated identifier for the ETRegion in question. This should be treated as a primary key, and is stored on the device as the encoded version sent via the routes.
 */
@property (nonatomic, strong) NSString *fenceIdentifier;

/**
 The latitude of this region. Saved in an NSNumber as a double for easy passing. Be sure to call doubleValue on this property.
 */
@property (nonatomic, strong) NSNumber *latitude;

/**
 The longitude of this region. Saved in an NSNumber as a double for easy passing. Be sure to call doubleValue on this property.
 */
@property (nonatomic, strong) NSNumber *longitude;

/**
 For geofences only, the radius of the fence. This number, an integer, is in meters. 
 */
@property (nonatomic, strong) NSNumber *radius;

/**
 An array of related messages. It is not proper to pull a message out of this array, though. It's used for initialization and data passing.
 */
@property (nonatomic, strong) NSMutableArray *messages;

/**
 For beacons, the Proximity UUID of the beacon. 
 */
@property (nonatomic, strong) NSString *proximityUUID;

/**
 For beacons, the Major number. This is a uint32 per the CLBeaconRegion spec.
 */
@property (nonatomic, strong) NSNumber *majorNumber;

/** 
 For beacons, the Minor number. This is a uint32 per the CLBeaconRegion spec.
 */
@property (nonatomic, strong) NSNumber *minorNumber;

/**
 This is the number of times a region is entered as counted by the ETLocationManager. 
 */
@property (nonatomic, strong) NSNumber *entryCount;

/**
 This is the number of times a region is exited as counted by the ETLocationManager. Ideally, it matches enter count.
 */
@property (nonatomic, strong) NSNumber *exitCount;

/**
 This is the name which is set on SalesforceMarketingCloud, while setting the ETRegion
 */
@property (nonatomic, strong) NSString *regionName;


/**
 The type of region this ETRegion represents. This is sent from the server, so we trust it. 
 */
@property (nonatomic, assign) MobilePushGeofenceType locationType;

/** 
 For ETGenericUpdate, this is the type of request that is being initiated. It will soon be deprecated. 
 */
@property (nonatomic) ETRegionRequestType requestType;

/**
 This is the designated initializer. Pass it in a dictionary, get out an ETRegion. 
 
 @param dict NSDictionary of values of which to apply to this ETRegion.
 @return A newly minted ETRegion.
 */
-(id)initFromDictionary:(NSDictionary *)dict;

/**
 Region equality. Based on the kind of ETRegion, it will compare values and determine equality. 
 
 @param The other ETRegion to which the comparison should be made.
 @return BOOL T/F of equality.
 */
-(BOOL)isEqualToRegion:(ETRegion *)region;


/**
 This returns a CLLocation representation of the current ETRegion, or nil if a beacon.

 @return The region as a CLLocation.
 */
-(CLLocation *)regionAsLocation; // For Geofences

/**
 Returns the ETRegion as a CLRegion for use in Beacon code, or nil if a Geofence.
 
 @return A CLRegion representation of self.
 */
-(CLRegion *)regionAsCLRegion; // For Beacons

/**
 Returns self as a CLBeaconRegion, or nil if a Geofence.
 
 @return CLBeaconRegion representation of self.
 */
-(CLBeaconRegion *)regionAsBeaconRegion; // Also for beacons

/**
 Helper to quickly determine if this is a Geofence region. 
 
 @return T/F if a geofence.
 */
-(BOOL)isGeofenceRegion;

/**
 Helper to quickly determine if this is a Beacon/Proximity region.
 
 @return T/F if a beacon.
 */
-(BOOL)isBeaconRegion;

/**
 Returns a specific ETRegion by the ET-provided identifier, or nil if it doesn't exist. 

 @param identifier The region ID to retrieve. 
 @return The region, or nil if it doesn't exist.
 */
+(ETRegion*)getRegionByIdentifier:(NSString *)identifier;

/**
 Returns a specific Beacon Region from the database. This is more useful for ranging, since at that time we don't know the ET identifier yet, but we know UUID, Major and Minor. 
 
 @param proximityUUID The ranged beacon UUID
 @param majorNumber An NSNumber-wrapped uint32 of the beacon's major number
 @param minorNumber An NSNumber-wrapped uint32 of the beacon's minor number
 @return The region, or nil if it doesn't exist. 
 */
+(ETRegion*)getBeaconRegionForRegionWithProximityUUID:(NSString *)proximityUUID andMajorNumber:(NSNumber *)majorNumber andMinorNumber:(NSNumber *)minorNumber;

/**
 Returns a specific Beacon Region from the database.
 
 @param proximityUUID The ranged beacon region UUID
 @return The region, or nil if it doesn't exist.
 */
+(ETRegion *)getBeaconRegionForRegionWithProximityUUID:(NSString *)proximityUUID;

/**
 Pulls all active regions out of the local database. 
 
 @return An NSSet of ETRegions.
 */
+(NSSet *)getFencesFromCache;

/**
 Pulls all (both active and inactive) regions out of the local database.
 
 @return An NSSet of *all* ETRegions.
 */
+(NSSet *)getFencesFromCacheIncludingInactive:(BOOL)getInactive;

/**
 Marks all regions in the database for a specific type as inactive. This is done after successfully retrieving fences from Salesforce.
 
 @param requestType Filter to only invalidate certain types of region based on ET Request. 
 @return T/F if the process was successful. 
 */
+(BOOL)invalidateAllRegionsForRequestType:(ETRegionRequestType)requestType;

/**
 Invalidates all reason. Full stop. 
 
 @return T/F of the success of the operation. 
 */
+(BOOL)invalidateAllRegions;

/**
 Begins fence retrieval from ET of Geofences. 
 */
+(void)retrieveGeofencesFromET;

/** 
 Begins fence retrieval from ET of Beacons.
 */
+(void)retrieveProximityFromET;

+(BOOL)generatePersistentDataSchemaInDatabase;

@end
