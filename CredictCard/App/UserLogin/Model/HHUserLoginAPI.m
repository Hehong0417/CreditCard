//
//  HHGetAccess_TokenAPI.m
//  CredictCard
//
//  Created by User on 2017/12/22.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHUserLoginAPI.h"

@implementation HHUserLoginAPI

//账户是否存在
+ (instancetype)postUserIsExistWithopenId:(NSString *)openId{
    
    HHUserLoginAPI *api = [self new];
    api.subUrl = API_UserIsExist;
    api.parametersAddToken = NO;
    if (openId) {
        [api.parameters setObject:openId forKey:@"openId"];
    }
    return api;
    
}
//账户是否绑定手机号
+ (instancetype)postUserIsBrankPhone{
    
    HHUserLoginAPI *api = [self new];
    api.subUrl = API_UserIsBrankPhone;
    api.parametersAddToken = NO;
    return api;
}
//发送手机验证码手机
+ (instancetype)postSendCodeWithPhone:(NSString *)phone{
    HHUserLoginAPI *api = [self new];
    api.subUrl = API_SendCode;
    if (phone) {
        [api.parameters setObject:phone forKey:@"phone"];
    }
    api.parametersAddToken = NO;
    return api;
}

//登录
+ (instancetype)postApiLoginWithopenId:(NSString *)openId{
    
    HHUserLoginAPI *api = [self new];
    api.subUrl = API_LOGIN;
    api.parametersAddToken = NO;
    if (openId) {
        [api.parameters setObject:openId forKey:@"openId"];
    }
    return api;
}
//注册
+ (instancetype)postRegsterWithopenId:(NSString *)openId name:(NSString *)name image:(NSString *)image unionId:(NSString *)unionId{
    
    HHUserLoginAPI *api = [self new];
    api.subUrl = API_REGISTER;
    api.parametersAddToken = NO;
    if (openId) {
        [api.parameters setObject:openId forKey:@"openId"];
    }
    if (name) {
        [api.parameters setObject:name forKey:@"name"];
    }
    if (image) {
        [api.parameters setObject:image forKey:@"image"];
    }
    if (unionId) {
        [api.parameters setObject:unionId forKey:@"unionId"];
    }
    return api;
    
}
@end
