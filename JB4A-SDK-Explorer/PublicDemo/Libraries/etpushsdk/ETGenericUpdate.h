    //
//  GenericUpdate.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 7/18/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This enumeration defines what HTTP method should be used in sending the data. These are standard HTTP methods.
 */
typedef NS_ENUM(NSInteger, GenericUpdateSendMethod)
{
    /** HTTP GET */
    GenericUpdateSendMethodGet,
    /** HTTP POST */
    GenericUpdateSendMethodPost,
    /** HTTP PUT */
    GenericUpdateSendMethodPut,
    /** HTTP DELETE */
    GenericUpdateSendMethodDelete
};

/**
 This protocol defines methods that ETGenericUpdate objects must implement. 
 */
@protocol ETGenericUpdateObjectProtocol <NSObject>

+(instancetype)alloc;
-(instancetype)initFromDictionary:(NSDictionary *)dict;

+(NSString *)remoteRoutePath;
-(NSString *)remoteRoutePath;

+(NSString *)tableName;
-(NSString *)tableName;

-(NSString *)jsonPayloadAsString;
-(NSDictionary *)jsonPayloadAsDictionary;

-(GenericUpdateSendMethod)sendMethod;

@optional
-(void)setRemoteRoutePath:(NSString *)route;

@end

static NSString * const ETRequestBaseURL = @"https://consumer.exacttargetapis.com";

@interface ETGenericUpdate : NSObject

@property (nonatomic) int tag; // The property that started this whole ordeal.
@property (nonatomic) NSInteger databaseIdentifier;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSHTTPURLResponse *responseCode;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskID;

/**
 Sending to Salesforce
 
 These methods need to be implemented so that ETPhoneHome works.
 */

/**
 The HTTP method that should be used for this call.
 */
-(GenericUpdateSendMethod)sendMethod;

/**
 The route to which the call should be made. This will be appended to the BaseURL in ETPhoneHome, and should lead with a slash.
 */
-(NSString *)remoteRoutePath;

/**
 Serializes the payload for POSTing. 
 */
-(NSString *)jsonPayloadAsString;

/**
 Serializes as a dictionary for bulk uploading.
 */
-(NSDictionary *)jsonPayloadAsDictionary;

/**
 Called by ETPhoneHome after the ETURLConnection is finished. This should handle doing anything that needs to be done to the payload after it's fully received (like, start monitoring for geofences.
 
 It's called after a respondsToSelector: so it doesn't have to be implemented.
 */
-(void)processResults;

/** 
 Called by ETPhone if the ETURLConnection fails. This should do it's best to recover what it can, maybe loading things from the database or whatever. 
 
 Sometimes bad things happen when retrieving data from Salesforce. I mean, cellular Internet isn't a perfect science.
 */
-(void)handleDataFailure;

/**
 Not everything should save itself to the database. By default, they should, since that's the expectation that's already set. However, sometimes, it doesn't make sense. This controls that. 
 
 "But, if it defaults to 'YES', can't that leave to errors if the other methods aren't implemented?"
 
 Yup. But that's on them. Also, that's why we have asserts in the base class method. 
 */
-(BOOL)shouldSaveSelfToDatabase;

/**
 Saving to the Database
 
 These methods are used to save oneself to the database. The objects need to bootstrap themselves to a savable state, and these methods make that possible through a strange combination of inheritance, witch craft, and magic. And Objective-C.
 
 Worth noting that these should almost always cause a crash if they come from GenericUpdate, and in reality are being superceded by their children with real values. Also, some are passthrough to other things or statics because I'm kind of making this up as I go along.
 */

/**
 To make the databases self-updating (more or less), we keep track of the version of the local DB that the insert query represents. This number is stored to NSUserDefaults with the key in databaseVersionKey and checked before inserts. If the number returned is less than this number, it drops and recreates the database table. 
 */
-(int)dbVersionNumber;

/** 
 And this is the key to match the dbVersionNumber. It is saved to NSUserDefaults in combination with dbVersionNumber to identify the age of the table.
 */
-(NSString *)databaseVersionKey;

/**
 Passes a call to the Static method of the same name, with the correct object named in the instance variable. It needed an instance counterpart because we are dealing with a specific update at the point where this is called, and that's the perfect place to reference back to the static version.
 */
-(BOOL)generatePersistentDataSchemaInDatabase;

/**
 Returns the arguments that should be inserted into the database to match the query specified in the previous method. As such, the number should equal the number of question marks used in the previous method.
 
 Also, they need to all be NSObjects, and not primitives or non-object variants of NULL. So, use an NSNumber wrapper for numbers and bools, and [NSNull null] for nils. Please.
 */
-(NSArray *)insertQueryArguments;
-(NSArray *)updateQueryArguments;


/**
 Returns the SQL string that should execute on insert. It should be ready to be prepared and bound via SQLite, so use placeholders where appropriate. 
 
 Also, if you're new to SQLite and binding, the number of question marks in this statement should be equal to the number of arguments returned in the next method.
 */
-(NSString *)insertQuerySyntax;
-(NSString *)updateQuerySyntax;

/*
 An exception already. This method should *not* be called from the children objects. Just pretend you can't see it.
 */
-(BOOL)insertSelfIntoDatabase;

/**
 Returns the name of the table the object should save to. Since this comes in static and instance varieties (sorry), it should return a constant or static string from the object itself.
 */
-(NSString *)tableName;
+(NSString *)tableName;

/**
 Statics
 
 These methods apply to the generic object in question.
 */
+(NSDateFormatter *)formatterOfCorrectFormat; // This one should *not* be implemented by children
+(NSDateFormatter *)alternativeFormatterOfCorrectFormat; // Well, this one should *really* never be used
+(NSDate *)dateFromString:(NSString *)dateAsString;
+(NSString *)stringFromDate:(NSDate *)date;

+(NSNumberFormatter *)numberFormatterOfCorrectFormatForDouble;



@end
