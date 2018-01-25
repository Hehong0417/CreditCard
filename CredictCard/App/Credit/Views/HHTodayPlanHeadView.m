//
//  TodayPlanHeadView.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTodayPlanHeadView.h"

@implementation HHTodayPlanHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //分类图片1
        [self addSubview:self.categoryImageV1];
        //标题1
        self.titleLab1.text = @"今日还需刷";
        [self addSubview:self.titleLab1];
        //标题2
        self.titleLab2.text = @"选择消费项目";
        [self addSubview:self.titleLab2];
        //时间
        self.timeLab.text = @"2017-12-14";
        [self addSubview:self.timeLab];

        //价格
        self.priceLab.text = @"¥10000";
        [self addSubview:self.priceLab];
        
        //店铺名称
        self.storeNameLab.text = @"潮汕牛肉火锅店";
        [self addSubview:self.storeNameLab];
        
        //分类图片2
        [self addSubview:self.categoryImageV2];
        
        
        [self setConstains];
        
    }
    
    return self;
}
- (void)setConstains{
    
    //分类图1
    [self.categoryImageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    //今日还需
    [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryImageV1.mas_right).with.offset(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    //时间
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-20);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    //价格
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab1.mas_bottom).with.offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    //店铺名称
    [self.storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    //贝塞尔水波
    LLWaveView *waveView = [[LLWaveView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    [self addSubview:waveView];
    
    [waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeNameLab.mas_bottom).with.offset(30);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    //分类图2
    [self.categoryImageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(waveView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    //选择消费项目
    [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryImageV2.mas_right).with.offset(10);
        make.centerY.equalTo(self.categoryImageV2);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];

}

- (UIImageView *)categoryImageV1 {
    
    if (!_categoryImageV1) {
        _categoryImageV1 = [[UIImageView alloc]init];
        _categoryImageV1.contentMode = UIViewContentModeLeft;
        _categoryImageV1.backgroundColor = kComm_Color;
    }
    
    return _categoryImageV1;
}
- (UIImageView *)categoryImageV2 {
    
    if (!_categoryImageV2) {
        _categoryImageV2 = [[UIImageView alloc]init];
        _categoryImageV2.contentMode = UIViewContentModeLeft;
        _categoryImageV2.backgroundColor = kComm_Color;
    }
    
    return _categoryImageV2;
}
- (UILabel *)titleLab1{
    
    if (!_titleLab1) {
        _titleLab1 = [[UILabel alloc]init];
        _titleLab1.textColor = kBlackColor;
        _titleLab1.font = FONT(15);
        _titleLab1.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab1;
}
- (UILabel *)titleLab2{
    
    if (!_titleLab2) {
        _titleLab2 = [[UILabel alloc]init];
        _titleLab2.textColor = kBlackColor;
        _titleLab2.font = FONT(15);
        _titleLab2.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab2;
}
- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = KACLabelColor;
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}
- (UILabel *)priceLab{
    
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = kComm_Color;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}
- (UILabel *)storeNameLab{
    
    if (!_storeNameLab) {
        _storeNameLab = [[UILabel alloc]init];
        _storeNameLab.textColor = kComm_Color;
        _storeNameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _storeNameLab;
}
@end
