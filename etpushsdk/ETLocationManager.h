//
//  ETLocationManager.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 2/12/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationUpdate.h"
#import "ETMessage.h"
#import "Geofence.h"

/**
 ETLocationManager is the main interface to ExactTarget's Location Services. In the way that ETPush manages the push notification cycle, ETLocationMangaer manages geo services. It will use some of the information from ETPush (namely, App ID and Access Token) to function, but is an independent piece of functionality. 
 
 Due to the invasive nature of location services, ETLocationManager defaults to off, and must be explicity turned on by the developer, whether invisibly to the user or not. To begin location services, call [[ETLocationManager locationManager] startWatchingLocation]. Similarly, to stop location services, call [[ETLocationManager locationManager] stopWatchingLocation]. 
 
 ETLocationManager will always respect the user's wishes (as enforced by iOS), so if the user disables Location Services at the system level through Settings, the SDK will be unable to use any location services, and fence monitoring will not function. You can check for this by querying [[ETLocationManager locationManager] locationEnabled], as it will reconcile app-level permissions as well as the state of you enabling loc services. Internally, this method is used to report back to ExactTarget on the state of location services, so it is trustworthy. 
 
 Please ensure you are linking against CoreLocation. You will get errors otherwise. 
 
 */
@interface ETLocationManager : NSObject <CLLocationManagerDelegate>
{

}

@property (nonatomic, getter = isUpdatingGeofences) BOOL updatingGeofences;
    
/**
 Returns a reference to the shared loc manager.
 */
+(ETLocationManager *)locationManager;
-(id)init;
   
/**
 Determines the state of Location Services based on developer setting and OS-level permission. This is the preferred method for checking for location state.
 */
-(BOOL)locationEnabled;

/**
 Use this method to initiate Location Services through the MobilePush SDK. 
 */
-(void)startWatchingLocation;
    
/** 
 Use this method to disable Location Services through the MobilePush SDK.
 */
-(void)stopWathingLocation;

/**
 Calls various handlers that should fire when the app enters the foreground. 
 */
-(void)appInForeground;

/** Calls various handlers that should fire when the app enters the background.
 */
-(void)appInBackground;

/**
 Queues a send for a location update to ExactTarget.
 */
-(void)updateLocationServerWithLocation:(CLLocation *)loc forAppState:(LocationUpdateAppState)state;


/* Location */
-(void)monitorRegions:(NSSet *)fences;
-(void)stopMonitoringRegions;
-(void)getAndScheduleAlertsForRegion:(NSString *)regionIdentifier andMessageType:(MobilePushMessageType)type;
-(NSSet *)monitoredRegions;
-(NSDictionary *)lastKnownLocation;
 
@end
