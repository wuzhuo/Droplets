//
//  DRModelManager.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRModelManager.h"

@implementation DRModelManager

+ (DRModelManager *)sharedInstance
{
	static DRModelManager *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRModelManager alloc] init];
   });
  }

  return _sharedInstance;
}

- (void)processSizeData:(NSArray *)sizeArray
{
    if (_sizeDict) {
        [_sizeDict removeAllObjects];
    } else {
        _sizeDict = [[NSMutableDictionary alloc] init];
    }
    
    for (NSDictionary *dict in sizeArray) {
        _sizeDict[dict[@"name"]] = dict[@"id"];
    }
    _sortedSizeDictKeys = [_sizeDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 sizeInMB] - [(NSString *)obj2 sizeInMB];
    }];
}

- (void)processImageData:(NSArray *)imageArray
{
    if (_imageDict) {
        [_imageDict removeAllObjects];
    } else {
        _imageDict = [[NSMutableDictionary alloc] init];
    }
    
    for (NSDictionary *dict in imageArray) {
        _imageDict[dict[@"id"]] = dict[@"name"];
    }
    _sortedImageDictKeys = [_imageDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 intValue] - [obj2 intValue];
    }];
}

- (void)processRegionData:(NSArray *)regionArray
{
    if (_regionDict) {
        [_regionDict removeAllObjects];
    } else {
        _regionDict = [[NSMutableDictionary alloc] init];
    }
    
    for (NSDictionary *dict in regionArray) {
        _regionDict[dict[@"id"]] = dict[@"name"];
    }
    _sortedRegionDictKeys = [_regionDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 intValue] - [obj2 intValue];
    }];
}

@end
