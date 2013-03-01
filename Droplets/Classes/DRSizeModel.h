//
//  DRSizeModel.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface DRSizeModel : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *sizeDict;

+ (DRSizeModel *)sharedInstance;

- (void)processSizeData:(NSArray *)sizeArray;

@end
