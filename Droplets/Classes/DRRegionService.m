//
//  DRRegionService.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRRegionService.h"
#import "DRAPIClient.h"

@implementation DRRegionService

- (void)requestAllRegions:(void(^)(NSArray *array, NSError *error))completion
{
    if (![DRPreferences clientID] || ![DRPreferences APIKey]) {
        return;
    }
    
    [[DRAPIClient sharedInstance] getPath:@"regions/"
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      NSArray *result = jsonObject[@"regions"];
                                      
                                      if (result) {
                                          [[DRModelManager sharedInstance] processRegionData:result];
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
