//
//  HHTeamSalesCell.h
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTeamSalesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *TypeName;
@property (weak, nonatomic) IBOutlet UILabel *Commission;
@property (weak, nonatomic) IBOutlet UILabel *CreateDate;

@property(nonatomic,strong) HHPerCenterModel *model;

@end
