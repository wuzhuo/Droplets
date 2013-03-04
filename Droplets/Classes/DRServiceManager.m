//
//  DRServiceManager.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRServiceManager.h"

#define Base_URL @"https://api.digitalocean.com"

@implementation DRServiceManager
{
    AFHTTPClient *_httpClient;
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
        _httpClient = [[AFHTTPClient alloc] initWithBaseURL:Base_URL.toURL];
        _sizeService = [[DRSizeService alloc] init];
        _regionService = [[DRRegionService alloc] init];
        _imageService = [[DRImageService alloc] init];
    }
    return self;
}

- (void)validateUserAndDownloadEssentialDataSuccess:(void(^)())success
                                            failure:(void(^)(NSString *errorMessage))failure
{
#warning TODO
    success();
    return;
    
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        if (failure) failure(@"Client ID & API Key cannot be blank!");
        return;
    }
    
    [self requestAllSizesSuccess:^{
        [self requestAllImagesSuccess:^{
            [self requestAllRegionsSuccess:^{
                // Check the client id and api key in preferences plist. Both will be nil if those are invalid.
                if ([DRPreferences clientID] && [DRPreferences APIKey]) {
                    if (success) success();
                }
                
            } failure:^(NSString *message) {
                if (failure) failure(message);
            }];
        } failure:^(NSString *message) {
            if (failure) failure(message);
        }];
    } failure:^(NSString *message) {
        if (failure) failure(message);
    }];
    
}

- (void)requestAllSizesSuccess:(void(^)())success
                       failure:(void(^)(NSString *message))failure
{
    [_httpClient getPath:@"sizes/"
              parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"sizes"];
                     
                     if (result) {
                         [[DRModelManager sharedInstance] processSizeData:result];
                         if (success) success();
                     } else {
                         [DRPreferences resetLoginKey];
                         if (failure) failure(@"Invaild User!");
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"error");
                     if (failure) failure(error.localizedDescription);
                 }];
}

- (void)requestAllImagesSuccess:(void(^)())success
                        failure:(void(^)(NSString *message))failure
{
    [_httpClient getPath:@"images/"
              parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"images"];
                     
                     if (result) {
                         [[DRModelManager sharedInstance] processImageData:result];
                         if (success) success();
                     } else {
                         [DRPreferences resetLoginKey];
                         if (failure) failure(@"Invaild User!");
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"error");
                     if (failure) failure(error.localizedDescription);
                 }];
}

- (void)requestAllRegionsSuccess:(void(^)())success
                         failure:(void(^)(NSString *message))failure
{
    [_httpClient getPath:@"regions/"
              parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"regions"];
                     
                     if (result) {
                         [[DRModelManager sharedInstance] processRegionData:result];
                         if (success) success();
                     } else {
                         [DRPreferences resetLoginKey];
                         if (failure) failure(@"Invaild User!");
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"error");
                     if (failure) failure(error.localizedDescription);
                 }];
}

@end
