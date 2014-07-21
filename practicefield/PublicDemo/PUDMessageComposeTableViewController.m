//
//  PUDMessageDetailTableViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDMessageComposeTableViewController.h"

// Models
#import "PUDDefaultMessageModel.h"
#import "PUDMessageComposeTableData.h"
#import "PUDMessagePayload.h"

// Protocols
#import "PUDMessageModelProtocol.h"

// Views
#import "PUDDataPickerView.h"

@interface PUDMessageComposeTableViewController ()

@property (nonatomic, assign) id currentResponder;

/**
 Stores the data that will be displayed
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 The message conforming to the PUDMessageProtocol that will be displayed by the controller
 */
@property (nonatomic, strong) id<PUDMessageModelProtocol> message;

@end

@implementation PUDMessageComposeTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataArray = [self tableDataArray];
        _message = [[PUDDefaultMessageModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     Clear out any previously set properties of the message
     */
    [self.message resetMessagePayload];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    [self setupTableHeaderView];
}

- (void)setupTableHeaderView {
    /**
     *  Create label with intro text
     */
    CGFloat xMargin = 15;
    CGFloat yMargin = 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xMargin, yMargin, self.tableView.frame.size.width, 10)];
    label.numberOfLines = 0;
    label.text = @"Sending push messages from an app is not normally done. We've added this capability in this demo app for demonstration purposes only, allowing you to fully test the functionality of MobilePush within this app. \n\nMessages will only be sent to this specific device. These values would normally be set for a specific message by the marketing team in the ET Marketing Cloud.";
    label.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.9];
    label.font = [UIFont systemFontOfSize:14.0];
    label.backgroundColor = [UIColor clearColor];
    
    CGSize maxSize = CGSizeMake(self.tableView.bounds.size.width - 30.0f, CGFLOAT_MAX);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, requiredSize.width, requiredSize.height);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, label.frame.size.height + yMargin)];
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - data creation methods

- (PUDMessageComposeTableData *)sendMessageData {
    PUDMessageComposeTableData *sendNow = [[PUDMessageComposeTableData alloc] init];
    sendNow.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    sendNow.configureCellBlock = ^(UITableViewCell *cell) {
        UIButton *sendButton = (UIButton *)[cell viewWithTag:kPUDMessageDetailSendButtonTag];
        sendButton.hidden = NO;
    };
    
    return sendNow;
}

- (PUDMessageComposeTableData *)messageTextData {
    PUDMessageComposeTableData *messageText = [[PUDMessageComposeTableData alloc] init];
    messageText.sectionTitle = @"Message";
    
    messageText.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    messageText.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        textField.placeholder = kPUDAppMessageDetailDefaultMessageText;
        textField.text = [[self.message messagePayload] messageText];
        textField.hidden = NO;
    };
    
    messageText.textFieldDidEndEditingBlock = ^(UITextField *textField) {
        [[self.message messagePayload] setMessageText:textField.text];
    };
    
    messageText.sectionFooter = @"This text is displayed on the lock screen, banner, and alert views when a device receives the message.";
    
    return messageText;
}

- (PUDMessageComposeTableData *)customSoundData {
    PUDMessageComposeTableData *customSound = [[PUDMessageComposeTableData alloc] init];
    customSound.sectionTitle = @"Sound";
    customSound.pickerSelectedRow = 0;
    
    customSound.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    __weak typeof(customSound) weakCustomSound = customSound;
    customSound.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        
        NSString *defaultSound = @"Default Sound";
        NSString *custSound = @"Custom";
        NSString *noneSound = @"None";
        
        textField.hidden = NO;
        
        if (!IOS_PRE_7_0) {
            textField.tintColor = [UIColor whiteColor];
        }
        
        /**
         Set up the picker view
         */
        PUDDataPickerView *pickerView = [[PUDDataPickerView alloc] initWithArray:@[defaultSound, custSound, noneSound]];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [pickerView selectRow:weakCustomSound.pickerSelectedRow inComponent:0 animated:NO];
        pickerView.pickerViewRowSelectedBlock = ^(UIPickerView *picker) {
            PUDDataPickerView *dataPicker = (PUDDataPickerView *)picker;
            weakCustomSound.pickerSelectedRow = [dataPicker selectedRowInComponent:0];
            NSString *selectedText = dataPicker.dataArray[weakCustomSound.pickerSelectedRow];
            
            if ([selectedText isEqualToString:defaultSound]) {
                [[self.message messagePayload] setSound:@"default"];
            }
            else if ([selectedText isEqualToString:custSound]) {
                [[self.message messagePayload] setSound:@"custom.caf"];
            }
            else if ([selectedText isEqualToString:noneSound]) {
                [[self.message messagePayload] setSound:nil];
            }
            
            textField.text = selectedText;
        };
        
        /**
         Set up the textfield
         */
        textField.inputView = pickerView;
        textField.text = pickerView.dataArray[weakCustomSound.pickerSelectedRow];
    };
    
    customSound.sectionFooter = @"This is the sound that is played when the device receives the alert.";
    
    return customSound;
}

