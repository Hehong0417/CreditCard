//
//  AllPlanCell.h
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAllPlanCell : UITableViewCell

//圆点
@property(nonatomic,strong)UIImageView *dot;
//竖线
@property(nonatomic,strong)UILabel *downLineLab;

//刷卡记录
@property(nonatomic,strong)UILabel *cardRecordLab;

//刷卡记录
@property(nonatomic,strong)UILabel *cardRecordLab2;

//完成按钮
@property(nonatomic,strong)UIButton *finishBtn2;

//时间
@property(nonatomic,strong)UILabel *timeLab;

//完成按钮
@property(nonatomic,strong)UIButton *finishBtn;

//
@property(nonatomic,strong)HHHomeModel *model;

@end
