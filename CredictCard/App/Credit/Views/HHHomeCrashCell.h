//
//  HomeCrashCell.h
//  CredictCard
//
//  Created by User on 2017/12/14.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHomeCrashCell : UITableViewCell

//背景图
@property(nonatomic,strong)UIImageView *backImageV;

//历史佣金按钮
@property(nonatomic,strong)XYQButton *historyPriceBtn;
//可提现佣金按钮
@property(nonatomic,strong)XYQButton *canWithDrawPriceBtn;

//历史佣金
@property(nonatomic,strong)UILabel *historyPriceLab;
//可提现佣金
@property(nonatomic,strong)UILabel *canWithDrawPriceLab;


@end
