//
//  AllPlanVC.m
//  CredictCard
//
//  Created by User on 2017/12/13.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAllPlanVC.h"
#import "HHAllPlanCell.h"
#import "HXTableViewHead.h"
#import "HHAllPlanHead.h"
#import "HHPlanModel.h"

@interface HHAllPlanVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
{
    UIButton *refreshBtn;
    UIView *bottomView;
}
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   HXCommonPickView *pickView;
@property (nonatomic, strong)   HHAllPlanHead *section;
@property (nonatomic, strong)   NSMutableArray *datas;
@property (nonatomic, strong)   NSString *dateStr;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, assign)   BOOL status;

@end

@implementation HHAllPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"当月计划";
    self.page = 1;
    
    //网络监测
    [self setMonitor];
    
    NSDate  *date1 = [NSDate date];
    NSString *dateStr1 = [date1 lh_string_yyyy_MM_dd];
    [self getCurrentMonthDataWithDateStr:dateStr1];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - WidthScaleSize_H(50)-64 - WidthScaleSize_H(40)-75;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(50)+WidthScaleSize_H(40)+10, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = KVCBackGroundColor;
    
    refreshBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) target:self action:@selector(refreshBtnAction) image:[UIImage imageNamed:@"icon_refresh_default"] title:@" 下拉更新当月计划" titleColor:kComm_Color font:FONT(14)];
    refreshBtn.backgroundColor = kWhiteColor;
    self.tableView.tableHeaderView = refreshBtn;
    refreshBtn.hidden = YES;
    
    self.pickView = [[HXCommonPickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.section = [[HHAllPlanHead alloc] initWithFrame: CGRectMake(0, WidthScaleSize_H(50), SCREEN_WIDTH, 40)];
    self.section.backgroundColor = kWhiteColor;
    NSDate *date = [NSDate date];
    NSString *dateStr = [date lh_string_yyyy_MM];
    self.section.timeLab.text = dateStr;
    self.dateStr = [date lh_string_yyyy_MM_dd];
    [self.view addSubview:self.section];
    
    self.section.userInteractionEnabled = YES;
    //选择年月
    [self selectYearMonth];
    
    
    bottomView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) backColor:kWhiteColor];
    bottomView.hidden = YES;
    self.tableView.tableFooterView = bottomView;
    
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-75, SCREEN_WIDTH, 75) backColor:KVCBackGroundColor];
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 20, SCREEN_WIDTH - 60, 40) target:self action:@selector(finishBtnAction) backgroundImage:nil title:@"一键完成" titleColor:kWhiteColor font:FONT(17)];
    finishBtn.backgroundColor = kComm_Color;
    [finishBtn lh_setCornerRadius:5 borderWidth:0 borderColor:nil];
    [footView addSubview:finishBtn];
    [self.view addSubview: footView];
    
    [self addHeadRefresh];
//    [self addFootRefresh];

    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
}

- (void)selectYearMonth{
    
    //选择年月
    WEAK_SELF();
    [self.section setTapActionWithBlock:^{
        
        [weakSelf.pickView setStyle:HXCommonPickViewStyleYearMonth titleArr:nil];
        [weakSelf.pickView showPickViewAnimation:YES];
        weakSelf.pickView.completeBlock = ^(NSString *result) {
            
            if (result.length == 0) {
             
                NSDate  *date1 = [NSDate date];
                NSString *dateStr1 = [date1 lh_string_yyyy_MM];
                
                weakSelf.section.timeLab.text = dateStr1;
                //获取当月计划数据
                NSString *dateStr = [NSString stringWithFormat:@"%@-1",dateStr1];
                //年月
                weakSelf.dateStr = dateStr;
                
                [weakSelf getCurrentMonthDataWithDateStr:dateStr];
                
            }else{
            
            weakSelf.section.timeLab.text = result;
            //获取当月计划数据
            NSString *dateStr = [NSString stringWithFormat:@"%@-1",result];
            //年月
            weakSelf.dateStr = dateStr;
            
            [weakSelf getCurrentMonthDataWithDateStr:dateStr];
            
            }
        };
        
    }];
    
}
- (void)setMonitor{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if(status == 1 || status == 2)
        {
            self.status = NO;
            NSLog(@"有网");
        }else
        {
            NSLog(@"没有网");
            self.status = YES;
            [self.tableView reloadData];

        }
    }];
    
    
}
#pragma mark - DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.status) {
        return [UIImage imageNamed:@"img_network_disable"];

    }else{
        return [UIImage imageNamed:@"logo_plan_disabled"];

    }
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *title ;
    if (self.status) {
        title = @"网络竟然崩溃了～";

    }else{
        title = @"当月暂无计划";
    }
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:KACLabelColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    
    return 30;
}

- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        self.page = 1;
        [self getRefreshPlanData];
        
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;

    self.tableView.mj_header = refreshHeader;
    
}
- (void)addFootRefresh{
    
    MJRefreshAutoNormalFooter *refreshfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        self.page++;
        
        [self getCurrentMonthDataWithDateStr:self.dateStr];

    }];
    self.tableView.mj_footer = refreshfooter;
    
}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    [self.datas addObjectsFromArray:arr];
    
    if (arr.count < 10) {
        
        [self endRefreshing:YES];
        
    }else{
        [self endRefreshing:NO];
    }
    
}

/**
 *  结束刷新
 */
- (void)endRefreshing:(BOOL)noMoreData {
    // 取消刷新
    
    if (noMoreData) {
        if (self.datas.count == 0) {
            self.tableView.mj_footer.hidden = YES;
        }else {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }
    }else{
        
        [self.tableView.mj_footer setState:MJRefreshStateIdle];
        
    }
    
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
    //刷新界面
    [self.tableView reloadData];
    
}
- (void)getRefreshPlanData{
    
    [self.datas removeAllObjects];
    
    NSString *refDate = [NSString stringWithFormat:@"%@-01",self.section.timeLab.text];
    
    [[[HHHomeDataAPI postRefreshPlanWithCardId:self.CardId refDate:refDate page:nil] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (!error) {
            if (api.code == 0) {
                NSArray *arr = api.data;
                self.datas = arr.mutableCopy;
                if (self.datas.count>0) {
                    refreshBtn.hidden = NO;
                    bottomView.hidden = NO;

                }else{
                    refreshBtn.hidden = YES;
                    bottomView.hidden = YES;

                }
                [self.tableView reloadData];
                
            }else{
                
                [SVProgressHUD showInfoWithStatus:api.msg];
                
            }
        }else{
            [SVProgressHUD showInfoWithStatus:api.msg];

        }
    }];
    
}
- (void)refreshBtnAction{
    
    
}
- (void)getCurrentMonthDataWithDateStr:(NSString *)DateStr{
    
    [self.datas removeAllObjects];
    
    [[[HHHomeDataAPI getMonthPlanWithCardId:self.CardId refDate:DateStr page:nil] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
       
        if (!error) {
            if (api.code == 0) {
                
                NSArray *arr = api.data;
                self.datas = arr.mutableCopy;
                if (self.datas.count>0) {
                    refreshBtn.hidden = NO;
                    bottomView.hidden = NO;
                }else{
                    refreshBtn.hidden = YES;
                    bottomView.hidden = YES;

                }
                [self.tableView reloadData];
            }else{
                
                [SVProgressHUD showInfoWithStatus:api.msg];

            }
        }
    }];

}
//一键完成
- (void)finishBtnAction{
    
    [self.datas removeAllObjects];
    
    [[[HHHomeDataAPI  postSetAllPlanFinishWithCardId:self.CardId date:self.dateStr] netWorkClient] postRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {

        if (!error) {

            if (api.code == 0) {

                NSArray *arr = api.data;
                self.datas = arr.mutableCopy;
                
                if (self.datas.count>0) {
                    refreshBtn.hidden = NO;
                    bottomView.hidden = NO;
                }else{
                    refreshBtn.hidden = YES;
                    bottomView.hidden = YES;
                    
                }
                [self.tableView reloadData];

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
    
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHAllPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllPlanCell"];
    
    if (!cell) {
        
        cell = [[HHAllPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllPlanCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.datas.count >0) {
        HHHomeModel *model = [HHHomeModel mj_objectWithKeyValues:self.datas[indexPath.row]];
        cell.model = model;
    }
    [cell.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.finishBtn.tag = indexPath.row+100;

    [cell.finishBtn2 addTarget:self action:@selector(finishBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.finishBtn2.tag = indexPath.row +200;
    return cell;
}
- (void)finishBtnAction:(UIButton *)btn{
    
    HHHomeModel *model = [HHHomeModel mj_objectWithKeyValues:self.datas[btn.tag-100]];
    
    HHPlanModel *pModel = [HHPlanModel mj_objectWithKeyValues:model.Details[0]];
    
    [[[HHHomeDataAPI postSetPlanFinishWithPlanId:pModel.Id] netWorkClient] postRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        if (!error) {
            if (api.code == 0) {
                btn.selected = YES;
                
            }
        }
    }];
}
- (void)finishBtn2Action:(UIButton *)btn{
    
    HHHomeModel *model = [HHHomeModel mj_objectWithKeyValues:self.datas[btn.tag-200]];

    HHPlanModel *pModel = [HHPlanModel mj_objectWithKeyValues:model.Details[1]];;
    [[[HHHomeDataAPI postSetPlanFinishWithPlanId:pModel.Id] netWorkClient] postRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        if (!error) {
            
            if (api.code == 0) {
                
                btn.selected = YES;
                
            }
        }
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(90);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
- (NSMutableArray *)datas{
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
