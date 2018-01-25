//
//  HHHomeDataAPI.m
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHHomeDataAPI.h"

@implementation HHHomeDataAPI

//获取首页的其它信息
+ (instancetype)getIndexBase{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetIndexBase;
    api.parametersAddToken = NO;
    
    return api;
    
}

//获取用户信用卡列表
+ (instancetype)getUserAllCardList{
   
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetUserAllCardList;
    api.parametersAddToken = NO;
    
    return api;
    
}

//获取一张信用卡信息
+ (instancetype)getCardaInfoByCardId:(NSString *)cardId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetCardById;
    api.parametersAddToken = NO;
    if(cardId){
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
   
    return api;
    
}

//获取所有银行
+ (instancetype)getBrankListWithPage:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_teachingtype_LIST;
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    api.parametersAddToken = NO;
    return api;
    
}
//信用卡超市（办卡列表）
+ (instancetype)getCreateCardListWithPage:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetCreateCardList;
    api.parametersAddToken = NO;
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    return api;
    
}

//贷款超市（贷款列表）
+ (instancetype)getLoanListWithPage:(NSNumber *)page{
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetLoanList;
    api.parametersAddToken = NO;
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    return api;
}

//获取首页银行卡计划
+ (instancetype)getCardTopPlanWithCardId:(NSString *)cardId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetCardTopPlan;
    api.parametersAddToken = NO;
    if (cardId) {
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    return api;
    
}

//获取消费类型
+ (instancetype)getConsumptionTypeWithplanDetailId:(NSString *)planDetailId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetConsumptionType;
    api.parametersAddToken = NO;
    if (planDetailId) {
        [api.parameters setObject:planDetailId forKey:@"planId"];
    }
    return api;
    
}

//计划当天还需操作
+ (instancetype)getTodayPlanWithCardId:(NSString *)cardId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_today_CardPlanDetail;
    api.parametersAddToken = NO;
    if (cardId) {
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    return api;
    
}

// 当月刷卡计划
+ (instancetype)getMonthPlanWithCardId:(NSString *)cardId refDate:(NSString *)refDate page:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetMonthPlan;
    api.parametersAddToken = NO;
    if (cardId) {
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if (refDate) {
        [api.parameters setObject:refDate forKey:@"date"];
    }
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    return api;
    
}

// 消息列表
+ (instancetype)getNoticeListWithPage:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetNoticeList;
    api.parametersAddToken = NO;
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }

    return api;
    
}

// 消息详细
+ (instancetype)getNoticeDetailWithId:(NSString *)Id{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetNoticeDetail;
    api.parametersAddToken = NO;
    if (Id) {
        [api.parameters setObject:Id forKey:@"id"];
    }
    return api;
}

// 文章分类列表
+ (instancetype)getArticleTypeList{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetArticleTypeList;
    api.parametersAddToken = NO;
    return api;
}

// 文章列表
+ (instancetype)getArticleListWithtypeId:(NSString *)typeId page:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetArticleList;
    api.parametersAddToken = NO;
    if (typeId) {
        [api.parameters setObject:typeId forKey:@"typeId"];
    }
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    return api;
    
}
// 文章详细
+ (instancetype)GetArticleDetailWithId:(NSString *)Id{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetArticleDetail;
    api.parametersAddToken = NO;
    if (Id) {
        [api.parameters setObject:Id forKey:@"id"];
    }
    return api;
}

+ (instancetype)GetChildsWithId:(NSNumber *)Id{
    HHHomeDataAPI *api = [self new];
    api.subUrl = @"http://buyear.elevo.cn/Api/District/GetChilds";
    if (Id) {
        [api.parameters setObject:Id forKey:@"id"];
    }
    api.parametersAddToken = NO;
    return api;
}
#pragma mark - post

// 设置还清
+ (instancetype)postSetPlanFinishWithPlanId:(NSString *)planId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_SetPlanFinish;
    api.parametersAddToken = NO;
    if (planId) {
        [api.parameters setObject:planId forKey:@"planId"];
    }
    return api;
    
}
//点击更换刷卡额度
+ (instancetype)postRefreshPlanWithCardId:(NSString *)cardId refDate:(NSString *)refDate page:(NSNumber *)page{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_GetRefreshPlan;
    api.parametersAddToken = NO;
    if (cardId) {
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if (refDate) {
        [api.parameters setObject:refDate forKey:@"refDate"];
    } 
    if (page) {
        [api.parameters setObject:page forKey:@"page"];
    }
    return api;
    
}
//一键完成
+ (instancetype)postSetAllPlanFinishWithCardId:(NSString *)cardId date:(NSString *)date{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_SetAllPlanFinish;
    api.parametersAddToken = NO;
    if (cardId) {
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if (date) {
        [api.parameters setObject:date forKey:@"date"];
    }
    return api;
    
}
//修改消费类型
+ (instancetype)postEditConsumptionTypeWithplanId:(NSString *)planId typeId:(NSString *)typeId{
    
    HHHomeDataAPI *api = [self new];
    api.subUrl = API_EditConsumptionType;
    api.parametersAddToken = NO;
    if (planId) {
        [api.parameters setObject:planId forKey:@"planId"];
    }
    if (typeId) {
        [api.parameters setObject:typeId forKey:@"typeId"];
    }
    return api;
    
}
@end
