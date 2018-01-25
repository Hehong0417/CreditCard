//
//  AllPlanCell.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAllPlanCell.h"

@implementation HHAllPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.timeLab.text = @"2017-12-14";
        
        [self.contentView addSubview:self.timeLab];
     
        [self.dot lh_setCornerRadius:15/2 borderWidth:0 borderColor:nil];
        [self.contentView addSubview:self.dot];
        
        [self.contentView addSubview:self.downLineLab];
        
        self.cardRecordLab.text = @"刷¥666";
        [self.contentView addSubview:self.cardRecordLab];
        
        [self setContrains];
 
    }
    return self;
}
- (void)setContrains{

    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(8);
    }];
    [self.downLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.timeLab.mas_right).with.offset(23);
        make.bottom.equalTo(self.timeLab.mas_top).with.offset(-8);
    }];
    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLab);
        make.centerX.equalTo(self.downLineLab);
        make.width.height.mas_equalTo(15);
        
    }];
  
    [self.cardRecordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLab);
        make.left.equalTo(self.dot.mas_right).with.offset(40);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
}

- (UIImageView *)dot{
    
    if (!_dot) {
            _dot = [[UIImageView alloc]init];
            _dot.contentMode = UIViewContentModeScaleAspectFill;
            _dot.backgroundColor = kComm_Color;
    }
    return _dot;
}
- (UILabel *)downLineLab {
    
    if (!_downLineLab) {
        _downLineLab = [[UILabel alloc]init];
        _downLineLab.backgroundColor = KACLabelColor;
        _downLineLab.textAlignment = NSTextAlignmentCenter;
    }
    return _downLineLab;
}
- (UILabel *)cardRecordLab{
    
    if (!_cardRecordLab) {
        _cardRecordLab = [[UILabel alloc]init];
        _cardRecordLab.textColor = kBlackColor;
        _cardRecordLab.font = FONT(17);
        _cardRecordLab.textAlignment = NSTextAlignmentLeft;
    }
    return _cardRecordLab;
    
}
- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = KACLabelColor;
        _timeLab.font = FONT(15);
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
    
}

@end
