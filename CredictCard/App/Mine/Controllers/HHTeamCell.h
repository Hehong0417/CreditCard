//
//  TeamCell.h
//  CredictCard
//
//  Created by User on 2017/12/16.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTeamCell : UITableViewCell

@property(nonatomic,strong) UIImageView *iconImagV;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *title2Label;

@property(nonatomic,strong) HHPerCenterModel *model;

@end
