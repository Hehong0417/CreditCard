//
//  HXbulletinView.m
//  mengyaProject
//
//  Created by n on 2017/10/18.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXbulletinView.h"

@interface HXbulletinView ()

@property (strong, nonatomic)  UIImageView *voiceImageV;
@property (strong, nonatomic)  UIImageView *right_Arrow;

@end

@implementation HXbulletinView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kWhiteColor;
        
        [self addSubview:self.cycleScroll];
        
        [self  addSubview:self.voiceImageV];
        
        [self addSubview:self.right_Arrow];        
        
    }

    return self;

}
- (SDCycleScrollView *)cycleScroll{
    
    if (!_cycleScroll) {
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(self.mj_h, 0, SCREEN_WIDTH - 2*self.mj_h - WidthScaleSize_W(20), self.mj_h) imageNamesGroup:@[@"",@"",@""]];
    }
    
    return _cycleScroll;

}
- (void)setTitlesGroup:(NSArray *)titlesGroup {
    
    _titlesGroup = titlesGroup;
    self.cycleScroll.titlesGroup = titlesGroup;
    
}
- (UIImageView *)voiceImageV {

    if (!_voiceImageV) {
        _voiceImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.mj_h, self.mj_h)];
        _voiceImageV.contentMode = UIViewContentModeCenter;
        _voiceImageV.image = [UIImage imageNamed:@"mind_icon_notice_default"];
    }

    return _voiceImageV;
}
- (UIImageView *)right_Arrow {

    if (!_right_Arrow) {
        _right_Arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-self.mj_h - WidthScaleSize_W(20),0, self.mj_h, self.mj_h)];
        _right_Arrow.contentMode = UIViewContentModeCenter;
        _right_Arrow.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _right_Arrow;
}
@end
