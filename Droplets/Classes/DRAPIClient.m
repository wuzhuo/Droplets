//
//  DRAPIClient.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.

#import "DRAPIClient.h"

#define Base_URL @"https://api.digitalocean.com"

@implementation DRAPIClient

+ (DRAPIClient *)sharedInstance
{
	static DRAPIClient *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[DRAPIClient alloc] initWithBaseURL:Base_URL.toURL];
   });
  }

  return _sharedInstance;
}

// Add your custom methods here

@end
