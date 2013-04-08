//
//  DRCreateDropletViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRCreateDropletViewController.h"
#import "DRDropletService.h"
#import "MBProgressHUD.h"
#import "DRSelectionViewController.h"

#define Size_Picker_View_Tag 1001
#define Region_Picker_View_Tag 1002

#define Image_Picker_View_Tag 1003

@interface DRCreateDropletViewController ()
@property (nonatomic, strong) NSMutableDictionary *dropletDict;
@end

@implementation DRCreateDropletViewController
{
    NSArray *_sizeArray;
    NSArray *_regionArray;
    NSArray *_imageArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *sizeFetchRequset = [DRSize fetchRequest:[DRSize fetchRequestAll] orderByKey:@"size" ascending:YES];
    _sizeArray = [DRSize objectsWithFetchRequest:sizeFetchRequset];
    
    NSFetchRequest *regionFetchRequset = [DRRegion fetchRequest:[DRRegion fetchRequestAll] orderByKey:@"regionID" ascending:YES];
    _regionArray = [DRRegion objectsWithFetchRequest:regionFetchRequset];
    
    _imageArray = [DRImage allObjects];
    
    [self reloadDropletInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([_dropletDict[@"name"] isEqualToString:@""]) {
        [self alertToInputName];
    }
}

#pragma mark - Accessors

- (NSMutableDictionary *)dropletDict
{
    if (!_dropletDict) {
        _dropletDict = [[NSMutableDictionary alloc] initWithCapacity:4];
        _dropletDict[@"name"] = @"";
        _dropletDict[@"size"] = _sizeArray[0];
        _dropletDict[@"image"] = _imageArray[0];
        _dropletDict[@"region"] = _regionArray[0];
    }
    return _dropletDict;
}

- (DRCustomPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[DRCustomPickerView alloc] init];
        _pickerView.bottom = self.view.frame.size.height;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self.view addSubview:_pickerView];
    }
    
    return _pickerView;
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadDropletInfo
{
    self.nameLabel.text = self.dropletDict[@"name"];
    self.sizeLabel.text = [self.dropletDict[@"size"] name];
    self.imageLabel.text = [self.dropletDict[@"image"] name];
    self.regionLabel.text = [self.dropletDict[@"region"] name];
    [self.tableView reloadData];
}

- (void)alertToInputName
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Input a Hostname"
                                                       delegate:self
                                              cancelButtonTitle:@"cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.delegate = self;
    [alertView show];
}

- (void)createDroplet
{
    if ([_dropletDict[@"name"] isEqualToString:@""]) {
        [self alertToInputName];
        return;
    }
    
    NSNumber *sizeID = [DRModelManager sharedInstance].reversedSizeDict[_dropletDict[@"size"]];
    NSNumber *imageID = [DRModelManager sharedInstance].reversedImageDict[_dropletDict[@"image"]];
    
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [[DRDropletService sharedInstance] createDropletWithName:_dropletDict[@"name"]
                                                      sizeID:sizeID
                                                     imageID:imageID
                                                    regionID:_dropletDict[@"region_id"]
                                                     success:^(NSDictionary *dict) {
                                                         [hud hide:NO];
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     } failure:^(NSString *message) {
                                                         [hud hide:NO];
                                                         [UIAlertView alertErrorMessage:message];
                                                     }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // droplet name
            [self alertToInputName];
        } else {
            if (indexPath.row == 1) {
                self.pickerView.tag = Size_Picker_View_Tag;
            } else if (indexPath.row == 2) {
                self.pickerView.tag = Region_Picker_View_Tag;
            } else if (indexPath.row == 3) {
                DRSelectionViewController *selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DRSelectionViewController"];
                selectionVC.dropletID = _dropletDict[@"id"];
                selectionVC.selectionArray = [DRModelManager sharedInstance].sortedReversedImageDictKeys;
                selectionVC.selectedString = [DRModelManager sharedInstance].imageDict[_dropletDict[@"image_id"]];
                selectionVC.title = @"Images";
                [self.navigationController pushViewController:selectionVC animated:YES];
            }
            self.pickerView.hidden = NO;
            [self.pickerView reloadData];
        }
    } else if (indexPath.section == 1 && indexPath.row == 0) { // create droplet
        [self createDroplet];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - DRCustomPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(DRCustomPickerView *)pickerView
{
    if (pickerView.tag == Size_Picker_View_Tag) {
        return _sizeArray.count;
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        return _regionArray.count;
    }
    return 0;
}

- (NSString *)pickerView:(DRCustomPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView.tag == Size_Picker_View_Tag) {
        DRSize *size = _sizeArray[row];
        return size.name;
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        DRRegion *region = _regionArray[row];
        return region.name;
    }
    return nil;
}

#pragma mark - DRCustomPickerViewDelegate

- (void)pickerView:(DRCustomPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView.tag == Size_Picker_View_Tag) {
        self.dropletDict[@"size"] = _sizeArray[row];
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        self.dropletDict[@"region"] = _regionArray[row];
    }
    [self reloadDropletInfo];
}

- (void)pickerViewDidEndSelecting:(DRCustomPickerView *)pickerView
{
    [self.pickerView removeFromSuperview];
    self.pickerView = nil;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.pickerView.hidden = YES;
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { // OK
        UITextField *textField = [alertView textFieldAtIndex:0];
        _dropletDict[@"name"] = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self reloadDropletInfo];
    }
}

@end
