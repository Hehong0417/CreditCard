//
//  HXCommonPickView.m
//  HXBudsProject
//
//  Created by n on 2017/3/6.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXCommonPickView.h"
#import "HXTeachingTypeListAPI.h"
#import "HXTeachingTypeListModel.h"
#import "HXTalentvideotypeAPI.h"
#import "HXTalentVideoTypeModel.h"

@interface HXCommonPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,strong) NSMutableArray *teachingTypeList;

@property (nonatomic, strong)   HXTeachingTypeListModel *teachingTypeListModel;

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
        
        UIView *finishView = [UIView lh_viewWithFrame:CGRectMake(-2, 0, SCREEN_WIDTH+4, WidthScaleSize_H(40)) backColor:kWhiteColor];
        [contentView addSubview:finishView];
        
        [finishView lh_setCornerRadius:0 borderWidth:1 borderColor:LineLightColor];
        UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, WidthScaleSize_H(40)) target:self action:@selector(finished:) title:@"完成" titleColor:APP_COMMON_COLOR font:FONT(16) backgroundColor:kWhiteColor];
        [finishView addSubview:finishBtn];
        
        [self addSubview:contentView];
    }
    
    return self;
}

- (void)finished:(UIButton *)btn {

    [self hidePickViewComplete:nil];
  
    if (self.style == HXCommonPickViewStyleSex) {
        
        self.completeBlock(self.selectedItem);

    }else if(self.style == HXCommonPickViewStyleDate){
     
        self.completeBlock2(self.datePick.date);
    
    }else if(self.style == HXCommonPickViewStyleTeachingtype){
    
        HXTeachingTypeVarListModel *model = self.teachingTypeListModel.varList[self.selectIndex];
        
        self.completeBlock2(model);
        
    }else if(self.style == HXCommonPickViewStyleWithDrawWay){
    
        self.completeBlock(self.selectedItem);
    
    }else if(self.style == HXCommonPickViewStyleTeachingYears){
        
        self.completeBlock(self.selectedItem);
        
    }else if(self.style == HXCommonPickViewStyleEducation){
        
        self.completeBlock(self.selectedItem);
        
    }else if(self.style == HXCommonPickViewStyleTalentvideotype){
        
        HXTalentVideoTypeModel *api = [HXTalentVideoTypeModel new];
        HXTalentVideoTypeModel *model = [api.class mj_objectWithKeyValues:self.teachingTypeList[self.selectIndex]];
        self.completeBlock2(model);
        
    }else if(self.style == HXCommonPickViewStylechapterCount){
        
        self.completeBlock(self.selectedItem);
        
    }
    
}
- (void)setStyle:(HXCommonPickViewStyle)style minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate{

     _style = style;
    
            if (self.style == HXCommonPickViewStyleSex) {
                
                [self.titleArr removeAllObjects];
                NSArray *arr = @[@"男",@"女"];
                [self.titleArr addObjectsFromArray:arr];
               
                [self addPickViewInContentView];

                
            }else if (self.style == HXCommonPickViewStyleDate){
    
                UIDatePicker *datePick = [[UIDatePicker alloc]init];
                datePick.frame = CGRectMake(0, WidthScaleSize_H(40), self.frame.size.width, WidthScaleSize_H(220));
                datePick.datePickerMode = UIDatePickerModeDate;
                datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
                if (minimumDate) {
                    datePick.minimumDate = minimumDate;
                }
                if (maximumDate) {
                    datePick.maximumDate = maximumDate;
                }
                self.datePick = datePick;

                [self.contentView addSubview:datePick];
       
            }else if(self.style == HXCommonPickViewStyleTeachingtype){
                
                //教学类型
                [self getTeachingtypeData];
                
            }else if(self.style == HXCommonPickViewStyleWithDrawWay){
                
                [self.titleArr removeAllObjects];
                NSArray *arr = @[@"微信",@"支付宝"];
                [self.titleArr addObjectsFromArray:arr];
                
                [self addPickViewInContentView];

            }else if(self.style == HXCommonPickViewStyleTeachingYears){
              //教龄
                [self.titleArr removeAllObjects];
                NSArray *arr = @[@"1年以下",@"1~3年",@"3~6年",@"6~10年",@"10~20年",@"20年以上"];
                [self.titleArr addObjectsFromArray:arr];
                
                [self addPickViewInContentView];
            
                
            }else if(self.style == HXCommonPickViewStyleEducation){
                //学历
                [self.titleArr removeAllObjects];
                NSArray *arr = @[@"博士研究生",@"硕士研究生",@"本科",@"专科",@"高中"];
                [self.titleArr addObjectsFromArray:arr];
                
                [self addPickViewInContentView];
            }else if(self.style == HXCommonPickViewStyleTalentvideotype){
            
                //才艺类别
                [self getTalentvideotype];
                
            }else if(self.style == HXCommonPickViewStylechapterCount){
                
                //章节数
                [self.titleArr removeAllObjects];
                
                for (NSInteger i = 0;i<50; i++) {
                    
                    [self.titleArr addObject:[NSString stringWithFormat:@"%ld节",i+1]];
   
                }
                
                [self addPickViewInContentView];
                
            }

}

- (void)addPickViewInContentView{

    UIPickerView *sexPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, WidthScaleSize_H(40), SCREEN_WIDTH, WidthScaleSize_H(220))];
    sexPick.dataSource = self;
    sexPick.delegate = self;
    sexPick.backgroundColor = kWhiteColor;
    sexPick.showsSelectionIndicator = YES;
    [self pickerView:sexPick didSelectRow:0 inComponent:0];
    [self.contentView addSubview:sexPick];

}

#pragma mark --网络请求

- (void)getTeachingtypeData {
    
    [[[HXTeachingTypeListAPI getTeachingTypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
        
        HXTeachingTypeListModel *api = [HXTeachingTypeListModel new];
        
        self.teachingTypeListModel = [api.class mj_objectWithKeyValues:responseObject];
        
        [self.titleArr removeAllObjects];
        
        for (HXTeachingTypeVarListModel *model  in self.teachingTypeListModel.varList) {
            [self.titleArr addObject:model.teachingtype_name];
        }
        
        [self addPickViewInContentView];
       
        
    }];
    
}
- (void)getTalentvideotype{

    
    [self.titleArr removeAllObjects];

    [[[HXTalentvideotypeAPI getTalentvideotypeList] netWorkClient] postRequestInView:nil finishedBlock:^(id responseObject, NSError *error) {
       
        NSArray *varlist = responseObject[@"varList"];
        self.teachingTypeList = varlist;
        
        if (varlist.count>0) {
            
            for (NSDictionary *dic in varlist) {
                
                HXTalentVideoTypeModel *api = [HXTalentVideoTypeModel new];
                HXTalentVideoTypeModel *model = [api.class mj_objectWithKeyValues:dic];
                [self.titleArr addObject:model.talentvideotype_name];
                
            }
            
            [self addPickViewInContentView];

        }
      
    }];
  
}
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

    [self removeFromSuperview];

}
@end
