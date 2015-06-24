//
//  Registration.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 12/9/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "ETGenericUpdate.h"


/**
 ETRegistration sends data about the device back to Salesforce. The data in here covers a few different pieces, from things necessary to make the wheels spin (app id, access token, device id, token, etc) to extra things used for segmentation but not necessarily required (attributes, tags). 
 
 ETRegistrations are generated nearly completely programmatically, so you just have to make one and throw it at the server. They are not saved to the database because of this - the values should not change over time, and if they're new later, the old values don't matter.
 */
@interface ETRegistration : ETGenericUpdate
{
    // Note the no ivars...
}

/**
    Makes a new Registration Update object. One per session.
 */
- (id)init;


@end
