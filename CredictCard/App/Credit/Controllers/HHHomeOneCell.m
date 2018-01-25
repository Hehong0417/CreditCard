//
//  HXTeacherCenterCell.m
//  mengyaProject
//
//  Created by n on 2017/8/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HHHomeOneCell.h"

@implementation HHHomeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSArray *models = @[@[@"home_icon_cardmarket_default",@"home_icon_loanmarket_default",@"home_icon_live_default"],@[@"home_icon_writings_default",@"home_icon_up_default",@"home_icon_card_default"]];
        NSArray *modelsNames = @[@[@"信用卡超市",@"贷款超市",@"直播现场"],@[@"最新技术",@"一键提额",@"办卡进度"]];
//        CGFloat imagW = (SCREEN_WIDTH)/4 - WidthScaleSize_W(3);
        CGFloat imagW = (SCREEN_WIDTH)/3;
        CGFloat imagH = imagW * 18/25;
//        UIView *line = [UIView lh_viewWithFrame:CGRectMake(0, WidthScaleSize_W(10), SCREEN_WIDTH,WidthScaleSize_W(1)) backColor:KPartingLineColor];
//        [self.contentView addSubview:line];
        
        for (NSInteger i = 0; i < 6; i++) {
           
            NSInteger line = i%3;
            NSInteger row = i/3;
            CGFloat imageX = line*imagW;
            CGFloat imageY = WidthScaleSize_W(10) + row*imagH;
            self.modelBtn = [XYQButton ButtonWithFrame:CGRectMake(imageX, imageY, imagW, imagH) imgaeName:models[row][line] titleName:modelsNames[row][line] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:TitleGrayColor fontsize:WidthScaleSize_H(14)] tapAction:nil];
            [self.modelBtn addTarget:self action:@selector(modelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            self.modelBtn.tag = i+10000;
            self.modelBtn.backgroundColor = kWhiteColor;
            [self.contentView addSubview:self.modelBtn];
            
        }
        
    }

    return self;
}
- (void)modelBtnAction:(UIButton *)btn{
    
    if (self.buttonSelectBlock) {
       
        self.buttonSelectBlock(btn);

    }
}
@end
