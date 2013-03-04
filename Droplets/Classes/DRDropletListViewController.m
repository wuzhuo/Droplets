//
//  DRDropletListViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRDropletListViewController.h"
#import "DRDropletService.h"
#import "DRSizeService.h"
#import "DRRegionService.h"
#import "DRDropletDetailViewController.h"
#import "DRLoginViewController.h"
#import "SVPullToRefresh.h"

@interface DRDropletListViewController ()
@property (nonatomic, strong) NSArray *dropletArray;
@property (nonatomic, strong) DRDropletService *dropletService;
@property (nonatomic, strong) DRSizeService *sizeService;
@property (nonatomic, strong) DRRegionService *regionService;
@end

@implementation DRDropletListViewController

- (void)awakeFromNib
{
    _dropletArray = [[NSArray alloc] init];
    _dropletService = [[DRDropletService alloc] init];
    _sizeService = [[DRSizeService alloc] init];
    _regionService = [[DRRegionService alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    __weak DRDropletListViewController *weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf reloadData];
    }];
    [self.tableView triggerPullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dropletArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DropletListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *dict = _dropletArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    if ([dict[@"status"] isEqualToString:@"new"]) { // just created and maybe no ip yet
        cell.detailTextLabel.text = @"Creating...";
    } else {
        cell.detailTextLabel.text = dict[@"ip_address"];
    }
    
    if ([dict[@"status"] isEqualToString:@"active"]) {
        cell.imageView.image = [UIImage imageNamed:@"green_light"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"red_light"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushDropletDetailViewController"]) {
        DRDropletDetailViewController *dropletDetailVC = [segue destinationViewController];
        dropletDetailVC.dropletDict = _dropletArray[self.tableView.indexPathForSelectedRow.row];
    }
}

- (void)reloadData
{
    [_dropletService showAllActiveDropletsSuccess:^(NSArray *array) {
        self.dropletArray = array;
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    } failure:^(NSString *message) {
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}

@end