- (PUDMessageComposeTableData *)updateBadgeData {
    PUDMessageComposeTableData *updateIOSBadge = [[PUDMessageComposeTableData alloc] init];
    updateIOSBadge.sectionTitle = @"Badge";
    
    updateIOSBadge.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    updateIOSBadge.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        UISwitch *badgeSwitch = (UISwitch *)[cell viewWithTag:kPUDMessageDetailSwitchTag];
        
        textField.text = @"Update iOS Badge";
        textField.userInteractionEnabled = NO;
        textField.hidden = NO;
        
        badgeSwitch.on = ([[self.message messagePayload] badge] != nil && [[[self.message messagePayload] badge] boolValue] != NO);
        badgeSwitch.hidden = NO;
    };
    
    updateIOSBadge.switchValueChangedBlock = ^(UISwitch *badgeSwitch) {
        if (badgeSwitch.on) {
            [[self.message messagePayload] setBadge:@"+1"];
        }
        else {
            [[self.message messagePayload] setBadge:kPUDMessagePayloadDefaultBadgeValue];
        }
        
        [self reloadPostPayloadSection];
    };
    
    updateIOSBadge.sectionFooter = @"If ON, this will increment the badge count of the app by one.";
    
    return updateIOSBadge;
}

- (PUDMessageComposeTableData *)openDirectData {
    PUDMessageComposeTableData *opendirect = [[PUDMessageComposeTableData alloc] init];
    opendirect.sectionTitle = @"OpenDirect";
    
    opendirect.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    opendirect.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        textField.placeholder = kPUDMessageDetailDefaultOpenDirect;
        textField.text = [[self.message messagePayload] openDirect];
        textField.hidden = NO;
    };
    
    opendirect.textFieldDidEndEditingBlock = ^(UITextField *textField) {
        [[self.message messagePayload] setOpenDirect:textField.text];
    };
    
    opendirect.sectionFooter = @"OpenDirect allows you to specify a URL that is opened inside your app when the user activates a notification. You can specify a URL pointing to a website or a URL specifying a specific location inside your app.";
    
    return opendirect;
}

- (PUDMessageComposeTableData *)customKeyData {
    PUDMessageComposeTableData *customKey = [[PUDMessageComposeTableData alloc] init];
    customKey.sectionTitle = @"Custom Key (Discount Code)";
    
    customKey.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    __weak typeof(customKey) weakCustomKey = customKey;
    customKey.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        
        NSArray *keys = @[
                          @"None"
                          ,@"10%"
                          ,@"20%"
                          ,@"30%"
                          ];
        
        textField.hidden = NO;
        
        if (!IOS_PRE_7_0) {
            textField.tintColor = [UIColor whiteColor];
        }
        
        /**
         Set up the picker view
         */
        PUDDataPickerView *pickerView = [[PUDDataPickerView alloc] initWithArray:keys];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [pickerView selectRow:weakCustomKey.pickerSelectedRow inComponent:0 animated:NO];
        pickerView.pickerViewRowSelectedBlock = ^(UIPickerView *picker) {
            PUDDataPickerView *dataPicker = (PUDDataPickerView *)picker;
            weakCustomKey.pickerSelectedRow = [dataPicker selectedRowInComponent:0];
            NSString *selectedText = dataPicker.dataArray[weakCustomKey.pickerSelectedRow];
            
            if ([selectedText isEqualToString:@"None"]) {
                [[self.message messagePayload] setCustomKeys:nil];
            }
            else {
                NSDictionary *dict = @{kPUDMessageDetailCustomKeyDiscountCode : selectedText.lowercaseString};
                [[self.message messagePayload] setCustomKeys:dict];
            }
            
            textField.text = selectedText;
        };
        
        /**
         Set up the textfield
         */
        textField.inputView = pickerView;
        textField.text = pickerView.dataArray[weakCustomKey.pickerSelectedRow];
    };
    
    customKey.sectionFooter = @"Custom keys allow you to specify your own data to be included in the push payload received by devices. The Practice Field app uses a custom key to give discounts out to specific subscribers.";
    
    return customKey;
}

