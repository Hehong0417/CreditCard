//
//  HHAddBankVC.m
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAddBankVC.h"
#import "HHBankListVC.h"

@interface HHAddBankVC ()<UITextFieldDelegate>

@property (nonatomic, strong)   UITextField *cardNoTF;
@property (nonatomic, strong)   UITextField *limitTF;
@property (nonatomic, strong)   HXCommonPickView *pickView;
@property (nonatomic, strong)   NSArray *titleArr;
@property (nonatomic, strong)   NSString *bankId;
@property (nonatomic, strong)   NSString *bankName;
@property (nonatomic, strong)   NSString *statementDate;
@property (nonatomic, strong)   NSString *repaymentDate;

@end

@implementation HHAddBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    self.title = @"添加信用卡";
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) backColor:kClearColor];
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 50, SCREEN_WIDTH - 60, 45) target:self action:@selector(addBankAction) backgroundImage:nil title:@"添加信用卡" titleColor:kWhiteColor font:FONT(17)];
    finishBtn.backgroundColor = kComm_Color;
    [finishBtn lh_setRadii:5 borderWidth:0 borderColor:nil];
    
    [footView addSubview:finishBtn];
    self.tableV.tableFooterView = footView;
    
    self.pickView = [[HXCommonPickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.cardNoTF) {
        
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 20 && range.length!=1){
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
        
        
    }else{
        
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 7 && range.length!=1){
            textField.text = [toBeString substringToIndex:7];
            return NO;
        }
        
        
    }
        return YES;
}

- (void)addBankAction{
    
    HJSettingItem *item = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *statementDate = item.detailTitle;
    HJSettingItem *item1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *repaymentDate = item1.detailTitle;
    NSString *overdraftDate = self.limitTF.text;
    
    NSString *valid = [self validWithCardNo:self.cardNoTF.text bankName:self.bankName statementDate:statementDate repaymentDate:repaymentDate overdraft:overdraftDate];
    if (!valid) {
    
        [[[HHFoundDataAPI postAddCardWithCardNo:self.cardNoTF.text brankId:self.bankId statementDate:self.statementDate repaymentDate:self.repaymentDate overdraft:self.limitTF.text] netWorkClient] postRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
            
            if (api.code == 0) {
                
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                if (self.backBlock) {
                    self.backBlock();
                }
                [self.navigationController popVC];
            }
            
        }];
        
    }else{
        
        [SVProgressHUD showInfoWithStatus:valid];
    }
    
}
- (NSString *)validWithCardNo:(NSString *)cardNo bankName:(NSString *)bankName statementDate:(NSString *)statementDate repaymentDate:(NSString *)repaymentDate overdraft:(NSString *)overdraft{
    
    if (cardNo.length == 0) {
        return @"请输入卡号";
    }else if(bankName.length == 0) {
        return @"请选择发卡银行";
    }else if(statementDate.length == 0) {
        return @"请选择账单日";
    }else if(repaymentDate.length == 0) {
        return @"请选择还款日";
    }else if(overdraft.length == 0) {
        return @"请输入额度";
    }else{
        return nil;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        //卡号
        self.cardNoTF = [UITextField lh_textFieldWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-120, 44) placeholder:@"请输入卡号" font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
        self.cardNoTF.keyboardType = UIKeyboardTypeNumberPad;
        self.cardNoTF.delegate = self;
        [cell.contentView addSubview:self.cardNoTF];
        
    }else if(indexPath.row == 4){
        //额度
          self.limitTF = [UITextField lh_textFieldWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-120, 44) placeholder:@"请填写信用卡额度" font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
        self.limitTF.keyboardType = UIKeyboardTypeNumberPad;
        self.limitTF.delegate = self;
        [cell.contentView addSubview:self.limitTF];

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
       //发卡银行
        HHBankListVC *vc = [HHBankListVC new];
        vc.titleStr = @"发卡银行";
        vc.pushType = addBankType;
        WEAK_SELF();
        vc.bankBlock = ^(NSDictionary  *dic) {
            self.bankName = dic[@"Name"];
            self.bankId = dic[@"Id"];
            HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
            item.detailTitle = self.bankName;
            [weakSelf.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushVC:vc];
        
    }else if (indexPath.row == 2) {
       //账单日
        WEAK_SELF();
        [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.titleArr];
        [self.pickView showPickViewAnimation:YES];
        self.pickView.completeBlock = ^(NSString *result) {
            HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
            weakSelf.statementDate = result?result:@"1";
            item.detailTitle = [NSString stringWithFormat:@"%@日",weakSelf.statementDate];
            [weakSelf.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
    }else if (indexPath.row == 3) {
        //还款日
        WEAK_SELF();
        [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.titleArr];
        [self.pickView showPickViewAnimation:YES];
        self.pickView.completeBlock = ^(NSString *result) {
            weakSelf.repaymentDate = result?result:@"1";
            HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
            item.detailTitle = [NSString stringWithFormat:@"%@日",weakSelf.repaymentDate];
            [weakSelf.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    
}
- (NSArray *)indicatorIndexPaths {
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]];
    
    return indexPaths;
}
- (NSArray *)groupTitles{
    
    return @[@[@"卡号",@"选择发卡银行",@"账单日",@"还款日",@"额度"]];
    
}
- (NSArray *)groupIcons {
    
    return @[@[@"",@"",@"",@"",@""]];

}
- (NSArray *)groupDetials{
    
    return @[@[@"",@"",@"",@"",@""]];
}

@end
