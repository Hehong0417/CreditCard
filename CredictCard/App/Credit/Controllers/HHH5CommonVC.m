//
//  HHH5CommonVC.m
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHH5CommonVC.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"


@interface HHH5CommonVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIWebView *_webView;

    
}
@end

@implementation HHH5CommonVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.titleStr;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];

    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _webView.scalesPageToFit = YES;;
    [self.view addSubview:_webView];
    
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURL *url = [NSURL URLWithString:self.commonUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}
@end
