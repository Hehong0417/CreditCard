//
//  HHInComeListAPI.h
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseAPI.h"

@interface HHPerCenterDataAPI : BaseAPI

#pragma mark - get

//获取用户信息
+ (instancetype)getUserInfo;

//收入记录
+ (instancetype)getInComeListWithPage:(NSNumber *)page;

//已出账单
+ (instancetype)getYetPlanListWithPage:(NSNumber *)page;

//团队列表
+ (instancetype)getSubordinateListWithPage:(NSNumber *)page key:(NSString *)key;

//团队销量列表
+ (instancetype)getSubordinateSaleListWithPage:(NSNumber *)page name:(NSString *)name;

//会员升级数据
+ (instancetype)getUserUpgradeInfo;

// 获取海报
+ (instancetype)getGetQRCode;

// 会员当前等级数据
+ (instancetype)GetNextUpgrade;

// 获取邮箱和密码
+ (instancetype)GetUserMail;

#pragma mark - post

//修改头像
+ (instancetype)postEditUserHeadWithImage:(NSString *)image;

//修改昵称
+ (instancetype)postEditUserNameWithName:(NSString *)name;

//修改手机
+ (instancetype)postEditUserPhoneWithPhone:(NSString *)phone code:(NSString *)code;

//提现
+ (instancetype)postUserWithdrawalsWithMoney:(NSString *)money;


//设置邮箱和密码
+ (instancetype)postEditUserMailWitheEmail:(NSString *)email password:(NSString *)password;


//手动导入当月或上月账单
+ (instancetype)postCardPlanUserMail;

@end


