//
//  DRModelManager.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface DRModelManager : NSObject

/* Key => size_id, Value => name
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *sizeDict;

/* Key => name, Value => size_id
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *reversedSizeDict;

/* Key => image_id, Value => name
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *imageDict;

/* Key => name, Value => size_id
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *reversedImageDict;

/* Key => region_id, Value => name
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *regionDict;

@property (nonatomic, strong, readonly) NSArray *sortedReversedSizeDictKeys;
@property (nonatomic, strong, readonly) NSArray *sortedReversedImageDictKeys;
@property (nonatomic, strong, readonly) NSArray *sortedRegionDictKeys;

+ (DRModelManager *)sharedInstance;

- (void)processSizeData:(NSArray *)sizeArray;
- (void)processImageData:(NSArray *)imageArray;
- (void)processRegionData:(NSArray *)regionArray;

@end
