//
//  HHPerCenterModel.h
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseModel.h"

@interface HHPerCenterModel : BaseModel

//公共
@property(nonatomic, copy)NSString *Id;
@property(nonatomic, copy)NSString *CreateDate;


//收入记录
@property(nonatomic, copy)NSString *TypeName;
@property(nonatomic, copy)NSString *Commission;

//团队列表、团队销量列表
@property(nonatomic, copy)NSString *Name;
@property(nonatomic, copy)NSString *Image;

//已出账单
@property(nonatomic, copy)NSString *BrankName;
@property(nonatomic, copy)NSString *LastCardNo;
@property(nonatomic, copy)NSString *RepayMoney;
@property(nonatomic, copy)NSString *RepayDate;


@property(nonatomic, copy)NSString *Email;
@property(nonatomic, copy)NSString *Password;
@end
