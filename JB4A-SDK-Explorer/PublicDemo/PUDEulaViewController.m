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
//  PUDEulaViewController.m
//  PublicDemo
//
//  Created by Peter Van Dyk (Contractor) on 9/4/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDEulaViewController.h"

// Controllers
#import "PUDPageContentViewController.h"

//Classes

@interface PUDEulaViewController ()



@end

@implementation PUDEulaViewController

- (NSString *)htmlPrefix {
    return @"<html style=\"margin:10px; font-size:16px; word-wrap: break-word;\"><font color=\"black\" face=\"Avenir Next\">";
}

- (NSArray *)pageHtml {
    return [self pageHtmlWithHeader:YES];
}

- (NSArray *)pageHtmlWithHeader:(BOOL)hasHeader {
    NSString *headerHtml = @"<h3 style=\"text-align:center;\">Journey Builder for Apps (JB4A) IOS SDK</h3>";
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[[self eulaBody]]];
    
    if (hasHeader) {
        NSMutableArray *newArray = [NSMutableArray array];
        
        for (NSString *str in array) {
            [newArray addObject:[headerHtml stringByAppendingString:str]];
        }
        
        array = newArray;
    }
    
    return array;
}

#pragma mark - page content

- (NSString *)eulaBody {
    
    NSString *ret = @
    "<a href=\"http://www.exacttarget.com/privacy-policy\">Privacy Policy</a>"
    "<p>"
    "This is a legally binding agreement. Please read it carefully. By clicking \"I Accept\", or installing or using the Journey Builder for Apps (JB4A) IOS SDK for IOS software and/or any updates to such software provided by salesforce.com, inc. and/or a salesforce.com, inc. affiliate (collectively, \"salesforce.com\"), you:"
    "</p>"
    "<ul>"
    "<li>agree to the following terms on behalf of the salesforce.com customer with which you are employed, affiliated or associated (the \"Customer\"),</li>"
    "<li>represent that you have the authority to bind the Customer to these terms, and</li>"
    "<li>represent that you are an authorized User under the master subscription agreement between salesforce.com and the Customer (the \"Master Subscription Agreement\").</li>"
    "</ul>"
    "<p>"
    "If you do not have such authority, are not an authorized User, or do not agree to these terms, you may not install or use the Software."
    "</p>"
    "<p>"
    "Apple Inc. may, at any time and without notice, restrict, interrupt or prevent use of the Software, or delete the Software from your or the Customer's Apple devices, or require salesforce.com to do any of the foregoing, without entitling the Customer or you to any refund, credit or other compensation from salesforce.com or any third party (including, but not limited to, Apple Inc. or your network connectivity provider)."
    "</p>"
    "<p>"
    "This Order Form Supplement was last updated on July 22, 2014. It is effective between the Customer and salesforce.com as of the date you first download, install or use the Software, whichever is earliest."
    "</p>"
    "<p>"
    "1. THIS ORDER FORM SUPPLEMENT"
    "</p>"
    "<p>"
    "This Order Form Supplement is a part of each Order Form by which the Customer ordered the Journey Builder for Apps (JB4A) IOS SDK service, or a salesforce.com service incorporating the Journey Builder for Apps (JB4A) IOS SDK service (an \"Order Form\"). The Order Form and this Order Form Supplement are governed by the Master Subscription Agreement.  This Order Form Supplement adjusts certain terms of the Master Subscription Agreement, solely with respect to the Software.  Capitalized terms used but not defined in this Order Form Supplement have the meanings given to them in the Master Subscription Agreement."
    "</p>"
    "<p>"
    "2. THE SOFTWARE"
    "</p>"
    "<p>"
    "The Software allows Journey Builder for Apps (JB4A) IOS SDK customers to use the Journey Builder for Apps (JB4A) IOS SDK service from Supported Devices. A \"Supported Device\" is a combination of an Apple device model and relevant iOS software version(s) that is supported by the Software. The Software is provided by salesforce.com as a component of the applicable service described in the Order Form."
    "</p>"
    "<p>"
    "3. WHO YOU ARE CONTRACTING WITH"
    "</p>"
    "<p>"
    "This Order Form Supplement is being entered into between the salesforce.com entity named on the Order Form and the Customer. In this Order Form Supplement, the term \"salesforce.com\" means that entity."
    "</p>"
    "<p>"
    "4. SOFTWARE LICENSE"
    "</p>"
    "<p>"
    "The Software, including software embedded in the Software, is licensed, not sold, to the Customer by salesforce.com only under the terms of the Master Subscription Agreement, the Order Form and this Order Form Supplement, and salesforce.com reserves all rights not expressly granted to the Customer. This Software may include some third-party software; please visit help.salesforce.com for additional notices required by our licensors. The Customer or you own the media or device on which the Software is recorded or stored but salesforce.com retains ownership of the Software itself."
    "</p>"
    "<p>"
    "5. PERMITTED LICENSE USES AND RESTRICTIONS"
    "</p>"
    "<p>"
    "(a) This Order Form Supplement allows you, as an authorized User under the Master Subscription Agreement, to use the Software on any Supported Device and on no other devices."
    "</p>"
    "<p>"
    "(b) You may not distribute or make the Software available over a network where it could be used by multiple devices at the same time."
    "</p>"
    "<p>"
    "(c) With respect to updates to the Software that salesforce.com may make available for download, this Order Form Supplement allows you to download such Software updates to update or restore the Software on any Supported Device."
    "</p>"
    "<p>"
    "(d) Except as and only to the extent permitted by applicable law, or by licensing terms governing use of open-sourced components included with the Software, neither you nor any other Customer personnel may copy, decompile, reverse engineer, disassemble, attempt to derive the source code of, decrypt, modify, or create derivative works of the Software or Software updates, or any part thereof. Any attempt to do so is a violation of the rights of salesforce.com and its licensors. If you or any other Customer personnel violate this restriction, you or they, and the Customer, may be subject to prosecution and damages."
    "</p>"
    "<p>"
    "(e) Neither you nor the Customer may rent, lease, lend, redistribute or sublicense the Software. The Customer may, however, allow other authorized Users under the Master Subscription Agreement to use the Software in connection with a re-assignment of the Supported Device to another authorized User under the Master Subscription Agreement."
    "</p>"
    "<p>"
    "(f) The Software is available only for Supported Devices, and is not available for all devices. Please check www.salesforce.com or contact your salesforce.com representative to determine whether a specific device-iOS software combination is supported by the Software."
    "</p>"
    "<p>"
    "6. TERM AND TERMINATION"
    "</p>"
    "<p>"
    "Salesforce.com may terminate this Order Form Supplement at any time upon 30 days' notice to Customer without cause, or immediately upon notice to the Customer if any third party (including, but not limited to, Apple Inc., or your network connectivity provider) restricts, prevents or ceases to authorize the installation or use of the Software on your Supported Device or over your network. In addition, this Order Form Supplement shall terminate immediately and automatically upon any termination or expiration of the Customer's subscription to the Journey Builder for Apps (JB4A) IOS SDK service. Upon any such termination or expiration, the Customer (including you) shall no longer be permitted to use the Software, and shall delete or destroy all copies of the Software in its (including your) possession."
    "</p>"
    "<p>"
    "Termination of this Order Form Supplement shall not entitle the Customer to any refund, credit, or other compensation from salesforce.com under the Master Subscription Agreement or any other agreement or from any third party."
    "</p>"
    "<p>"
    "7. SERVICE LEVEL AGREEMENT"
    "</p>"
    "<p>"
    "Any service level agreement in effect between the Customer and saleforce.com shall not apply to the Software."
    "</p>"
    "<p>"
    "8. USE OF DATA"
    "</p>"
    "<p>"
    "The Software may obtain information from, or access data stored on, a Supported Device to provide the Journey Builder for Apps IOS (JB4A) SDK service.  The Software may transmit information to and from your device to provide the Journey Builder for Apps (JB4A) IOS SDK service.  The Software may provide salesforce.com with information related to your use of the Journey Builder for Apps (JB4A) IOS SDK service, information regarding your computer system, and information regarding your interaction with the Software, which salesforce.com may use to provide and improve the Journey Builder for Apps (JB4A) IOS SDK service and related products.  The Software’s access to information through your or the Customer’s device does not cause that information to be Customer Data under the Master Subscription Agreement or the ETMC Privacy Statement."
    "</p>"
    "<p>"
    "9. TERMS REQUIRED BY APPLE INC."
    "</p>"
    "<p>"
    "(a) This Order Form Supplement is between the Customer and salesforce.com only, and not with Apple. Salesforce.com is solely responsible for the Software."
    "</p>"
    "<p>"
    "(b) Customer's use of the Software must comply with the Usage Rules set forth in the Goole Play Store Terms of Use."
    "</p>"
    "<p>"
    "(c) Salesforce.com is solely responsible for providing and Apple has no obligation to provide maintenance and support for the Software. Support requests, as well as questions, complaints or claims regarding the Software, may be directed to salesforce.com Customer Support, via http://www.exacttarget.com/services/technical-support ."
    "</p>"
    "<p>"
    "(d) In the event of any failure of the Software to comply with the warranty in the Master Subscription Agreement, the Customer may notify Apple, and Apple will refund the purchase price for the Software to the Customer. To the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the Software, and will not be liable for any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty. Salesforce.com shall not be required to provide a refund to you or to the Customer under any circumstances."
    "</p>"
    "<p>"
    "(e) Apple shall not be responsible for addressing any claims by you, the Customer or any third party relating to the Software or the Customer's possession and/or use of the Software, including but not limited to (i) product liability claims, (ii) any claim that the Software fails to conform to any applicable legal or regulatory requirement, or (iii) claims arising under consumer protection or similar legislation."
    "</p>"
    "<p>"
    "(f) Apple shall not be responsible for the investigation, defense, settlement or discharge of any claim that the Software, or your or the Customer's possession and use of the Software, infringes a third party's intellectual property rights."
    "</p>"
    "<p>"
    "(g) The Customer represents and warrants that (i) the Software will not be downloaded or used in, or transported to, a country that is subject to a U.S. Government embargo, or has been designated by the U.S. Government as a \"terrorist-supporting\" country, and (ii) neither the Customer nor any User is listed on any U.S. Government list of prohibited or restricted parties."
    "</p>"
    "<p>"
    "(h) Salesforce.com's address is The Landmark @ One Market, Suite 300, San Francisco, California 94105, U.S.A."
    "</p>"
    "<p>"
    "(i) Notwithstanding anything to the contrary in the Master Subscription Agreement, Apple and its subsidiaries are third-party beneficiaries of this Order Form Supplement, and have the right (and shall be deemed to have accepted the right) to enforce this Order Form Supplement against you and the Customer."
    "Please indicate whether you agree to the terms of this Order Form Supplement."
    "</p>"
    ;
    
    return ret;
}

@end