//
//  HHAllPlanHead.m
//  CredictCard
//
//  Created by User on 2017/12/27.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAllPlanHead.h"

@implementation HHAllPlanHead

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.right_arrow];
        
    }
    return self;
}
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [UILabel lh_labelWithFrame:CGRectMake(15, 0, 90, 40) text:@"选择年月" textColor:kBlackColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    }
    return _titleLab;
    
}
- (UILabel *)timeLab {
    
    if (!_timeLab) {
        _timeLab = [UILabel lh_labelWithFrame:CGRectMake(SCREEN_WIDTH-40-100, 0, 100, 40) text:@"2017-12" textColor:kBlackColor font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kWhiteColor];
    }
    return _timeLab;
    
}
- (UIImageView *)right_arrow {
    
    if (!_right_arrow) {
        _right_arrow = [UIImageView lh_imageViewWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40) image:[UIImage imageNamed:@"icon_skip_default"]];
        _right_arrow.contentMode = UIViewContentModeCenter;
    }
    return _right_arrow;
}
@end
