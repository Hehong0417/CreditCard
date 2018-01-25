//
//  HHUpgradeVC.m
//  CredictCard
//
//  Created by User on 2017/12/26.
//  Copyright © 2017年 User. All rights reserved.
//

#define KpartnerId @"1900000109"
#define KprepayId @""
#define KnonceStr @""


#import "HHUpgradeVC.h"

@interface HHUpgradeVC ()

@property(nonatomic, copy)NSString *HasPayMoney;
@property(nonatomic, copy)NSString *Commission;
@property(nonatomic, strong)NSMutableArray *Grades;
@property(nonatomic, strong)NSMutableArray *ids;
@property(nonatomic, strong)NSMutableArray *moneys;

@property(nonatomic, strong)UILabel *describLab;
@property(nonatomic, strong)HXCommonPickView *pickView;


@property(nonatomic, strong)NSString *NowLevelName;
@property(nonatomic, strong)NSString *NextLevelName;
@property(nonatomic, strong)NSString *LevelUpMoney;

@end

@implementation HHUpgradeVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //微信支付通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPaySucesscount) name:KWX_Pay_Sucess_Notification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPayFailcount) name:KWX_Pay_Fail_Notification object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我要升级";
    
    self.pickView = [[HXCommonPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self getDatas];
    
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) backColor:kClearColor];
    
    self.describLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.describLab.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:self.describLab];
    
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, CGRectGetMaxY(self.describLab.frame)+25, SCREEN_WIDTH - 60, 45) target:self action:@selector(saveAction) backgroundImage:nil title:@"我要升级" titleColor:kWhiteColor font:FONT(17)];
    finishBtn.backgroundColor = kComm_Color;
    [finishBtn lh_setRadii:5 borderWidth:0 borderColor:nil];
    [footView addSubview:finishBtn];
    
    self.tableV.tableFooterView = footView;
    
    
}
#pragma mark - 微信支付

- (void)wxPaySucesscount{
    
    NSLog(@"******支付成功*******");

    
}
- (void)wxPayFailcount {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showErrorWithStatus:@"支付失败～"];
}
- (void)getDatas{
    
    [[[HHPerCenterDataAPI GetNextUpgrade] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                
                self.NowLevelName = api.data[@"NowLevelName"];
                self.NextLevelName = api.data[@"NextLevelName"];
                self.LevelUpMoney = api.data[@"LevelUpMoney"];
                
                HJSettingItem *item = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                item.detailTitle = self.NextLevelName;
                [self.tableV reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                
                NSString *content;
                NSString *LevelUpMoney = [NSString stringWithFormat:@"%@",self.LevelUpMoney];
                if (self.NowLevelName.length == 0) {
                    content = [NSString stringWithFormat:@"您现在还不是会员，升级到%@需要支付%@元",self.NextLevelName,LevelUpMoney];
                    
                }else{
                    
                    content = [NSString stringWithFormat:@"您现在是%@，升级到%@需要支付%@元",self.NowLevelName,self.NextLevelName,LevelUpMoney];
                    
                }

                NSMutableAttributedString *attr = [self lh_attriStrWithResultStr:self.NowLevelName payStr:self.NextLevelName commsionStr:LevelUpMoney Content:content];
                
                 self.describLab.attributedText = attr;
                
                [self.tableV reloadData];
            }
        }
    }];
    
    
    [[[HHPerCenterDataAPI getUserUpgradeInfo] netWorkClient] getRequestInView:nil finishedBlock:^(HHPerCenterDataAPI *api, NSError *error) {
        
        if (!error) {
            
            if (api.code == 0) {
                
                NSArray *arr = api.data[@"Grade"];
                self.HasPayMoney = api.data[@"HasPayMoney"];
                
                NSMutableArray *Grades = [NSMutableArray array];
                NSMutableArray *ids = [NSMutableArray array];
                NSMutableArray *moneys = [NSMutableArray array];

                [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                [Grades addObject:dic[@"Name"]];
                [ids addObject:dic[@"Id"]];
                [moneys addObject:dic[@"Money"]];
                }];
                self.Grades = Grades;
                self.ids = ids;
                self.moneys = moneys;
            }
        }
        
    }];
    
    
}
- (void)saveAction{
    
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]){
        
        //微信支付
        PayReq * req = [[PayReq alloc] init];
//        req.partnerId           = response[@"pd"][@"partner"];
//        req.prepayId            = response[@"pd"][@"prepay_id"];
//        req.nonceStr            = response[@"pd"][@"nonceStr"];
//        NSString *timeStamp = response[@"pd"][@"timeStamp"];
//        req.timeStamp           = timeStamp.intValue;
//        req.package             = @"WXPay";
//        req.sign                = response[@"pd"][@"finalsign"];
        BOOL success =  [WXApi sendReq:req];
        //日志输出
        NSLog(@"partid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\n sign=%@",req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        NSLog(@"success--%d",success);
        
//        self.orderId = response[@"pd"][@"prepay_id"];
        
    }else{
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您未安装微信，是否安装？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[KWX_APPStore_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
        }];
        
        [alertC addAction:action1];
        [alertC addAction:action2];
        [self presentViewController:alertC animated:YES completion:nil];
        
        
    }
