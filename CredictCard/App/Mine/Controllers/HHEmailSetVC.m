//
//  HHEmailSetVC.m
//  CredictCard
//
//  Created by User on 2017/12/18.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHEmailSetVC.h"
#import "HHEmailSetCell.h"

@interface HHEmailSetVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSArray *placeHolders;
@property (nonatomic, strong)   HHPerCenterModel *model;

@end

@implementation HHEmailSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"智能规划";
    
    //获取邮箱和密码
    [self  getDatas];
    
    [self addTableView];
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) backColor:kClearColor];
    
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 120, SCREEN_WIDTH - 60, 45)  target:self action:@selector(saveAction) backgroundImage:nil title:@"保存" titleColor:kWhiteColor font:FONT(17)];
    finishBtn.backgroundColor = kComm_Color;
    [finishBtn lh_setRadii:5 borderWidth:0 borderColor:nil];
    
    [footView addSubview:finishBtn];
    
    UIButton *finishBtn1 = [UIButton lh_buttonWithFrame:CGRectMake(30, 50, SCREEN_WIDTH - 60, 45) target:self action:@selector(finishBtn1Action) backgroundImage:nil title:@"手动导入" titleColor:kWhiteColor font:FONT(17)];
    finishBtn1.backgroundColor = kComm_Color;
    [finishBtn1 lh_setRadii:5 borderWidth:0 borderColor:nil];
    
    [footView addSubview:finishBtn1];
    
    self.tableView.tableFooterView = footView;
    
    self.placeHolders = @[@"请输入电子邮箱",@"请输入密码或授权码"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHEmailSetCell" bundle:nil] forCellReuseIdentifier:@"HHEmailSetCell"];
    
}
- (void)getDatas{
    
    [[[HHPerCenterDataAPI  GetUserMail] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        if (!error) {
            if (api.code == 0) {

                self.model = [HHPerCenterModel mj_objectWithKeyValues:api.data];
                [self.tableView reloadData];
            }
        }
        
    }];
    
    
}
- (void)saveAction{
    
    HHEmailSetCell *mail = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    HHEmailSetCell *pd = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSString *valid = [self validWithMail:mail.textField.text passWord:pd.textField.text];
    if (!valid) {
        [[[HHPerCenterDataAPI postEditUserMailWitheEmail:mail.textField.text password:pd.textField.text] netWorkClient] postRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
            if (!error) {
                if (api.code == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"邮箱设置成功"];
                    [self.navigationController popVC];
                    
                }
            }
            
        }];
        
    }else{
          [SVProgressHUD showInfoWithStatus:valid];
    }
    
}
- (void)finishBtn1Action{
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];

    HHEmailSetCell *mail = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    HHEmailSetCell *pd = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *valid = [self validWithMail:mail.textField.text passWord:pd.textField.text];
    if (!valid) {
        [[[HHPerCenterDataAPI postEditUserMailWitheEmail:mail.textField.text password:pd.textField.text] netWorkClient] postRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
//            if (!error) {
//                if (api.code == 0) {
                    //导入
                    [[[HHPerCenterDataAPI postCardPlanUserMail] netWorkClient] postRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
                        if (!error) {
                            if (api.code == 0) {
                                [SVProgressHUD showSuccessWithStatus:@"导入成功！"];
                                [self.navigationController popVC];
                            }else{
                                
                                [SVProgressHUD showInfoWithStatus:api.msg];
                            }
                        }else{
                            [SVProgressHUD showInfoWithStatus:api.msg];
                        }
                    }];
                    //////////
//                }else{
//                    [SVProgressHUD showInfoWithStatus:api.msg];
//
//                }
//            }else{
//                [SVProgressHUD showInfoWithStatus:api.msg];
//
//            }
            
        }];
        
    }else{
        [SVProgressHUD showInfoWithStatus:valid];
    }
    

    
}
- (NSString *)validWithMail:(NSString *)mail passWord:(NSString *)pd{
    
    if (mail.length==0) {
        return @"请填写邮箱";
        
    }else if (pd.length == 0){
        return @"请填写密码";

    }else if (pd.length <6){
        return @"密码不能少于6位数！";
    }else if (![mail lh_isValidateEmail]){
        
        return @"邮箱格式不正确！";
        
    } else{
        
        return nil;
    }
    
}
#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    HHEmailSetCell *mail = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    HHEmailSetCell *pd = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (textField == mail.textField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 50 && range.length!=1){
            textField.text = [toBeString substringToIndex:50];
            return NO;
        }
    }else if (textField == pd.textField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 20 && range.length!=1){
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    return YES;
}

- (void)addTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - 64 ;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHEmailSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHEmailSetCell"];
    
    cell.textField.placeholder = self.placeHolders[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
    cell.textField.delegate = self;
    if (indexPath.row == 0) {
        cell.textField.secureTextEntry = NO;
        cell.textField.text =  self.model.Email;
    }else{
        cell.textField.secureTextEntry = YES;
        cell.textField.text =  self.model.Password;

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
@end
