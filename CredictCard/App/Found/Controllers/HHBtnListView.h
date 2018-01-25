//
//  HHBtnListView.h
//  CredictCard
//
//  Created by User on 2017/12/21.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBtnListView : UIView

@property(nonatomic,strong) XYQButton *modelBtn;

@property(nonatomic,copy) idBlock buttonSelectBlock;

@end
