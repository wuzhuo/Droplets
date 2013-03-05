//
//  DRSelectionViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 03/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRSelectionViewController.h"
#import "DRDropletService.h"
#import "MBProgressHUD.h"

#define Size_Save_AlertView_Tag 1001
#define Image_Save_AlertView_Tag 1002

@interface DRSelectionViewController ()

@end

@implementation DRSelectionViewController

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectionListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _selectionArray[indexPath.row];
    if ([cell.textLabel.text isEqualToString:_selectedString]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [_selectionArray indexOfObject:_selectedString];
    NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    UITableViewCell *preCell = [tableView cellForRowAtIndexPath:preIndexPath];
    preCell.accessoryType = UITableViewCellAccessoryNone;
    
    _selectedString = _selectionArray[indexPath.row];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)saveButtonPressed:(id)sender
{
    if ([self.title isEqualToString:@"Sizes"]) {
        NSNumber *sizeID = [DRModelManager sharedInstance].reversedSizeDict[_selectedString];
        
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        [[DRDropletService sharedInstance] resizeDroplet:_dropletID sizeID:sizeID success:^{
            [hud hide:NO];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(NSString *message) {
            [hud hide:NO];
            [UIAlertView alertErrorMessage:message];
        }];
        
    } else if ([self.title isEqualToString:@"Images"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This will rebuild your droplet using the original image you specified when you deployed. Please be advised that all data will be lost." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Rebuild", nil];
        alertView.tag = Image_Save_AlertView_Tag;
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == Image_Save_AlertView_Tag) {
        NSNumber *imageID = [DRModelManager sharedInstance].reversedImageDict[_selectedString];
        
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        [[DRDropletService sharedInstance] rebuildDroplet:_dropletID imageID:imageID success:^{
            [hud hide:NO];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } failure:^(NSString *message) {
            [hud hide:NO];
            [UIAlertView alertErrorMessage:message];
        }];
    }
}

@end
