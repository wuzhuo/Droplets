//
//  DRDropletService.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRDroplet.h"

@interface DRDropletService : NSObject

+ (DRDropletService *)sharedInstance;

- (void)showAllActiveDroplets:(void(^)(NSArray *array, NSError *error))completion;

- (void)showDropletWithID:(NSString *)dropletID
               completion:(void(^)(NSDictionary *dict, NSError *error))completion;

- (void)createDropletWithName:(NSString *)name
                       sizeID:(NSNumber *)sizeID
                      imageID:(NSNumber *)imageID
                     regionID:(NSNumber *)regionID;

- (void)destroyDroplet:(NSNumber *)dropletID;

- (void)powerOnWithID:(NSNumber *)dropletID;
- (void)shutDownDropletWithID:(NSNumber *)dropletID;
- (void)rebootDropletWithID:(NSNumber *)dropletID;

- (void)resetRootPasswordWithID:(int)dropletID;
- (void)resizeDropletWithID:(int)dropletID
                     sizeID:(int)sizeID;
- (void)takeASnapshot;
- (void)restoreDroplet;
- (void)rebuildDroplet;
- (void)enableAutomaticBackups;
- (void)disableAutomaticBackups;


#pragma mark - Not use in current version

- (void)powerOffWithID:(int)dropletID;
- (void)powerCycleDropletWithID:(int)dropletID;

@end
