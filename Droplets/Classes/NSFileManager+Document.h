//
//  NSFileManager+Document.h
//  Droplets
//
//  Created by Zhuo Wu on 28/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Document)

+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationCachesDirectory;

/* Return the size of folder in MB.
 */
+ (float)folderSize:(NSString *)path;

/* delete all item in this folder but not delete the fold itself
 */
+ (void)emptyFolder:(NSString *)path;

@end
