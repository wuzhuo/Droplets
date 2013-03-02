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
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
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
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
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

/* This method allows you to create a new droplet.
 * Sample URL: https://api.digitalocean.com/droplets/new?name=[DROPLET_NAME]&size_id=[SIZE_ID]&image_id=[IMAGE_ID]&region_id=[REGION_ID]&client_id=[YOUR_CLIENT_ID]&ssh_key_ids=[SSH_KEY_ID1],[SSH_KEY_ID2]
 */
- (void)newDropletWithName:(NSString *)name
                    sizeID:(NSNumber *)sizeID
                   imageID:(NSNumber *)imageID
                  regionID:(NSNumber *)regionID
{
    [[DRAPIClient sharedInstance] getPath:@"droplets/new"
                               parameters:@{@"name": name, @"size_id": sizeID, @"image_id": imageID, @"region_id": regionID, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSDictionary *result = jsonObject[@"droplet"];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

- (void)destroyDroplet:(NSNumber *)dropletID
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/destroy/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
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
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
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
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
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
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                  }];
}

@end
