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
//  PUDPushConfig.m
//  PublicDemo
//
//  Created by Swetha Pendyala (Contractor) on 7/25/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDPushConfig.h"

//Classes
#import "PUDAppSettingConstants.h"
#import "PUDConstants.h"

//SDK
#import "ETPush.h"

@implementation PUDPushConfig

@synthesize appID = _appID;
@synthesize accessToken = _accessToken;
@synthesize clientID = _clientID;
@synthesize clientSecret = _clientSecret;
@synthesize standardMessageID = _standardMessageID;
@synthesize cloudpageMessageID = _cloudpageMessageID;

+ (PUDPushConfig *) getDefaultPushConfig
{
    PUDPushConfig *push = [[PUDPushConfig alloc] init];
    
    push.appID = kAppSettingEtProd_DevAPNSAppId;
    push.accessToken = kAppSettingEtProd_DevAPNSAccessToken;
    push.clientID = kAppSettingEtProd_DevAPNSClientId ;
    push.clientSecret = kAppSettingEtProd_DevAPNSClientSecret;
    push.standardMessageID = kAppSettingEtProd_DevAPNSOutboundMessageIdStandard;
    push.cloudpageMessageID = kAppSettingEtProd_DevAPNSOutboundMessageIdCloudPage;
    
    return push;
}

@end

