//
//  UIView+Frame.m
//  Droplets
//
//  Created by Zhuo Wu on 02/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)top
{
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)t
{
	self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)b
{
	self.frame = CGRectMake(self.left, b-self.height, self.width, self.height);
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)l
{
	self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)r
{
	self.frame = CGRectMake(r-self.width, self.top, self.width, self.height);
}

- (CGFloat)width
{
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)w
{
	self.frame = CGRectMake(self.left, self.top, w, self.height);
}

- (CGFloat)height
{
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)h
{
	self.frame = CGRectMake(self.left, self.top, self.width, h);
}

@end
