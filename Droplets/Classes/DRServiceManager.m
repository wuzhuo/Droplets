//
//  DRServiceManager.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRServiceManager.h"

//#define Base_URL @"https://api.digitalocean.com"

@implementation DRServiceManager
{
//    AFHTTPClient *_httpClient;
    DRSizeService *_sizeService;
    DRRegionService *_regionService;
    DRImageService *_imageService;
}

+ (DRServiceManager *)sharedInstance
{
	static DRServiceManager *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRServiceManager alloc] init];
        });
    }
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
//        _httpClient = [[AFHTTPClient alloc] initWithBaseURL:Base_URL.toURL];
        _sizeService = [[DRSizeService alloc] init];
        _regionService = [[DRRegionService alloc] init];
        _imageService = [[DRImageService alloc] init];
    }
    return self;
}

- (BOOL)validateUserAndDownloadEssentialData
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        return NO;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [_sizeService requestAllSizes:nil];
        [_imageService requestAllImages:nil];
        [_regionService requestAllRegions:nil];
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_release(group);
    
    // Check the client id and api key in preferences plist. Both will be nil if those are invalid.
    if ([DRPreferences clientID] && [DRPreferences APIKey]) {
        return YES;
    }
    return NO;
}

@end
