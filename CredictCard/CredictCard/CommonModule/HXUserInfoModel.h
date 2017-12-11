//
//  HXUserInfoModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@class HXUserInfoPdModel;
@interface HXUserInfoModel : BaseModel

@property(nonatomic,strong) HXUserInfoPdModel *pd;

@end
@interface HXUserInfoPdModel : BaseModel

@property(nonatomic,copy) NSString *expect;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *sex;
@property(nonatomic,copy) NSString *users_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *user_address;
@property(nonatomic,copy) NSString *headportrait;
@property(nonatomic,copy) NSString *birthdate;
@property(nonatomic,copy) NSString *targetart;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *openid;
@property(nonatomic,copy) NSString *acc;

@property(nonatomic,copy) NSString *totalfabulous;
@property(nonatomic,copy) NSString *myfollow;
@property(nonatomic,copy) NSString *myfans;
@property(nonatomic,copy) NSString *isfollow;
@property(nonatomic,copy) NSString *coverlogins_id;
@property(nonatomic,copy) NSString *logins_id;
@property(nonatomic,copy) NSString *videonum;
@end
