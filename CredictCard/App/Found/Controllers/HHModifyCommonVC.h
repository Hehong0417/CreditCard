//
//  HHModifyCommonVC.h
//  CredictCard
//
//  Created by User on 2017/12/27.
//  Copyright © 2017年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHModifyCommonVC : UIViewController
@property (nonatomic, strong)   NSString *titleStr;
@property (nonatomic, strong)   NSString *textStr;
@property (nonatomic, copy)   idBlock  modifyBlock;
@property (nonatomic, strong)   NSString *cardId;

@end
