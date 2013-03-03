//
//  DRSelectionViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 03/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRSelectionViewController.h"

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
    if ([self.title isEqualToString:@"Size"]) {
        
    } else if ([self.title isEqualToString:@"Image"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This will rebuild your droplet using the original image you specified when you deployed. Please be advised that all data will be lost." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Rebuild", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end
