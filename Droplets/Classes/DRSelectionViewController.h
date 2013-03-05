//
//  DRSelectionViewController.h
//  Droplets
//
//  Created by Zhuo Wu on 03/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRSelectionViewController;

@protocol DRSelectionViewControllerDelegate <NSObject>
@optional
- (void)saveSizeID:(NSNumber *)sizeID;
- (void)saveImageID:(NSNumber *)imageID;
@end

@interface DRSelectionViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic, strong) NSNumber *dropletID;
@property (nonatomic, strong) NSArray *selectionArray;
@property (nonatomic, copy) NSString *selectedString;

- (IBAction)saveButtonPressed:(id)sender;

@end
