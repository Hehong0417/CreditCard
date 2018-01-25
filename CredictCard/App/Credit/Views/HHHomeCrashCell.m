//
//  HomeCrashCell.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHHomeCrashCell.h"

@implementation HHHomeCrashCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.backImageV];
        [self.contentView addSubview:self.historyPriceBtn];
        [self.contentView addSubview:self.canWithDrawPriceBtn];
        self.historyPriceLab.text = @"¥8888";
        [self.contentView addSubview:self.historyPriceLab];
        self.canWithDrawPriceLab.text = @"¥8888";
        [self.contentView addSubview:self.canWithDrawPriceLab];
        
        [self setContrains];
        
    }
    return self;
}
- (void)setContrains{
    
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self).mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];


}
- (UIImageView *)backImageV{
    
    if (!_backImageV) {
        _backImageV = [[UIImageView alloc]init];
        _backImageV.backgroundColor = kComm_Color;
        _backImageV.image = [UIImage imageNamed:@"banner_bg_home_bg"];
        _backImageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageV;
    
}

- (UILabel *)historyPriceLab{
    
    if (!_historyPriceLab) {
        _historyPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.historyPriceBtn.frame), SCREEN_WIDTH/2, WidthScaleSize_H(30))];
        _historyPriceLab.textColor = kWhiteColor;
        _historyPriceLab.font = BoldFONT(24);
        _historyPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _historyPriceLab;
}
- (UILabel *)canWithDrawPriceLab{
    
    if (!_canWithDrawPriceLab) {
        _canWithDrawPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(self.canWithDrawPriceBtn.frame), SCREEN_WIDTH/2, WidthScaleSize_H(30))];
        _canWithDrawPriceLab.textColor = kWhiteColor;
        _canWithDrawPriceLab.font = BoldFONT(24);
        _canWithDrawPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _canWithDrawPriceLab;
}
- (XYQButton *)historyPriceBtn{
   
    if (!_historyPriceBtn) {
        _historyPriceBtn = [XYQButton ButtonWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/2, WidthScaleSize_H(165)*2/3) imgaeName:@"icon_home_history" titleName:@" 历史佣金" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize: WidthScaleSize_H(15)] tapAction:^(XYQButton *button) {
            
        }];
        _historyPriceBtn.titleLabel.font = BoldFONT(15);
    }
    return _historyPriceBtn;
}
- (XYQButton *)canWithDrawPriceBtn{
    
    if (!_canWithDrawPriceBtn) {
        _canWithDrawPriceBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH/2, 0,SCREEN_WIDTH/2, WidthScaleSize_H(165)*2/3) imgaeName:@"icon_home_money" titleName:@"可提现佣金" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kWhiteColor fontsize: WidthScaleSize_H(15)] tapAction:^(XYQButton *button) {
            
        }];
        _canWithDrawPriceBtn.titleLabel.font = BoldFONT(15);

    }
    return _canWithDrawPriceBtn;
}

@end
