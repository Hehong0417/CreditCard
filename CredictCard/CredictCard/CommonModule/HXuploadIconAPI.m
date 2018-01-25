//
//  HXuploadIconAPI.m
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXuploadIconAPI.h"

@implementation HXuploadIconAPI
+ (instancetype)uploadImageWithphotoFile:(NSString *)photoFile type:(NSString *)type{
    
    HXuploadIconAPI *api = [[HXuploadIconAPI alloc] init];
//    if (photoFile) {
//        NetworkClientFile *file = [NetworkClientFile imageFileWithFileData:photoFile name:@"image"];
//        api.uploadFile = @[file];
//    }
    if (photoFile) {
        [api.parameters setObject:photoFile forKey:@"image"];

    }
    api.subUrl = [NSString stringWithFormat:@"%@/ApiUploadFile/UploadImage",API_HOST];
    
    return api;
}
@end
