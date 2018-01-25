//
//  HHInComeListAPI.m
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHPerCenterDataAPI.h"

@implementation HHPerCenterDataAPI

//用户信息
+ (instancetype)getUserInfo{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GET_USER_INFO;
    api.parametersAddToken = NO;
    return api;
}
//收入记录
+ (instancetype)getInComeListWithPage:(NSNumber *)page{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetUserInComeList;
    api.parametersAddToken = NO;
    if(page){
    [api.parameters setObject:page forKey:@"page"];
    }
    return api;
}
//已出账单
+ (instancetype)getYetPlanListWithPage:(NSNumber *)page{
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
     api.subUrl = API_GetYetPlan;
    api.parametersAddToken = NO;
    if(page){
    [api.parameters setObject:page forKey:@"page"];
    }
    return api;
}
//团队列表
+ (instancetype)getSubordinateListWithPage:(NSNumber *)page key:(NSString *)key{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetSubordinateList;
    api.parametersAddToken = NO;
    if(page){
    [api.parameters setObject:page forKey:@"page"];
    }
    if(key){
        [api.parameters setObject:key forKey:@"key"];
    }
    return api;
    
}

//团队销量列表
+ (instancetype)getSubordinateSaleListWithPage:(NSNumber *)page name:(NSString *)name{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetSubordinateSaleList;
    api.parametersAddToken = NO;
    if(page){
    [api.parameters setObject:page forKey:@"page"];
    }
    if(name){
        [api.parameters setObject:name forKey:@"name"];
    }
    return api;
}
//会员升级数据
+ (instancetype)getUserUpgradeInfo{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetUserUpgrade;
    api.parametersAddToken = NO;
    
    return api;
}
// 获取海报
+ (instancetype)getGetQRCode{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetQRCode;
    api.parametersAddToken = NO;
    
    return api;
    
}
+ (instancetype)GetNextUpgrade{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetNextUpgrade;
    api.parametersAddToken = NO;
    
    return api;
}
+ (instancetype)GetUserMail{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetUserMail2;
    api.parametersAddToken = NO;
    return api;
    
}
#pragma mark - 设置信息

//修改头像
+ (instancetype)postEditUserHeadWithImage:(NSString *)image{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_EditUserHead;
    api.parametersAddToken = NO;
    if(image){
        [api.parameters setObject:image forKey:@"image"];
    }
    return api;
    
}

//修改昵称
+ (instancetype)postEditUserNameWithName:(NSString *)name{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_EditUserName;
    api.parametersAddToken = NO;
    if(name){
        [api.parameters setObject:name forKey:@"name"];
    }
    return api;
}

//修改手机
+ (instancetype)postEditUserPhoneWithPhone:(NSString *)phone code:(NSString *)code{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_EditUserPhone;
    api.parametersAddToken = NO;
    if(phone){
        [api.parameters setObject:phone forKey:@"phone"];
    }
    if(code){
        [api.parameters setObject:code forKey:@"code"];
    }
    return api;
}
//提现
+ (instancetype)postUserWithdrawalsWithMoney:(NSString *)money{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_UserWithdrawals;
    api.parametersAddToken = NO;
    if(money){
        [api.parameters setObject:money forKey:@"money"];
    }
    return api;
}

//设置邮箱和密码
+ (instancetype)postEditUserMailWitheEmail:(NSString *)email password:(NSString *)password{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_EditUserMail;
    if (email) {
        [api.parameters setObject:email forKey:@"email"];
    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    api.parametersAddToken = NO;
    return api;
    
}
//手动导入当月或上月账单
+ (instancetype)postCardPlanUserMail{
    
    HHPerCenterDataAPI *api = [HHPerCenterDataAPI new];
    api.subUrl = API_GetUserMail;
    api.parametersAddToken = NO;
    return api;
    
}


@end

