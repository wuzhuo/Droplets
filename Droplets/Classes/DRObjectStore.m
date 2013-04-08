//
//  DRObjectStore.m
//  Droplets
//
//  Created by Zhuo Wu on 28/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRObjectStore.h"

@implementation DRObjectStore
{
    NSString *_databaseName;
    NSString *_momdName;
}

+ (DRObjectStore *)sharedInstance
{
	static DRObjectStore *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
            NSString *bundleVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
            NSString *databaseName = [NSString stringWithFormat:@"Droplets%@.sqlite", bundleVersion];
            NSString *momdName = @"MainDataModel";
			_sharedInstance = [[DRObjectStore alloc] initWithDatabase:databaseName momd:momdName];
   });
  }

  return _sharedInstance;
}

- (id)initWithDatabase:(NSString *)databaseName momd:(NSString *)momdName
{
    self = [super init];
    if (self) {
        _databaseName = databaseName;
        _momdName = momdName;
        
        [self managedObjectContext];
    }
    return self;
}

- (void)save
{
    NSError *error;
    // 如果CoreData未做任何操作就直接save，会抛出异常
    if (_persistentStoreCoordinator.persistentStores.count > 0) {
        [[self managedObjectContext] save:&error];
    }
}

#pragma mark - Override Accessors

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *momdURL = [[NSBundle mainBundle] URLForResource:_momdName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath:[[NSFileManager applicationDocumentsDirectory] stringByAppendingPathComponent:_databaseName]];
    
    NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{
        NSMigratePersistentStoresAutomaticallyOption : @YES,
        NSInferMappingModelAutomaticallyOption : @YES
    };

#warning DELETE
//    [NSDictionary dictionaryWithObjectsAndKeys:
//                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeUrl
                                                         options:options
                                                           error:&error]) {
        // Handle the error.
        NSLog(@"%@", error.localizedDescription);
    }
    
    return _persistentStoreCoordinator;
}

@end
