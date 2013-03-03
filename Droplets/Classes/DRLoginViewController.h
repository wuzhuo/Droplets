//
//  DRLoginViewController.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRLoginViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *clientIDTextField;
@property (nonatomic, strong) IBOutlet UITextField *apiKeyTextField;

@end
