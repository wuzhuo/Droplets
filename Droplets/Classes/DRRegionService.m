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
    [[DRAPIClient sharedInstance] getPath:@"regions/"
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSArray *result = jsonObject[@"regions"];
                                      [[DRRegionModel sharedInstance] processRegionData:result];
                                      NSLog(@"%@", jsonObject);
                                      if (completion) completion(result, nil);
     
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (completion) completion(nil, error);
                                  }];
}

@end
