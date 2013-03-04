//
//  DRServiceManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface DRServiceManager : NSObject

+ (DRServiceManager *)sharedInstance;

/* Check if the client id and api key are valid.
 * It will try to download essential data such as droplet sizes, region, images, etc.
 */
- (void)validateUserAndDownloadEssentialDataSuccess:(void(^)())success
                                            failure:(void(^)(NSString *errorMessage))failure;

@end
