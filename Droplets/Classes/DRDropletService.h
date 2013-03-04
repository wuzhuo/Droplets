//
//  DRDropletService.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRDropletService : NSObject

+ (DRDropletService *)sharedInstance;

- (void)showAllActiveDropletsSuccess:(void(^)(NSArray *array))success
                             failure:(void(^)(NSString *message))failure;

- (void)showDropletWithID:(NSString *)dropletID
                  success:(void(^)(NSDictionary *dict))success
                  failure:(void(^)(NSString *message))failure;

- (void)createDropletWithName:(NSString *)name
                       sizeID:(NSNumber *)sizeID
                      imageID:(NSNumber *)imageID
                     regionID:(NSNumber *)regionID
                      success:(void(^)(NSDictionary *dict))success
                      failure:(void(^)(NSString *message))failure;

- (void)rebootDroplet:(NSNumber *)dropletID
              success:(void(^)())success
              failure:(void(^)(NSString *message))failure;

- (void)powerCycleDroplet:(NSNumber *)dropletID
                  success:(void(^)())success
                  failure:(void(^)(NSString *message))failure;

- (void)shutDownDroplet:(NSNumber *)dropletID
                success:(void(^)())success
                failure:(void(^)(NSString *message))failure;

- (void)powerOffDroplet:(NSNumber *)dropletID
                success:(void(^)())success
                failure:(void(^)(NSString *message))failure;

- (void)powerOnDroplet:(NSNumber *)dropletID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure;

- (void)resetRootPasswordDroplet:(NSNumber *)dropletID
                         success:(void(^)())success
                         failure:(void(^)(NSString *message))failure;

- (void)resizeDroplet:(NSNumber *)dropletID
               sizeID:(NSNumber *)sizeID
              success:(void(^)())success
              failure:(void(^)(NSString *message))failure;

- (void)takeASnapshotDroplet:(NSNumber *)dropletID
                        name:(NSString *)name
                     success:(void(^)())success
                     failure:(void(^)(NSString *message))failure;

- (void)restoreDroplet:(NSNumber *)dropletID
               imageID:(NSNumber *)imageID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure;

- (void)rebuildDroplet:(NSNumber *)dropletID
               imageID:(NSNumber *)imageID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure;

- (void)enableAutomaticBackups:(NSNumber *)dropletID
                       success:(void(^)())success
                       failure:(void(^)(NSString *message))failure;

- (void)disableAutomaticBackups:(NSNumber *)dropletID
                        success:(void(^)())success
                        failure:(void(^)(NSString *message))failure;

- (void)destroyDroplet:(NSNumber *)dropletID
               success:(void(^)())success
               failure:(void(^)(NSString *message))failure;

@end
