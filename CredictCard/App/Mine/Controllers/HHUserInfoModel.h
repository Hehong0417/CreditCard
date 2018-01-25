//
//  HHUserInfoModel.h
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "BaseModel.h"

@interface HHUserInfoModel : BaseModel

@property(nonatomic, copy)NSString *Id;

@property(nonatomic, copy)NSString *Name;

@property(nonatomic, copy)NSString *Phone;

@property(nonatomic, copy)NSString *Image;

@property(nonatomic, strong)NSString *LevelName;

@property(nonatomic, copy)NSString *HistoryCommission;

@property(nonatomic, strong)NSString *Commission;

@property(nonatomic, strong)NSString *InComeCommission;

@end
