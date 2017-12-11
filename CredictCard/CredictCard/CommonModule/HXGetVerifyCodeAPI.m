//
//  HXGetVerifyCodeAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXGetVerifyCodeAPI.h"

@implementation HXGetVerifyCodeAPI

+ (instancetype)getVerifyCodeWithPhoneNum:(NSString *)acc{

    HXGetVerifyCodeAPI *api = [self new];
    api.subUrl = API_GET_VERIFY_CODE;
    if (acc) {
        [api.parameters setObject:acc forKey:@"p"];
    }
    api.parametersAddToken = NO;
    return api;
}

@end
