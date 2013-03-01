//
//  DRDropletService.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRDropletService.h"
#import "DRAPIClient.h"

@implementation DRDropletService

- (void)showAllActiveDroplets:(void(^)(NSArray *array, NSError *error))completion
{
    [[DRAPIClient sharedInstance] getPath:@"droplets/"
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSArray *result = jsonObject[@"droplets"];
                                      NSLog(@"%@", jsonObject);
                                      completion(result, nil);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      completion(nil, error);
                                  }];
}

- (void)showDropletWithID:(NSString *)dropletID
               completion:(void(^)(NSDictionary *dict, NSError *error))completion
{
    [[DRAPIClient sharedInstance] getPath:[@"droplets/" stringByAppendingString:dropletID]
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSDictionary *result = jsonObject[@"droplet"];
                                      NSLog(@"%@", jsonObject);
                                      completion(result, nil);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      completion(nil, error);
                                  }];
}

- (void)destroyDroplet:(NSNumber *)dropletID
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/destroy/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

- (void)powerOnWithID:(NSNumber *)dropletID
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/power_on/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

- (void)shutDownDropletWithID:(NSNumber *)dropletID
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/shutdown/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

- (void)rebootDropletWithID:(NSNumber *)dropletID
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/reboot/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": Client_ID, @"api_key": API_Key}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

@end
