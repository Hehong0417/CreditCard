//
//  HHTeamSalesCell.m
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTeamSalesCell.h"

@implementation HHTeamSalesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.Image lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(HHPerCenterModel *)model{
    
    _model = model;
    [self.Image sd_setImageWithURL:[NSURL URLWithString:model.Image]];
    self.Name.text = model.Name;
    self.TypeName.text = model.TypeName;
    self.CreateDate.text = model.CreateDate;
    self.Commission.text = [NSString stringWithFormat:@"¥%@",model.Commission];

}
@end
