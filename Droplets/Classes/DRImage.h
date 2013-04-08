//
//  DRImage.h
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, DRImageType) {
    DRImageTypeGlobal = 1,
    DRImageTypeMy = 2
};

@interface DRImage : NSManagedObject

@property (nonatomic, retain) NSNumber * imageID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * distribution;
@property (nonatomic, retain) NSNumber * type;

@end
