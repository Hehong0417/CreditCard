//
//  HHTodayPlanCell1.h
//  CredictCard
//
//  Created by User on 2017/12/22.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTodayPlanCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLab;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UILabel *repayLab;

@property (nonatomic, strong)   NSDictionary *modelDic;


@end
