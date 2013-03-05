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

#define Size_Picker_View_Tag 1001
#define Image_Picker_View_Tag 1002
#define Region_Picker_View_Tag 1003

@interface DRCreateDropletViewController ()
@property (nonatomic, strong) NSMutableDictionary *dropletDict;
@end

@implementation DRCreateDropletViewController

- (void)awakeFromNib
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        _dropletDict[@"size"] = [DRModelManager sharedInstance].sortedReversedSizeDictKeys[0];
        _dropletDict[@"image"] = [DRModelManager sharedInstance].sortedReversedImageDictKeys[0];
        _dropletDict[@"region_id"] = [DRModelManager sharedInstance].sortedRegionDictKeys[0];
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
    self.sizeLabel.text = self.dropletDict[@"size"];
    self.imageLabel.text = self.dropletDict[@"image"];;
    NSDictionary *regionDict = [DRModelManager sharedInstance].regionDict;
    self.regionLabel.text = regionDict[self.dropletDict[@"region_id"]];
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
                self.pickerView.tag = Image_Picker_View_Tag;
            } else if (indexPath.row == 3) {
                self.pickerView.tag = Region_Picker_View_Tag;
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
        return [DRModelManager sharedInstance].sizeDict.count;
    } else if (pickerView.tag == Image_Picker_View_Tag) {
        return [DRModelManager sharedInstance].imageDict.count;
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        return [DRModelManager sharedInstance].regionDict.count;
    }
    return 0;
}

- (NSString *)pickerView:(DRCustomPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView.tag == Size_Picker_View_Tag) {
        return [DRModelManager sharedInstance].sortedReversedSizeDictKeys[row];
    } else if (pickerView.tag == Image_Picker_View_Tag) {
        return [DRModelManager sharedInstance].sortedReversedImageDictKeys[row];
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        NSDictionary *dict = [DRModelManager sharedInstance].regionDict;
        id key = [DRModelManager sharedInstance].sortedRegionDictKeys[row];
        return dict[key];
    }
    return nil;
}

#pragma mark - DRCustomPickerViewDelegate

- (void)pickerView:(DRCustomPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView.tag == Size_Picker_View_Tag) {
        self.dropletDict[@"size"] = [DRModelManager sharedInstance].sortedReversedSizeDictKeys[row];
    } else if (pickerView.tag == Image_Picker_View_Tag) {
        self.dropletDict[@"image"] = [DRModelManager sharedInstance].sortedReversedImageDictKeys[row];
    } else if (pickerView.tag == Region_Picker_View_Tag) {
        self.dropletDict[@"region_id"] = [DRModelManager sharedInstance].sortedRegionDictKeys[row];
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
