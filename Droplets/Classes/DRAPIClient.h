//
//  DRAPIClient.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface DRAPIClient : AFHTTPClient

+ (DRAPIClient *)sharedInstance;

@end