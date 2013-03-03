//
//  DRCustomPickerViewDataSouce.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRCustomPickerViewDataSouce : NSObject<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSDictionary *dict;

@end
