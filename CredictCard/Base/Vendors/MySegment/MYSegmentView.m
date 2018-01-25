//
//  MYSegmentView.m
//  Kitchen
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "MYSegmentView.h"

@implementation MYSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH
{
    if ( self=[super initWithFrame:frame  ])
    {
        float avgWidth = (frame.size.width/controllers.count);
   
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, WidthScaleSize_H(50))];
        self.segmentView.tag=50;
        [self addSubview:self.segmentView];
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, WidthScaleSize_H(50), frame.size.width, frame.size.height-WidthScaleSize_H(50))];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, -1, frame.size.width,frame.size.height-41);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        
        self.line=[[UILabel alloc]initWithFrame:CGRectMake((avgWidth-lineW)/2,WidthScaleSize_H(50) -lineH, lineW, lineH)];
        self.line.backgroundColor = kComm_Color;
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
        
        NSArray *arr = @[@"tab_2",@"t3_pre",@"t2_pre",@"tab_2"];
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, WidthScaleSize_H(50));
            btn.tag=i;
//            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
//            [btn setTitleColor:[UIColor colorWithRed:104/255. green:104/255. blue:104/255. alpha:1] forState:(UIControlStateNormal)];
//            [btn setTitleColor:kComm_Color forState:(UIControlStateSelected)];
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font= FONT(14);
            
            if (i==1)
            {
                [self Click:btn];
            }
            [self.segmentView addSubview:btn];
        }

        self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, WidthScaleSize_H(49), frame.size.width, 1)];
        self.down.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
        [self.segmentView addSubview:self.down];

    }
    
    
    return self;
}

- (void)Click:(UIButton*)sender
{
    
    self.seleBtn.titleLabel.font= FONT(14);
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= FONT(14);
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:@(sender.tag) userInfo:nil];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}

@end
