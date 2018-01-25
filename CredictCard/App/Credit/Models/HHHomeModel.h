//
//  HHHomeModel.h
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseModel.h"

@interface HHHomeModel : BaseModel

//直播现场
@property (nonatomic, strong)  NSString *LiveBroadcastUrl;
//一键提额
@property (nonatomic, strong)  NSString *WithdrawalsUrl;
//一键贷款
@property (nonatomic, strong)  NSString *LoanUrl;
//历史佣金
@property (nonatomic, strong)  NSString *HistoryCommission;
//可提现佣金
@property (nonatomic, strong)  NSString *Commission;
//滚动消息
@property (nonatomic, strong)  NSArray *Message;

//办卡进度
@property (nonatomic, strong)  NSString *CreateCardUrl;

//轮播
@property (nonatomic, strong)  NSArray *Carousel;


//当月计划
@property (nonatomic, strong)  NSString *RepayDate;
@property (nonatomic, strong)  NSArray *Details;
@property (nonatomic, strong)  NSString *Type;
@end
