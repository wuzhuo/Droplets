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
    
    if (!_hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    } else {
        [self.hud show:YES];
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hide:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.hud hide:NO];
}

- (IBAction)copyButtonPressed:(id)sender
{
    if ([self parseHTML]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)parseHTML
{
    NSString *clientJS = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"js/client_id" withExtension:@"js"]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSString *clientID = [self.webView stringByEvaluatingJavaScriptFromString:clientJS];
    
    NSString *keyJS = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"js/api_key" withExtension:@"js"]
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    NSString *apiKey = [self.webView stringByEvaluatingJavaScriptFromString:keyJS];
    
    NSLog(@"clientID: %@", clientID);
    NSLog(@"apiKey: %@", apiKey);
    
    if (clientID && apiKey) {
        [DRPreferences setClientID:clientID];
        [DRPreferences setAPIKey:apiKey];
        [DRPreferences save];
        return YES;
    }
    return NO;
}

@end