- (PUDMessageComposeTableData *)tagData {
    PUDMessageComposeTableData *tags = [[PUDMessageComposeTableData alloc] init];
    tags.sectionTitle = @"Tag";
    
    tags.cellHeightBlock = ^(){
        return (CGFloat)44.0f;
    };
    
    __weak typeof(tags) weakTags = tags;
    tags.configureCellBlock = ^(UITableViewCell *cell) {
        UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
        
        NSArray *tags = @[
                          @"None"
                          ,kPUDTagCowboys
                          ,kPUDTagPackers
                          ,kPUDTagGiants
                          ,kPUDTagSteelers
                          ,kPUDTagColts
                          ,kPUDTagArsenal
                          ,kPUDTagChelsea
                          ,kPUDTagManu
                          ,kPUDTagMadrid
                          ,kPUDTagFcbarc
                          ];
        
        textField.hidden = NO;
        
        if (!IOS_PRE_7_0) {
            textField.tintColor = [UIColor whiteColor];
        }
        
        /**
         Set up the picker view
         */
        PUDDataPickerView *pickerView = [[PUDDataPickerView alloc] initWithArray:tags];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [pickerView selectRow:weakTags.pickerSelectedRow inComponent:0 animated:NO];
        pickerView.pickerViewRowSelectedBlock = ^(UIPickerView *picker) {
            PUDDataPickerView *dataPicker = (PUDDataPickerView *)picker;
            weakTags.pickerSelectedRow = [dataPicker selectedRowInComponent:0];
            NSString *selectedText = dataPicker.dataArray[weakTags.pickerSelectedRow];
            
            if ([selectedText isEqualToString:@"None"]) {
                [[self.message messagePayload] setInclusionTags:nil];
            }
            else {
                [[self.message messagePayload] setInclusionTags:@[selectedText.lowercaseString]];
            }
            
            textField.text = selectedText;
        };
        
        /**
         Set up the textfield
         */
        textField.inputView = pickerView;
        textField.text = pickerView.dataArray[weakTags.pickerSelectedRow];
    };
    
    tags.sectionFooter = @"Select a tag to filter the send on. You must have the tag set to ON in the Preferences tab in order to receive the message.";
    
    return tags;
}

- (PUDMessageComposeTableData *)payloadData {
    PUDMessageComposeTableData *payload = [[PUDMessageComposeTableData alloc] init];
    payload.sectionTitle = @"Fuel Payload";
    
    payload.cellHeightBlock = ^(){
        return [self textViewHeightForText:[self.message restPayloadString]];
    };
    
    payload.configureCellBlock = ^(UITableViewCell *cell) {
        cell.textLabel.text = [self.message restPayloadString];
        cell.textLabel.hidden = NO;
    };
    
    return payload;
}

- (NSArray *)tableDataArray {
    NSMutableArray *dataArray = [NSMutableArray array];
    
    //[dataArray autoExpandInsertObject:[self payloadData] atIndex:kPUDMessageDetailPayloadSectionIndex];
    [dataArray autoExpandInsertObject:[self sendMessageData] atIndex:kPUDMessageDetailSendMessageSectionIndex];
    [dataArray autoExpandInsertObject:[self messageTextData] atIndex:kPUDMessageDetailMessageTextSectionIndex];
    [dataArray autoExpandInsertObject:[self customSoundData] atIndex:kPUDMessageDetailCustomSoundSectionIndex];
    [dataArray autoExpandInsertObject:[self updateBadgeData] atIndex:kPUDMessageDetailUpdateBadgeSectionIndex];
    [dataArray autoExpandInsertObject:[self tagData] atIndex:kPUDMessageDetailTagsSectionIndex];
    [dataArray autoExpandInsertObject:[self customKeyData] atIndex:kPUDMessageDetailCustomKeySectionIndex];
    [dataArray autoExpandInsertObject:[self openDirectData] atIndex:kPUDMessageDetailOpenDirectSectionIndex];
    
    return dataArray;
}

