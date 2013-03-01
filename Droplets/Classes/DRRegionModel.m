//
//  DRRegionModel.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRRegionModel.h"

@implementation DRRegionModel

+ (DRRegionModel *)sharedInstance
{
	static DRRegionModel *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRRegionModel alloc] init];
        });
    }
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _regionDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)processRegionData:(NSArray *)regionArray
{
    [_regionDict removeAllObjects];
    for (NSDictionary *dict in regionArray) {
        _regionDict[dict[@"id"]] = dict[@"name"];
    }
}

@end
