//
//  withDrawCommissionVC.m
//  CredictCard
//
//  Created by User on 2017/12/15.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHwithDrawCommissionVC.h"
#import "HHWithDrawVC.h"
#import "HHCanWithDrawCell.h"
#import "HHUserInfoModel.h"

@interface HHwithDrawCommissionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UITableView *tableView;

//价格
@property(nonatomic,strong)UILabel *priceLab;
//店铺名称
@property(nonatomic,strong)UILabel *storeNameLab;

@property(nonatomic,strong)UIImageView *imagV;

@property (nonatomic, strong)   HHUserInfoModel *userInfoModel;

@end

@implementation HHwithDrawCommissionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getDatas];
    
    self.title = @"可提现佣金";
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHCanWithDrawCell" bundle:nil] forCellReuseIdentifier:@"HHCanWithDrawCell"];
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) backColor:kClearColor];
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 20, SCREEN_WIDTH - 60, 45) target:self action:@selector(finishBtnAction) backgroundImage:nil title:@"我要提现" titleColor:kWhiteColor font:FONT(17)];
    finishBtn.backgroundColor = kComm_Color;
    [finishBtn lh_setRadii:5 borderWidth:0 borderColor:nil];
    
    [footView addSubview:finishBtn];
    self.tableView.tableFooterView = footView;
    
    self.tableView.backgroundColor = kWhiteColor;
    
}
- (void)finishBtnAction{
    
    HHWithDrawVC *vc = [[HHWithDrawVC alloc] init];
    [self.navigationController pushVC:vc];
    
}
- (void)getDatas{
    
    [[[HHPerCenterDataAPI getUserInfo] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                
                self.userInfoModel =  [HHUserInfoModel mj_objectWithKeyValues:api.data];
                [self.tableView reloadData];
                
            }else {
                
                
            }
            
        }else{
            
            NSLog(@"错误信息：%@",error);
        }
        
    }];
    
}
#pragma mark --- tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHCanWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHCanWithDrawCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0){
        cell.bgImagV.image = [UIImage imageNamed:@"user_imgs_default"];
        cell.titleLab.text = @"已提现佣金";
        CGFloat  canCommission = self.userInfoModel.HistoryCommission.floatValue - self.userInfoModel.Commission.floatValue;
        cell.priceLab.text = [NSString stringWithFormat:@"¥%.2f",canCommission?canCommission:0.00];

    }else if (indexPath.section == 1){
        cell.bgImagV.image = [UIImage imageNamed:@"user_img_default"];
        cell.titleLab.text = @"可提现佣金";
        CGFloat  commission = self.userInfoModel.Commission.floatValue;
        cell.priceLab.text =  [NSString stringWithFormat:@"¥%.2f",commission?commission:0.00];

    }
        return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}

@end
