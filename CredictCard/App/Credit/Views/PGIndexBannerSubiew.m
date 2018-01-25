//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"
@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
//        [self addSubview:self.coverView];
//        self.shadow.backgroundColor = [UIColor blackColor];
//        self.shadow.alpha = 0.5;
//        [self addSubview:self.shadow];
        [self addSubview:self.bankNameLabel];
        [self addSubview:self.titleLabel];
        [self addSubview: self.bankTagLabel];
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0,self.frame.size.width,self.frame.size.height-8)];
        _mainImageView.contentMode = UIViewContentModeScaleToFill;
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}
- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 70,self.frame.size.width, 40)];
    }
    return _shadow;
}
- (UILabel *)bankNameLabel {
    if (_bankNameLabel == nil) {
        _bankNameLabel = [UILabel lh_labelWithFrame:CGRectMake(20, 12,self.frame.size.width-40, 30) text:@"中国银行" textColor:kWhiteColor font:FONT(18) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
        _bankNameLabel.alpha = 0.3;
    }
    return _bankNameLabel;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel lh_labelWithFrame:CGRectMake(30, CGRectGetMaxY(self.bankNameLabel.frame),self.frame.size.width-30, 40) text:@"" textColor:kWhiteColor font:BoldFONT(18) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    }
    return _titleLabel;
}

- (UILabel *)bankTagLabel {
    if (_bankTagLabel == nil) {
        _bankTagLabel = [UILabel lh_labelWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleLabel.frame),self.frame.size.width-80, 40) text:@"" textColor:kWhiteColor font:FONT(12) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    }
    return _bankTagLabel;
}
- (void)setCardDic:(HHcardModel *)cardDic{
    
    _cardDic = cardDic;
    self.titleLabel.text = cardDic.CardNo;
    
    self.bankTagLabel.text = @"XIANG RUI KU    00/00";
    self.bankNameLabel.text = cardDic.BrankName;
}
@end
