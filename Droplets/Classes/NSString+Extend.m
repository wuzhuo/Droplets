//
//  NSString+Extend.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (NSURL *)toURL
{
    return [NSURL URLWithString:self];
}

@end
