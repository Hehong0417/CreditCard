//
//  HHFoundDataAPI.m
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHFoundDataAPI.h"

@implementation HHFoundDataAPI

//多处链接
+ (instancetype)getCommonUrl{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_GetCommonUrl;
    api.parametersAddToken = NO;
    return api;
}

//添加信用卡
+ (instancetype)postAddCardWithCardNo:(NSString *)cardNo brankId:(NSString *)brankId statementDate:(NSString *)statementDate repaymentDate:(NSString *)repaymentDate overdraft:(NSString *)overdraft{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_AddCard;
    api.parametersAddToken = NO;
    if(cardNo){
        [api.parameters setObject:cardNo forKey:@"cardNo"];
    }
    if(brankId){
        [api.parameters setObject:brankId forKey:@"brankId"];
    }
    if(statementDate){
        [api.parameters setObject:statementDate forKey:@"statementDate"];
    }
    if(repaymentDate){
        [api.parameters setObject:repaymentDate forKey:@"repaymentDate"];
    }
    if(overdraft){
        [api.parameters setObject:overdraft forKey:@"overdraft"];
    }
    return api;
    
}

//修改卡账单日
+ (instancetype)postUpdateStatementDateWithCardId:(NSString *)cardId statementDate:(NSString *)statementDate{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_UpdateStatementDate;
    api.parametersAddToken = NO;
    if(cardId){
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if(statementDate){
        [api.parameters setObject:statementDate forKey:@"statementDate"];
    }
    
    return api;
    
}

//修改卡还款日
+ (instancetype)postUpdateRepaymentDateWithCardId:(NSString *)cardId repaymentDate:(NSString *)repaymentDate{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_UpdateRepaymentDate;
    api.parametersAddToken = NO;
    if(cardId){
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if(repaymentDate){
        [api.parameters setObject:repaymentDate forKey:@"repaymentDate"];
    }
    
    return api;
    
    
}


//修改卡上月应还金额
+ (instancetype)postUpdateLastMonthConsumptionWithCardId:(NSString *)cardId consumption:(NSString *)consumption{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_UpdateLastMonthConsumption;
    api.parametersAddToken = NO;
    if(cardId){
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if(consumption){
        [api.parameters setObject:consumption forKey:@"consumption"];
    }
    
    return api;
    
}
//修改卡额度
+ (instancetype)postUpdateCardOverdraftWithCardId:(NSString *)cardId overdraft:(NSString *)overdraft{
    
    HHFoundDataAPI *api = [self new];
    api.subUrl = API_UpdateCardOverdraft;
    api.parametersAddToken = NO;
    if(cardId){
        [api.parameters setObject:cardId forKey:@"cardId"];
    }
    if(overdraft){
        [api.parameters setObject:overdraft forKey:@"overdraft"];
    }

    return api;
    
}
@end
