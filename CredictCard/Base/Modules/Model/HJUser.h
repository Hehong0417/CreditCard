//
//  HJUser.h
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "BaseModel.h"
#import "LHMacro.h"

@interface HJLoginModel : BaseModel

@property(nonatomic,copy) NSString *state;
@property(nonatomic,strong) NSString *token;
@property(nonatomic,copy) NSString *users_id;
@property(nonatomic,copy) NSString *teacher_id;
@property(nonatomic,copy) NSString *logins_id;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *password;

@end


@interface HJUser : BaseModel {
    
//    HJLoginModel *_userModel;
}
singleton_h(User)

@property (nonatomic, strong) HJLoginModel *pd;
@property(nonatomic,strong) NSString *token;
@property (nonatomic, assign)   NSInteger selectedIndex;
@property (nonatomic, strong)   NSString *cardId;

@property (nonatomic, strong)   NSString *email;
@property (nonatomic, strong)   NSString *emailPd;
@property (nonatomic, assign)   NSTimeInterval expirationTime;

@end
