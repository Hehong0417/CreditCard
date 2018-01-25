//
//  AppDelegate.m
//  CredictCard
//
//  Created by User on 2017/12/11.
//  Copyright © 2017年 User. All rights reserved.
//

#import "AppDelegate.h"
#import "HHWXLoginVC.h"
#import "WXApi.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UserNotifications/UserNotifications.h>
#import "HHBandPhoneVc.h"

#define USHARE_DEMO_APPKEY  @"5a5f10bfa40fa34719000128"
#define JPush_APPKEY  @"dba4f02ef6078ed02ddb2983"

//测试
//#define Wechat_AppKey  @"wx4a20e81b69eba007"
//#define Wechat_appSecret  @"066849ab40a78ddeb49370b9dcc2a4b4"

#define Wechat_AppKey  @"wxa66d50d179264ae7"
#define Wechat_appSecret  @"b877f83478a8b700bbc78041a7a12558"


static NSString *channel = @"App Store" ;
static BOOL isProduction = FALSE;

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    
    
    
    //引导页配置
    [self  guidancePageConfig];
    
    //键盘设置
    [self IQKeyboardManagerConfig];
    
    //配置友盟
    [self UMSocialConfig];
    
    //支付方式配置
    [self payWayConfig];

    [self startMonitor];
    
    
    return YES;
}
- (void)startMonitor{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status == 1 || status == 2)
        {
            NSLog(@"有网");
        }else
        {
            NSLog(@"没有网");
            [SVProgressHUD showInfoWithStatus:@"网络竟然崩溃了～"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    }];
    
}
//极光推送配置
- (void)JPUSHConfigWithOptions:(NSDictionary *)launchOptions{
    
    //极光推送配置
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPush_APPKEY
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if(resCode == 0){
            NSLog(@"registr0ationID获取成功：%@",registrationID);
            
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
}
//初始化window
- (void)setAppearWindow{
    
    HJUser *user0 = [HJUser sharedUser];
    //当前时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    if ((currentTime - user0.expirationTime) >24*60*60) {
        user0.token = @"";
        [user0 write];
    }
    
    HJUser *user = [HJUser sharedUser];
    
    if (user.token.length == 0) {
        
        HHWXLoginVC *vc = [[HHWXLoginVC alloc] initWithNibName:@"HHWXLoginVC" bundle:nil];
        self.window.rootViewController = [[HJNavigationController alloc] initWithRootViewController:vc];
        
    }else{
        //用户是否绑定了手机
        
        [self UserIsBandPhone];
    }
}
- (void)guidancePageConfig {
    
    //**************************************//
    
    NSString *key = @"CFBundleVersion";
    //上一次使用的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //版本号相同直接打开工程
    if ([currentVersion isEqualToString:lastVersion]) {
        
        //初始化window
        [self  setAppearWindow];
        
    }else{
        
        self.window.rootViewController = [[HWNEWfeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //**************************************//
    
}
- (void)UserIsBandPhone{
    
    [[[HHUserLoginAPI postUserIsBrankPhone] netWorkClient] postRequestInView:nil finishedBlock:^(HHUserLoginAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                
                if ([api.data isEqualToNumber:@1]) {
                    HHBandPhoneVc *vc = [HHBandPhoneVc new];
                    vc.titleStr = @"绑定手机";
                    self.window.rootViewController = [[HJNavigationController alloc] initWithRootViewController:vc];
                    
                }else{
                    //绑过
                    self.window.rootViewController = [[HJTabBarController alloc] init];

                }
            }else{
                
                [SVProgressHUD showInfoWithStatus:api.msg];
            }
            
        }else{
            
            self.window.rootViewController = [[HJTabBarController alloc] init];

        }
        
    }];
    
}
- (void)IQKeyboardManagerConfig {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    
}
#pragma mark - 注册微信

- (void)payWayConfig{
    
    //向微信注册
    [WXApi registerApp:Wechat_AppKey];
    
}
#pragma mark - 配置友盟

- (void)UMSocialConfig{
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wechat_AppKey appSecret:Wechat_appSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:Wechat_AppKey appSecret:Wechat_appSecret redirectURL:@"http://mobile.umeng.com/social"];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
        if (!result) {
            
            //其他SDK如支付宝回调
            return [WXApi handleOpenURL:url delegate:self];
        }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if (!result) {
        
        //其他SDK如支付宝回调
        return [WXApi handleOpenURL:url delegate:self];
        
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
    //微信SDK
      return [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}
//支付回调
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response = (PayResp*)resp;
        
        switch(response.errCode){
            case WXSuccess:{
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[NSNotificationCenter defaultCenter]postNotificationName:KWX_Pay_Sucess_Notification object:@""];
                
                NSLog(@"支付成功");
                
            }
                break;
            default:{
                [[NSNotificationCenter defaultCenter]postNotificationName:KWX_Pay_Fail_Notification object:@""];
                
                NSLog(@"支付失败，retcode=%d",resp.errCode);
            }
                break;
        }
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
    [JPUSHService registerDeviceToken:deviceToken];
    
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"FailToRegisterError -- %@",error);
    
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"iOS6及以下系统，收到通知:%@",userInfo);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        //        [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark- JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
        //        userInfo[@"aps"][@"1"]
        //        [rootViewController addNotificationCount];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:KDidReceiveMessageNotification object:userInfo];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}




@end
