//
//  HXUploadIconModel.h
//  HXBudsProject
//
//  Created by n on 2017/5/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseModel.h"

@interface HXUploadIconModel : BaseModel

singleton_h(userIconModel)

@property(nonatomic,copy) NSString *fileName;

@property(nonatomic,strong) UIImage *cellImage;

@end
