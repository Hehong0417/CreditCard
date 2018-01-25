//
//  PersenCenterVC.m
//  CredictCard
//
//  Created by User on 2017/12/12.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHPersenCenterVC.h"
#import "HHMineHeadView.h"
#import "HHYetBillVC.h"
#import "HHTeamListVC.h"
#import "HHEmailSetVC.h"
#import "HHModifyInfoVC.h"
#import "HHUserInfoModel.h"
#import "HHMyPosterVC.h"
#import "HHTeamSalesVC.h"
#import "HHIncomeRecordVC.h"

@interface HHPersenCenterVC ()
@property(nonatomic,strong) HHMineHeadView *mineHeadView;
@property (nonatomic, strong)   HHCommentSection *section;
@property(nonatomic,strong) UIButton *exitBtn;
@property (nonatomic, strong)   HHUserInfoModel *userInfoModel;

@end

@implementation HHPersenCenterVC

- (void)acceptNotice:(NSNotification *)noti{
    
    [self GetUserInfo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.backgroundColor = kComm_Color;
    [self.view addSubview:nav];
    
    [nav addSubview:self.exitBtn];
    
    UILabel *qestionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    qestionTitle.text = @"我的";
    qestionTitle.font = FONT(20);
    
    qestionTitle.textAlignment = NSTextAlignmentCenter;
    qestionTitle.textColor = kWhiteColor;
    [nav addSubview:qestionTitle];
    
    self.tableV.mj_y = 64;
    self.mineHeadView.nav = self.navigationController;
    self.mineHeadView.teacherImageIcon.userInteractionEnabled = YES;
    [self.mineHeadView.teacherImageIcon setTapActionWithBlock:^{
      
    }];
    
    self.tableV.tableHeaderView = self.mineHeadView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotice:) name:kNotificationModifySuccess object:nil];

    
    [self GetUserInfo];
    
    
    [self addHeadRefresh];
}

- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetUserInfo];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableV.mj_header = refreshHeader;
    
}

- (void)GetUserInfo{
    
    NetworkClient *netWorkClient  = [[HHPerCenterDataAPI getUserInfo] netWorkClient];
    
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, globalQueue, ^{
        
        netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
        
        [netWorkClient getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
            
            if ([self.tableV.mj_header isRefreshing]) {
                [self.tableV.mj_header endRefreshing];
            }
            
            if (!error) {
                
                if (api.code == 0) {
                    
                    self.userInfoModel =  [HHUserInfoModel mj_objectWithKeyValues:api.data];
                    
                    [self updateUserInfo];
                    dispatch_semaphore_signal(semaphore);
                    
                }else {
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
            
            netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
            
            [netWorkClient getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
                
                if ([self.tableV.mj_header isRefreshing]) {
                    [self.tableV.mj_header endRefreshing];
                }
                if (!error) {
                    
                    if (api.code == 0) {
                        
                        self.userInfoModel =  [HHUserInfoModel mj_objectWithKeyValues:api.data];
                        
                        [self updateUserInfo];
                        
                    }else {
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
    //////
   
    
}
- (void)updateUserInfo{

    self.mineHeadView.nameLabel.text = self.userInfoModel.Name;
    [self.mineHeadView.teacherImageIcon sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.Image]];
    
    if (self.userInfoModel.LevelName.length == 0) {
            NSMutableAttributedString *attriStr = [@"成为会员" lh_addUnderlineAtContent:@"成为会员" rangeStr:@"成为会员" color:kWhiteColor];
            [self.mineHeadView.regAndLoginBtn setAttributedTitle:attriStr forState:UIControlStateNormal];

    }else{
    NSMutableAttributedString *attriStr = [self.userInfoModel.LevelName lh_addUnderlineAtContent:self.userInfoModel.LevelName rangeStr:self.userInfoModel.LevelName color:kWhiteColor];
    [self.mineHeadView.regAndLoginBtn setAttributedTitle:attriStr forState:UIControlStateNormal];
    }
    
    HHCommentSection *section0 = [self.mineHeadView viewWithTag:10001];
    CGFloat HistoryCommission = self.userInfoModel.HistoryCommission.floatValue;
    section0.titleLabel.text = [NSString stringWithFormat:@"¥%.2f",HistoryCommission?HistoryCommission:0.00];

    HHCommentSection *section1 = [self.mineHeadView viewWithTag:10002];
    CGFloat Commission = self.userInfoModel.Commission.floatValue;

    section1.titleLabel.text = [NSString stringWithFormat:@"¥%.2f", Commission?Commission:0.00];

}
- (NSArray *)groupTitles{
    
    return @[@[@"收入记录",@"已出账单",@"团队列表",@"团队销量"],@[@"我的海报"]];
    
}
- (NSArray *)groupIcons {
    
    return @[@[@"use_icon_record_default",@"icon_list_default",@"icon_teamlist_default",@"icon_team_default"],@[@"icon_img_default"]];
    
}
- (NSArray *)groupDetials{
    
    return @[@[@"",@"",@"",@""],@[@""]];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            HHIncomeRecordVC *vc  = [HHIncomeRecordVC new];
            [self.navigationController pushVC:vc];
        }else if (indexPath.row == 1){
            HHYetBillVC *vc  = [HHYetBillVC new];
            [self.navigationController pushVC:vc];
            
        }else if (indexPath.row == 2) {
            HHTeamListVC *vc = [HHTeamListVC new];
            [self.navigationController pushVC:vc];
            
        }else if (indexPath.row == 3){
            HHTeamSalesVC *vc = [HHTeamSalesVC new];
            [self.navigationController pushVC:vc];
            }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            HHMyPosterVC *vc = [HHMyPosterVC new];
            [self.navigationController pushVC:vc];
            
        }
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return WidthScaleSize_H(4);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(50);
    
}
- (HHMineHeadView *)mineHeadView {
    
    if (!_mineHeadView) {
        _mineHeadView = [[HHMineHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(240))];
    }
    
    return _mineHeadView;
}
- (UIButton *)exitBtn{
    
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 20, WidthScaleSize_W(60), 44);
        [_exitBtn setImage:[UIImage imageNamed:@"user_icon_set_default"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _exitBtn.titleLabel.font = FONT(14);
    }
    return _exitBtn;
    
}
- (void)exitBtnAction{
    
    HHModifyInfoVC *vc = [HHModifyInfoVC new];
    [self.navigationController pushVC:vc];
}
@end
