//
//  MessageVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHMessageVC.h"
#import "UIView+WHC_AutoLayout.h"
#import "HHMessageCell.h"
#import "HHMessageDetailVC.h"

@interface HHMessageVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, strong)   NSMutableArray *datas;

@end
@implementation HHMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datas = [NSMutableArray array];
    
    self.page = 1;
    //  获取消息
    [self getDatas];
    
    self.title = @"消息";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT-64;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
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
    
}
- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
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
    
    [self.datas addObjectsFromArray:arr];
        if (self.datas.count == 0) {
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
    
    return [UIImage imageNamed:@"logo_message_disabled"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有通知";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:KACLabelColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}
- (void)getDatas{
    
    [[[HHHomeDataAPI getNoticeListWithPage:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if (!error) {
            if (api.code == 0) {
                
                [self loadDataFinish:api.data];
                
            }else{
                [SVProgressHUD showInfoWithStatus:api.msg];
            }
        }
        
    }];
    
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHMessageCell"];
    
    if (!cell) {
        
        cell = [[HHMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HHMessageCell"];
      
    }
    NSDictionary *dic = self.datas[indexPath.section];
    cell.titleLab.text = dic[@"Title"];
    cell.contentLab.text = dic[@"Content"];
    cell.contentLab.editable = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(150);
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView  = [[UIView alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    footView.backgroundColor = kWhiteColor;
    UIButton *moreBtn = [XYQButton ButtonWithFrame:CGRectMake(SCREEN_WIDTH - WidthScaleSize_W(80), 0, WidthScaleSize_W(80), 40) imgaeName:@"icon_skip_default" titleName:@"查看详情" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kBlackColor fontsize:13] tapAction:^(XYQButton *button) {
        
        HHMessageDetailVC *vc = [HHMessageDetailVC new];
        NSDictionary *dic = self.datas[section];
        vc.Id = dic[@"Id"];
        [self.navigationController pushVC:vc];
        
    }];
    [footView addSubview:moreBtn];
    
    return footView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.01;
    }else{
        return 8;
    }
}


@end
