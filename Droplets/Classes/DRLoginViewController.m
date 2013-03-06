//
//  DRLoginViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRLoginViewController.h"

#define Client_Key_TextField_Tag 1001
#define API_Key_TextField_Tag 1002

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([DRPreferences clientID] && [DRPreferences APIKey]) {
        self.clientIDTextField.text = [DRPreferences clientID];
        self.apiKeyTextField.text = [DRPreferences APIKey];
        
        [self loginAndDownload];
    }
}

- (void)loginAndDownload
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        [UIAlertView alertErrorMessage:@"Client ID & API Key cannot be blank!"];
        return;
    }
    
    if (!_hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    } else {
        [self.hud show:YES];
    }
    _hud.dimBackground = YES;
    _hud.delegate = self;
    _hud.labelText = @"Validating...";
    
    [[DRServiceManager sharedInstance] validateUserSuccess:^{
        _hud.labelText = @"Downloading...";
        
    } downloadDataFinish:^{
        _hud.labelText = @"Completed";
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark"]];
        _hud.mode = MBProgressHUDModeCustomView;
        [_hud hide:YES afterDelay:1.5];
        
        [self performSelector:@selector(showDropletList) withObject:nil afterDelay:2.0];
        
    } failure:^(NSString *errorMessage) {
        [_hud hide:NO];
        [UIAlertView alertErrorMessage:errorMessage];
    }];
}

- (void)showDropletList
{
    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"DRMainTabBarController"];
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.clientIDTextField resignFirstResponder];
    [self.apiKeyTextField resignFirstResponder];
    
    if (indexPath.section == 1 && indexPath.row == 0) { // validate user
        NSString *clientID = [self.clientIDTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *apiKey = [self.apiKeyTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([clientID isEqualToString:@""]) {
            [DRPreferences setClientID:nil];
        } else {
            [DRPreferences setClientID:clientID];
        }
        if ([apiKey isEqualToString:@""]) {
            [DRPreferences setAPIKey:nil];
        } else {
            [DRPreferences setAPIKey:apiKey];
        }
        [DRPreferences save];
        
        [self loginAndDownload];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
