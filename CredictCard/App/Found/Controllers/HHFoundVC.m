//
//  FoundVC.m
//  CredictCard
//
//  Created by User on 2017/12/12.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHFoundVC.h"
#import "LLWaveView.h"
#import "PGIndexBannerSubiew.h"
#import "NewPagedFlowView.h"
#import "HHAriticleVC.h"
#import "HHBtnListView.h"
#import "HHBankCardVC.h"
#import "HHAddBankVC.h"
#import "HHEmailSetVC.h"
#import "HHcardModel.h"

@interface HHFoundVC()<UITableViewDelegate,UITableViewDataSource,NewPagedFlowViewDataSource,NewPagedFlowViewDelegate>
{
    
    NSArray *images;
    NewPagedFlowView *pageFlowView;
}
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NewPagedFlowView *pageFlowView;

@property (nonatomic, strong)   NSMutableArray *creditsArr;
@property (nonatomic, strong)   NSMutableArray *BrankNamesArr;
@property (nonatomic, strong)   NSMutableArray *IdsArr;
@property (nonatomic, strong)   NSMutableArray *CradNosArr;
@property (nonatomic, strong)   NSArray *colorArr;
@property (nonatomic, strong)   NSDictionary *dataDic;
@property (nonatomic, strong)   BaseCache *yyCache;
@property (nonatomic, strong)   HHcardModel *cardModel;

@end

@implementation HHFoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
    
    self.BrankNamesArr = [NSMutableArray array];
    self.IdsArr = [NSMutableArray array];
    self.CradNosArr = [NSMutableArray array];
    
    images = @[@"img_cardred_default",@"img_cardblue_default",@"img_cardgreen_default"];
    
    self.colorArr = @[@"#ED334F",@"#2F6CE7",@"#36E3BC"];
    
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.backgroundColor = KVCBackGroundColor;
    [self.view addSubview:nav];
    
    UILabel *qestionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    qestionTitle.text = @"发现";
    qestionTitle.font = FONT(20);
    qestionTitle.textAlignment = NSTextAlignmentCenter;
    qestionTitle.textColor = kBlackColor;
    [nav addSubview:qestionTitle];
    [self.view addSubview:nav];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - 64 ;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    //头部
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize_H(220))];
    
    pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,headView.mj_h)];
    pageFlowView.leftRightMargin = WidthScaleSize_W(50);
    pageFlowView.topBottomMargin = WidthScaleSize_H(25);
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.isOpenAutoScroll = NO;
    pageFlowView.isCarousel = NO;
    pageFlowView.backgroundColor = KVCBackGroundColor;
    [pageFlowView scrollToPage:1];

    [headView addSubview:pageFlowView];
    
    self.tableView.tableHeaderView = headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kWhiteColor;
    self.view.backgroundColor = kWhiteColor;
    
    //获取数据
    [self getDatas];
    
    [self addHeadRefresh];
}
- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDatas];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
}
- (void)getDatas{
    
    //获取用户信用卡列表
    
    NetworkClient *netWorkClient  = [[HHHomeDataAPI getUserAllCardList] netWorkClient];

    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, globalQueue, ^{
        
        netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
        
        [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            if (!error) {
                if (self.tableView.mj_header.isRefreshing) {
                    [self.tableView.mj_header endRefreshing];
                }
                if (api.code == 0) {
                    [self.creditsArr  removeAllObjects];
                    NSArray *arr = api.data;
                    HHcardModel *model = [HHcardModel new];
                    model.CardNo = @"";
                    [self.creditsArr addObject:model];
                    [self.creditsArr insertObjects:arr atIndex:0];
                    [pageFlowView reloadData];
                    dispatch_semaphore_signal(semaphore);
                }else{
                    
                    [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
                }
                
            }
            
        }];
        
    });
    
    dispatch_group_notify(group, globalQueue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            
            [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
                if (!error) {
                    if (self.tableView.mj_header.isRefreshing) {
                        [self.tableView.mj_header endRefreshing];
                    }
                    if (api.code == 0) {
                        NSArray *arr = api.data;
                        [self.creditsArr  removeAllObjects];
                        HHcardModel *model = [HHcardModel new];
                        model.CardNo = @"";
                        [self.creditsArr addObject:model];
                        [self.creditsArr insertObjects:arr atIndex:0];
                        [pageFlowView reloadData];
                        dispatch_semaphore_signal(semaphore);
                    }else{
                        
                        [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
                    }
                    
                }else{
                    
                }
                
            }];
            
        });
        
    });
    
    [[[HHFoundDataAPI getCommonUrl] netWorkClient] getRequestInView:nil finishedBlock:^(HHFoundDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                self.dataDic = api.data;
            }
        }
    }];
    
}
#pragma mark -- NewPagedFlowViewDataSource

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    

    return self.creditsArr.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
