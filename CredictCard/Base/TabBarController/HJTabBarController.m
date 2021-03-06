//
//  JDTabBarController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//
#import "HJTabBarController.h"
#import "HJNavigationController.h"
#import "HJStoryBoardItem.h"
#import "HXTabBar.h"

@interface HJTabBarController () <UITabBarControllerDelegate,HXTabBarDelegate>

@property (nonatomic,strong) NSArray *tabBarItemTitles;
@property (nonatomic,strong) NSArray *tabBarItemNormalImages;
@property (nonatomic,strong) NSArray *tabBarItemSelectedImages;
@property (nonatomic,strong) NSArray *tabBarStoryBoardItems;
@property (strong, nonatomic) NSDate *lastDate;

@end

@implementation HJTabBarController


-(BOOL)shouldAutorotate{
    
    UINavigationController *nav = self.viewControllers[self.Index];
    return [nav.topViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UINavigationController *nav = self.viewControllers[self.Index];
    return [nav.topViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UINavigationController *nav = self.viewControllers[self.Index];
    return [nav.topViewController preferredInterfaceOrientationForPresentation];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //1.添加所有的自控制器
    [self addAllChildVcs];
    
    
    self.delegate = self;
    self.tabBar.tintColor=APP_COMMON_COLOR;
    
//    HXTabBar *tabBar = [[HXTabBar alloc] init];
//    tabBar.customDelegate = self;
//    /** KVC */
//    [self setValue:tabBar forKey:@"tabBar"];
    
}

- (void)addAllChildVcs
{
    
    for (int i=0; i < self.tabBarStoryBoardItems.count; i++) {
        
        UIViewController *childVC = [self viewControllerWithStoryBoardItem:self.tabBarStoryBoardItems[i]];
        
        [self addOneChildVc:childVC title:self.tabBarItemTitles[i] imageName:self.tabBarItemNormalImages[i] selectedImageName:self.tabBarItemSelectedImages[i]];
    }
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    self.Index = self.selectedIndex;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
        UIViewController *vc = tabBarController.selectedViewController;
   
        NSDate *date = [[NSDate alloc] init];
       if ([vc isEqual:viewController]) {
              // 处理双击事件
             if (date.timeIntervalSince1970 - _lastDate.timeIntervalSince1970 < 0.5) {
                 
                 POST_NOTIFY(kNOTIFY_TABBAR_DOUBLE_CLICK, nil);
                 
                   }
              _lastDate = date;
        
                return NO;
            }
       return YES;
}
- (UIViewController *)viewControllerWithStoryBoardItem:(HJStoryBoardItem *)storyBoardItem {
    
    UIViewController *controller = nil;
    
    if (storyBoardItem.viewControllerNonExist) {
        
        controller = (UIViewController *)[[NSClassFromString(storyBoardItem.Identifier) alloc]init];
        
        return controller;
    }
    
    controller = [UIViewController createFromStoryboardName:((HJStoryBoardItem *)storyBoardItem).storyBoardName WithIdentifier:((HJStoryBoardItem *)storyBoardItem).Identifier];
    
    return controller;
    
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //设置标题
    childVc.title = title;
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置图标
    childVc.tabBarItem.image = image;
    
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    //添加导航控制器
    if ([childVc isKindOfClass:[UINavigationController class]]) {
        
        [self addChildViewController:childVc];
        return;
    }
    HJNavigationController *nav = [[HJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kComm_Color, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    //    UITabBar *appearance1 = [UITabBar appearance];
    //    UIImage *navImage = [UIImage imageWithColor:RGB(46, 40, 42)];
    //    [appearance1 setBackgroundImage:navImage];
    //
    
}

#pragma mark - Setter&Getter

- (NSArray *)tabBarItemTitles {
    
    if (!_tabBarItemTitles) {
        
        _tabBarItemTitles = @[ @"首页",
                               @"发现",
                               @"我的"];
    }
    
    return _tabBarItemTitles;
}

- (NSArray *)tabBarItemNormalImages {
    
    if (!_tabBarItemNormalImages) {
        
        _tabBarItemNormalImages = @[@"tab_icon_home_default",
                                    @"tab_icon_find_default",
                                     @"tab_icon_user_default",
                                     ];
    }
    
    return _tabBarItemNormalImages;
}

- (NSArray *)tabBarItemSelectedImages {
    
    if (!_tabBarItemSelectedImages) {
        
        _tabBarItemSelectedImages =  @[@"tab_icon_home_selected",
                                       @"tab_icon_find_selected",
                                       @"tab_icon_user_selected",
                                       ];    }
    
    return _tabBarItemSelectedImages;
}

- (NSArray *)tabBarStoryBoardItems {
    
    if (!_tabBarStoryBoardItems) {
        
        //
        HJStoryBoardItem *item1 = [HJStoryBoardItem itemWithStroyBoardName:@"Home" identifier:@"HHHomeVC" viewControllerNonExist:YES];
        HJStoryBoardItem *item2 = [HJStoryBoardItem itemWithStroyBoardName:@"Found" identifier:@"HHFoundVC" viewControllerNonExist:YES];
        HJStoryBoardItem *item3 = [HJStoryBoardItem itemWithStroyBoardName:@"Mine" identifier:@"HHPersenCenterVC" viewControllerNonExist:YES];
        
        _tabBarStoryBoardItems = @[ item1,
                                    item2,
                                    item3,
                                    ];
    }
    
    return _tabBarStoryBoardItems;
}

- (void)tabBarDidClickPlusButton:(HXTabBar *)tabBar{
    

    
}

@end
