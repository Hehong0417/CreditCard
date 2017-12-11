//
//  HXRegisterAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXRegisterAPI.h"

@implementation HXRegisterAPI
+ (instancetype)registerWithPhoneNum:(NSString *)acc password:(NSString *)password{

    HXRegisterAPI *api = [self new];
    api.subUrl = API_REGISTER;
    api.parametersAddToken = NO;
    if (acc) {
        [api.parameters setObject:acc forKey:@"acc"];
    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    return api;

}

@end
