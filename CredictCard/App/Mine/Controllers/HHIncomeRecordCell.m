//
//  HHIncomeRecordCell.m
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHIncomeRecordCell.h"

@implementation HHIncomeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HHPerCenterModel *)model{
    _model = model;
    
    self.CreateDate.text = model.CreateDate;
    self.TypeName.text = model.TypeName;
    self.Commission.text = [NSString stringWithFormat:@"¥%@",model.Commission];
    
}

@end
