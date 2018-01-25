//
//  MessageCell.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHMessageCell.h"

@implementation HHMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.titleLab.text = @"  学习践行“两不怕”精神　争做新时代王杰式好战士";
//        self.contentLab.text = @"党的十九大后不久，习近平就视察军委联合作战指挥中心，表明了新一届中央军委推动全军各项工作向能打仗、打胜仗聚焦的鲜明态度。练兵备战在基层落实得怎么样？习近平十分关注。13日下午4时30分许，习近平风尘仆仆来到驻江苏徐州的第71集团军某旅王杰生前所在连。";
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        
        [self setContrains];
        
    }
    return self;
}
- (void)setContrains{
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);

    }];
   
}
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = kBlackColor;
        _titleLab.font = FONT(17);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
    
}
- (UITextView *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UITextView alloc]init];
        _contentLab.textColor = KACLabelColor;
        _contentLab.font = FONT(14);
    }
    return _contentLab;
    
}

@end
