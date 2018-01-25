//
//  HHcardModel.h
//  CredictCard
//
//  Created by User on 2018/1/25.
//  Copyright © 2018年 User. All rights reserved.
//

#import "BaseModel.h"

@interface HHcardModel : BaseModel
@property (strong, nonatomic) NSString *CradNo;
@property (strong, nonatomic) NSString *StatementDate;
@property (strong, nonatomic) NSString *RepaymentDate;
@property (strong, nonatomic) NSString *Overdraft;
@property (strong, nonatomic) NSString *RepayMoney;
@property (strong, nonatomic) NSString *BrankName;
@property (strong, nonatomic) NSString *CardNo;

@end
