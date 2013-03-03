//
//  NSString+Extend.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (NSURL *)toURL;

/* This is used to convert the size(512MB, 1GB, 2GB, etc.) of memory into MB.
 */
- (NSInteger)sizeInMB;

@end
