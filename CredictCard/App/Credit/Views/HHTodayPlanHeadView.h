//
//  TodayPlanHeadView.h
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLWaveView.h"

@interface HHTodayPlanHeadView : UIView

//分类图片1
@property(nonatomic,strong)UIImageView *categoryImageV1;
//分类图片2
@property(nonatomic,strong)UIImageView *categoryImageV2;

@property(nonatomic,strong)UILabel *titleLab1;

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,strong)UILabel *titleLab2;

//价格
@property(nonatomic,strong)UILabel *priceLab;
//店铺名称
@property(nonatomic,strong)UILabel *storeNameLab;

@end
