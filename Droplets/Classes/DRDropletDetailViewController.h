//
//  DRDropletDetailViewController.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRDropletDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dropletDict;
@property (nonatomic, strong) IBOutlet UILabel *ipAddressLabel;
@property (nonatomic, strong) IBOutlet UILabel *regionLabel;

- (IBAction)bootButtonPressed:(id)sender;
- (IBAction)shutdownButtonPressed:(id)sender;
- (IBAction)rebootButtonPressed:(id)sender;

@end