//
//  HHLoadVC.m
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHLoadVC.h"
#import "HHHomeDataAPI.h"
#import "HHLoadCell.h"

@interface HHLoadVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, strong)   NSMutableArray *datas;

@end
@implementation HHLoadVC

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
    tableHeight = SCREEN_HEIGHT - 64;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"HHLoadCell" bundle:nil] forCellReuseIdentifier:@"HHLoadCell"];
    [self.view addSubview:self.tableView];
    
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
- (void)getDatas{

        //获取贷款列表数据
        [[[HHHomeDataAPI getLoanListWithPage:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                if (api.code == 0) {
                    
                    [self loadDataFinish:api.data];
                }
            }
            
        }];

}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHLoadCell"];
    
        NSDictionary *dic = self.datas[indexPath.row];
        cell.titleLabel.text = dic[@"Name"];
        cell.subTitle1.text = dic[@"Remark"];
 //     cell.subTitle1.text;
        NSString *imageUrl = dic[@"Image"];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.loadBtn setTapActionWithBlock:^{
        
        NSDictionary *dic = self.datas[indexPath.row];
        
        HHH5CommonVC *vc = [HHH5CommonVC new];
        vc.titleStr = self.titleStr;
        vc.commonUrl = dic[@"Url"];
        [self.navigationController pushVC:vc];
        
    }];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(80);
    
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
