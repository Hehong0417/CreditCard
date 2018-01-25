//
//  YetBillVC.m
//  CredictCard
//
//  Created by User on 2017/12/13.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHYetBillVC.h"
#import "HHYetBillCell.h"


@interface HHYetBillVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, strong)   NSMutableArray *datas;
@property (nonatomic, assign)   BOOL status;

@end

@implementation HHYetBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    self.datas =  [NSMutableArray array];

    //网络监测
    [self setMonitor];
    
    
    [self getYetPlanListData];
    
    self.title = @"已出账单";
    
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYetBillCell" bundle:nil] forCellReuseIdentifier:@"HHYetBillCell"];
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    
    [self addHeadRefresh];
    [self addFootRefresh];
    
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
- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        self.page = 1;
        [self getYetPlanListData];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
}
- (void)addFootRefresh{
    
    MJRefreshAutoNormalFooter *refreshfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        
        [self getYetPlanListData];
    }];
    self.tableView.mj_footer = refreshfooter;
    
}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    [self.datas addObjectsFromArray:arr];
    
    if (self.datas.count <10) {
        self.tableView.mj_footer.hidden = YES;
    }
    
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
        
        [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
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
#pragma mark - DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.status) {
        return [UIImage imageNamed:@"img_network_disable"];
    }else{
        return [UIImage imageNamed:@"logo_data_disabled"];

    }
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *title ;
    if (self.status) {
        title = @"网络竟然崩溃了～";
    }else{
        title = @"暂时没有数据";

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
//已出账单
- (void)getYetPlanListData{
    
    [[[HHPerCenterDataAPI getYetPlanListWithPage:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                [self loadDataFinish:api.data];
            }
        }
    }];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYetBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHYetBillCell"];
    
    cell.model = [HHPerCenterModel mj_objectWithKeyValues:self.datas[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
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
