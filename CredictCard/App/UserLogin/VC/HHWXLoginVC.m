//
//  HHWXLoginVC.m
//  CredictCard
//
//  Created by User on 2017/12/21.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHWXLoginVC.h"
#import "HHBandPhoneVc.h"
#import "WXApi.h"
#import <UMSocialCore/UMSocialCore.h>

@interface HHWXLoginVC ()

@end

@implementation HHWXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = RGB(120, 159, 243);
    
    self.title = @"微信登录";
    
    self.wxLoginView.userInteractionEnabled = YES;
    [self.wxLoginView setTapActionWithBlock:^{
        
         if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]){
          //已安装微信
             [self getAuthWithUserInfoFromWechat];

        }else{
          //未安装微信
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您未安装微信，是否安装？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {


            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[KWX_APPStore_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

            }];

            [alertC addAction:action1];
            [alertC addAction:action2];
            [self presentViewController:alertC animated:YES completion:nil];
        }

        
    }];
    
}
- (void)getAuthWithUserInfoFromWechat
{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
            NSLog(@"error--error--%@",error);
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat unionId: %@", resp.unionId);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            //判断账号是否存在
            //存在-->登录-->已绑手机号
            //存在-->登录-->未绑--->绑
            //不存在---->注册(token？)-->绑
            
            [JPUSHService setTags:[NSSet setWithObject:@""] alias:resp.openid fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                
                NSLog(@"%d--%@",iResCode,iAlias);
                
            }];
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            //账户是否存在
            [[[HHUserLoginAPI postUserIsExistWithopenId:resp.openid] netWorkClient] postRequestInView:nil finishedBlock:^(HHUserLoginAPI *api, NSError *error) {
                
                if (!error) {
                    
                    if (api.code == 0) {
                    
                        if ([api.data isEqualToNumber:@0]) {
                            //用户不存在-->注册
                            [self registerWithName:resp.name image:resp.iconurl openid:resp.openid unionId:resp.unionId];
                            
                        }else{
                        //用户存在 -->登录
                            
                            [[[HHUserLoginAPI postApiLoginWithopenId:resp.openid] netWorkClient] postRequestInView:nil finishedBlock:^(HHUserLoginAPI *api, NSError *error) {
                                
                                if (!error) {
                                    if (api.code == 0) {
                                        NSString *token = api.data;
                                        HJUser *user = [HJUser sharedUser];
                                        user.token = token;
                                        user.expirationTime = [[NSDate date] timeIntervalSince1970];
                                        [user write];
                                        
//                                     //是否绑定手机号
                                        [self UserIsBandPhone];
                                        
                                    }else{
                                        
                                        [SVProgressHUD showInfoWithStatus:api.msg];
                                    }
                                }else{
                                    
                                    if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]||[error.localizedDescription  containsString:@"请求超时"]) {
                                        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                                        [SVProgressHUD showInfoWithStatus:@"网络竟然崩溃了～"];
                                        
                                    }
                                }
                                
                            }];
                            
                        }
                        
                    }
                }
                
            }];
            
        }
    }];
    
    
}
- (void)registerWithName:(NSString *)name image:(NSString *)image openid:(NSString *)openid  unionId:(NSString *)unionId{
    
    //注册
    [[[HHUserLoginAPI postRegsterWithopenId:openid name:name image:image unionId:unionId] netWorkClient] postRequestInView:nil finishedBlock:^(HHUserLoginAPI *api, NSError *error) {
        
            if (!error) {
                
            if (api.code == 0) {
                NSString *token = api.data;
                HJUser *user = [HJUser sharedUser];
                user.token = token;
                user.expirationTime = [[NSDate date] timeIntervalSince1970];
                [user write];
                
                //用户是否绑定手机号
                [self UserIsBandPhone];
            }
        }
    }];
    
}
- (void)UserIsBandPhone{
    
    [[[HHUserLoginAPI postUserIsBrankPhone] netWorkClient] postRequestInView:nil finishedBlock:^(HHUserLoginAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
            
                if ([api.data isEqualToNumber:@1]) {
                    HHBandPhoneVc *vc = [HHBandPhoneVc new];
                    vc.titleStr = @"绑定手机";
                    [self.navigationController pushVC:vc];
                    
                }else{
                    //绑过
                    HJTabBarController *tabBarVC = [[HJTabBarController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
                }
            }
            
        }
        
    }];
    
}
@end
