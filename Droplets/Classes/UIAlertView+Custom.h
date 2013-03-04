//
//  UIAlertView+Custom.h
//  Droplets
//
//  Created by Zhuo Wu on 04/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Custom)

+ (UIAlertView *)errorAlertView:(NSString *)errorMessage;
+ (void)alertErrorMessage:(NSString *)message;

@end
