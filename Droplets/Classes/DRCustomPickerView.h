//
//  DRCustomPickerView.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRCustomPickerView;

@protocol DRCustomPickerViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsInPickerView:(DRCustomPickerView *)pickerView;
- (NSString *)pickerView:(DRCustomPickerView *)pickerView titleForRow:(NSInteger)row;
@end

@protocol DRCustomPickerViewDelegate <NSObject>
@required
- (void)pickerView:(DRCustomPickerView *)pickerView didSelectRow:(NSInteger)row;
- (void)pickerViewDidEndSelecting:(DRCustomPickerView *)pickerView;
@end

@interface DRCustomPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<DRCustomPickerViewDataSource> dataSource;
@property (nonatomic, weak) id<DRCustomPickerViewDelegate> delegate;

- (void)reloadData;

@end
