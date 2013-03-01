//
//  DRDroplet.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRDroplet : NSObject

@property (nonatomic, copy) NSString *backupsActive;
@property (nonatomic) NSInteger dropletID;
@property (nonatomic) NSInteger imageID;
@property (nonatomic, copy) NSString *ipAddress;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger regionID;
@property (nonatomic) NSInteger sizeID;
@property (nonatomic, copy) NSString *status;

@end
