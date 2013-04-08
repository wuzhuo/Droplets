//
//  NSFileManager+Document.m
//  Droplets
//
//  Created by Zhuo Wu on 28/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "NSFileManager+Document.h"

@implementation NSFileManager (Document)

+ (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)applicationCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (float)folderSize:(NSString *)path
{
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize / (1024 * 1024);
}

+ (void)emptyFolder:(NSString *)path
{
    NSArray *filenameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filename in filenameArray) {
        NSString *filePath = [path stringByAppendingPathComponent:filename];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

@end
