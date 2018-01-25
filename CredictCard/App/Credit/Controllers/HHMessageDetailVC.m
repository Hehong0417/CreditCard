//
//  HHMessageDetailVC.m
//  CredictCard
//
//  Created by User on 2017/12/25.
//  Copyright © 2017年 User. All rights reserved.
//

#import "HHMessageDetailVC.h"

@interface HHMessageDetailVC ()

@property (nonatomic, strong)  UILabel *titleLab;
@property (nonatomic, strong)  UITextView *content;

@end

@implementation HHMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //消息详情
    self.title = @"消息详情";
    
    self.view.backgroundColor = kWhiteColor;
    
    //获取数据
    [self getDatas];
    
    self.titleLab = [UILabel lh_labelWithFrame:CGRectMake(15, 25, SCREEN_WIDTH-30,30) text:@"" textColor:kBlackColor font:FONT(17) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    [self.view addSubview:self.titleLab];
    
    self.content = [UITextView lh_textViewWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+15, SCREEN_WIDTH - 30, SCREEN_HEIGHT - CGRectGetMaxY(self.titleLab.frame)-15-15) font:FONT(14) backgroundColor:kWhiteColor];
    [self.view addSubview:self.content];
    self.content.editable = NO;
    
}
- (void)getDatas{
    
    [[[HHHomeDataAPI getNoticeDetailWithId:self.Id] netWorkClient] getRequestInView:nil finishedBlock:^(HHHomeDataAPI *api, NSError *error) {
        
        if (!error) {
        
            if (api.code == 0) {
                
                NSDictionary *dic = api.data;
                self.titleLab.text = dic[@"Title"];
                self.content.text = dic[@"Content"];
            }else{
                [SVProgressHUD showInfoWithStatus:api.msg];
            }
        }
        
    }];
    
}

@end
