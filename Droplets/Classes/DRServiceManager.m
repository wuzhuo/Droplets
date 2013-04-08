//
//  DRServiceManager.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRServiceManager.h"
#import "AFHTTPClient.h"

@implementation DRServiceManager
{
    AFHTTPClient *_httpClient;
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
    }
    return self;
}

- (void)validateUserSuccess:(void(^)())success
         downloadDataFinish:(void(^)())finish
                    failure:(void(^)(NSString *errorMessage))failure
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        if (failure) failure(@"Client ID & API Key cannot be blank!");
        return;
    }
    
    [self requestAllRegionsSuccess:^{
        if (success) success();
        
        [self requestAllSizesSuccess:^{
            [self requestAllImagesSuccess:^{
                if (finish) finish();
                
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
    NSDictionary *paramDict = @{
                                @"client_id": [DRPreferences clientID],
                                @"api_key": [DRPreferences APIKey]
                                };
    [_httpClient getPath:@"sizes/"
              parameters:paramDict
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"sizes"];
                     
                     if (result) {
                         [DRSize deleteAllObjects];
                         for (NSDictionary *dict in result) {
                             DRSize *size = [DRSize object];
                             [size setValuesForKeysWithDictionary:dict];
                         }
                         [[DRObjectStore sharedInstance] save];
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
              parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey], @"filter": @"global"}
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

- (void)requestAllImagesType:(DRImageType)imageType
                   onSuccess:(void(^)())success
                     failure:(void(^)(NSString *message))failure
{
    NSDictionary *paramDict;
    if (imageType == DRImageTypeGlobal) {
        paramDict = @{
                      @"client_id": [DRPreferences clientID],
                      @"api_key": [DRPreferences APIKey],
                      @"filter": @"global"
                      };
    } else if (imageType == DRImageTypeMy) {
        paramDict = @{
                      @"client_id": [DRPreferences clientID],
                      @"api_key": [DRPreferences APIKey],
                      @"filter": @"my_images"
                      };
    }
    [_httpClient getPath:@"images/"
              parameters:paramDict
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"images"];
                     
                     if (result) {
                         for (NSDictionary *dict in result) {
                             DRImage *image = [DRImage object];
                             [image setValuesForKeysWithDictionary:dict];
                             image.type = @(imageType);
                         }
                         [[DRObjectStore sharedInstance] save];
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
    NSDictionary *paramDict = @{
                                @"client_id": [DRPreferences clientID],
                                @"api_key": [DRPreferences APIKey]
                                };
    [_httpClient getPath:@"regions/"
              parameters:paramDict
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                     NSLog(@"%@", jsonObject);
                     NSArray *result = jsonObject[@"regions"];
                     
                     if (result) {
                         [DRRegion deleteAllObjects];
                         for (NSDictionary *dict in result) {
                             DRRegion *region = [DRRegion object];
                             [region setValuesForKeysWithDictionary:dict];
                         }
                         [[DRObjectStore sharedInstance] save];
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
