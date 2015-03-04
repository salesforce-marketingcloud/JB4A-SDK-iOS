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
//  PUDAppSettingConstants.h
//  PublicDemo
//
//  Created by Matt Lathrop on 6/27/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

/**
 *  ET_NOTE: This file stores your app specific settings. An explanation of each setting:
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
 *      Message Id Vanilla -> This is the Message Id of the api trigger message that you created inside of MobilePush.
 *                            This one does not have the CloudPage options selected. Consult the github README for info 
 *                            on how to do this
 *
 *      Message Id CloudPage -> This is the Message Id of the api trigger message that you created inside of MobilePush
 *                              This one has the CloudPage options selected. Consult the github README for info
 *                              on how to do this
 */

#pragma mark - DEV settings

extern NSString *const kAppSettingDevConfigName;
extern NSString *const kAppSettingDevAccessToken;
extern NSString *const kAppSettingDevAccessTokenUrl;
extern NSString *const kAppSettingDevAppId;
extern NSString *const kAppSettingDevClientId;
extern NSString *const kAppSettingDevClientSecret;
extern NSString *const kAppSettingDevOutboundMessageIdVanilla;
extern NSString *const kAppSettingDevOutboundMessageIdCloudPage;

#pragma mark - QA settings

extern NSString *const kAppSettingQaConfigName;
extern NSString *const kAppSettingQaAccessToken;
extern NSString *const kAppSettingQaAppId;
extern NSString *const kAppSettingQaClientId;
extern NSString *const kAppSettingQaClientSecret;
extern NSString *const kAppSettingQaOutboundMessageIdVanilla;
extern NSString *const kAppSettingQaOutboundMessageIdCloudPage;

#pragma mark - ETPROD settings

extern NSString *const kAppSettingEtprodConfigName;
extern NSString *const kAppSettingEtprodAccessToken;
extern NSString *const kAppSettingEtprodAccessTokenUrl;
extern NSString *const kAppSettingEtprodAppId;
extern NSString *const kAppSettingEtprodClientId;
extern NSString *const kAppSettingEtprodClientSecret;
extern NSString *const kAppSettingEtprodOutboundMessageIdVanilla;
extern NSString *const kAppSettingEtprodOutboundMessageIdCloudPage;

#pragma mark - APPSTORE settings

extern NSString *const kAppSettingAppstoreConfigName;
extern NSString *const kAppSettingAppstoreAccessToken;
extern NSString *const kAppSettingAppstoreAccessTokenUrl;
extern NSString *const kAppSettingAppstoreAppId;
extern NSString *const kAppSettingAppstoreClientId;
extern NSString *const kAppSettingAppstoreClientSecret;
extern NSString *const kAppSettingAppstoreOutboundMessageIdVanilla;
extern NSString *const kAppSettingAppstoreOutboundMessageIdCloudPage;
