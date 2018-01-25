//
//  LoginVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHLoginVC.h"
#import "HHRegisterVC.h"

@interface HHLoginVC ()
//背景图
@property(nonatomic,strong)UIImageView *backImageV;

//登录
@property(nonatomic,strong)UIButton *loginBtn;

//立即注册
@property(nonatomic,strong)UIButton *registerBtn;
//忘记密码
@property(nonatomic,strong)UIButton *forgetPdBtn;
//用户名
@property(nonatomic,strong)UITextField *accontTf;
//密码
@property(nonatomic,strong)UITextField *pdTf;
//邀请码
@property(nonatomic,strong)UITextField *invitCodeTf;
//
@property(nonatomic,strong)UIView *bgSubView;

//
@property(nonatomic,strong) UIImageView *headImagV;

@end

@implementation HHLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;
    
    self.headImagV = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(232)) image:[UIImage imageNamed:@"bg_home_login"]];
    [self.view addSubview:self.headImagV];
    
    //背景图
    self.bgSubView = [[UIView alloc]initWithFrame:CGRectMake(WidthScaleSize_W(30), CGRectGetMaxY(self.headImagV.frame)-WidthScaleSize_H(15), SCREEN_WIDTH - WidthScaleSize_W(60), SCREEN_HEIGHT-WidthScaleSize_H(232)+WidthScaleSize_H(15)-WidthScaleSize_H(65))];
    self.bgSubView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.bgSubView];
    //加阴影
    [self.view addShadowToView:self.bgSubView withOpacity:0.8 shadowRadius:10 andCornerRadius:10 shadowColor:kComm_Color];

    [self.registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPdBtn addTarget:self action:@selector(forgetPdBtnAction) forControlEvents:UIControlEventTouchUpInside];

    //
    [self.bgSubView addSubview:self.accontTf];
    [self.bgSubView addSubview:self.pdTf];
    [self.bgSubView addSubview:self.invitCodeTf];
    [self.bgSubView addSubview:self.loginBtn];
    [self.bgSubView addSubview:self.registerBtn];
    [self.bgSubView addSubview:self.forgetPdBtn];

    [self setContrain];
    
}
- (void)setContrain{
    
    [self.accontTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgSubView).with.offset(62);
        make.left.equalTo(self.bgSubView).with.offset(45);
        make.right.equalTo(self.bgSubView).with.offset(-45);
        make.height.mas_equalTo(25);
    }];
    UIView *down1 = [[UIView alloc] init];
    down1.backgroundColor = LineLightColor;
    [self.bgSubView addSubview:down1];
    [down1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accontTf.mas_bottom).with.offset(5);
        make.left.equalTo(self.accontTf.mas_left);
        make.right.equalTo(self.accontTf.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    [self.pdTf mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(down1.mas_bottom).with.offset(30);
        make.left.equalTo(self.accontTf.mas_left);
        make.right.equalTo(self.accontTf.mas_right);
        make.height.mas_equalTo(25);

    }];
    
    UIView *down2 = [[UIView alloc] init];
    down2.backgroundColor = LineLightColor;
    [self.bgSubView addSubview:down2];
    [down2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.pdTf.mas_bottom).with.offset(5);
        make.left.equalTo(self.pdTf.mas_left);
        make.right.equalTo(self.pdTf.mas_right);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.invitCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(down2.mas_bottom).with.offset(30);
        make.left.equalTo(self.accontTf.mas_left);
        make.right.equalTo(self.accontTf.mas_right);
        make.height.mas_equalTo(25);

    }];
    
    UIView *down3 = [[UIView alloc] init];
    down3.backgroundColor = LineLightColor;
    [self.bgSubView addSubview:down3];
    [down3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.invitCodeTf.mas_bottom).with.offset(5);
        make.left.equalTo(self.accontTf.mas_left);
        make.right.equalTo(self.accontTf.mas_right);
        make.height.mas_equalTo(1);

    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(down3.mas_bottom).with.offset(36);
        make.left.equalTo(self.bgSubView).with.offset(30);
        make.right.equalTo(self.bgSubView).with.offset(-30);
        make.height.mas_equalTo(50);

    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgSubView.mas_bottom).with.offset(-20);
        make.width.mas_equalTo(60);
        make.left.equalTo(self.bgSubView).with.offset(25);
        make.height.mas_equalTo(10);
    }];
    [self.forgetPdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgSubView.mas_bottom).with.offset(-20);
        make.right.equalTo(self.bgSubView).with.offset(-25);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(10);
    }];
}
- (void)registerBtnAction{
    
    HHRegisterVC *vc = [[HHRegisterVC alloc] init];
    [self.navigationController pushVC:vc];
    
}
- (void)loginBtnAction{
    
    
}
- (void)forgetPdBtnAction{
    

    
}
// 登录
- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_loginBtn lh_setBackgroundColor:kComm_Color forState:UIControlStateNormal];
        [_loginBtn addShadowToView:_loginBtn withOpacity:0.8 shadowRadius:10 andCornerRadius:11 shadowColor:kComm_Color];
        
    }
    return _loginBtn;
}
//注册
- (UIButton *)registerBtn{
    
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = FONT(12);
        [_registerBtn setTitleColor:KACLabelColor forState:UIControlStateNormal];
        
    }
    return _registerBtn;
}
- (UIButton *)forgetPdBtn{
    
    if (!_forgetPdBtn) {
        _forgetPdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPdBtn.titleLabel.font = FONT(12);
        [_forgetPdBtn setTitleColor:KACLabelColor forState:UIControlStateNormal];
    }
    return _forgetPdBtn;
}

- (UITextField *)accontTf{
    if (!_accontTf) {
        _accontTf = [[UITextField alloc]initWithFrame:CGRectZero];
        _accontTf.borderStyle = UITextBorderStyleNone;
        _accontTf.placeholder = @"请输入用户名/手机号";
    }
    return _accontTf;
}
- (UITextField *)pdTf{
    
    if (!_pdTf) {
        _pdTf = [[UITextField alloc]initWithFrame:CGRectZero];
        _pdTf.borderStyle = UITextBorderStyleNone;
        _pdTf.placeholder = @"请输入密码";
    }
    return _pdTf;
    
}
- (UITextField *)invitCodeTf{
    
    if (!_invitCodeTf) {
        _invitCodeTf = [[UITextField alloc]initWithFrame:CGRectZero];
        _invitCodeTf.borderStyle = UITextBorderStyleNone;
        _invitCodeTf.placeholder = @"邀请码（选填）";
    }
    return _invitCodeTf;
    
}

@end
