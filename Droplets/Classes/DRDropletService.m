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

+ (DRDropletService *)sharedInstance
{
	static DRDropletService *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRDropletService alloc] init];
        });
    }
    
    return _sharedInstance;
}

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
 * Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -)
 */
- (void)createDropletWithName:(NSString *)name
                       sizeID:(NSNumber *)sizeID
                      imageID:(NSNumber *)imageID
                     regionID:(NSNumber *)regionID
                      success:(void(^)(NSDictionary *dict))success
                      failure:(void(^)(NSString *message))failure
{
    [[DRAPIClient sharedInstance] getPath:@"droplets/new"
                               parameters:@{@"name": name, @"size_id": sizeID, @"image_id": imageID, @"region_id": regionID, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          NSDictionary *dict = jsonObject[@"droplet"];
                                          if (success) success(dict);
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -)");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)rebootDroplet:(NSNumber *)dropletID
              success:(void(^)())success
              failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/reboot/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)powerCycleDroplet:(NSNumber *)dropletID
                  success:(void(^)())success
                  failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/power_cycle/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)shutDownDroplet:(NSNumber *)dropletID
                success:(void(^)())success
                failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/shutdown/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)powerOffDroplet:(NSNumber *)dropletID
                success:(void(^)())success
                failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/power_off/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)powerOnDroplet:(NSNumber *)dropletID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/power_on/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)resetRootPasswordDroplet:(NSNumber *)dropletID
                         success:(void(^)())success
                         failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/password_reset/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)resizeDroplet:(NSNumber *)dropletID
               sizeID:(NSNumber *)sizeID
              success:(void(^)())success
              failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/resize/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"size_id": sizeID, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)takeASnapshotDroplet:(NSNumber *)dropletID
                        name:(NSString *)name
                     success:(void(^)())success
                     failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/snapshot/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"name": name, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)restoreDroplet:(NSNumber *)dropletID
               imageID:(NSNumber *)imageID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/restore/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"image_id": imageID, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)rebuildDroplet:(NSNumber *)dropletID
               imageID:(NSNumber *)imageID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/rebuild/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"image_id": imageID, @"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)enableAutomaticBackups:(NSNumber *)dropletID
                       success:(void(^)())success
                       failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/enable_backups/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)disableAutomaticBackups:(NSNumber *)dropletID
                        success:(void(^)())success
                        failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/disable_backups/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

- (void)destroyDroplet:(NSNumber *)dropletID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure
{
    NSString *url = [NSString stringWithFormat:@"droplets/%@/destroy/", dropletID];
    [[DRAPIClient sharedInstance] getPath:url
                               parameters:@{@"client_id": [DRPreferences clientID], @"api_key": [DRPreferences APIKey]}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                      NSLog(@"%@", jsonObject);
                                      
                                      NSString *status = jsonObject[@"status"];
                                      if ([status isEqualToString:@"OK"]) {
                                          if (success) success();
                                      } else if ([status isEqualToString:@"ERROR"]) {
                                          if (failure) failure(@"Failed!");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error");
                                      if (failure) failure(error.localizedDescription);
                                  }];
}

@end
