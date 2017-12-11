//
//  HXForgetPwdAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXForgetPwdAPI.h"

@implementation HXForgetPwdAPI

+ (instancetype)FindPwdWithAcc:(NSString *)acc NewPwd:(NSString *)password{
    
    HXForgetPwdAPI *api = [HXForgetPwdAPI new];
    api.subUrl = API_GET_FORGET_PWD;
    if (acc) {
        [api.parameters setObject:acc forKey:@"acc"];
    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    api.parametersAddToken = NO;
    return api;


}
@end
