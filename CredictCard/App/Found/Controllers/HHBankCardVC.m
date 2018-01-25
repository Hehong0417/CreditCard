//
//  HHBankCardVC.m
//  CredictCard
//
//  Created by User on 2017/12/23.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHBankCardVC.h"
#import "HHModifyCommonVC.h"
#import "HHcardModel.h"

@interface HHBankCardVC ()
@property (nonatomic, strong)   HXCommonPickView *pickView;
@property (nonatomic, strong)   NSArray *titleArr;
@property (nonatomic, strong)   HHcardModel *data;
@property (nonatomic, strong)   BaseCache *yyCache;

@end

@implementation HHBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\
    
    self.titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    //获取数据
    [self getDatas];
    
    self.title = [NSString stringWithFormat:@"%@卡",self.bankName];
    self.pickView = [[HXCommonPickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

}
- (void)getDatas{
    
   
    /////////////
    NetworkClient *netWorkClient  = [[HHHomeDataAPI getCardaInfoByCardId:self.cardId] netWorkClient];
    
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, globalQueue, ^{
        
        netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
        
        [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                
                if (api.code == 0) {
                    self.data = [HHcardModel mj_objectWithKeyValues:api.data];
                    //更新数据
                    [self setItemDataWithData:self.data];

                    dispatch_semaphore_signal(semaphore);
                }else{
                    [SVProgressHUD showInfoWithStatus:api.msg];
                }
                
            }else{
                
                if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]||[error.localizedDescription  containsString:@"请求超时"]) {
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD showInfoWithStatus:@"网络竟然崩溃了～"];
                    
                }
            }
        }];
        
    });
    
    dispatch_group_notify(group, globalQueue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            
            [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
                
                if (!error) {
                    
                    if (api.code == 0) {
                        self.data = [HHcardModel mj_objectWithKeyValues:api.data];
                         //更新数据
                        [self setItemDataWithData:self.data];
                      
                    }else{
                        [SVProgressHUD showInfoWithStatus:api.msg];
                    }
                    
                }else{
                    
                    if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]||[error.localizedDescription  containsString:@"请求超时"]) {
                        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                        [SVProgressHUD showInfoWithStatus:@"网络竟然崩溃了～"];
                        
                    }
                }
            }];
            
        });
        
    });
}
- (void)setItemDataWithData:(HHcardModel *)data{
    
    HJSettingItem *item0 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    item0.detailTitle = data.CradNo;
    HJSettingItem *item1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    item1.detailTitle =  [NSString stringWithFormat:@"%@日",data.StatementDate];
    HJSettingItem *item2 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    item2.detailTitle = [NSString stringWithFormat:@"%@日",data.RepaymentDate];
    HJSettingItem *item3 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    item3.detailTitle =  [NSString stringWithFormat:@"%@",data.Overdraft];
    HJSettingItem *item4 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    item4.detailTitle = [NSString stringWithFormat:@"%@",data.RepayMoney];
    [self.tableV reloadData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    if (indexPath.row == 1) {
        //账单日
        WEAK_SELF();
        [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.titleArr];
        [self.pickView showPickViewAnimation:YES];
        self.pickView.completeBlock = ^(NSString *result) {
            HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
            NSString *statementDate = [NSString stringWithFormat:@"%@日",result];

        //修改
            [[[HHFoundDataAPI postUpdateStatementDateWithCardId:weakSelf.cardId statementDate:result] netWorkClient] postRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
                if (!error) {
                    if (api.code == 0) {
                        
                        item.detailTitle = statementDate;
                        [weakSelf.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
        };
        
    }else  if (indexPath.row == 2) {
        //还款日
        WEAK_SELF();
        [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.titleArr];
        [self.pickView showPickViewAnimation:YES];
        self.pickView.completeBlock = ^(NSString *result) {
            HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
            NSString *repaymentDate = [NSString stringWithFormat:@"%@日",result];
            //修改
            [[[HHFoundDataAPI postUpdateRepaymentDateWithCardId:weakSelf.cardId repaymentDate:result] netWorkClient] postRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
                if (!error) {
                    if (api.code == 0) {
                        item.detailTitle = repaymentDate;
                        [weakSelf.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }];
        };
    }else  if (indexPath.row == 3) {
        //额度
        WEAK_SELF();
        HHModifyCommonVC *vc = [HHModifyCommonVC new];
        vc.titleStr = @"额度";
        vc.textStr = [NSString stringWithFormat:@"%@",self.data.Overdraft];
        vc.cardId = self.cardId;
        vc.modifyBlock = ^(NSString  *overdraft) {
             HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
             item.detailTitle = overdraft;
        [self.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushVC:vc];
        
    }else  if (indexPath.row == 4) {
        //本月应还
        WEAK_SELF();
        HHModifyCommonVC *vc = [HHModifyCommonVC new];
        vc.titleStr = @"本月应还";
         HJSettingItem *item = [weakSelf settingItemInIndexPath:indexPath];
        vc.textStr = item.detailTitle;
        vc.cardId = self.cardId;
        vc.modifyBlock = ^(NSString  *repayMoney) {
            item.detailTitle = repayMoney;
        [self.tableV reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushVC:vc];
    }else  if (indexPath.row == 5) {
        //手动还款
        [self returnCard];
        
        
    }else  if (indexPath.row == 6) {
        //临时额度
        [self addCardMoney];
    }
    
}
- (void)returnCard{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"手动还款" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入手动还款额度";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
//        textField.text = self.userInfoModel.Name;
//        textField.delegate = self;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"还款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        NSArray * textfields = alert.textFields;
//        namefield = textfields[0];
        //上传昵称
//        if (namefield.text.length == 0) {
//
//            [SVProgressHUD showInfoWithStatus:@"昵称不能为空"];
//
//        }else{
//
//        }
        
    }];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
- (void)addCardMoney{
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"临时额度" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.placeholder = @"请输入本月临时额度";

        //        textField.text = self.userInfoModel.Name;
        //        textField.delegate = self;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"新增" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        NSArray * textfields = alert.textFields;
        //        namefield = textfields[0];
        //上传昵称
        //        if (namefield.text.length == 0) {
        //
        //            [SVProgressHUD showInfoWithStatus:@"昵称不能为空"];
        //
        //        }else{
        //
        //        }
        
    }];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
- (NSArray *)indicatorIndexPaths{
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0],[NSIndexPath indexPathForRow:5 inSection:0],[NSIndexPath indexPathForRow:6 inSection:0]];
    
    return indexPaths;
}
- (NSArray *)groupTitles{
    
    return @[@[@"卡号",@"账单日",@"还款日",@"额度",@"本月应还",@"手动还款",@"临时额度"]];
    
}
- (NSArray *)groupIcons {
    
    return @[@[@"",@"",@"",@"",@"",@"",@""]];
    
}
- (NSArray *)groupDetials{
    
    return @[@[@"",@"",@"",@"",@"",@"请输入手动还款额度",@"请输入本月临时额度"]];
}

@end
