//
//  HHCommentSection.m
//  mengyaProject
//
//  Created by n on 2017/10/31.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HHCommentSection.h"

@implementation HHCommentSection

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.titleLabel];
        [self addSubview:self.countLabel];
        
    }

    return self;

}

- (UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.mj_h/2, self.mj_w, self.mj_h/2)];
        _titleLabel.textColor = kComm_Color;
        _titleLabel.font = FONT(20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)countLabel{
    
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h/2)];
        _countLabel.textColor = KTitleLabelColor;
        _countLabel.font = FONT(12);
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

@end
