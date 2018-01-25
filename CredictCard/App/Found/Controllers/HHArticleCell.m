//
//  ArticleCell.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHArticleCell.h"

@implementation HHArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self.contentView addSubview:self.ico_ImagV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.articleContentLab];
     
        [self setContrains];
    }
    
    return self;
}
- (void)setContrains{
    
    [self.ico_ImagV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(140);
        
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ico_ImagV.mas_right).with.offset(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);

    }];
    
    [self.articleContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ico_ImagV.mas_right).with.offset(15);
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(5);
        make.right.mas_equalTo(-15); 
        make.height.mas_equalTo(40);
    }];
}
- (UIImageView *)ico_ImagV{
    
    if (!_ico_ImagV) {
        _ico_ImagV = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ico_ImagV.backgroundColor = KVCBackGroundColor;
        _ico_ImagV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _ico_ImagV;
    
}
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLab.textColor = kBlackColor;
        _titleLab.font = BoldFONT(15);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }

    return _titleLab;
}

- (UILabel *)articleContentLab{
    
    if (!_articleContentLab) {
        _articleContentLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _articleContentLab.textColor = kBlackColor;
        _articleContentLab.font = FONT(12);
        _articleContentLab.numberOfLines = 2;
        _articleContentLab.textAlignment = NSTextAlignmentLeft;
    }
    
    return _articleContentLab;
}
@end
