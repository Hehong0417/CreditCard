//
//  HomeVC.m
//  CredictCard
//
//  Created by User on 2017/12/12.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHHomeVC.h"
#import <WebKit/WebKit.h>
#import "SDCycleScrollView.h"
#import "HHPlanVC.h"
#import "HHHomeOneCell.h"
#import "HHRegisterVC.h"
#import "HHMessageVC.h"
#import "HHCommentSection.h"
#import "HXbulletinView.h"
#import "LLWaveView.h"
#import "HHHomeDataAPI.h"
#import "HHCreditModel.h"
#import "HXCommonPickView.h"
#import "HHHomeModel.h"
#import "HHBankListVC.h"
#import "HHAriticleVC.h"
#import "HHH5CommonVC.h"
#import "HHLoadVC.h"
#import "HHAddBankVC.h"

@interface HHHomeVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SDCycleScrollViewDelegate>
{
    HXCommonPickView *pickView;
    UIView *headView;
    UILabel *bankNameLab;
    UIImageView *imageV;
}
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   SDCycleScrollView *cycleScrollView;
//公告栏
@property (nonatomic, strong)   HXbulletinView *bulletin;
@property (nonatomic, strong)   NSMutableArray *creditsArr;
@property (nonatomic, strong)   NSMutableArray *BrankNamesArr;
@property (nonatomic, strong)   NSMutableArray *IdsArr;
@property (nonatomic, strong)   NSMutableArray *CradNosArr;
@property (nonatomic, strong)   NSMutableArray *CarouselArr;
@property (nonatomic, strong)   NSMutableArray *liveSteamUrlArr;
@property (nonatomic, strong)   NSString *CardId;

//详情按钮
@property (nonatomic, strong)  UIButton *detailBtn;

@property (nonatomic, strong)  UIView *headView1;

@property (nonatomic, strong)  UILabel *todayLab;

//首页其他信息model
@property (nonatomic, strong)  HHHomeModel *model;

@property (nonatomic, strong)  UIView *commonView;

@property (nonatomic, strong)  UILabel *priceLab;

@property (nonatomic, strong)  UILabel *categotyLab;

@property (nonatomic, assign)  BOOL  isCardId;

@property (nonatomic, assign)   BOOL status;

@end