//    //升级
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifySuccess object:nil];

    [self.navigationController popVC];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    [self.pickView setStyle:HXCommonPickViewStyleCredit titleArr:self.Grades];
    [self.pickView showPickViewAnimation:YES];
    WEAK_SELF();
    self.pickView.completeBlock = ^(NSString *result) {
      
        HJSettingItem *item = [weakSelf settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        item.detailTitle = result;
        [weakSelf.tableV reloadData];
        
        NSInteger index = [weakSelf.Grades indexOfObject:result];
        NSString *money = weakSelf.moneys[index];
        CGFloat  payMoney = money.floatValue - weakSelf.HasPayMoney.floatValue;
        NSString *payStr = [NSString stringWithFormat:@"%.1f",payMoney];
        NSString *content;
        if (weakSelf.NowLevelName.length==0) {
            content =  [NSString stringWithFormat:@"您现在还不是会员，升级到%@需要支付%@元",result,payStr];
        }else{
            content = [NSString stringWithFormat:@"您现在是%@，升级到%@需要支付%@元",weakSelf.NowLevelName,result,payStr];
        }
        NSMutableAttributedString *attr = [weakSelf lh_attriStrWithResultStr:result payStr:payStr commsionStr:@"10%%" Content:content];

        weakSelf.describLab.attributedText = attr;
        
    };
    
}
- (NSMutableAttributedString *)lh_attriStrWithResultStr:(NSString *)resultStr payStr:(NSString *)payStr commsionStr:(NSString *)commsionStr Content:(NSString *)content{
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSRange resultRange = [content rangeOfString:resultStr];
    NSRange payRange = [content rangeOfString:payStr];
    NSRange commisionRange = [content rangeOfString:commsionStr];
    NSRange contentRange = [content rangeOfString:content];

    [attr addAttribute:NSFontAttributeName value:FONT(14) range:contentRange];
    [attr addAttribute:NSForegroundColorAttributeName value:KACLabelColor range:contentRange];
    [attr addAttribute:NSForegroundColorAttributeName value:kComm_Color range:resultRange];
    [attr addAttribute:NSForegroundColorAttributeName value:kComm_Color range:payRange];
    [attr addAttribute:NSForegroundColorAttributeName value:kComm_Color range:commisionRange];

    return attr;
}

- (NSArray *)indicatorIndexPaths{
    
    return @[[NSIndexPath indexPathForRow:0 inSection:0]];
    
}
- (NSArray *)groupTitles{
    
    return @[@[@"会员级别"]];
    
}
- (NSArray *)groupIcons {
    
    return @[@[@""]];
    
}
- (NSArray *)groupDetials{
    
    return @[@[@"超级会员"]];
    
}

@end
