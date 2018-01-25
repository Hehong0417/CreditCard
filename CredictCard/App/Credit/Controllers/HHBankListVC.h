//
//  BankListVC.h
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    addBankType,
    getBankCardType,
} pushType;

@interface HHBankListVC : UIViewController

@property(nonatomic,strong)   NSString *titleStr;
@property(nonatomic,copy)   idBlock  bankBlock;
@property(nonatomic,assign)   pushType  pushType;

@end