@implementation HHHomeVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //获取数据
    [self getHomeDatas];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.BrankNamesArr = [NSMutableArray array];
    self.IdsArr = [NSMutableArray array];
    self.CradNosArr = [NSMutableArray array];
    
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    nav.backgroundColor = kComm_Color;
    [self.view addSubview:nav];
    
    UILabel *qestionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    qestionTitle.text = @"信用卡";
    qestionTitle.font = FONT(20);
    qestionTitle.textAlignment = NSTextAlignmentCenter;
    qestionTitle.textColor = kWhiteColor;
    [nav addSubview:qestionTitle];
    [self.view addSubview:nav];
    
    
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - 60, 20, 60, 44) target:self action:@selector(homeMessageAction) image:[UIImage imageNamed:@"home_icon_message_default"]];
    [nav addSubview:rightBtn];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableView
    CGFloat tableHeight;
    tableHeight = SCREEN_HEIGHT - 64 - 49;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH,tableHeight) style:UITableViewStyleGrouped];
    self.view.backgroundColor = kWhiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];

    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    headView.backgroundColor = kWhiteColor;
    self.headView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.headView1.backgroundColor = kComm_Color;
    [headView addSubview:self.headView1];
    
    self.tableView.tableHeaderView = headView;
    
    //银行名字
    NSString *todayStr = @"今日还需";
    CGSize size0 = [todayStr lh_sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(MAXFLOAT, 24)];
    self.todayLab = [UILabel lh_labelWithFrame:CGRectMake(WidthScaleSize_W(15),15,size0.width, 24) text:todayStr textColor:kWhiteColor font:FONT(15) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [headView addSubview:self.todayLab];
    
    
    //银行名字
    NSString *bankName = @"                                     ";
    CGSize size = [bankName lh_sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(MAXFLOAT, 24)];
    bankNameLab = [UILabel lh_labelWithFrame:CGRectMake(SCREEN_WIDTH - 40 - size.width, 15,size.width , 24) text:bankName textColor:kWhiteColor font:FONT(15) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
    [headView addSubview:bankNameLab];
    //编辑按钮
    imageV = [UIImageView lh_imageViewWithFrame:CGRectMake(CGRectGetMaxX(bankNameLab.frame)+5, 15, 24, 24) image:[UIImage imageNamed:@"home_icon_edit_default"]];
    imageV.contentMode = UIViewContentModeCenter;
    [self.headView1 addSubview:imageV];
    imageV.userInteractionEnabled = YES;
    imageV.hidden = YES;
    pickView = [[HXCommonPickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    WEAK_SELF();
    [imageV setTapActionWithBlock:^{
        
        [weakSelf  setMonitor];
       
    }];
    pickView.completeBlock = ^(NSString *result) {
        
    if(self.IdsArr.count>0){
        if (result.length==0) {
            
        }else {
        bankNameLab.text = result;
        NSInteger index =  [self.BrankNamesArr indexOfObject:result];
        HJUser *user = [HJUser sharedUser];
        user.selectedIndex = index;
        user.cardId = self.IdsArr[index];
        [user write];
        [self getTodayPlan2WithCardId:user.cardId];

          }
       }
        
    };
    //详情按钮
    self.detailBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH - 60 - 25, CGRectGetMaxY(bankNameLab.frame)+5, 60, 60) target:self action:@selector(detailBtnAction) image:[UIImage imageNamed:@"home_icon_detail_default"]];
    [self.headView1 addSubview:self.detailBtn];
    self.detailBtn.userInteractionEnabled = YES;

 
    //贝塞尔水波
    LLWaveView *waveView = [[LLWaveView alloc]initWithFrame:CGRectMake(0, self.headView1.mj_h - 40, SCREEN_WIDTH, 40)];
    [self.headView1 addSubview:waveView];
    
    [self.tableView registerClass:[HHHomeOneCell class] forCellReuseIdentifier:@"HHHomeOneCell"];
    
    [self addHeadRefresh];
}
- (void)setMonitor{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if(status == 1 || status == 2)
        {
            self.status = YES;
            NSLog(@"有网");
            
            [pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.BrankNamesArr];
            [pickView showPickViewAnimation:YES];
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];

        }else
        {
            NSLog(@"没有网");
            self.status = NO;
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showInfoWithStatus:@"网络不可用，请稍后再试～"];
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];

        }
    }];
    
    
}
//
- (void)getTodayPlan2WithCardId:(NSString *)cardId{

    NetworkClient *netWorkClient  = [[HHHomeDataAPI getTodayPlanWithCardId:cardId] netWorkClient];

    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);

    dispatch_group_async(group, globalQueue, ^{

        netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;

        [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                
                if (api.code == 0) {
                    NSArray *arr = api.data;
                    [self createPriceTypeLabWithDataArr:arr];
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

            netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
            
            [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
                
                if (!error) {
                    
                    if (api.code == 0) {
                        NSArray *arr = api.data;
                        [self createPriceTypeLabWithDataArr:arr];
                        
                    }else{
                        
                        [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
                        
                    }
                    
                }
            }];

        });

    });
