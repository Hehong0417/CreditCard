//
//  HHIncomeRecordCell.h
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHYetBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *RepayMoney;
@property (weak, nonatomic) IBOutlet UILabel *LastCardNo;
@property (weak, nonatomic) IBOutlet UILabel *RepayDate;

@property (nonatomic, strong)   HHPerCenterModel *model;

@end
