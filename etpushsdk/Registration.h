//
//  Registration.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 12/9/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import "GenericUpdate.h"


/**
 A registration update sends data about the device back to ExactTarget. The data in here covers a few different pieces, from things necessary to make the wheels spin (app id, access token, device id, token, etc) to extra things used for segmentation but not necessarily required (attributes, tags). It also does legacy analytics.
 */
@interface Registration : GenericUpdate
{
    
}

/**
    Makes a new Registration Update object. One per session.
 */
- (id)init;


@end
