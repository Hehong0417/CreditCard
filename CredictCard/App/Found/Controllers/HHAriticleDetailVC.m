//
//  HHAriticleDetailVC.m
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAriticleDetailVC.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface HHAriticleDetailVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIWebView *_webView;
    
}

@end

@implementation HHAriticleDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //文章详情
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
    
    
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - 60, 20, 60, 44) target:self action:@selector(shareAction) image:[UIImage imageNamed:@"find_icon_share_default"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
  
}
- (void)shareAction{
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareVedioToPlatformType:platformType];
        
    }];
    
    
}
//分享到不同平台
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //        NSURL *url = [NSURL URLWithString:kAPITalent_videoImageFromUrl(model.videos_picture)];
    
    
    //创建Webpage内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.titleStr descr:@"" thumImage:self.imageUrl];
    
    //设置Webpage地址
    shareObject.webpageUrl = self.commonUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            
        }
    }];
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
