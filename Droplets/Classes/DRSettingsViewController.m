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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) { // Account
        if (indexPath.row == 1) { // Sign out
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure sign out?"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:@"Sign Out"
                                                            otherButtonTitles:nil];
            actionSheet.delegate = self;
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) { // More Apps
            [[UIApplication sharedApplication] openURL:More_Apps_URL.toURL];
        }
    }
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [DRPreferences setClientID:nil];
        [DRPreferences setAPIKey:nil];
        [DRPreferences save];
        self.tabBarController.selectedIndex = 0;
        
        UINavigationController *loginNC = [self.storyboard instantiateInitialViewController];
        UIWindow* window = [[UIApplication sharedApplication].delegate window];
        window.rootViewController = loginNC;
        [window makeKeyAndVisible];
    }
}

@end
