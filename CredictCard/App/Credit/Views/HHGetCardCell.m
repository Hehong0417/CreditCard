//
//  GetCardCell.m
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHGetCardCell.h"
#import "HHBankListVC.h"

@implementation HHGetCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.historyPriceBtn];
        [self.contentView addSubview:self.canWithDrawPriceBtn];
        
        [self.historyPriceBtn addTarget:self action:@selector(getCardAction) forControlEvents:UIControlEventTouchUpInside];
        
         [self.canWithDrawPriceBtn addTarget:self action:@selector(loansAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self setContrains];

    }
    
    return self;
}
- (void)getCardAction{
    
    HHBankListVC *vc = [HHBankListVC new];
    vc.titleStr = @"办卡";
    [self.nav pushVC:vc];
    
}
- (void)loansAction{
    
    HHBankListVC *vc = [HHBankListVC new];
    vc.titleStr = @"贷款";
    [self.nav pushVC:vc];
    
}
- (void)setContrains{
    
    [self.historyPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        CGFloat h = SCREEN_WIDTH/2;
        make.height.mas_equalTo(h);
        CGFloat w = SCREEN_WIDTH/2;
        make.width.mas_equalTo(w);
        make.centerY.equalTo(self);
    }];
    [self.canWithDrawPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.historyPriceBtn.mas_height);
        make.left.equalTo(self.historyPriceBtn.mas_right);
        make.top.mas_equalTo(0);
        CGFloat w = SCREEN_WIDTH/2;
        make.width.mas_equalTo(w);
        make.centerY.equalTo(self);
    }];
}
// 办卡
- (UIButton *)historyPriceBtn{
    
    if (!_historyPriceBtn) {
        _historyPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyPriceBtn setImage:[UIImage imageNamed:@"img_home_card"] forState: UIControlStateNormal];
    }
    return _historyPriceBtn;
}
//贷款
- (UIButton *)canWithDrawPriceBtn{
    
    if (!_canWithDrawPriceBtn) {
        _canWithDrawPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_canWithDrawPriceBtn setImage:[UIImage imageNamed:@"img_home_loan"] forState: UIControlStateNormal];

    }
    return _canWithDrawPriceBtn;
}
@end
