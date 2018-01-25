

//
//  HXMineHeadView.m
//  mengyaProject
//
//  Created by n on 2017/6/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HHMineHeadView.h"
#import "HHLoginVC.h"
#import "HHYetBillVC.h"
#import "HHwithDrawCommissionVC.h"
#import "HHUpgradeVC.h"

#define head_H  SCREEN_WIDTH*240/375

@implementation HHMineHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {

        //登录后状态底视图
        self.loginContentView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  frame.size.height*175/240) backColor:kComm_Color];
        
        self.teacherImageIcon.centerX = self.centerX;
        self.nameLabel.centerX = self.centerX;
        self.nameLabel.text = @"name";
        [self addSubview:self.loginContentView];
        self.nameLabel.centerX = self.centerX;
//        self.title2Label.centerX = self.centerX;
//        self.titleLabel.centerY = self.title2Label.centerY;
//        self.regAndLoginBtn.centerY = self.title2Label.centerY;
        self.regAndLoginBtn.centerX = self.centerX;

        [self.loginContentView addSubview:self.teacherImageIcon];
        [self.loginContentView addSubview:self.nameLabel];
//        [self.loginContentView addSubview:self.titleLabel];
//        [self.loginContentView addSubview:self.title2Label];
        [self.loginContentView addSubview:self.regAndLoginBtn];
//        [self.loginContentView addSubview:self.exitBtn];

        
        //账单底图
        [self addSubview:self.billBottomView];
        
        //加阴影
        [self addShadowToView:self.billBottomView withOpacity:0.15 shadowRadius:10 andCornerRadius:8 shadowColor:kComm_Color];

        NSArray *titiles = @[@"历史佣金",@"可提现佣金"];
        NSArray *counts = @[@"0.00",@"0.00"];
        
        for (NSInteger i = 0; i<2; i++) {
            
            self.section = [[HHCommentSection alloc]initWithFrame:CGRectMake(i*(self.billBottomView.mj_w/2 + 1),10 , self.billBottomView.mj_w/2 - 2, self.billBottomView.mj_h-20)];
            self.section.userInteractionEnabled = YES;
            self.section.tag = i+10001;
            self.section.titleLabel.text = counts[i];
            self.section.countLabel.text = titiles[i];
            if (i<1) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.section.frame), (self.billBottomView.mj_h-WidthScaleSize_H(30))/2, 1, WidthScaleSize_H(30))];
                line.backgroundColor = KACLabelColor;
                [self.billBottomView addSubview:line];
                
            }
            WEAK_SELF()
            [self.section setTapActionWithBlock:^{
                
                if(i == 1){
                    
                    HHwithDrawCommissionVC *vc = [HHwithDrawCommissionVC new];
                    [weakSelf.nav pushVC:vc];
                }
                
                }];
            
            [self.billBottomView addSubview:self.section];
        }
        
    }
    return self;
}


- (void)vipAction{
    
    HHUpgradeVC *vc = [HHUpgradeVC new];
    [self.nav pushVC:vc];
    
}
//注销
- (void)exitBtnAction{
    
    HHLoginVC *vc = [[HHLoginVC alloc] init];
    [self.nav pushVC:vc];
    
}
- (UIView *)billBottomView {
    
    CGFloat b_H = head_H*75/255;
    CGFloat b_W = b_H*320/75;
    if (!_billBottomView) {
        _billBottomView = [[UIView alloc]initWithFrame: CGRectMake((SCREEN_WIDTH - b_W)/2, CGRectGetMaxY(self.loginContentView.frame)- WidthScaleSize_H(15), b_W,b_H)];
        _billBottomView.backgroundColor = kWhiteColor;
    }
    return _billBottomView;
}

//我的级别
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), WidthScaleSize_W(100), WidthScaleSize_H(20))];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.text = @"我的级别";
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = FONT(13);
    }
    return _titleLabel;
    
}

//高级用户按钮
- (UIButton *)regAndLoginBtn {
    
    if (!_regAndLoginBtn) {
        _regAndLoginBtn = [UIButton lh_buttonWithFrame:CGRectMake(CGRectGetMaxX(self.title2Label.frame)+10, self.titleLabel.mj_y, WidthScaleSize_W(100), WidthScaleSize_H(20)) target:self action:@selector(vipAction) image:nil];
        _regAndLoginBtn.titleLabel.font = FONT(14);
    }
    return _regAndLoginBtn;
}

//标题2
- (UILabel *)title2Label {
    if (!_title2Label) {
        _title2Label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame)+5, 1, WidthScaleSize_H(15))];
        _title2Label.backgroundColor = kWhiteColor;
        _title2Label.text = @"";
        _title2Label.textAlignment = NSTextAlignmentCenter;
        _title2Label.font = FONT(17);
    }
    return _title2Label;

}
- (UIButton *)exitBtn{
    
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 5, WidthScaleSize_W(50), WidthScaleSize_H(15));
        [_exitBtn setTitle:@"注销" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _exitBtn.titleLabel.font = FONT(14);
    }
    return _exitBtn;
    
}

//用户头像
- (UIImageView *)teacherImageIcon {
    
    if (!_teacherImageIcon) {
        _teacherImageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(WidthScaleSize_W(20), WidthScaleSize_H(10), WidthScaleSize_W(75), WidthScaleSize_W(75))];
        _teacherImageIcon.backgroundColor = KVCBackGroundColor;
        [_teacherImageIcon lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    }
    return _teacherImageIcon;
    
}
//姓名
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.teacherImageIcon.frame)+3, WidthScaleSize_W(200), WidthScaleSize_H(30))];
        _nameLabel.textColor = kWhiteColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = FONT(20);
    }
    return _nameLabel;
    
}
@end
