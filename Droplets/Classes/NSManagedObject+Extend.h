//
//  NSManagedObject+Extend.h
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (Extend)

+ (NSManagedObjectContext *)managedObjectContext;
+ (NSEntityDescription *)entity;
+ (NSFetchRequest *)fetchRequest;

+ (id)object;
+ (id)objectWithPrimaryKey:(id)value;
+ (id)objectWithPrimaryKey:(NSString *)value isEqualTo:(id)value;
+ (id)allObjects;
+ (NSUInteger)count;
+ (void)deleteAllObjects;

+ (NSArray *)objectsWithFetchRequest:(NSFetchRequest *)fetchRequest;
+ (id)objectWithFetchRequest:(NSFetchRequest *)fetchRequest;
+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate;
+ (id)objectWithPredicate:(NSPredicate *)predicate;
+ (NSInteger)numberOfObjectsWithPredicate:(NSPredicate *)predicate;

+ (NSFetchRequest *)fetchRequestAll;
+ (NSFetchRequest *)fetchRequestAllWhere:(NSString *)property isEqualTo:(id)value;
+ (NSFetchRequest *)fetchRequestAllWhere:(NSString *)property inArray:(NSArray *)array;
+ (NSFetchRequest *)fetchRequest:(NSFetchRequest *)request orderByKey:(NSString *)key ascending:(BOOL)ascending;
+ (NSFetchRequest *)fetchRequestMaxValueFor:(NSString *)property;
+ (NSFetchRequest *)fetchRequestMinValueFor:(NSString *)property;

+ (NSString *)primaryKey;
- (NSDictionary *)elementToPropertyMappings;
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues;

@end
