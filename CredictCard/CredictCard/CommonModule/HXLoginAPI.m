//
//  HXLoginAPI.m
//  HXBudsProject
//
//  Created by n on 2017/4/28.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXLoginAPI.h"

@implementation HXLoginAPI
+ (instancetype)loginWithPhoneNum:(NSString *)acc password:(NSString *)password{

    HXLoginAPI *api = [self new];
    api.subUrl = API_LOGIN;
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
