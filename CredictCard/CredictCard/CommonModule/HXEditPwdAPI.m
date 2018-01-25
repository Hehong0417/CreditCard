//
//  HXEditPwdAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/11.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXEditPwdAPI.h"

@implementation HXEditPwdAPI

+ (instancetype)editPwdWithOldpassword:(NSString *)oldpassword NewPwd:(NSString *)password Teacher_id:(NSString *)teacher_id Logins_id:(NSString *)logins_id{
    
    HXEditPwdAPI *api = [HXEditPwdAPI new];
//    api.subUrl = API_GET_EDIT_PWD;
    if (oldpassword) {
        [api.parameters setObject:oldpassword forKey:@"oldpassword"];
    }
//    if (teacher_id) {
//        [api.parameters setObject:teacher_id forKey:@"teacher_id"];
//    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    if (logins_id) {
        [api.parameters setObject:logins_id forKey:@"logins_id"];
    }
    api.parametersAddToken = YES;
    
    return api;
    
    
}
@end
