//
//  HHFoundDataAPI.h
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseAPI.h"

@interface HHFoundDataAPI : BaseAPI

#pragma mark - get

//多处链接
+ (instancetype)getCommonUrl;

#pragma mark - post

//添加信用卡
+ (instancetype)postAddCardWithCardNo:(NSString *)cardNo brankId:(NSString *)brankId statementDate:(NSString *)statementDate repaymentDate:(NSString *)repaymentDate overdraft:(NSString *)overdraft;

//修改卡账单日
+ (instancetype)postUpdateStatementDateWithCardId:(NSString *)cardId statementDate:(NSString *)statementDate;

//修改卡还款日
+ (instancetype)postUpdateRepaymentDateWithCardId:(NSString *)cardId repaymentDate:(NSString *)repaymentDate;

//修改卡额度
+ (instancetype)postUpdateCardOverdraftWithCardId:(NSString *)cardId overdraft:(NSString *)overdraft;

//修改卡上月应还金额
+ (instancetype)postUpdateLastMonthConsumptionWithCardId:(NSString *)cardId consumption:(NSString *)consumption;



@end
