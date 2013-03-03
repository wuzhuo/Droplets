//
//  DRCreateDropletViewController.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRCustomPickerView.h"

@interface DRCreateDropletViewController : UITableViewController<DRCustomPickerViewDataSource, DRCustomPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *sizeLabel;
@property (nonatomic, strong) IBOutlet UILabel *imageLabel;
@property (nonatomic, strong) IBOutlet UILabel *regionLabel;
@property (nonatomic, strong) DRCustomPickerView *pickerView;

- (IBAction)cancelButtonPressed:(id)sender;

@end
