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

@interface DRDropletDetailViewController ()
@property (nonatomic, strong) DRDropletService *dropletService;
@end

@implementation DRDropletDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.ipAddressLabel.text = _dropletDict[@"ip_address"];
    NSNumber *regionID = _dropletDict[@"region_id"];
    self.regionLabel.text = [DRRegionModel sharedInstance].regionDict[regionID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = _dropletDict[@"name"];
}

#pragma mark - Accessors

- (DRDropletService *)dropletService
{
    if (_dropletService) {
        return _dropletService;
    }
    
    _dropletService = [[DRDropletService alloc] init];
    return _dropletService;
}

#pragma mark - Actions

- (IBAction)bootButtonPressed:(id)sender
{
    [self.dropletService powerOnWithID:_dropletDict[@"id"]];
}

- (IBAction)shutdownButtonPressed:(id)sender
{
    [self.dropletService shutDownDropletWithID:_dropletDict[@"id"]];
}

- (IBAction)rebootButtonPressed:(id)sender
{
    [self.dropletService rebootDropletWithID:_dropletDict[@"id"]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"aaa";
    }
    return @"aaa";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OperationLisCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //
            
        }
    }
    
    cell.textLabel.text = @"aaa";
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
