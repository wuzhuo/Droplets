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
        _sizeDict[dict[@"id"]] = dict[@"name"];
    }
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
}

@end
