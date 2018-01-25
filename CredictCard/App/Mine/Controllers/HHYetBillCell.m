//
//  HHIncomeRecordCell.m
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHYetBillCell.h"

@implementation HHYetBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.Image lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
}
- (void)setModel:(HHPerCenterModel *)model{
    
    _model = model;
    [self.Image sd_setImageWithURL:[NSURL URLWithString:model.Image]];
    self.RepayMoney.text = [NSString stringWithFormat:@"本月应还¥%@",model.RepayMoney];
    self.LastCardNo.text = [NSString stringWithFormat:@"尾号%@",model.LastCardNo];
    self.RepayDate.text = model.RepayDate;

}

@end
