//
//  HXTableViewHead.m
//  mengyaProject
//
//  Created by n on 2017/8/5.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXTableViewHead.h"

@implementation HXTableViewHead

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self =[super initWithFrame:frame]) {
        //分类图片
        self.categoryImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 4, 15)];
        self.categoryImageV.contentMode = UIViewContentModeLeft;
        self.categoryImageV.backgroundColor = kComm_Color;
        self.categoryImageV.centerY = self.centerY;
        [self addSubview:self.categoryImageV];
        //标题
        self.headTitleLab = [[UILabel alloc]init];
        self.headTitleLab.textColor = kBlackColor;
        self.headTitleLab.textAlignment = NSTextAlignmentLeft;
        self.headTitleLab.font = FONT(14);
        
        [self addSubview:self.headTitleLab];
        //描述
        self.discribLab = [[UILabel alloc]init];
        self.discribLab.textColor = RGB(186, 186, 186);
        self.discribLab.font = FONT(12);
        self.discribLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.discribLab];
        
    }
    
    return self;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.categoryImageV.image = [UIImage imageNamed:_imageName];
}
- (void)setHeadtitle:(NSString *)headtitle {
    _headtitle = headtitle;
    CGSize nameSize = [self.headtitle lh_sizeWithFont:[UIFont systemFontOfSize:self.labFont] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 25)];
    self.headTitleLab.frame = CGRectMake(CGRectGetMaxX(self.categoryImageV.frame)+8, 0, nameSize.width+5, 35);
    self.headTitleLab.text = _headtitle;
}
- (void)setDiscribText:(NSString *)discribText {
    
    _discribText = discribText;
    
}
- (void)setHeadtitleFrame:(CGRect)headtitleFrame {
    
    _headtitleFrame = headtitleFrame;
    
}
-(void)setRightImageName:(NSString *)rightImageName {
    
    _rightImageName = rightImageName;
    
}
- (void)setRightBtn_W:(CGFloat)rightBtn_W{
    
    _rightBtn_W = rightBtn_W;

}

- (void)layoutSubviews {
    
    XYQButton *changeBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - self.rightBtn_W, 2, self.rightBtn_W, self.frame.size.height-2) imgaeName:self.rightImageName titleName:self.rightBtnTitle contentType:self.contentType buttonFontAttributes:self.btnFontAttributes tapAction:^(XYQButton *button) {
        
        
    }];
    changeBtn.enabled = NO;
    [self addSubview:changeBtn];
    
    self.headTitleLab.frame = self.headtitleFrame;
    
}

@end
