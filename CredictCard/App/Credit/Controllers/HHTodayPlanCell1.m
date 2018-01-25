//
//  HHTodayPlanCell1.m
//  CredictCard
//
//  Created by User on 2017/12/22.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTodayPlanCell1.h"

@implementation HHTodayPlanCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self.finishBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    
}
- (void)setModelDic:(NSDictionary *)modelDic{
    
    _modelDic = modelDic;
    
    self.timeLab.text = modelDic[@"RepayDate"];
    NSString *type = modelDic[@"Type"];
    NSString *BussinessTypeName = modelDic[@"BussinessTypeName"];

    if ([type isEqual:@1]) {
        //刷
        self.payLab.text = [NSString stringWithFormat:@"刷 ¥%@",modelDic[@"RepayMoney"]];
        self.payLab.textColor = kComm_Color;
        self.payTypeLab.hidden = NO;
        self.payTypeLab.text = BussinessTypeName;
        self.editBtn.hidden = NO;
        self.repayLab.hidden = YES;

    }else if([type isEqual:@2]){
        //还
        self.repayLab.text = [NSString stringWithFormat:@"还 ¥%@",modelDic[@"RepayMoney"]];
        self.payLab.hidden = YES;
        self.editBtn.hidden = YES;
        self.payTypeLab.hidden = YES;
        self.repayLab.hidden = NO;

    }
//    NSString *Status = modelDic[@"Status"];

//    if ([Status isEqual:@1]) {
//        //未完成
//        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
//        [self.finishBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//        [self.finishBtn lh_setBackgroundColor:kComm_Color forState:UIControlStateNormal];
//        self.finishBtn.userInteractionEnabled = YES;
//
//
//    }else if([Status isEqual:@2]){
//        //已完成
//        [self.finishBtn setTitle:@"已完成" forState:UIControlStateNormal];
//        [self.finishBtn setTitleColor:kComm_Color forState:UIControlStateNormal];
//        self.finishBtn.userInteractionEnabled = NO;
//        [self.finishBtn lh_setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
//    }
    
}

@end
