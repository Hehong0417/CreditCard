//
//  HHHomeDataAPI.h
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseAPI.h"

@interface HHHomeDataAPI : BaseAPI

#pragma mark - get

//获取首页的其它信息
+ (instancetype)getIndexBase;

//获取用户信用卡列表
+ (instancetype)getUserAllCardList;

//获取一张信用卡信息
+ (instancetype)getCardaInfoByCardId:(NSString *)cardId;

//获取所有银行
+ (instancetype)getBrankListWithPage:(NSNumber *)page;

//信用卡超市（办卡列表）
+ (instancetype)getCreateCardListWithPage:(NSNumber *)page;

//贷款超市（贷款列表）
+ (instancetype)getLoanListWithPage:(NSNumber *)page;

//获取首页银行卡计划
+ (instancetype)getCardTopPlanWithCardId:(NSString *)cardId;

//获取消费类型
+ (instancetype)getConsumptionTypeWithplanDetailId:(NSString *)planDetailId;

//计划当天还需操作
+ (instancetype)getTodayPlanWithCardId:(NSString *)cardId;

// 当月刷卡计划
+ (instancetype)getMonthPlanWithCardId:(NSString *)cardId refDate:(NSString *)refDate page:(NSNumber *)page;

// 消息列表
+ (instancetype)getNoticeListWithPage:(NSNumber *)page;

// 消息详细
+ (instancetype)getNoticeDetailWithId:(NSString *)Id;

// 文章分类列表
+ (instancetype)getArticleTypeList;

// 文章列表
 + (instancetype)getArticleListWithtypeId:(NSString *)typeId page:(NSNumber *)page;

// 文章详细
+ (instancetype)GetArticleDetailWithId:(NSString *)Id;

// 测试
+ (instancetype)GetChildsWithId:(NSNumber *)Id;

#pragma mark - post

// 设置还清
+ (instancetype)postSetPlanFinishWithPlanId:(NSString *)planId;

//点击更换刷卡额度
+ (instancetype)postRefreshPlanWithCardId:(NSString *)cardId refDate:(NSString *)refDate page:(NSNumber *)page;

//一键完成
+ (instancetype)postSetAllPlanFinishWithCardId:(NSString *)cardId date:(NSString *)date;

//修改消费类型
+ (instancetype)postEditConsumptionTypeWithplanId:(NSString *)planId typeId:(NSString *)typeId;

@end
