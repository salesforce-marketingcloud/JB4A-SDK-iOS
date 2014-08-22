/**
 * Copyright (c) 2014 ExactTarget, Inc.
 * All rights reserved.
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
//  Copyright (c) 2014 ExactTarget. All rights reserved.
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

#pragma mark - AdHoc settings

extern NSString *const kAppSettingAdHocAccessToken;
extern NSString *const kAppSettingAdHocAppId;
extern NSString *const kAppSettingAdHocClientId;
extern NSString *const kAppSettingAdHocClientSecret;
extern NSString *const kAppSettingAdHocOutboundMessageIdVanilla;
extern NSString *const kAppSettingAdHocOutboundMessageIdCloudPage;

#pragma mark - Debug settings

extern NSString *const kAppSettingDebugAccessToken;
extern NSString *const kAppSettingDebugAppId;
extern NSString *const kAppSettingDebugClientId;
extern NSString *const kAppSettingDebugClientSecret;
extern NSString *const kAppSettingDebugOutboundMessageIdVanilla;
extern NSString *const kAppSettingDebugOutboundMessageIdCloudPage;

#pragma mark - QA settings

extern NSString *const kAppSettingQAAccessToken;
extern NSString *const kAppSettingQAAppId;
extern NSString *const kAppSettingQAClientId;
extern NSString *const kAppSettingQAClientSecret;
extern NSString *const kAppSettingQAOutboundMessageIdVanilla;
extern NSString *const kAppSettingQAOutboundMessageIdCloudPage;

#pragma mark - Release settings

extern NSString *const kAppSettingReleaseAccessToken;
extern NSString *const kAppSettingReleaseAppId;
extern NSString *const kAppSettingReleaseClientId;
extern NSString *const kAppSettingReleaseClientSecret;
extern NSString *const kAppSettingReleaseOutboundMessageIdVanilla;
extern NSString *const kAppSettingReleaseOutboundMessageIdCloudPage;
