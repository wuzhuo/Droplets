//
//  DRSizeService.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRSizeService.h"
#import "DRAPIClient.h"

@implementation DRSizeService

- (void)requestAllSizes:(void(^)(NSArray *array, NSError *error))completion
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        return;
    }
    [[DRAPIClient sharedInstance] getPath:@"sizes/"
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      NSArray *result = jsonObject[@"sizes"];
                                      
                                      if (result) {
                                          [[DRModelManager sharedInstance] processSizeData:result];
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
