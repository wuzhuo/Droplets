//
//  DRSize.m
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRSize.h"


@implementation DRSize

@dynamic sizeID;
@dynamic name;
@dynamic size;

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    if (keyedValues[@"id"]) {
        self.sizeID = keyedValues[@"id"];
    }
    if (keyedValues[@"name"]) {
        self.name = keyedValues[@"name"];
        self.size = @([self.name sizeInMB]);
    }
}

@end
