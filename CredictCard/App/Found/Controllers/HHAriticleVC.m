//
//  AriticleVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHAriticleVC.h"
#import "HHArticleCell.h"
#import "HHAriticleDetailVC.h"

@interface HHAriticleVC ()<UITableViewDelegate,UITableViewDataSource,SGSegmentedControlDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong)   UITableView *tableView;
@property(nonatomic,strong)   SGSegmentedControl *SG;
@property (nonatomic, strong)   NSMutableArray *title_arr;
@property (nonatomic, strong)   NSMutableArray *ids_arr;
@property (nonatomic, assign)   NSInteger page;
@property (nonatomic, strong)   NSMutableArray *articleList;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSString *typeId;

@end

@implementation HHAriticleVC

- (NSMutableArray *)title_arr {
    
    if (!_title_arr) {
        _title_arr = [NSMutableArray array];
    }
    return _title_arr;
}

- (NSMutableArray *)ids_arr {
    
    if (!_ids_arr) {
        _ids_arr = [NSMutableArray array];
    }
    return _ids_arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.articleList = [NSMutableArray array];
    
    self.page = 1;
    
    //获取数据
    [self getDatas];
    
    
    self.title =@"文章列表";
    
    self.automaticallyAdjustsScrollViewInsets = NO;

//
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.SG.height - 1, SCREEN_WIDTH, 1)];
//    line.backgroundColor = LineLightColor ;
//    [self.SG addSubview:line];
    
    
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - 64 - 49;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,49, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
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
        [self.articleList removeAllObjects];
        self.page = 1;
        [self getArticleDataWithtypeId:self.typeId];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
}
- (void)addFootRefresh{
    
    MJRefreshAutoNormalFooter *refreshfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        
        [self getArticleDataWithtypeId:self.typeId];
    }];
    self.tableView.mj_footer = refreshfooter;
    
}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {
    
    [self.articleList addObjectsFromArray:arr];
    
    if (self.articleList.count <10) {
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
        if (self.articleList.count == 0) {
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
#pragma mark - DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"logo_writings_disabled"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂时没有文章";
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
    
    [[[HHHomeDataAPI getArticleTypeList] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {

        if (!error) {

            if (api.code == 0) {

                NSArray *arr = api.data;
                [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.ids_arr addObject:dic[@"Id"]];
                    [self.title_arr addObject:dic[@"Name"]];
                }];
                if (self.title_arr.count < 5) {
                    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:self.title_arr];
                }else{
                    
                    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeScroll) titleArr:self.title_arr];
                }
                self.SG.titleColorStateNormal = kComm_Color;
                self.SG.titleColorStateSelected = kComm_Color;
                self.SG.title_fondOfSize  = BoldFONT(16);
                // self.SG.showsBottomScrollIndicator = YES;
                self.SG.backgroundColor = kWhiteColor;
                self.SG.indicatorColor = kComm_Color;
                [self.view addSubview:_SG];
                
            }
        }
        
    }];
    
}
- (void)getArticleDataWithtypeId:(NSString *)typeId{
    
    
   self.task = [[[HHHomeDataAPI getArticleListWithtypeId:typeId page:@(self.page)] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
       
        if (!error) {
            if (api.code == 0) {
                
                NSArray *arr = api.data;
                [self loadDataFinish:arr];
            }
        }
        
    }];
    
}
//- (NSMutableArray *)articleList{
//    if (!_articleList) {
//        _articleList = [NSMutableArray array];
//    }
//
//    return _articleList;
//}
#pragma mark - SGSegmentedControlDelegate

- (void)SGSegmentedControl:(SGSegmentedControl *)segmentedControl didSelectBtnAtIndex:(NSInteger)index {

    [self.task cancel];

    NSString *typeId = self.ids_arr[index];
    self.typeId  = typeId;
    [self.articleList removeAllObjects];
    self.tableView.mj_footer.hidden = NO;
    [self getArticleDataWithtypeId:typeId];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    if (!cell) {
        
        cell = [[HHArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArticleCell"];
    }
    NSDictionary *dic = self.articleList[indexPath.section];
    cell.titleLab.text = dic[@"Title"];
    NSString *ImagUrl = dic[@"Image"];
    [cell.ico_ImagV sd_setImageWithURL: [NSURL URLWithString:ImagUrl]];
    cell.articleContentLab.text = dic[@"Content"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.articleList.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize_H(105);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHAriticleDetailVC *vc = [HHAriticleDetailVC new];
    NSDictionary *dic = self.articleList[indexPath.section];
    vc.commonUrl = dic[@"Url"];
    vc.titleStr = dic[@"Title"];
    vc.imageUrl = dic[@"Image"];
    
    [self.navigationController pushVC:vc];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}


@end
