//
//  UIAlertView+Custom.m
//  Droplets
//
//  Created by Zhuo Wu on 04/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "UIAlertView+Custom.h"

@implementation UIAlertView (Custom)

+ (UIAlertView *)errorAlertView:(NSString *)errorMessage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    return alertView;
}

+ (void)alertErrorMessage:(NSString *)message
{
    UIAlertView *alertView = [self errorAlertView:message];
    [alertView show];
}

@end
