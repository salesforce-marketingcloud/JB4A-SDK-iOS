//
//  ETBulkUpdateShim.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 7/24/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"

/**
 This is an adaptor that allows multiple ETGenericUpdate objects of the same class to be uploaded together. It overrides some of the ETGenericUpdate base methods in favor of a different implementation, and generates a payload differently than a single update would. 
 
 This only works if the ETGenericUpdate follows the convention of havint the tablename (as returned by tableName) match the key in the array payload. For example, the ETEvents tableName is "events", and the payload format is {"events":[...]}.
 
 If everything is working correctly, you can use ETPhoneHome phoneHomeInBulkForGenericUpdateType: and it will take care of the rest for you, which includes marking objects as 'claimed' for sending and deleting them on success. Check the doc on that method (and it's source) for more specifics. There are some extra assumptions on bulk-updatable objects (like the DB being updated to have a claimed column), and they're outlined there.
 */
@interface ETBulkUpdateShim : ETGenericUpdate <ETGenericUpdateObjectProtocol>

/**
 Designated Initializer. This generates an ETBulkUpdateShim object suitable for passing to ETPhoneHome phoneHome:.
 
 @param updateClass The type of object you want to send, not an instance of it ([ETEvent class]).
 @param realObjects An array of NSDictionaries (serialized ETGenericUpdate objects) that you want to send in. 
 @param success What to do if the update worked
 @param failure What to do if the update failed
 @return id A very special ETGenericUpdate object that can bulk send data. 
 */
-(instancetype)initForGenericUpdateClass:(Class<ETGenericUpdateObjectProtocol>)updateClass
                    andObjects:(NSArray *)realObjects
              withSuccessBlock:(void(^)())success
               andFailureBlock:(void(^)())failure;

/**
 A class pointer to the ETGenericUpdate object you wish to bulk send. Must implement the ETGenericUpdateObjectProtocol protocol.
 */
@property (nonatomic, assign, readonly) Class<ETGenericUpdateObjectProtocol> updateClass;

/**
 An array of NSDictionary versions of the things you want to send. This should be equivalent to what would be serailzed to send back.
 */
@property (nonatomic, strong, readonly) NSArray *realObjects;

@end
