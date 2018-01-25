//
//  HHModifyInfoVC.m
//  CredictCard
//
//  Created by User on 2017/12/18.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHModifyInfoVC.h"
#import "HHUserInfoModel.h"
#import "HHWXLoginVC.h"
#import "HHBandPhoneVc.h"

@interface HHModifyInfoVC ()<UITextFieldDelegate>
{
    UITextField * namefield;
    
}
@property (nonatomic, strong)   HHUserInfoModel *userInfoModel;

@end

@implementation HHModifyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改信息";
    
    [self getDatas];
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) backColor:kClearColor];
    
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 50, SCREEN_WIDTH - 60, 45) target:self action:@selector(saveAction) backgroundImage:nil title:@"退出登录"  titleColor:kWhiteColor font:FONT(14)];
    finishBtn.backgroundColor = kRedColor;
    [finishBtn lh_setRadii:5 borderWidth:0 borderColor:nil];
    
    [footView addSubview:finishBtn];
    
    self.tableV.tableFooterView = footView;
    
    
    
}
- (void)getDatas{
    
    [[[HHPerCenterDataAPI getUserInfo] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                
                self.userInfoModel =  [HHUserInfoModel mj_objectWithKeyValues:api.data];
         
                [self.cellHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.Image]];
                
                HJSettingItem *nameItem= [self settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                nameItem.detailTitle = self.userInfoModel.Name;
                
                HJSettingItem *phoneItem= [self settingItemInIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                phoneItem.detailTitle = self.userInfoModel.Phone;
                
                [self.tableV reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                
            }
            
        }else{
            
            NSLog(@"错误信息：%@",error);
        }
        
    }];
    
}
//退出登录
- (void)saveAction{
    
    HJUser *user = [HJUser sharedUser];
    user.token = @"";
    [user write];
    
    [JPUSHService setTags:[NSSet setWithObject:@""] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
        NSLog(@"%d--%@",iResCode,iAlias);
        
    }];
    
    HHWXLoginVC *vc = [[HHWXLoginVC alloc] initWithNibName:@"HHWXLoginVC" bundle:nil];
    kKeyWindow.rootViewController =  [[HJNavigationController alloc] initWithRootViewController:vc];
 
}
#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 15 && range.length!=1){
        textField.text = [toBeString substringToIndex:15];
        return NO;
    }
    
    return YES;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];

            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = self.userInfoModel.Name;
                textField.delegate = self;

            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alert addAction:action1];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                NSArray * textfields = alert.textFields;
                namefield = textfields[0];
                //上传昵称
                if (namefield.text.length == 0) {
                    
                    [SVProgressHUD showInfoWithStatus:@"昵称不能为空"];
                
                }else{
                    [[[HHPerCenterDataAPI postEditUserNameWithName:namefield.text] netWorkClient] postRequestInView:self.view finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {

                        if (!error) {
                            if (api.code == 0) {
                                HJSettingItem *item1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                                item1.detailTitle = namefield.text;
                                [self.tableV reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
                               
                                //修改昵称
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifySuccess object:nil];
                                
                            }else{

                                [SVProgressHUD showInfoWithStatus:api.msg];

                            }
                        }

                    }];
                }

            }];
            [alert addAction:action2];

            [self presentViewController:alert animated:YES completion:nil];

        }else {
          //更换手机
            
            HHBandPhoneVc *vc = [HHBandPhoneVc new];
            vc.titleStr = @"更换手机";
            [self.navigationController pushVC:vc];

        }
    }


}
- (NSArray *)groupTitles{
    
    return @[@[@"头像"],@[@"昵称",@"登录手机号"]];
    
}
- (NSArray *)groupIcons {
    
    return @[@[@""],@[@"",@""],@[@"",@""]];
}
- (NSArray *)groupDetials{
    
    return @[@[@""],@[@"",@"13826424459"]];
    
}
- (NSArray *)indicatorIndexPaths{
    
    NSArray *indexPaths =  @[[NSIndexPath indexPathForRow:0 inSection:1],[NSIndexPath indexPathForRow:1 inSection:1]];
    
    return indexPaths;
    
}
- (NSIndexPath *)headImageCellIndexPath{
    
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return WidthScaleSize_H(75);
    }
    
    return WidthScaleSize_H(44);
    
}
@end
