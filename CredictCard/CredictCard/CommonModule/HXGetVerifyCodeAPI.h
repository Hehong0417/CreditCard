//
//  HXGetVerifyCodeAPI.h
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXGetVerifyCodeAPI : BaseAPI
+ (instancetype)getVerifyCodeWithPhoneNum:(NSString *)acc;

@end
