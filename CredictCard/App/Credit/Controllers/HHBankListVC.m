//
//  BankListVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHBankListVC.h"
#import "HHHomeDataAPI.h"
#import "HHH5CommonVC.h"
#import "HHBankListCell.h"

@interface HHBankListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, strong)   NSMutableArray *datas;

@end
@implementation HHBankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    //获取数据
    [self getDatas];
    
    self.title = self.titleStr;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT -64;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHBankListCell" bundle:nil] forCellReuseIdentifier:@"HHBankListCell"];
    
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
    
    return [UIImage imageNamed:@"logo_data_disabled"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有数据";
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
    
    if (self.pushType == addBankType) {
      //添加银行卡
        [[[HHHomeDataAPI getBrankListWithPage:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                if (api.code == 0) {
                    
                    [self loadDataFinish:api.data];

                }
            }else{
                
                if ([error.localizedDescription isEqualToString:@"似乎已断开与互联网的连接。"]||[error.localizedDescription  containsString:@"请求超时"]) {
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD showInfoWithStatus:@"网络竟然崩溃了～"];
                    
                }
            }
        }];
        
        
    }else if (self.pushType == getBankCardType){
        
        //获取办卡列表数据
        [[[HHHomeDataAPI getCreateCardListWithPage:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                if (api.code == 0) {
                    
                    [self loadDataFinish:api.data];

                }
            }
            
        }];
        
    }
  
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHBankListCell"];
    
        NSDictionary *dic = self.datas[indexPath.row];
        if (self.pushType == addBankType) {
            cell.bankName.text = dic[@"Name"];
            NSString *imageUrl = dic[@"Image"];
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }else if(self.pushType == getBankCardType){
            
        cell.bankName.text = dic[@"Name"];
        cell.detailLab.text = dic[@"Remark"];
        NSString *imageUrl = dic[@"Image"];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
//      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(70);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.pushType == addBankType) {
        NSDictionary *dic = self.datas[indexPath.row];
        
        if (self.bankBlock) {
            self.bankBlock(dic);
            [self.navigationController popVC];
        }
        
    }else if (self.pushType == getBankCardType) {
    
    NSDictionary *dic = self.datas[indexPath.row];
    HHH5CommonVC *vc = [HHH5CommonVC new];
    vc.titleStr = self.titleStr;
    vc.commonUrl = dic[@"Url"];
    [self.navigationController pushVC:vc];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
- (NSMutableArray *)datas {
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
