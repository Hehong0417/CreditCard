//
//  HHBtnListView.m
//  CredictCard
//
//  Created by User on 2017/12/21.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHBtnListView.h"

@implementation HHBtnListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *models = @[@[@"find_icon_bonus_default",@"find_icon_mailbox_default",@"find_icon_idcard_default"],@[@"find_icon_mcc_default",@"find_icon_credit_default",@"find_icon_net_default"]];
        NSArray *modelsNames = @[@[@"公积金查询",@"智能规划",@"身份证挂失"],@[@"MCC码查询",@"征信查询",@"网贷数据"]];
        //CGFloat imagW = (SCREEN_WIDTH)/4 - WidthScaleSize_W(3);
        CGFloat imagW = (SCREEN_WIDTH)/3;
//        CGFloat imagH = imagW * 18/25;
        CGFloat imagH = self.mj_h/2;

        //        UIView *line = [UIView lh_viewWithFrame:CGRectMake(0, WidthScaleSize_W(10), SCREEN_WIDTH,WidthScaleSize_W(1)) backColor:KPartingLineColor];
        //        [self.contentView addSubview:line];
        
        for (NSInteger i = 0; i < 6; i++) {
            
            NSInteger line = i%3;
            NSInteger row = i/3;
            CGFloat imageX = line*imagW;
            CGFloat imageY = row*imagH +WidthScaleSize_H(10);
            self.modelBtn = [XYQButton ButtonWithFrame:CGRectMake(imageX, imageY, imagW, imagH) imgaeName:models[row][line] titleName:modelsNames[row][line] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:TitleGrayColor fontsize:WidthScaleSize_H(14)] tapAction:^(XYQButton *button) {
                
                if (self.buttonSelectBlock) {
                    self.buttonSelectBlock(button);
                }
            }];
            self.modelBtn.tag = i+1000;
            self.modelBtn.backgroundColor = kWhiteColor;
            self.backgroundColor = kWhiteColor;
            [self addSubview:self.modelBtn];
        }
    }
    
    return self;
}

@end
