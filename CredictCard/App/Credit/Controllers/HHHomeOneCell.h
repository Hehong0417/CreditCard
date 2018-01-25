//
//  HXTeacherCenterCell.h
//  mengyaProject
//
//  Created by n on 2017/8/8.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHomeOneCell : UITableViewCell

@property(nonatomic,strong) XYQButton *modelBtn;

@property(nonatomic,copy) idBlock buttonSelectBlock;

@property(nonatomic,strong) UINavigationController *nav;

@end
