//
//  DRSize.h
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DRSize : NSManagedObject

@property (nonatomic, retain) NSNumber * sizeID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * size;

@end
