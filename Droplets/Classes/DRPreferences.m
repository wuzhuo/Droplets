//
//  DRPreferences.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DRPreferences.h"

@implementation DRPreferences

+ (BOOL)save
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults synchronize];
}

+ (NSString *)bundleVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"BundleVersion"];
}

+ (void)saveCurrentVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [userDefaults setValue:currentVersion forKey:@"BundleVersion"];
    [self save];
}

+ (NSString *)clientID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"ClientID"];
}

+ (void)setClientID:(NSString *)clientID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:clientID forKey:@"ClientID"];
}

+ (NSString *)APIKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"APIKey"];
}

+ (void)setAPIKey:(NSString *)APIKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:APIKey forKey:@"APIKey"];
}

@end