//
    
   
    
}
- (void)addHeadRefresh{
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHomeDatas];
    }];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    self.tableView.mj_header = refreshHeader;
    
}
- (void)createPriceTypeLabWithDataArr:(NSArray *)dataArr{
    
    [self.commonView removeFromSuperview];
    //刷卡计划底图
    self.commonView = [UIView lh_viewWithFrame:CGRectMake(WidthScaleSize_W(15), CGRectGetMaxY(self.todayLab.frame)+8, SCREEN_WIDTH - WidthScaleSize_W(15)-85, self.headView1.mj_h - 40 - CGRectGetMaxY(self.todayLab.frame)) backColor:kClearColor];
    [self.headView1 addSubview:self.commonView];
    
    //
    NSArray *arr;
    NSInteger count;
    if(dataArr.count >0&&dataArr.count <4){
        arr = dataArr;
        count = arr.count;
        imageV.hidden = NO;

    }else if(dataArr.count>=4){
        arr = dataArr;
        count = 3;
        imageV.hidden = NO;

    }else{
        if (self.isCardId) {
            imageV.hidden = NO;
            arr = @[@{@"Id":@"",@"RepayMoney":@"当日暂无计划",@"Type":@""}];
            self.detailBtn.userInteractionEnabled = YES;
            count = 1;

        }else{
            arr = @[@{@"Id":@"",@"RepayMoney":@"请添加银行卡",@"Type":@"1"}];
            //详情按钮不能点
            [self.detailBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.detailBtn.userInteractionEnabled = NO;
            imageV.hidden = YES;
        }
        count = 1;
    }
    if (self.priceLab) {
        [self.priceLab removeFromSuperview];
    }
    if (self.categotyLab) {
        [self.categotyLab removeFromSuperview];
    }
    for (NSInteger i = 0; i<count; i++) {
        CGFloat price_h = 20;
        UIFont  *font  = BoldFONT(14);
        UIFont  *reFont = FONT(14);
        if (arr.count == 1) {
            price_h = 55;
            font = BoldFONT(20);
            reFont = FONT(18);
        }else if(arr.count == 2){
            price_h = 30;
            font = BoldFONT(18);
            reFont = FONT(15);
        }else if(arr.count == 3){
            price_h = 20;
            font = BoldFONT(14);
            reFont = FONT(14);
        }
        HHCreditModel *model = [HHCreditModel mj_objectWithKeyValues:arr[i]];
        CGFloat width = 150;
        if (arr.count == 1) {
            width = 170;
        }else{
            width = 150;
        }
        self.priceLab = [UILabel lh_labelWithFrame:CGRectMake(0,i*price_h,width, price_h) text:model.RepayMoney textColor:kWhiteColor font:font textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        NSString *typeName;
        if ([model.Type isEqualToString:@"1"]) {
            typeName = @"刷";
        }else  if ([model.Type isEqualToString:@"2"]) {
            typeName = @"还";
        }
        if ([model.RepayMoney isEqualToString:@"当日暂无计划"]) {
            self.priceLab.text = @"当日暂无计划";
        }else{
            WEAK_SELF();
            if ([model.RepayMoney isEqualToString:@"请添加银行卡"]) {
                self.priceLab.text = [NSString stringWithFormat:@"%@",model.RepayMoney];
                self.priceLab.userInteractionEnabled = YES;
                [self.priceLab setTapActionWithBlock:^{
                     HHAddBankVC *vc = [HHAddBankVC new];
                    vc.backBlock = ^{
                        
                    };
                    [weakSelf.navigationController pushVC:vc];

                }];
            }else{
                self.priceLab.text = [NSString stringWithFormat:@"%@ ¥%@",typeName,model.RepayMoney];

            }
        }
        [self.commonView addSubview:self.priceLab];
        self.categotyLab = [UILabel lh_labelWithFrame:CGRectMake(CGRectGetMaxX(self.priceLab.frame)+10, self.priceLab.mj_y,80, price_h) text:model.TypeName textColor:kWhiteColor font:reFont textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        self.categotyLab.text = model.BussinessTypeName;
        
        [self.commonView addSubview:self.categotyLab];
    }
   
}
- (void)configAnnoWith:(NSArray *)ano_arr{
    
    if (ano_arr.count == 0) {
        ano_arr = @[@"暂时没有通知～"];
    }
    self.bulletin = [[HXbulletinView alloc]initWithFrame:CGRectMake(WidthScaleSize_W(65), CGRectGetMaxY(self.headView1.frame)+5, SCREEN_WIDTH - WidthScaleSize_W(65)*2, 20)];
    self.bulletin.cycleScroll.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.bulletin.cycleScroll.autoScrollTimeInterval = 3.0;
    self.bulletin.cycleScroll.showPageControl = NO;
    self.bulletin.cycleScroll.onlyDisplayText  = YES;
    self.bulletin.cycleScroll.backgroundColor = kWhiteColor;
    self.bulletin.cycleScroll.titlesGroup = ano_arr;
    self.bulletin.cycleScroll.titleLabelBackgroundColor = kWhiteColor;
    self.bulletin.cycleScroll.titleLabelTextColor = kBlackColor;
    self.bulletin.cycleScroll.titleLabelTextFont = FONT(13.);
    self.bulletin.userInteractionEnabled = YES;
    [headView addSubview:self.bulletin];
    
    
}
- (void)getHomeDatas{

    //获取用户信用卡列表
    
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    NetworkClient *netWorkClient = [[HHHomeDataAPI getUserAllCardList] netWorkClient];
    dispatch_group_async(group, globalQueue, ^{
    // //加载缓存
    [self.BrankNamesArr removeAllObjects];
    [self.IdsArr removeAllObjects];
    [self.CradNosArr  removeAllObjects];
    netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
    [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if (!error) {
            
            if (api.code == 0) {
                NSArray *arr = api.data;
                self.creditsArr = arr.mutableCopy;
                [self.creditsArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *CradNo = dic[@"CardNo"];
                    NSString *subCradNo = [CradNo substringFromIndex:CradNo.length-4];
                    NSString *BrankName = [NSString stringWithFormat:@"%@(%@)",dic[@"BrankName"],subCradNo];
                    [self.BrankNamesArr addObject:BrankName];
                    [self.IdsArr addObject: dic[@"Id"]];
                    [self.CradNosArr addObject: dic[@"CardNo"]];
                }];
                if (self.creditsArr.count>0) {
                    //当日计划
                    HJUser *user = [HJUser sharedUser];
                    NSInteger  index = user.selectedIndex;
                    NSDictionary *oneDic;
                    if (index>0) {
                        oneDic = self.creditsArr[index];
                    }else{
                        oneDic = self.creditsArr[0];
                    }
                    NSString *CradNo1 = oneDic[@"CardNo"];
                    NSString *subCradNo1 = [CradNo1 substringFromIndex:CradNo1.length-4];
                    NSString *BrankName1 = [NSString stringWithFormat:@"%@(%@)",oneDic[@"BrankName"],subCradNo1];
                    bankNameLab.text = BrankName1;
                    user.cardId = oneDic[@"Id"];
                    [user write];
                    [self getTodayPlan];
                }else{
                    
                    [self getTodayPlan];
                }
                
                dispatch_semaphore_signal(semaphore);

            }else{
                
                [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
            }
            
        }else{
            
            NSLog(@"错误信息：%@",error);
        }
        
    }];
    
    });
    dispatch_group_notify(group, globalQueue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        dispatch_async(dispatch_get_main_queue(), ^{

    [self.BrankNamesArr removeAllObjects];
    [self.IdsArr removeAllObjects];
    [self.CradNosArr  removeAllObjects];
    netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if (!error) {
            
            if (api.code == 0) {
                NSArray *arr = api.data;
                self.creditsArr = arr.mutableCopy;
                [self.creditsArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *CradNo = dic[@"CardNo"];
                    NSString *subCradNo = [CradNo substringFromIndex:CradNo.length-4];
                    NSString *BrankName = [NSString stringWithFormat:@"%@(%@)",dic[@"BrankName"],subCradNo];
                    [self.BrankNamesArr addObject:BrankName];
                    [self.IdsArr addObject: dic[@"Id"]];
                    [self.CradNosArr addObject: dic[@"CardNo"]];
                }];
                if (self.creditsArr.count>0) {
                    //当日计划
                    HJUser *user = [HJUser sharedUser];
                    NSInteger  index = user.selectedIndex;
                    NSDictionary *oneDic;
                    if (index>0) {
                        oneDic = self.creditsArr[index];
                    }else{
                        oneDic = self.creditsArr[0];
                    }
                    NSString *CradNo1 = oneDic[@"CardNo"];
                    NSString *subCradNo1 = [CradNo1 substringFromIndex:CradNo1.length-4];
                    NSString *BrankName1 = [NSString stringWithFormat:@"%@(%@)",oneDic[@"BrankName"],subCradNo1];
                    bankNameLab.text = BrankName1;
                    user.cardId = oneDic[@"Id"];
                    [user write];
                    [self getTodayPlan];
                }else{
                    
                    [self getTodayPlan];
                }
                
                
            }else{
                
                [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
            }
            
        }
        
    }];

        });

    });
   
    //获取首页其他信息
    [[[HHHomeDataAPI getIndexBase] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if(!error){
            
            if (api.code == 0) {
                
                self.model = [HHHomeModel mj_objectWithKeyValues:api.data];
                [self.tableView reloadData];
                
                //消息
                [self configAnnoWith:self.model.Message];
                
            }
            
        }else{
            
            NSLog(@"错误信息：%@",error);
            
        }
    }];
}
- (void)getTodayPlan{
    
    if (self.IdsArr.count == 0) {
        //没有信用卡
        //设置信用卡名字
        self.isCardId = NO;
        NSArray *arr = @[];
        [self createPriceTypeLabWithDataArr:arr];
        
    }else if (self.IdsArr.count > 0) {
     //有信用卡
    self.isCardId = YES;
    
        //只有一张信用卡
        if (self.IdsArr.count == 1) {
            NSString *cardId = self.IdsArr[0];
            [self getTodayPlanWithCardId:cardId];
        }else{
            //已选择的银行卡
            HJUser *user = [HJUser sharedUser];
            NSString *cardId = user.cardId;
            [self getTodayPlanWithCardId:cardId];
            
        }
    
    }
}
- (void)getTodayPlanWithCardId:(NSString *)cardId{
    
    NetworkClient *netWorkClient  = [[HHHomeDataAPI getTodayPlanWithCardId:cardId] netWorkClient];
    
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, globalQueue, ^{
        
        netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
        
        [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
            
            if (!error) {
                if (api.code == 0) {
                    NSArray *arr = api.data;
                    [self createPriceTypeLabWithDataArr:arr];
                    dispatch_semaphore_signal(semaphore);

                }else{
                    
                    [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
                }
                
            }else{
                
                NSLog(@"错误信息：%@",error);
            }
        }];
        
        
    });
    dispatch_group_notify(group, globalQueue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            netWorkClient.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
            
            [netWorkClient getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
                
                if (!error) {
                    if (api.code == 0) {
                        NSArray *arr = api.data;
                        [self createPriceTypeLabWithDataArr:arr];
                        
                    }else{
                        
                        [self lh_showHudInView:self.view labText:@"服务器开小差了～"];
                    }
                    
                }else{
                    
                    NSLog(@"错误信息：%@",error);
                }
            }];
            
            
        });
        
    });
    
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
    
}
- (void)detailBtnAction{
    
    HHPlanVC *vc = [[HHPlanVC alloc] init];
    HJUser *user = [HJUser sharedUser];
    vc.CardId = user.cardId;
    [self.navigationController pushVC:vc];
    
}

