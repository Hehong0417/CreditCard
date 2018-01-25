//
//  TodayPlanCell.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTodayPlanCell.h"

@implementation HHTodayPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.foodImagV];
        [self.chooseBtn lh_setCornerRadius:15 borderWidth:1 borderColor:kComm_Color];
        self.titleLab.text = @"重庆串串香连锁总店";
        [self.contentView addSubview:self.chooseBtn];
        [self.contentView addSubview:self.titleLab];
    
        [self setConstraint];
    }
    return self;
}
- (void)setConstraint{
    
    [self.foodImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(self.foodImagV.mas_height).multipliedBy(1.3);
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foodImagV.mas_right).offset(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.mas_equalTo(-15);
    }];
    
}
- (UIImageView *)foodImagV{
    
    if (!_foodImagV) {
        _foodImagV = [[UIImageView alloc]init];
        _foodImagV.backgroundColor = KVCBackGroundColor;
        _foodImagV.contentMode = UIViewContentModeScaleAspectFill;
        _foodImagV.backgroundColor = kComm_Color;
    }
    return _foodImagV;
}
- (UIButton *)chooseBtn{
    
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setTitle:@"选择" forState:UIControlStateNormal];
        [_chooseBtn setTitleColor:kComm_Color forState:UIControlStateNormal];
    }
    return _chooseBtn;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
            _titleLab = [[UILabel alloc]init];
            _titleLab.textColor = kBlackColor;
            _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
@end
