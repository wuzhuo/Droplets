//
//  DRDropletDetailViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRDropletDetailViewController.h"
#import "DRDropletService.h"
#import "DRRegionModel.h"
#import "DRSelectionViewController.h"

#define Destroy_Confirm_AlertView_Tag 1001

@interface DRDropletDetailViewController ()
@property (nonatomic, strong) DRDropletService *dropletService;
@end

@implementation DRDropletDetailViewController
{
    NSArray *_operationArray;
    NSIndexPath *_selectedAccessoryButtonIndexPath;
}

- (void)awakeFromNib
{
    _operationArray = @[];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = _dropletDict[@"name"];
    [self reloadData];
}

#pragma mark - Accessors

- (DRDropletService *)dropletService
{
    if (!_dropletService) {
        _dropletService = [[DRDropletService alloc] init];
    }
    return _dropletService;
}

- (void)reloadData
{
    if ([_dropletDict[@"status"] isEqualToString:@"active"]) { // when the server is active
        if ([_dropletDict[@"backups_active"] respondsToSelector:@selector(intValue)]
            && [_dropletDict[@"backups_active"] intValue] > 0) {
            _operationArray = @[@"Reboot", @"Power Cycle", @"Shutdown", @"Power Off", @"Reset Root Password", @"Disable Automatic Backups", @"Rebuild", @"Destroy"];
        } else {
            _operationArray = @[@"Reboot", @"Power Cycle", @"Shutdown", @"Power Off", @"Reset Root Password", @"Enable Automatic Backups", @"Rebuild", @"Destroy"];
        }
        
    } else {
        if ([_dropletDict[@"backups_active"] respondsToSelector:@selector(intValue)]
            && [_dropletDict[@"backups_active"] intValue] > 0) {
            _operationArray = @[@"Boot", @"Reset Root Password", @"Resize", @"Disable Automatic Backups", @"Rebuild", @"Destroy"];
        } else {
            _operationArray = @[@"Boot", @"Reset Root Password", @"Resize", @"Enable Automatic Backups", @"Rebuild", @"Destroy"];
        }
        
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) { // basic info
        return 5;
    } else { // operation
        return _operationArray.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _dropletDict[@"name"];
    }
    return @"Operaion";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DetailCellIdentifier = @"DetailListCell";
    static NSString *OperationCellIdentifier = @"OperationListCell";
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier forIndexPath:indexPath];
        
        if (indexPath.row == 0) { //
            cell.textLabel.text = @"IP";
            cell.detailTextLabel.text = _dropletDict[@"ip_address"];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Status";
            cell.detailTextLabel.text = _dropletDict[@"status"];
            if ([_dropletDict[@"status"] isEqualToString:@"active"]) {
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.000 green:0.400 blue:0.000 alpha:1.000];
            } else {
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.600 green:0.000 blue:0.000 alpha:1.000];
            }
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Size";
            cell.detailTextLabel.text = [DRModelManager sharedInstance].sizeDict[_dropletDict[@"size_id"]];
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Image";
            cell.detailTextLabel.text = [DRModelManager sharedInstance].imageDict[_dropletDict[@"image_id"]];
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"Region";
            cell.detailTextLabel.text = [DRModelManager sharedInstance].regionDict[_dropletDict[@"region_id"]];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:OperationCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = _operationArray[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *operation = cell.textLabel.text;
    
    if ([operation isEqualToString:@"Reboot"]) {
        [[DRDropletService sharedInstance] rebootDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Power Cycle"]) {
        [[DRDropletService sharedInstance] powerCycleDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Shutdown"]) {
        [[DRDropletService sharedInstance] shutDownDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Power Off"]) {
        [[DRDropletService sharedInstance] powerOffDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Boot"]) {
        [[DRDropletService sharedInstance] powerOnDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    
    else if ([operation isEqualToString:@"Reset Root Password"]) {
        [[DRDropletService sharedInstance] resetRootPasswordDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Resize"]) {
        DRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DRSelectionViewController"];
        selectionVC.dropletID = _dropletDict[@"id"];
        selectionVC.selectionArray = [DRModelManager sharedInstance].sortedReversedSizeDictKeys;
        selectionVC.selectedString = [DRModelManager sharedInstance].sizeDict[_dropletDict[@"size_id"]];
        selectionVC.title = @"Sizes";
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
    
    else if ([operation isEqualToString:@"Take a Snapshot"]) {
        
        
    }
    else if ([operation isEqualToString:@"Restore Droplet"]) {
        
        
        
    }
    
    else if ([operation isEqualToString:@"Enable Automatic Backups"]) {
        [[DRDropletService sharedInstance] enableAutomaticBackups:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Disable Automatic Backups"]) {
        [[DRDropletService sharedInstance] disableAutomaticBackups:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
    
    else if ([operation isEqualToString:@"Rebuild"]) {
        DRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DRSelectionViewController"];
        selectionVC.dropletID = _dropletDict[@"id"];
        selectionVC.selectionArray = [DRModelManager sharedInstance].sortedReversedImageDictKeys;
        selectionVC.selectedString = [DRModelManager sharedInstance].imageDict[_dropletDict[@"image_id"]];
        selectionVC.title = @"Images";
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
    else if ([operation isEqualToString:@"Destroy"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This is irreversible. We will destroy your droplet and all associated backups." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Destroy", nil];
        alertView.tag = Destroy_Confirm_AlertView_Tag;
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == Destroy_Confirm_AlertView_Tag) {
        [[DRDropletService sharedInstance] destroyDroplet:_dropletDict[@"id"] success:^{
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *message) {
            [UIAlertView alertErrorMessage:message];
        }];
    }
}

@end
