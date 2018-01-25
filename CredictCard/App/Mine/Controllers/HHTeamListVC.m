//
//  HHTeamListVC.m
//  CredictCard
//
//  Created by User on 2017/12/16.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHTeamListVC.h"
#import "HHTeamCell.h"

@interface HHTeamListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic,retain) UISearchController *searchController;
//数据源
@property (nonatomic,strong) NSMutableArray *dataListArry;
@property (nonatomic,strong) NSMutableArray *searchListArry;

@property (nonatomic,assign) NSInteger  page;
@property (nonatomic,strong) NSString  *key;
@property (nonatomic,assign) BOOL  isSeachActive;
@property (nonatomic, assign)   BOOL status;

@end

@implementation HHTeamListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"团队列表";
    
    self.dataListArry = [NSMutableArray array];
    self.searchListArry = [NSMutableArray array];
    
    
    //网络监测
    [self setMonitor];
    
    self.page = 1;
    
    [self  getDatas];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.barTintColor = KVCBackGroundColor;
    self.searchController.searchBar.placeholder = @"搜索成员名称或ID";
    self.searchController.searchBar.backgroundImage = [UIImage imageWithColor:KVCBackGroundColor];
    self.definesPresentationContext = YES;
    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
  
    //点击搜索的时候,是否隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    //位置
//    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 50);
    self.searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [self.searchController.searchBar setImage:[UIImage imageNamed:@"mind_icon_search_default"] forSearchBarIcon:(UISearchBarIconSearch) state:UIControlStateNormal];

    
    [self.view addSubview:self.searchController.searchBar];
    
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - self.searchController.searchBar.mj_h - 64;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,50, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    
    [self addHeadRefresh];
    [self addFootRefresh];

    //捕捉返回按钮
    UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [leftButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backClicked:(UIButton *)btn{
    
    [self.searchController.searchBar resignFirstResponder];
    
    [self.navigationController popVC];
    
}

-(void)viewDidLayoutSubviews {
    
    if(self.searchController.active) {
        [self.tableView setFrame:CGRectMake(0, 70, SCREEN_WIDTH, self.view.height -20)];
    }else {
        self.tableView.frame = CGRectMake(0,50, SCREEN_WIDTH,SCREEN_HEIGHT - self.searchController.searchBar.mj_h - 64);
    }
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
        [self.dataListArry removeAllObjects];
        [self.searchListArry removeAllObjects];
        self.page = 1;
        [self getDatas];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
}
- (void)addFootRefresh{
    
    MJRefreshAutoNormalFooter *refreshfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        
        [self getDatas];
    }];
    self.tableView.mj_footer = refreshfooter;
    
}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    if(self.isSeachActive){
        
        [self.searchListArry addObjectsFromArray:arr];

    }else{
        [self.dataListArry addObjectsFromArray:arr];
        
        if (self.dataListArry.count == 0) {
            self.tableView.mj_footer.hidden = YES;
        }
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

- (void)getDatas{
    
    [[[HHPerCenterDataAPI  getSubordinateListWithPage:@(self.page) key:self.key] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {

                NSArray *arr = api.data;
                
                [self loadDataFinish:arr];

            }
        }else{
            
            self.tableView.mj_footer.hidden = YES;

        }
        
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchController.searchBar resignFirstResponder];
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHTeamCell"];
    
    if (!cell) {
        
        cell = [[HHTeamCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HHTeamCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.searchController.active) {
        if (self.searchListArry.count>0) {
            HHPerCenterModel *model =  [HHPerCenterModel mj_objectWithKeyValues:self.searchListArry[indexPath.row]];
            cell.nameLabel.text = model.Name;
            [cell.iconImagV sd_setImageWithURL:[NSURL URLWithString:model.Image]];
            cell.titleLabel.text =  [NSString stringWithFormat:@"ID:%@",model.Id];
            cell.title2Label.text = model.CreateDate;
        }

    }
    else{
        if (self.dataListArry.count>0) {

        HHPerCenterModel *model =  [HHPerCenterModel mj_objectWithKeyValues:self.dataListArry[indexPath.row]];
        cell.nameLabel.text = model.Name;
        [cell.iconImagV sd_setImageWithURL:[NSURL URLWithString:model.Image]];
        cell.titleLabel.text =  [NSString stringWithFormat:@"ID:%@",model.Id];
        cell.title2Label.text = [[model.CreateDate lh_yyyyMMdd_HHmmss_Date] lh_string_yyyyMMdd];

        }
    }

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.active) {

        return [self.searchListArry count];
    }
    else{
    
        return [self.dataListArry count];
    }
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
//谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    [self.searchListArry removeAllObjects];
    
    self.isSeachActive = YES;
    NSString *searchString = [self.searchController.searchBar text];
    
    if (searchString.length == 0) {
        self.key = nil;
        [self getDatas];

    }else{
        self.key = searchString;
        [self getDatas];

    }

    NSLog(@"updateSearchResultsForSearchController");

}

#pragma mark - UISearchControllerDelegate代理,可以省略,主要是为了验证打印的顺序
//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
#warning 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
//        [self.view addSubview:self.searchController.searchBar];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    
    self.key = nil;
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

@end
