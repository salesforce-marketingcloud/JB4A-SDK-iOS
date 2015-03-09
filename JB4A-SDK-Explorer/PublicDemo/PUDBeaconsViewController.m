/**
 * Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation and/or
 * other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//
//  PUDBeaconsViewController.m
//  PublicDemo
//
//  Created by Swetha Pendyala (Contractor) on 8/13/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDBeaconsViewController.h"

// Controllers
#import "PUDPageContentViewController.h"

@interface PUDBeaconsViewController ()

@end

@implementation PUDBeaconsViewController

- (NSString *)htmlPrefix {
    return @"<html style=\"margin:10px; font-size:16px; word-wrap: break-word;\"><font color=\"black\" face=\"Avenir Next\">"
    "<h3 style=\"text-align:center;\">Journey Builder for Apps (JB4A) IOS SDK</h3>";
}

- (NSArray *)pageHtml {
    return @[[self overviewLocationsHtml],[self overviewHtml], [self beacon1Html], [self beacon2Html], [self beacon3Html], [self beacon4Html]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController.view.alpha = 0;
    
    /*
     CGFloat scale = [[UIScreen mainScreen]scale];
     UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, scale);
     [[UIImage imageNamed:@"test"] drawInRect:CGRectMake(0,0,320,900)];
     UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pageViewController.view setAlpha:1.0];
    } completion:nil];
}

#pragma mark - page content

- (NSString *)overviewLocationsHtml {
    
    NSString *ret = @"<b>Geo-fences Overview</b><hr>"
    "The JB4A SDK Explorer has been set with Entry and Exit geo-fence messages for the following three locations:"
    "<br/>"
    "<ul>"
    "<li>Grand Canyon National Park (Coordinates: 36.106965, -112.112997)</li><br/>"
    "<li>Yellowstone National Park (Coordinates: 44.598884, -110.499898)</li><br/>"
    "<li>Yosemite Valley (Coordinates: 37.74856, -119.588113)</li>"
    "</ul>"
    "To see how geo-fence work, you could actually travel to one of the three locations and you would get an entry and exit message local notification.<br/>";
    return ret;
}

- (NSString *)overviewHtml {
    
    NSString *ret = @"<b>Beacons Overview</b><hr>"
    "The JB4A has been set with several Beacon messages. In order to see how Beacons work, you will need to purchase several Beacons and configure them to work with the JB4A."
    "<br/><br/>"
    "Each Beacon can be assigned a unique GUID as well as a Major and Minor number. For any Beacons you purchase, make sure that the Beacons can be configured.  You must be able to edit the GUID as well as the Major and Minor number."
    "<br/><br/>"
    "Messages are fired when you are in proximity of a Beacon.  Different messages can be fired when you are in the following ranges:"
    "<br/>"
    "<ul>"
    "<li>Immediate (2-3 inches)</li>"
    "<li>Near (2-3 feet)</li>"
    "<li>Far (Up to 50 feet)</li>"
    "</ul>"
    "To see how Beacons work, we have setup 4 Beacons with a GUID of 2f234454-cf6d-4a0f-adf2-f4911ba9ffa6.  The following pages describe the messages associated with each Beacon.<br/>";
    return ret;
}

- (NSString *)beacon1Html {
    
    NSString *ret = @"<b>Beacon 1</b><hr>"
    "This Beacon is setup with a GUID of 2f234454-cf6d-4a0f-adf2-f4911ba9ffa6 and a Major number of 1 and Minor number of 1.<br/>"
    "The following messages have been setup that are unlimited:<br/>"
    "<ul>"
    "<li>IMMEDIATE 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 1</li><br/>"
    "<li>NEAR 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 1</li><br/>"
    "<li>FAR 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 1</li><br/>"
    "</ul>";
    
    return ret;
}

- (NSString *)beacon2Html {
    
    NSString *ret = @"<b>Beacon 2</b><hr>"
    "This Beacon is setup with a GUID of 2f234454-cf6d-4a0f-adf2-f4911ba9ffa6 and a Major number of 1 and Minor number of 2."
    "<br/><br/>"
    "The following messages have been setup to fire at most once per hour: "
    "<br/>"
    "<ul>"
    "<li>IMMEDIATE 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 2</li><br/>"
    "</ul>";
    return ret;
}

- (NSString *)beacon3Html {
    
    NSString *ret = @"<b>Beacon 3</b><hr>"
    "This Beacon is setup with a GUID of 2f234454-cf6d-4a0f-adf2-f4911ba9ffa6 and a Major number of 1 and Minor number of 3."
    "<br/><br/>"
    "The following messages have been setup to fire at most once per day: "
    "<br/>"
    "<ul>"
    "<li>IMMEDIATE 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 3</li><br/>"
    "<li>NEAR 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 3</li><br/>"
    "</ul>";
    
    return ret;
}

- (NSString *)beacon4Html {
    
    NSString *ret = @"<b>Beacon 4</b><hr>"
    "This Beacon is setup with a GUID of 2f234454-cf6d-4a0f-adf2-f4911ba9ffa6 and a Major number of 1 and Minor number of 4."
    "<br/><br/>"
    "The following messages have been setup to fire once ever: "
    "<br/>"
    "<ul>"
    "<li>IMMEDIATE 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 4</li><br/>"
    "<li>FAR 2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6 Major 1 Minor 4</li><br/>"
    "</ul>";
    
    return ret;
}

@end
