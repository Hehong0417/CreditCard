//
//  HHLoadCell.m
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHLoadCell.h"

@implementation HHLoadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.loadBtn lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    
    [self.iconImage lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
