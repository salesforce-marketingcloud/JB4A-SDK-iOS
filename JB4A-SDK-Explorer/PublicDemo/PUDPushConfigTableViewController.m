/**
 * Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
//  PUDPushConfigTableViewController.m
//  PublicDemo
//
//  Created by Swetha Pendyala (Contractor) on 7/29/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDPushConfigTableViewController.h"

//Classes
#import "PUDUtility.h"
#import "PUDConstants.h"
#import "PUDPushConfig.h"
#import "ETPush.h"
#import "ETSqliteHelper.h"
#import "PUDAppSettingConstants.h"

@interface PUDPushConfigTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PUDPushConfigTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if defined (QA) || defined (DEBUG)
    [self listeningForConfigChanges];
#endif
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    _dataArray = @[[self defaultPushConfig],[self customPushConfig]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table data creation

- (NSMutableArray *) defaultPushConfig {
    
    NSMutableArray *configs = [[NSMutableArray alloc]init];
    
    configs = [NSMutableArray arrayWithArray:[PUDPushConfig availableDefaultPushConfigs]];
    
    return configs;
}

- (NSMutableArray *) customPushConfig {
    
    NSMutableArray *_configs = [[NSMutableArray alloc]init];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *configsPath = [documentsDirectory stringByAppendingPathComponent:@"PushConfig"];
    NSURL *configUrls = [NSURL fileURLWithPath:configsPath];
    
    _configs = [NSMutableArray new];
    
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:configUrls
                                                             includingPropertiesForKeys:@[NSURLIsDirectoryKey]
                                                                                options:0
                                                                           errorHandler:^BOOL(NSURL *url, NSError *error) {
                                                                               NSLog(@"Directory Enumerator failed at URL: %@", url);
                                                                               NSLog(@"Error was: %@", [error localizedDescription]);
                                                                               return true;
                                                                           }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        
        NSLog(@"File: %@", url);
        NSData *pushConfig = [NSData dataWithContentsOfURL:url];
        NSDictionary *pushConfigDict = [NSJSONSerialization JSONObjectWithData:pushConfig options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *details = [pushConfigDict objectForKey:@"PushConfig"];
        
               NSLog(@"Push Config: %@", [[NSString alloc] initWithData:pushConfig encoding:NSUTF8StringEncoding]);
        
        PUDPushConfig *_lastPushConfig = [PUDPushConfig pushConfigFromDictionary:details];
        
        if (_lastPushConfig) { // This one is hiding. To be safe
            [_configs addObject:_lastPushConfig];
        }
    }
    return _configs;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = _dataArray[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierPushConfigCell forIndexPath:indexPath];
    
    //Cell Info
    PUDPushConfig *config = _dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = config.configurationName;
    
    if ([config.configurationName isEqualToString: [PUDPushConfig getCurrentConfig].configurationName]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == kPUDConfigsDefaultIndex) {
        return @"Selected Configuration";
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Setting the current config
    
    PUDPushConfig *_lastPushConfig = _dataArray[indexPath.section][indexPath.row];
    
    if ([_lastPushConfig.configurationName isEqualToString:[PUDPushConfig getCurrentConfig].configurationName]) {
        return;
    }
    
    else {
        [PUDPushConfig setCurrentConfigWithSelected:_lastPushConfig];
        
        //Reload TableView
        [tableView reloadData];
        
        
        [[ETPush pushManager] configureSDKWithAppID:_lastPushConfig.appID
                                     andAccessToken:_lastPushConfig.accessToken
                                      withAnalytics:YES
                                andLocationServices:YES
                                      andCloudPages:YES];
        
        
        [[[UIAlertView alloc] initWithTitle:@"New Push Configuration"
                                    message:@"Done! Please remember, registrations can take up to 15 minutes to process."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show]; // I LOVE ARC!
        
    }
}

# pragma mark - Custom Methods

#if defined (QA) || defined (DEBUG)
// Registering as observer for push configuration changes, to refresh the
- (void) listeningForConfigChanges {
    //If the config is added, but not started to using, this adds a new row to the table view
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView)
                                                 name:kPUDNewPushConfigAddedNotication
                                               object:nil];
    //If the config is added, and started to use, this adds new row (if needed) and changes row selection
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView)
                                                 name:kPUDPushConfigChangedNotification
                                               object:nil];
}

- (void) reloadView {
    /*
     This method makes sure the message details change whenever the Config chnages./ new config loaded
     */
    _dataArray = @[[self defaultPushConfig],[self customPushConfig]];
    
    [self.tableView reloadData];
}

#endif
@end
