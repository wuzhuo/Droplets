//
//  UIView+Frame.h
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)top;
- (void)setTop:(CGFloat)t;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)b;

- (CGFloat)left;
- (void)setLeft:(CGFloat)l;

- (CGFloat)right;
- (void)setRight:(CGFloat)r;

- (CGFloat)width;
- (void)setWidth:(CGFloat)w;

- (CGFloat)height;
- (void)setHeight:(CGFloat)h;

@end
