//
//  TeamCell.m
//  CredictCard
//
//  Created by User on 2017/12/16.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTeamCell.h"

@implementation HHTeamCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel.text = @"ID:123456";
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.title2Label];
        [self.contentView addSubview:self.iconImagV];
        
        [self.iconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    }
    return self;
    
}
- (void)setModel:(HHPerCenterModel *)model{
    
    _model = model;
    
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.Image)]];
    self.nameLabel.text = model.Name;
    self.titleLabel.text = [NSString stringWithFormat:@"ID:%@",model.Id];
    self.title2Label.text = model.CreateDate;
    
}
//姓名
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImagV.frame)+10, self.iconImagV.mj_y+5, WidthScaleSize_W(200), WidthScaleSize_H(15))];
        _nameLabel.textColor = kBlackColor;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = FONT(15);
    }
    return _nameLabel;
    
}
//标题1
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.mj_x, CGRectGetMaxY(self.nameLabel.frame)+5, WidthScaleSize_W(200), WidthScaleSize_H(15))];
        _titleLabel.textColor = KACLabelColor;
        _titleLabel.text = @"";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = FONT(14);
    }
    return _titleLabel;
    
}
//时间
- (UILabel *)title2Label {
    if (!_title2Label) {
        _title2Label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, self.contentView.centerY, 100, WidthScaleSize_H(15))];
        _title2Label.textColor = KACLabelColor;
        _title2Label.text = @"2017-12-16";
        _title2Label.textAlignment = NSTextAlignmentRight;
        _title2Label.font = FONT(12);
    }
    return _title2Label;
    
}
//用户头像
- (UIImageView *)iconImagV {
    
    if (!_iconImagV) {
        _iconImagV = [[UIImageView alloc]initWithFrame:CGRectMake(WidthScaleSize_W(20), WidthScaleSize_H(5), WidthScaleSize_W(50), WidthScaleSize_W(50))];
        _iconImagV.backgroundColor = KVCBackGroundColor;
        [_iconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
    }
    return _iconImagV;
    
}

@end
