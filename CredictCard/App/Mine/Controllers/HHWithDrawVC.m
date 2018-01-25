//
//  WithDrawVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHWithDrawVC.h"

@interface HHWithDrawVC ()<UITextFieldDelegate>
@property (nonatomic, strong)   UITextField *tF;
@end

@implementation HHWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KVCBackGroundColor;
    self.title = @"提现";
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = kWhiteColor;
    [self.view addSubview:bgView];
    
    self.tF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 50)];
    self.tF.keyboardType = UIKeyboardTypeNumberPad;
    self.tF.placeholder = @"输入提现金额";
    self.tF.delegate = self;
    [bgView addSubview:self.tF];
    
    XYQButton *tipBtn  = [XYQButton ButtonWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), SCREEN_WIDTH, 40) imgaeName:@"mind_icon_notice_default" titleName:@"提示：72小时内到账，遇节假日延后" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:KACLabelColor fontsize:12] tapAction:nil];
    [self.view addSubview:tipBtn];
    
    UIButton *withDrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawBtn.frame = CGRectMake(WidthScaleSize_W(30), CGRectGetMaxY(tipBtn.frame)+20, SCREEN_WIDTH - WidthScaleSize_W(60), WidthScaleSize_H(40));
    [withDrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [withDrawBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [withDrawBtn lh_setBackgroundColor:kComm_Color forState:UIControlStateNormal];
    [withDrawBtn lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    [withDrawBtn addTarget:self action:@selector(withDrawAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withDrawBtn];
    
}
#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 11 && range.length!=1){
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
   
    return YES;
}

- (void)withDrawAction{
    
    
    
    if (self.tF.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入提现金额"];
        
    }else{
        CGFloat money  = self.tF.text.floatValue;
        
        if (money<=10000000) {
            if (money<0) {
                
                [SVProgressHUD showInfoWithStatus:@"提现金额不能低于0"];

            }else  if (money==0){
                
                [SVProgressHUD showInfoWithStatus:@"提现金额不能等于0"];

            } else{
                
            [[[HHPerCenterDataAPI postUserWithdrawalsWithMoney:self.tF.text] netWorkClient] postRequestInView:self.view finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
                
                if (!error) {
                    if (api.code == 0) {
                        
                        [self.navigationController popVC];
                        [SVProgressHUD showSuccessWithStatus:@"申请成功！"];
                        
                    }else{
                        
                        [SVProgressHUD showInfoWithStatus:api.msg];
                        
                    }
                }
                
            }];
                }
        }else {
            
            [SVProgressHUD showInfoWithStatus:@"提现金额不能大于10000000"];

        }
        
      
    }
    
}

@end
