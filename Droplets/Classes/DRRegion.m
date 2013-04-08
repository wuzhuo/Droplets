//
//  DRRegion.m
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRRegion.h"


@implementation DRRegion

@dynamic regionID;
@dynamic name;

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    if (keyedValues[@"id"]) {
        self.regionID = keyedValues[@"id"];
    }
    if (keyedValues[@"name"]) {
        self.name = keyedValues[@"name"];
    }
}

@end
