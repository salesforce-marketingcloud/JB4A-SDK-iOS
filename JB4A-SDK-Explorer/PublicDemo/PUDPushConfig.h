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
//  PUDPushConfig.h
//  PublicDemo
//
//  Created by Swetha Pendyala (Contractor) on 7/25/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

/**
 *  ET_NOTE: This PUDPushConfig model has the following properties. An explanation of each below:
 *
 *      Access Token -> This is the app Access Token that you receive when you create a MobilePush app
 *                      inside of AppCenter (http://appcenter.exacttarget.com/appcenter)
 *
 *      App Id -> This is the Application Id that you receive when you creat a MobilePush app
 *                inside of AppCenter (http://appcenter.exacttarget.com/appcenter)
 *
 *      Client Id -> This is the app Client Id that you receive when you create a server-to-server app
 *                   inside of AppCenter (http://appcenter.exacttarget.com/appcenter)
 *
 *      Client Secret -> This is the app Client Id that you receive when you create a server-to-server app
 *                       inside of AppCenter (http://appcenter.exacttarget.com/appcenter)
 *
 *      Standard Message Id -> This is the Message Id of the api trigger message that you created inside of MobilePush.
 *                            This one does not have the CloudPage options selected. Consult the github README for info
 *                            on how to do this
 *
 *      CloudPage Message Id -> This is the Message Id of the api trigger message that you created inside of MobilePush
 *                              This one has the CloudPage options selected. Consult the github README for info
 *                              on how to do this
 */


/**
 *
 *  NOTE: The ability to change Push Configurations is available only in the Internal "ETApp Store" builds.
 *        
 *        This feature SHOULD NOT be exposed to the "Consumer Store"/ "Customers"
 *
 */

#import <Foundation/Foundation.h>

@interface PUDPushConfig : NSObject

@property (nonatomic, strong) NSString *configurationName;
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *restUrl;
@property (nonatomic, strong) NSString *standardMessageID;
@property (nonatomic, strong) NSString *cloudpageMessageID;


# pragma mark - Push Config setters

/**
 This method returns a Push Configuration by initiating it from a dictionary. Custom configurations are read from .pushconfig file using this method
 */
+ (PUDPushConfig *)pushConfigFromDictionary:(NSDictionary *)dict;

/**
 This method is called whenever a Push Config is changed. The current Push Config is replaced with the selected one. The database is refreshed everytime this happens
 */
+ (void) setCurrentConfigWithSelected: (PUDPushConfig *)config;

# pragma mark - Push Config getters

/**
 Returns current Push Configuration
 */
+ (PUDPushConfig * ) getCurrentConfig;

/**
 Returns the default Push Configuration. "Production" is the default Push Configuration for ET appstore QA and ET appstore Production builds
 */
+ (PUDPushConfig *) getDefaultPushConfig;

/**
 Returns all the default Push Configuration available. "Production" @ "QA" are the two default Push Configurations for ET appstore QA and ET appstore Production builds. That means ET appstore QA & Production apps, will have a choice to switch between "Production" and "QA".
 NOTE: The Push Config Table View has two rows in Default Configuration section
 */
+ (NSArray *) availableDefaultPushConfigs;

@end

