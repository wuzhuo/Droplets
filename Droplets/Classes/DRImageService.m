//
//  DRImageService.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRImageService.h"
#import "DRAPIClient.h"

@implementation DRImageService

- (void)requestAllImages:(void(^)(NSArray *array, NSError *error))completion
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        return;
    }
    
    [[DRAPIClient sharedInstance] getPath:@"images/"
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      NSArray *result = jsonObject[@"images"];
                                      
                                      if (result) {
                                          [[DRModelManager sharedInstance] processImageData:result];
                                      } else {
                                          [DRPreferences resetLoginKey];
                                      }
                                      
                                      if (completion) completion(result, nil);
                                      
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (completion) completion(nil, error);
                                  }];
}

@end
