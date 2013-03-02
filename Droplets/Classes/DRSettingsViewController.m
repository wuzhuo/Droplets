//
//  DRSettingsViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRSettingsViewController.h"
#import "DROAuthViewController.h"

@interface DRSettingsViewController ()

@end

@implementation DRSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UITableViewCell *clientIDCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    clientIDCell.detailTextLabel.text = [DRPreferences clientID];
    
    UITableViewCell *apiKeyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    apiKeyCell.detailTextLabel.text = [DRPreferences APIKey];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"SettingsCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { // Account
        if (indexPath.row == 2) { // login or logout
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([cell.textLabel.text isEqualToString:@"Login"]) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Input Client ID & API Key"
                                                                         delegate:self
                                                                cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:@"Copy from Web", @"Input by Hand", nil];
                [actionSheet showInView:self.view];
                
            } else if ([cell.textLabel.text isEqualToString:@"logout"]) {
                [DRPreferences setClientID:nil];
                [DRPreferences setAPIKey:nil];
                [DRPreferences save];
            }
        }
        
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { // copy from web
        DROAuthViewController *oauthVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DROAuthViewController"];
        [self.navigationController pushViewController:oauthVC animated:YES];
    } else if (buttonIndex == 1) { // input by hand
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login"
                                                            message:@"Input Client ID & API Key"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
    }
}

@end
