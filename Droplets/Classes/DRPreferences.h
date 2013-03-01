//
//  DRPreferences.h
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/* operation on Library/Preferences/bundle_indentifier.plist
 */
@interface DRPreferences : NSObject

+ (BOOL)save;

+ (NSString *)bundleVersion;
+ (void)saveCurrentVersion;

+ (NSString *)clientID;
+ (void)setClientID:(NSString *)clientID;

+ (NSString *)APIKey;
+ (void)setAPIKey:(NSString *)APIKey;

@end
