//
//  HXbulletinView.h
//  mengyaProject
//
//  Created by n on 2017/10/18.
//  Copyright © 2017年 n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"


@interface HXbulletinView : UIView

@property (strong, nonatomic)  SDCycleScrollView *cycleScroll;
@property (strong, nonatomic)  NSArray *titlesGroup;

@end
