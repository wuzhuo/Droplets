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

- (NSInteger)sizeInMB
{
    if ([self hasSuffix:@"MB"]) {
        NSString *size = [self stringByReplacingOccurrencesOfString:@"MB" withString:@""];
        return [size intValue];
    } else if ([self hasSuffix:@"GB"]) {
        NSString *size = [self stringByReplacingOccurrencesOfString:@"GB" withString:@""];
        return [size intValue]*1024;
    }
    return 0;
}

@end
