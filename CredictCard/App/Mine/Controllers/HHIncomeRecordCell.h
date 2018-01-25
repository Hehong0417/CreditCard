//
//  HHIncomeRecordCell.h
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHIncomeRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CreateDate;
@property (weak, nonatomic) IBOutlet UILabel *TypeName;
@property (weak, nonatomic) IBOutlet UILabel *Commission;
@property (nonatomic, strong)   HHPerCenterModel *model;

@end
