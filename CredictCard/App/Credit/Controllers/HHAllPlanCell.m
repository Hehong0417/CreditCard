//
//  AllPlanCell.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAllPlanCell.h"
#import "HHPlanModel.h"

@implementation HHAllPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.timeLab.text = @"2017-12-14";
        
        [self.contentView addSubview:self.timeLab];
     
        [self.dot lh_setCornerRadius:15/2 borderWidth:0 borderColor:nil];
        [self.contentView addSubview:self.dot];
        
        [self.contentView addSubview:self.downLineLab];
        
        self.cardRecordLab.text = @"刷¥666";
        self.cardRecordLab2.text = @"刷¥666";

        //normal
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.finishBtn2 setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.finishBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [self.finishBtn2 setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [self.finishBtn lh_setBackgroundColor:kComm_Color forState:UIControlStateSelected];
        [self.finishBtn2 lh_setBackgroundColor:kComm_Color forState:UIControlStateSelected];
        
        //select
        [self.finishBtn setTitle:@"已完成" forState:UIControlStateSelected];
        [self.finishBtn2 setTitle:@"已完成" forState:UIControlStateSelected];
        [self.finishBtn setTitleColor:kComm_Color forState:UIControlStateSelected];
        [self.finishBtn2 setTitleColor:kComm_Color forState:UIControlStateSelected];
        
        [self.finishBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];
        [self.finishBtn2 lh_setBackgroundColor:kWhiteColor forState:UIControlStateSelected];


        
        [self.contentView addSubview:self.cardRecordLab];
        [self.contentView addSubview:self.finishBtn];
        [self.contentView addSubview:self.cardRecordLab2];
        [self.contentView addSubview:self.finishBtn2];

        
        [self setContrains];
 
    }
    return self;
}
- (void)setContrains{

    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(30);
    }];

    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLab);
        make.centerX.equalTo(self.downLineLab);
        make.width.height.mas_equalTo(15);
        
    }];
    [self.downLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dot.mas_bottom).with.offset(10);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.timeLab.mas_right).with.offset(23);
        make.bottom.mas_equalTo(8);
    }];

    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardRecordLab);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(65);
    }];
    [self.cardRecordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLab);
        make.left.equalTo(self.dot.mas_right).with.offset(20);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.finishBtn.mas_left).with.offset(-20);
    }];
    /////////
    [self.cardRecordLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardRecordLab.mas_bottom).with.offset(20);
        make.left.equalTo(self.dot.mas_right).with.offset(20);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.finishBtn.mas_left).with.offset(-20);
    }];

    [self.finishBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardRecordLab2);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(65);
    }];
}
- (void)setModel:(HHHomeModel *)model{
    
    _model = model;
    
    self.timeLab.text = model.RepayDate;
    
    if ([model.Type isEqualToString:@"1"]) {
        //刷***
        self.dot.image = [UIImage imageNamed:@"home_icon_circle_default"];
        
    if (model.Details.count == 1) {
        
        HHPlanModel *pModel = [HHPlanModel mj_objectWithKeyValues:model.Details[0]];
        self.cardRecordLab.text = [NSString stringWithFormat:@"刷 ¥%@", pModel.RepayMoney];
        self.cardRecordLab.hidden = NO;
        self.cardRecordLab2.hidden = YES;
        self.finishBtn.hidden = NO;
        self.finishBtn2.hidden = YES;
        if ([pModel.Status isEqualToString:@"1"]) {
            //未完成
            self.finishBtn.selected = NO;
        }else{
            self.finishBtn.selected = YES;
        }
        
    }else if (model.Details.count == 2){
        
        HHPlanModel *pModel1 = [HHPlanModel mj_objectWithKeyValues:model.Details[0]];
        self.cardRecordLab.text = [NSString stringWithFormat:@"刷 ¥%@", pModel1.RepayMoney];
        HHPlanModel *pModel2 = [HHPlanModel mj_objectWithKeyValues:model.Details[1]];
        self.cardRecordLab2.text = [NSString stringWithFormat:@"刷 ¥%@", pModel2.RepayMoney];
        self.cardRecordLab.hidden = NO;
        self.cardRecordLab2.hidden = NO;
        self.finishBtn.hidden = NO;
        self.finishBtn2.hidden = NO;
        if ([pModel1.Status isEqualToString:@"1"]) {
            //未完成
            self.finishBtn.selected = NO;
        }else{
            self.finishBtn.selected = YES;
        }
        if ([pModel2.Status isEqualToString:@"1"]) {
            //未完成
            self.finishBtn2.selected = NO;
        }else{
            self.finishBtn2.selected = YES;
        }
    }
     //
    }else{
        //还
        HHPlanModel *pModel = [HHPlanModel mj_objectWithKeyValues:model.Details[0]];
        self.dot.image = [UIImage imageNamed:@"home_icon_circles_default"];
        self.cardRecordLab.text = [NSString stringWithFormat:@"还 ¥%@", pModel.RepayMoney];
        self.cardRecordLab.hidden = NO;
        self.cardRecordLab2.hidden = YES;
        self.finishBtn.hidden = NO;
        self.finishBtn2.hidden = YES;
        if ([pModel.Status isEqualToString:@"1"]) {
            //未完成
            self.finishBtn.selected = NO;
        }else{
            self.finishBtn.selected = YES;
        }
        
    }
    
    
}

- (UIButton *)finishBtn{
    
    if (!_finishBtn) {
        _finishBtn = [UIButton lh_buttonWithFrame:CGRectZero target:self action:nil  image:nil title:@"完成" titleColor:kWhiteColor font:FONT(14)];
        _finishBtn.backgroundColor = kComm_Color;
        [_finishBtn lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    }
    return _finishBtn;
}
- (UIButton *)finishBtn2{
    
    if (!_finishBtn2) {
        _finishBtn2 = [UIButton lh_buttonWithFrame:CGRectZero target:self action:nil  image:nil title:@"完成" titleColor:kWhiteColor font:FONT(14)];
        _finishBtn2.backgroundColor = kComm_Color;
        [_finishBtn2 lh_setCornerRadius:5 borderWidth:0 borderColor:nil];

    }
    return _finishBtn2;
}
- (UILabel *)cardRecordLab2{
    
    if (!_cardRecordLab2) {
        _cardRecordLab2 = [[UILabel alloc]init];
        _cardRecordLab2.textColor = kBlackColor;
        _cardRecordLab2.font = FONT(17);
        _cardRecordLab2.textAlignment = NSTextAlignmentLeft;
    }
    return _cardRecordLab2;
    
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
