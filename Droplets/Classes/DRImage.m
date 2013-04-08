//
//  DRImage.m
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRImage.h"


@implementation DRImage

@dynamic imageID;
@dynamic name;
@dynamic distribution;
@dynamic type;

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    if (keyedValues[@"id"]) {
        self.imageID = keyedValues[@"id"];
    }
    if (keyedValues[@"name"]) {
        self.name = keyedValues[@"name"];
    }
    if (keyedValues[@"distribution"]) {
        self.distribution = keyedValues[@"distribution"];
    }
}


@end
