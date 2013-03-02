//
//  DRServiceManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "DRSizeService.h"
#import "DRRegionService.h"
#import "DRImageService.h"

@interface DRServiceManager : NSObject

+ (DRServiceManager *)sharedInstance;

/* Check if the client id and api key are valid.
 * It will try to download essential data such as droplet sizes, region, images, etc.
 * The downloading is async and a boolean result returns after finishing downloading.
 */
- (BOOL)validateUserAndDownloadEssentialData;

@end
