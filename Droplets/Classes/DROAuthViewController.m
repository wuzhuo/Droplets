//
//  DROAuthViewController.m
//  Droplets
//
//  Created by Zhuo Wu on 01/03/2013.
//  Copyright (c) 2013 zhuoapps.com. All rights reserved.
//

#import "DROAuthViewController.h"

#define Login_URL @"https://www.digitalocean.com/login"
#define Generate_API_Key_URL @"https://www.digitalocean.com/generate_api_key"

@interface DROAuthViewController ()

@end

@implementation DROAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:Login_URL.toURL];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL.absoluteString);
    if ([request.URL.absoluteString hasSuffix:@"/droplets"]) { // login success
        [webView loadRequest:[NSURLRequest requestWithURL:Generate_API_Key_URL.toURL]];
        return NO;
    }
    return YES;
}

@end