- (void)homeMessageAction{
    
    HHMessageVC *vc = [HHMessageVC new];
    [self.navigationController pushVC:vc];
    
}

#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        
        HHHomeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHHomeOneCell"];
        cell.nav = self.navigationController;
        cell.buttonSelectBlock = ^(UIButton *btn) {
            
            if (btn.tag == 10000) {
                //信用卡超市
                HHBankListVC *vc = [HHBankListVC new];
                vc.titleStr = @"办卡";
                vc.pushType = getBankCardType;
                [self.navigationController pushVC:vc];
                
            }else  if (btn.tag == 10001) {
                //贷款超市
                HHLoadVC *vc = [HHLoadVC new];
                vc.titleStr = @"贷款";
                [self.navigationController pushVC:vc];
            }else  if (btn.tag == 10002) {
                //直播现场
                HHH5CommonVC *vc = [HHH5CommonVC new];
                vc.titleStr = @"直播";
                vc.commonUrl = self.model.LiveBroadcastUrl;
                [self.navigationController pushVC:vc];
            }else  if (btn.tag == 10003) {
                //最新技术
                HHAriticleVC *vc = [HHAriticleVC new];
                [self.navigationController pushVC:vc];

            }else  if (btn.tag == 10004) {
                //一键提额
                HHH5CommonVC *vc = [HHH5CommonVC new];
                vc.titleStr = @"一键提额";
                vc.commonUrl = self.model.LiveBroadcastUrl;
                [self.navigationController pushVC:vc];
            }else  if (btn.tag == 10005) {
                //一键贷款
                HHH5CommonVC *vc = [HHH5CommonVC new];
                vc.titleStr = @"办卡进度";
                vc.commonUrl = self.model.CreateCardUrl;
                [self.navigationController pushVC:vc];
            }
            
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section == 0&&indexPath.row == 1) {
        
        NSArray *titiles = @[@"历史佣金",@"可提现佣金"];
        NSArray *counts = @[self.model.HistoryCommission?self.model.HistoryCommission:@"0.00",self.model.Commission?self.model.Commission:@"0.00"];
        UITableViewCell *cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            
            for(NSInteger i = 0 ;i<2;i++){
                HHCommentSection  *section = [[HHCommentSection alloc]initWithFrame:CGRectMake(i*(SCREEN_WIDTH/2 + 1), 0, SCREEN_WIDTH/2 - 1, WidthScaleSize_H(50))];
                section.userInteractionEnabled = YES;
                section.tag = i+10000;
                section.titleLabel.text = [NSString stringWithFormat:@"¥%@",counts[i]];
                section.countLabel.text = titiles[i];
                section.countLabel.textColor = KACLabelColor;
                [cell1.contentView addSubview:section];
                if (i<1) {
                    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(section.frame),(section.size.height-WidthScaleSize_H(30))/2 , 1, WidthScaleSize_H(30))];
                    line.backgroundColor = KACLabelColor;
                    [cell1.contentView addSubview:line];
                }
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell.contentView addSubview: self.cycleScrollView];
        }
        
        self.cycleScrollView.imageURLStringsGroup = self.model.Carousel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }
    return nil;
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        
        CGFloat imagW = (SCREEN_WIDTH)/3;
        CGFloat imagH = imagW * 18/25;
        
        return 2*imagH + 20;
        
    }else if(indexPath.section == 0&&indexPath.row == 1){
        
        return WidthScaleSize_H(60);

    }else if(indexPath.section == 1){
        
        return SCREEN_WIDTH*0.4;
    }
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
#pragma mark - SDCycleScrollView delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    HHH5CommonVC *vc = [HHH5CommonVC new];
    vc.titleStr = @"头条";
    NSDictionary *dic = self.model.Carousel[index];
    vc.commonUrl =  dic[@"Url"];
    
    [self.navigationController pushVC:vc];
    
}
//尾部
- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4) imageNamesGroup:@[@"img_cardblue_default",@"img_cardgreen_default",@"img_cardred_default"]];
        _cycleScrollView.delegate = self;
    }
    
    return _cycleScrollView;
}

@end
