//
//  HHTodayPlan1VC.m
//  CredictCard
//
//  Created by User on 2017/12/22.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTodayPlan1VC.h"
#import "HHTodayPlanCell1.h"
#import "HXTableViewHead.h"

@interface HHTodayPlan1VC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    HXTableViewHead *section;
}
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *datas;
@property (nonatomic, strong)   HXCommonPickView *pickView;
@property (nonatomic, assign)   BOOL status;

@end

@implementation HHTodayPlan1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"当天计划";
    
    //网络监测
    [self setMonitor];
    
    //获取数据
    [self getDatas];
    
    self.pickView = [[HXCommonPickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT- WidthScaleSize_H(50);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,WidthScaleSize_H(50),SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = KVCBackGroundColor;

    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHTodayPlanCell1" bundle:nil] forCellReuseIdentifier:@"HHTodayPlanCell1"];
//
//    section = [[HXTableViewHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(40))];
//    section.headTitleLab.text = @"今日还需";
//    section.headtitleFrame = CGRectMake(28, 0, 120, WidthScaleSize_H(40));
//    section.headTitleLab.textColor = KTitleLabelColor;
//    NSDate *date = [NSDate date];
//    NSString *dateStr = [date lh_string_yyyy_MM_dd];
//    section.rightBtnTitle = dateStr;
//    section.contentType = LeftTitleRightImage;
//    section.btnFontAttributes = [FontAttributes fontAttributesWithFontColor:KACLabelColor fontsize:15];
//    section.rightBtn_W = 100;
//    self.tableView.tableHeaderView = section;
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
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
        title = @"当天暂无计划";
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

- (void)getDatas{
    
    //当天计划数据
    [[[HHHomeDataAPI getTodayPlanWithCardId:self.CardId] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
       
        if (!error) {
            
            if (api.code == 0) {
                
                self.datas = [NSMutableArray arrayWithArray:api.data];
                
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showInfoWithStatus:api.msg];
            }
            
        }
        
    }];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHTodayPlanCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HHTodayPlanCell1"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.modelDic = self.datas[indexPath.section];
    
    cell.editBtn.tag = indexPath.section;
    
    [cell.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [cell.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
//编辑
- (void)editBtnAction:(UIButton *)btn{
    
    NSDictionary *dic =  self.datas[btn.tag];

    //消费类型数据
    NSString *Id = dic[@"Id"];
    [[[HHHomeDataAPI getConsumptionTypeWithplanDetailId:Id] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if (!error) {
            if (api.code == 0) {
                
                NSArray *arr = api.data;
                NSMutableArray *resultArr = [NSMutableArray array];
                NSMutableArray *IDsArr = [NSMutableArray array];

                [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    [resultArr addObject:dic[@"Name"]];
                    [IDsArr addObject:dic[@"Id"]];
                }];
                [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:resultArr];
                [self.pickView showPickViewAnimation:YES];
                WEAK_SELF();
                self.pickView.completeBlock = ^(NSString *result) {
                    
                    NSInteger index = [ resultArr indexOfObject:result];
                    
                    NSString *typeId = [IDsArr objectAtIndex:index];
                    
                    //提交消费类型
                    [[[HHHomeDataAPI postEditConsumptionTypeWithplanId:Id typeId:typeId] netWorkClient] postRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
                        
                        if (!error) {
                            if (api.code == 0) {
                                
                            HHTodayPlanCell1 *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btn.tag]];
                            cell.payTypeLab.text = result;
                                
                            }
                        }
                        
                    }];
                    
                };
            }
        }
        
    }];
    
}
//完成
- (void)finishBtnAction:(UIButton *)btn{
    
    NSDictionary *dic =  self.datas[btn.tag];
    
    [[[HHHomeDataAPI postSetPlanFinishWithPlanId:dic[@"Id"]] netWorkClient] postRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        if (!error) {
            
            if (api.code == 0) {
                
                [self getDatas];
            }
        }
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datas.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}




@end
