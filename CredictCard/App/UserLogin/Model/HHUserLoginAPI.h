//
//  HHGetAccess_TokenAPI.h
//  CredictCard
//
//  Created by User on 2017/12/22.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseAPI.h"

@interface HHUserLoginAPI : BaseAPI

#pragma mark - post

//账户是否存在
+ (instancetype)postUserIsExistWithopenId:(NSString *)openId;

//是否绑定手机号
+ (instancetype)postUserIsBrankPhone;

//发送手机验证码手机
+ (instancetype)postSendCodeWithPhone:(NSString *)phone;

//登录
+ (instancetype)postApiLoginWithopenId:(NSString *)openId;
//注册
+ (instancetype)postRegsterWithopenId:(NSString *)openId name:(NSString *)name image:(NSString *)image unionId:(NSString *)unionId;

@end