//    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
//    if (!bannerView) {
        PGIndexBannerSubiew *bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 40,SCREEN_WIDTH - WidthScaleSize_W(110)+16, WidthScaleSize_H(176))];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 10;
        bannerView.layer.masksToBounds = YES;
//    }
    //最后一张

    if (index == self.creditsArr.count-1) {
        
        bannerView.mainImageView.image = [UIImage imageNamed:@"img_carddefault_default"];
        //银行卡号
        bannerView.titleLabel.text = @"";
        bannerView.bankTagLabel.text = @"";
        bannerView.bankNameLabel.text = @"";
        UIColor *color = [UIColor colorWithHexString:@"#D4D4D4"];
        [self.view addShadowToView:bannerView.mainImageView withOpacity:0.4 shadowRadius:5 andCornerRadius:10 shadowColor:color];
        
    }else{

        NSInteger i = index % 3;
        bannerView.mainImageView.image = [UIImage imageNamed:images[i]];
        bannerView.cardDic =  [HHcardModel mj_objectWithKeyValues:self.creditsArr[index]];
        UIColor *color =  [UIColor colorWithHexString:self.colorArr[i]];
        [self.view addShadowToView:bannerView.mainImageView withOpacity:0.05 shadowRadius:5 andCornerRadius:10 shadowColor:color];
    }
    return bannerView;
}

#pragma mark -- NewPagedFlowViewDelegate

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    
    return CGSizeMake(SCREEN_WIDTH - WidthScaleSize_W(110)+30, WidthScaleSize_H(176));
    
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex{
    
    if (subIndex == self.creditsArr.count-1) {
        //添加信用卡
        HHAddBankVC *vc = [HHAddBankVC new];
        vc.backBlock = ^{
            
            [self getDatas];

        };
        [self.navigationController pushVC:vc];
    }else {
        HHBankCardVC *vc = [HHBankCardVC new];
        NSDictionary *dic = self.creditsArr[subIndex];
        vc.cardId = dic[@"Id"];
        vc.bankName = dic[@"BrankName"];
        [self.navigationController pushVC:vc];
        
    }
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        HHBtnListView *listView = [[HHBtnListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        listView.buttonSelectBlock = ^(UIButton *btn) {
            NSString *titleStr;
            NSString *urlStr;

            if (btn.tag == 1001){
                //邮箱设置
                
                HHEmailSetVC *vc = [HHEmailSetVC new];
                [self.navigationController pushVC:vc];
                
            }else{
            
            if (btn.tag == 1000) {
                //公积金查询
                titleStr = @"公积金查询";
                urlStr = self.dataDic[@"AccumulationFundUrl"];
            } else if (btn.tag == 1002){
                //身份证挂失
                titleStr = @"身份证挂失";
                urlStr = self.dataDic[@"IDCardUrl"];
            }else if (btn.tag == 1003){
                //MCC码查询
                titleStr = @"MCC码查询";
                urlStr = self.dataDic[@"MCCUrl"];
            }else if (btn.tag == 1004){
  
                //征信查询
                titleStr = @"征信查询";
                urlStr = self.dataDic[@"CreditUrl"];
            }else if (btn.tag == 1005){
             
                //网贷数据
                titleStr = @"网贷数据";
                urlStr = self.dataDic[@"NetLoanUrl"];
            }
            HHH5CommonVC *vc = [HHH5CommonVC new];
            vc.titleStr = titleStr;
            vc.commonUrl = urlStr;
            
            [self.navigationController pushVC:vc];
            }
        };
        [cell.contentView addSubview:listView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 240;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;

}
- (BaseCache *)yyCache {
    
    if (!_yyCache) {
        _yyCache = [BaseCache shareBaseCache];
    }
    return _yyCache;
}
- (NSMutableArray *)creditsArr{
    if (!_creditsArr) {
        _creditsArr = [NSMutableArray array];
    }
    return _creditsArr;
}
@end
