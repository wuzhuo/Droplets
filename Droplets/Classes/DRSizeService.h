//
//  DRSizeService.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRSizeModel.h"

@interface DRSizeService : NSObject

- (void)requestAllSizes:(void(^)(NSArray *array, NSError *error))completion;

@end
