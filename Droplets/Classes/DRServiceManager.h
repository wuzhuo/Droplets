//
//  DRServiceManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>
#import "DRObjectStore.h"
#import "DRImage.h"
#import "DRRegion.h"
#import "DRSize.h"

@interface DRServiceManager : NSObject

+ (DRServiceManager *)sharedInstance;

/* Check if the client id and api key are valid.
 * It will try to download essential data such as droplet sizes, region, images, etc.
 */
- (void)validateUserSuccess:(void(^)())success
         downloadDataFinish:(void(^)())finish
                    failure:(void(^)(NSString *errorMessage))failure;

- (void)requestAllSizesSuccess:(void(^)())success
                       failure:(void(^)(NSString *message))failure;

- (void)requestAllImagesSuccess:(void(^)())success
                        failure:(void(^)(NSString *message))failure;

- (void)requestAllImagesType:(DRImageType)imageType
                   onSuccess:(void(^)())success
                     failure:(void(^)(NSString *message))failure;

- (void)requestAllRegionsSuccess:(void(^)())success
                         failure:(void(^)(NSString *message))failure;

@end
