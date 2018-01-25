//
//  HHBankListCell.m
//  CredictCard
//
//  Created by User on 2017/12/30.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHBankListCell.h"

@implementation HHBankListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.iconImgV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
