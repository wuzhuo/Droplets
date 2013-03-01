//
//  DRSizeModel.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRSizeModel.h"

@implementation DRSizeModel

+ (DRSizeModel *)sharedInstance
{
	static DRSizeModel *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRSizeModel alloc] init];
        });
    }
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _sizeDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)processSizeData:(NSArray *)sizeArray
{
    [_sizeDict removeAllObjects];
    for (NSDictionary *dict in sizeArray) {
        _sizeDict[dict[@"id"]] = dict[@"name"];
    }
}

@end
