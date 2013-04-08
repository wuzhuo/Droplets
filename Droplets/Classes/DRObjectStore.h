//
//  DRObjectStore.h
//  Droplets
//
//  Created by Zhuo Wu on 28/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DRObjectStore : NSObject

+ (DRObjectStore *)sharedInstance;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (id)initWithDatabase:(NSString *)databaseName momd:(NSString *)momdName;
- (void)save;

@end
