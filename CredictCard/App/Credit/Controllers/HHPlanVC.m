//
//  PlanVC.m
//  CredictCard
//
//  Created by User on 2017/12/13.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHPlanVC.h"
#import "HHTodayPlan1VC.h"
#import "HHAllPlanVC.h"

@interface HHPlanVC ()<UIScrollViewDelegate,SGSegmentedControlDelegate>
@property(nonatomic,strong)   SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong)   NSMutableArray *title_arr;

@end

@implementation HHPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"当天计划";
    
    self.title_arr = [NSMutableArray arrayWithArray:@[@"当天计划",@"当月计划"]];
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];
    
}

- (void)setupSegmentedControl {
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.title_arr.count, 0);
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    if (self.title_arr.count < 5) {
        self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, WidthScaleSize_H(50)) delegate:self segmentedControlType:(SGSegmentedControlTypeStatic) titleArr:self.title_arr];
    }else{
        
        self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, self.view.frame.size.width, WidthScaleSize_H(50)) delegate:self segmentedControlType:(SGSegmentedControlTypeScroll) titleArr:self.title_arr];
    }
    self.SG.titleColorStateNormal = KLightTitleColor;
    self.SG.titleColorStateSelected = kComm_Color;
    self.SG.title_fondOfSize  = FONT(17);
    //    self.SG.showsBottomScrollIndicator = YES;
    self.SG.backgroundColor = kWhiteColor;
    self.SG.indicatorColor = kComm_Color;
    [self.view addSubview:_SG];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.SG.height - 1, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineLightColor ;
    [self.SG addSubview:line];
    
}

- (void)SGSegmentedControl:(SGSegmentedControl *)segmentedControl didSelectBtnAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    if (index == 0) {
        self.title = @"当天计划";
    }else if (index == 1){
        self.title = @"当月计划";
    }
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}
// 添加所有子控制器
- (void)setupChildViewController {
    
    HHTodayPlan1VC *todayPlanVc = [[HHTodayPlan1VC alloc]init];
    todayPlanVc.CardId = self.CardId;
    [self addChildViewController:todayPlanVc];
    
    HHAllPlanVC *allPlanVc = [[HHAllPlanVC alloc]init];
    allPlanVc.CardId = self.CardId;
    [self addChildViewController:allPlanVc];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    if(index == 0){
        HHTodayPlan1VC *vc = self.childViewControllers[index];
        [self.mainScrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
    }else{
        
        HHAllPlanVC *vc = self.childViewControllers[index];
        [self.mainScrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    
 
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [self.SG titleBtnSelectedWithScrollView:scrollView];
}



@end
