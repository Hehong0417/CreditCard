//
//  HXForgetPwdAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXForgetPwdAPI : BaseAPI

+(instancetype)FindPwdWithAcc:(NSString *)acc NewPwd:(NSString *)password;

@end
