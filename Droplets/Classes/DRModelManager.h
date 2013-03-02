//
//  DRModelManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface DRModelManager : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *sizeDict;
@property (nonatomic, strong, readonly) NSMutableDictionary *regionDict;
@property (nonatomic, strong, readonly) NSMutableDictionary *imageDict;

+ (DRModelManager *)sharedInstance;

- (void)processSizeData:(NSArray *)sizeArray;
- (void)processRegionData:(NSArray *)regionArray;

@end