#pragma mark - table view implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    PUDMessageComposeTableData *data = self.dataArray[section];
    return data.sectionTitle;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    PUDMessageComposeTableData *data = self.dataArray[section];
    return data.sectionFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierMessageDetailCell forIndexPath:indexPath];
    
    UISwitch *badgeSwitch = (UISwitch *)[cell viewWithTag:kPUDMessageDetailSwitchTag];
    UIButton *sendButton = (UIButton *)[cell viewWithTag:kPUDMessageDetailSendButtonTag];
    UITextField *textField = (UITextField *)[cell viewWithTag:kPUDMessageDetailTextFieldTag];
    
    /**
     Create switch if needed
     */
    if (!badgeSwitch) {
        badgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.bounds.size.width - 70.0, 7.0, 45.0, 34.0)];
        [badgeSwitch addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
        badgeSwitch.tag = kPUDMessageDetailSwitchTag;
        badgeSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:badgeSwitch];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(badgeSwitch);
        [badgeSwitch.superview addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"[badgeSwitch]-15.0-|"
                                             options:kNilOptions
                                             metrics:nil
                                             views:views]];
    }
    
    /**
     Create button if needed
     */
    if (!sendButton) {
        sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        sendButton.tag = kPUDMessageDetailSendButtonTag;
        sendButton.translatesAutoresizingMaskIntoConstraints = NO;
        sendButton.frame = CGRectMake(15, 12, 200, 20);
        [sendButton setTitle:@"Send Message" forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendMessageButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:sendButton];
        
        [cell.contentView addConstraint: [NSLayoutConstraint constraintWithItem:sendButton
                                                                      attribute:NSLayoutAttributeCenterX
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell.contentView
                                                                      attribute:NSLayoutAttributeCenterX
                                                                     multiplier:1
                                                                       constant:0]];
    }
    
    /**
     Create textfield if needed
     */
    if (!textField) {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 7.0, self.tableView.bounds.size.width - 30, 34.0)];
        textField.tag = kPUDMessageDetailTextFieldTag;
        textField.delegate = self;
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:textField];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(textField);
        [textField.superview addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"|-[textField]-|"
                                   options:kNilOptions
                                   metrics:nil
                                   views:views]];
    }
    
    /**
     Hide all the ui elements by default
     */
    cell.textLabel.hidden = YES;
    
    if (badgeSwitch) {
        badgeSwitch.hidden = YES;
    }
    
    if (sendButton) {
        sendButton.hidden = YES;
    }
    
    if (textField) {
        
        if (!IOS_PRE_7_0) {
            textField.tintColor = nil;
        }
        
        textField.userInteractionEnabled = YES;
        textField.hidden = YES;
        textField.inputView = nil;
        textField.placeholder = nil;
        textField.text = nil;
    }
    
    /**
     Set defaults values for the text label
     */
    cell.textLabel.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /**
     Customize the cell
     */
    PUDMessageComposeTableData *data = self.dataArray[indexPath.section];
    data.configureCellBlock(cell);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUDMessageComposeTableData *data = self.dataArray[indexPath.section];
    return data.cellHeightBlock();
}

- (CGFloat)textViewHeightForText:(NSString *)text {
    /**
     There are better ways of doing this but for the demo's purpose it is fine to create a label everytime
     */
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    label.numberOfLines = 0;
    label.text = text;
    
    /**
     Subtract 30.0 here to account for padding
     */
    CGSize maxSize = CGSizeMake(self.tableView.bounds.size.width - 30.0f, CGFLOAT_MAX);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, requiredSize.width, requiredSize.height);
    
    /**
     Add 20.0 here to account for padding
     */
    return label.frame.size.height + 28.0f;
}

#pragma mark - ui action methods

- (void)sendMessageButtonTapped:(id)sender {
    NSString *validationErrorMessage = [self.message validationErrorMessage];
    
    if (validationErrorMessage) {
        [[[UIAlertView alloc] initWithTitle:@"Validation Failed" message:validationErrorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        [self showSendingInformationAlert];
    }
}

- (void)switchValueDidChange:(UISwitch *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    PUDMessageComposeTableData *data = self.dataArray[indexPath.section];
    
    if (data.switchValueChangedBlock) {
        data.switchValueChangedBlock(sender);
    }
}

- (void)showSendingInformationAlert {
    NSString *text = @"To view the push as a standard iOS alert, exit out of the app (via the home button) after receiving the success message.";
    [[[UIAlertView alloc] initWithTitle:nil message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        [self.message sendMessage];
    }
}

#pragma mark - text view delegate methods

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGPoint buttonPosition = [textField convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    PUDMessageComposeTableData *data = self.dataArray[indexPath.section];
    
    if (data.textFieldDidEndEditingBlock) {
        data.textFieldDidEndEditingBlock(textField);
    }
    
    [self reloadPostPayloadSection];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - picker view methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    PUDDataPickerView *dataPicker = (PUDDataPickerView *)pickerView;
    return dataPicker.dataArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    PUDDataPickerView *dataPicker = (PUDDataPickerView *)pickerView;
    return dataPicker.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    PUDDataPickerView *dataPicker = (PUDDataPickerView *)pickerView;
    dataPicker.pickerViewRowSelectedBlock(dataPicker);
    [self reloadPostPayloadSection];
}

#pragma mark - other methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.currentResponder resignFirstResponder];
}

- (void)reloadPostPayloadSection {
    return;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:kPUDMessageDetailPayloadSectionIndex];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
