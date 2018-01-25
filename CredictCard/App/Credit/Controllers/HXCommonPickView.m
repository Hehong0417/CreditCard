//
//  HXCommonPickView.m
//  HXBudsProject
//
//  Created by n on 2017/3/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCommonPickView.h"
#import "FullTimeView.h"

@interface HXCommonPickView ()<UIPickerViewDelegate,UIPickerViewDataSource,FinishPickView>

@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,strong) NSMutableArray *teachingTypeList;
@property(nonatomic,strong) NSString *dateStr;
@property(nonatomic,strong) FullTimeView *fullTimePicker;

@property(nonatomic,strong) UIPickerView *sexPick;

@end

@implementation HXCommonPickView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        
        UIView *shadow = [UIView lh_viewWithFrame:self.bounds backColor:kBlackColor];
        shadow.alpha = 0.5;
        shadow.userInteractionEnabled = YES;
        [shadow setTapActionWithBlock:^{
            
            [self hidePickViewComplete:nil];
            
        }];
        [self addSubview:shadow];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, WidthScaleSize_H(260))];
        contentView.backgroundColor = kWhiteColor;
        self.contentView = contentView;
        
        UIView *finishView = [UIView lh_viewWithFrame:CGRectMake(-2, 0, SCREEN_WIDTH+4, WidthScaleSize_H(40)) backColor:RGB(237, 237, 237)];
        [contentView addSubview:finishView];
        
        [finishView lh_setCornerRadius:0 borderWidth:1 borderColor:LineLightColor];
        UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, WidthScaleSize_H(40)) target:self action:@selector(finished:) title:@"完成" titleColor:kComm_Color font:FONT(16) backgroundColor:RGB(237, 237, 237)];
        [finishView addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, WidthScaleSize_H(40)) target:self action:@selector(cancelAction) title:@"取消" titleColor:kComm_Color font:FONT(16) backgroundColor:RGB(237, 237, 237)];
        [finishView addSubview:cancelBtn];
        
        [self addSubview:contentView];
    }
    
    return self;
}
- (void)cancelAction{
    
    [self hidePickViewComplete:nil];
    
}
- (void)finished:(UIButton *)btn {

    [self hidePickViewComplete:nil];
  
    if (self.style == HXCommonPickViewStyleSex) {
        
        self.completeBlock(self.selectedItem);

    }else if(self.style == HXCommonPickViewStyleDate){
     
        self.completeBlock2(self.datePick.date);
    
    }else if (self.style == HXCommonPickViewStyleYearMonth){
        
      self.completeBlock(self.dateStr);

    }else{
        
        self.completeBlock(self.selectedItem);
        
    }
    
}
- (void)setStyle:(HXCommonPickViewStyle)style{
    
    [self setStyle:style minimumDate:nil maximumDate:nil titleArr:nil];

}
- (void)setStyle:(HXCommonPickViewStyle)style titleArr:(NSArray *)titleArr{
    
    [self setStyle:style minimumDate:nil maximumDate:nil titleArr:titleArr];
    
}
- (void)setStyle:(HXCommonPickViewStyle)style minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate titleArr:(NSArray *)titleArr{

     _style = style;
    
            [self.titleArr removeAllObjects];
    
            if (self.style == HXCommonPickViewStyleSex) {
                
                [self.titleArr addObjectsFromArray:titleArr];
               
                [self addPickViewInContentView];

                
            }else if (self.style == HXCommonPickViewStyleDate){
    
                UIDatePicker *datePick = [[UIDatePicker alloc]init];
                datePick.frame = CGRectMake(0, WidthScaleSize_H(40), self.frame.size.width, WidthScaleSize_H(220));
                datePick.datePickerMode = self.datePickerMode;
                datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
                if (minimumDate) {
                    datePick.minimumDate = minimumDate;
                }
                if (maximumDate) {
                    datePick.maximumDate = maximumDate;
                }
                self.datePick = datePick;

                [self.contentView addSubview:datePick];
       
            }else if(self.style == HXCommonPickViewStyleCredit){
                
                [self.titleArr addObjectsFromArray:titleArr];
                
                [self addPickViewInContentView];
                
            }else if (self.style == HXCommonPickViewStyleYearMonth){
                
                self.fullTimePicker = [[FullTimeView alloc]initWithFrame:CGRectMake(0, WidthScaleSize_H(40), self.frame.size.width, WidthScaleSize_H(220))];
                self.fullTimePicker.curDate = [NSDate date];
                self.fullTimePicker.delegate = self;
                
                [self.contentView addSubview:self.fullTimePicker];

            }else if(self.style == HXCommonPickViewStyleError){
                

            }
                
}

#pragma mark - FinishPickView
- (void)didFinishPickView:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    NSString *dateString = [fmt stringFromDate:date];
    self.dateStr = dateString;
}

- (void)addPickViewInContentView{

    self.sexPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, WidthScaleSize_H(40), SCREEN_WIDTH, WidthScaleSize_H(220))];
    self.sexPick.dataSource = self;
    self.sexPick.delegate = self;
    self.sexPick.backgroundColor = kWhiteColor;
    self.sexPick.showsSelectionIndicator = YES;
    HJUser *user = [HJUser sharedUser];
    [self.sexPick selectRow:user.selectedIndex inComponent:0 animated:NO];
    [self.contentView addSubview:self.sexPick];

}

#pragma mark --网络请求


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 37;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.titleArr.count;
   
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectIndex = row;
    
    if (self.titleArr.count > 0) {
        
        self.selectedItem = self.titleArr[row];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = LineLightColor;
        }
    }

    UILabel *titleLabel = [UILabel lh_labelWithFrame:CGRectMake(-2, 0, SCREEN_WIDTH+4, 37) text:self.titleArr[row] textColor:kBlackColor font:FONT(19) textAlignment:NSTextAlignmentCenter backgroundColor:kWhiteColor];
    
    return titleLabel;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.titleArr[row];

}

- ( NSMutableArray *)titleArr {

    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}
- (void)showPickViewAnimation:(BOOL)animated{

    self.animated = animated;
    
    [self addsuperView];
    if (animated) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.contentView.lh_top = self.lh_bottom - WidthScaleSize_H(220);
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
   
 
}
- (void)addsuperView{

    [kKeyWindow addSubview:self];


}
- (void)hidePickViewComplete:(void (^)())completeBlock {

    if (self.animated) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.contentView.lh_top = self.lh_bottom;

        } completion:^(BOOL finished) {
            
            [self removePickView];
        }];
    }


}

- (void)removePickView {

    [self.fullTimePicker removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
