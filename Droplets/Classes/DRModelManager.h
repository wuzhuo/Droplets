//
//  DRModelManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface DRModelManager : NSObject

/* Key => name, Value => size_id
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *sizeDict;

/* Key => image_id, Value => name
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *imageDict;

/* Key => region_id, Value => name
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *regionDict;

@property (nonatomic, strong, readonly) NSArray *sortedSizeDictKeys;
@property (nonatomic, strong, readonly) NSArray *sortedImageDictKeys;
@property (nonatomic, strong, readonly) NSArray *sortedRegionDictKeys;

+ (DRModelManager *)sharedInstance;

- (void)processSizeData:(NSArray *)sizeArray;
- (void)processImageData:(NSArray *)imageArray;
- (void)processRegionData:(NSArray *)regionArray;

@end
