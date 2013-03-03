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
        _operationArray = @[@"Reboot", @"Shutdown", @"Reset Root Password", @"Destroy"];
    } else if ([_dropletDict[@"status"] isEqualToString:@"off"]) {
        _operationArray = @[@"Boot", @"Reset Root Password", @"Resize", @"Take a Snapshot", @"Rebuild", @"Destroy"];
    }
    [self.tableView reloadData];
}

- (void)alertErrorMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) { // basic info
        return 4;
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
            cell.textLabel.text = @"Size";
            cell.detailTextLabel.text = [DRModelManager sharedInstance].sizeDict[_dropletDict[@"size_id"]];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Image";
            cell.detailTextLabel.text = [DRModelManager sharedInstance].imageDict[_dropletDict[@"image_id"]];
        } else if (indexPath.row == 3) {
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
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Power Cycle"]) {
        [[DRDropletService sharedInstance] powerCycleDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Shutdown"]) {
        [[DRDropletService sharedInstance] shutDownDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Power Off"]) {
        [[DRDropletService sharedInstance] powerOffDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Boost"]) {
        [[DRDropletService sharedInstance] powerOnDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    
    
    
    
    
    
    
    
    else if ([operation isEqualToString:@"Reset Root Password"]) {
        [[DRDropletService sharedInstance] resetRootPasswordDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
    else if ([operation isEqualToString:@"Resize"]) {
        DRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DRSelectionViewController"];
            selectionVC.selectionArray = [DRModelManager sharedInstance].sortedReversedSizeDictKeys;
            selectionVC.selectedString = [DRModelManager sharedInstance].sizeDict[_dropletDict[@"size_id"]];
            selectionVC.title = @"Size";
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
    
    
    
    else if ([operation isEqualToString:@"Rebuild"]) {
        DRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DRSelectionViewController"];
        selectionVC.selectionArray = [DRModelManager sharedInstance].sortedReversedImageDictKeys;
        selectionVC.selectedString = [DRModelManager sharedInstance].imageDict[_dropletDict[@"image_id"]];
        selectionVC.title = @"Image";
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
    else if ([operation isEqualToString:@"Destroy"]) {
        [[DRDropletService sharedInstance] destroyDroplet:_dropletDict[@"id"] success:^{
            
        } failure:^(NSString *message) {
            [self alertErrorMessage:message];
        }];
    }
}

@end
