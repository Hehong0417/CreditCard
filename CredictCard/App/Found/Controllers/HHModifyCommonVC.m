//
//  HHModifyCommonVC.m
//  CredictCard
//
//  Created by User on 2017/12/27.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHModifyCommonVC.h"

@interface HHModifyCommonVC ()
@property (nonatomic, strong)   UITextField *textFiled;

@end

@implementation HHModifyCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.titleStr;
    
    UIView *bgView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) backColor:kWhiteColor];
    [self.view addSubview:bgView];
    
    self.textFiled = [UITextField lh_textFieldWithFrame:CGRectMake(15, 3, SCREEN_WIDTH-20, 44) placeholder:@"" font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    self.textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [bgView addSubview:self.textFiled];
    
    if ([self.textStr isEqualToString:@"0"]) {
        self.textStr = @"";
    }
    self.textFiled.text = self.textStr;
    
  UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 44) target:self action:@selector(saveAction) image:nil title:@"保存" titleColor:kBlackColor font:FONT(14)];
    
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}
- (void)saveAction{
    
    if ([self.titleStr isEqualToString:@"额度"]) {
        
        [[[HHFoundDataAPI postUpdateCardOverdraftWithCardId:self.cardId overdraft:self.textFiled.text] netWorkClient] postRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
           
            if (!error) {
                if (api.code == 0) {
                    
                    self.modifyBlock(self.textFiled.text);
                    [self.navigationController popVC];
                    
                }else{
                    [SVProgressHUD showInfoWithStatus:api.msg];
                }
            }
        }];
        
    }else if ([self.titleStr isEqualToString:@"本月应还"]){
        
        [[[HHFoundDataAPI postUpdateLastMonthConsumptionWithCardId:self.cardId consumption:self.textFiled.text] netWorkClient] postRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
            
            if (!error) {
                if (api.code == 0) {
                    
                    self.modifyBlock(self.textFiled.text);
                    [self.navigationController popVC];
                }else{
                    [SVProgressHUD showInfoWithStatus:api.msg];
                }
            }
            
        }];
        
    }
    

    
    
}

@end
