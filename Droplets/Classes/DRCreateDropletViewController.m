//
//  DRCreateDropletViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRCreateDropletViewController.h"

@interface DRCreateDropletViewController ()
@property (nonatomic, strong) NSMutableDictionary *dropletDict;
@end

@implementation DRCreateDropletViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    pickerView.dataSource = self;
    self.sizeTextField.inputAccessoryView = pickerView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (NSMutableDictionary *)dropletDict
{
    if (!_dropletDict) {
        _dropletDict = [[NSMutableDictionary alloc] initWithCapacity:4];
        _dropletDict[@"size_id"] = @33;
        _dropletDict[@"region_id"] = @1;
        _dropletDict[@"image_id"] = @444;
    }
    return _dropletDict;
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // droplet name
            
        }
    } else if (indexPath.section == 1 && indexPath.row == 0) { // create droplet
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
