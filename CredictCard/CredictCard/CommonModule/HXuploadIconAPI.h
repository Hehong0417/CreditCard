//
//  HXuploadIconAPI.h
//  HXBudsProject
//
//  Created by n on 2017/5/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseAPI.h"

@interface HXuploadIconAPI : BaseAPI
+ (instancetype)uploadImageWithphotoFile:(NSString *)photoFile type:(NSString *)type;
@end
