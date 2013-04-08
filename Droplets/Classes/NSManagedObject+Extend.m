//
//  NSManagedObject+Extend.m
//  Droplets
//
//  Created by Zhuo Wu on 27/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "NSManagedObject+Extend.h"
#import "DRObjectStore.h"

@implementation NSManagedObject (Extend)

+ (NSEntityDescription *)entity
{
	return [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:[self managedObjectContext]];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    return [DRObjectStore sharedInstance].managedObjectContext;
}

+ (NSFetchRequest *)fetchRequest
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[self entity]];
	return fetchRequest;
}

#pragma mark - Basic Result

+ (id)object
{
	id object = [[self alloc] initWithEntity:[self entity] insertIntoManagedObjectContext:[self managedObjectContext]];
	return object;
}

+ (id)objectWithPrimaryKey:(id)value
{
    NSAssert([self primaryKey], @"请设置主键");
    
    NSFetchRequest *request = [self fetchRequestAllWhere:[self primaryKey] isEqualTo:value];
	return [self objectWithFetchRequest:request];
}

+ (id)objectWithPrimaryKey:(NSString *)primaryKey isEqualTo:(id)value
{
    NSFetchRequest *request = [self fetchRequestAllWhere:primaryKey isEqualTo:value];
	return [self objectWithFetchRequest:request];
}

+ (id)allObjects
{
    return [self objectsWithPredicate:nil];
}

+ (NSUInteger)count
{
	NSError *error;
	NSFetchRequest *fetchRequest = [self fetchRequest];
	return [[self managedObjectContext] countForFetchRequest:fetchRequest error:&error];
}

+ (void)deleteAllObjects
{
    NSArray *allObjects = [self allObjects];
    for (NSManagedObject *object in allObjects) {
        [[self managedObjectContext] deleteObject:object];
    }
    if (allObjects.count > 0) {
        [[self managedObjectContext] save:nil];
    }
}

#pragma mark - Conditional Result

+ (NSArray *)objectsWithFetchRequest:(NSFetchRequest *)fetchRequest
{
	NSError *error;
	return [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
}

+ (id)objectWithFetchRequest:(NSFetchRequest *)fetchRequest
{
	[fetchRequest setFetchLimit:1];
	NSArray *objects = [self objectsWithFetchRequest:fetchRequest];
	if ([objects count] == 0) {
		return nil;
	} else {
		return [objects objectAtIndex:0];
	}
}

+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *fetchRequest = [self fetchRequest];
	[fetchRequest setPredicate:predicate];
	return [self objectsWithFetchRequest:fetchRequest];
}

+ (id)objectWithPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *fetchRequest = [self fetchRequest];
	[fetchRequest setPredicate:predicate];
	return [self objectWithFetchRequest:fetchRequest];
}

+ (NSInteger)numberOfObjectsWithPredicate:(NSPredicate *)predicate
{
    NSError *error;
	NSFetchRequest *fetchRequest = [self fetchRequest];
	[fetchRequest setPredicate:predicate];
	return [[self managedObjectContext] countForFetchRequest:fetchRequest error:&error];
}

#pragma mark - Fetch Helper

+ (NSFetchRequest *)fetchRequestAll
{
	return [self fetchRequest];
}

+ (NSFetchRequest *)fetchRequestAllWhere:(NSString *)property isEqualTo:(id)value
{
    NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", property, value]];
    
    return request;
}

+ (NSFetchRequest *)fetchRequestAllWhere:(NSString *)property inArray:(NSArray *)array
{
    NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%@ IN %@", property, array]];
    
    return request;
}

+ (NSFetchRequest *)fetchRequest:(NSFetchRequest *)request orderByKey:(NSString *)key ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return request;
}

+ (NSFetchRequest *)fetchRequestMaxValueFor:(NSString *)property
{
	NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(SELF = %@) AND (%K = max(%@))", self, property, property]];
    
    return request;
}

+ (NSFetchRequest *)fetchRequestMinValueFor:(NSString *)property
{
	NSFetchRequest *request = [self fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(SELF = %@) AND (%K = min(%@))", self, property, property]];
    
    return request;
}

@end
