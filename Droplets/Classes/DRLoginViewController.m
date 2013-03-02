//
//  DRLoginViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRLoginViewController.h"

@interface DRLoginViewController ()

@end

@implementation DRLoginViewController

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) { // validate user
        [DRPreferences setClientID:self.clientIDTextField.text];
        [DRPreferences setAPIKey:self.apiKeyTextField.text];
        [DRPreferences save];
        [[DRServiceManager sharedInstance] validateUserAndDownloadEssentialData];
    }
}

@end
