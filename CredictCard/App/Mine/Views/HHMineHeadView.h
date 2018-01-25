//
//  HXMineHeadView.h
//  mengyaProject
//
//  Created by n on 2017/6/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHMineHeadView : UIView

@property(nonatomic,strong) UIImageView *teacherImageIcon;

@property(nonatomic,strong) UILabel *nameLabel;

//账单底图
@property(nonatomic,strong) UIView *billBottomView;

//登录后底视图
@property(nonatomic,strong) UIView *loginContentView;


@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *title2Label;

@property(nonatomic,strong) UIButton *regAndLoginBtn;

@property(nonatomic,strong) UIButton *exitBtn;

//@property(nonatomic,assign) NSInteger stateNum;


@property(nonatomic,strong) UINavigationController *nav;


@property (nonatomic, strong)   HHCommentSection *section;

@end

