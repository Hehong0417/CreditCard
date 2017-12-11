#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Effects)
///**
// *  准备高斯模糊
// */
//- (void)prepareToBlur;
//
///**
// *  添加高斯模糊
// *
// *  @param block 点击模糊的范围触发的事件
// */
//- (void)blur;
//
///**
// *  撤销高斯模糊
// */
//- (void)unBlur;
//
//
/////**
//// *  点击模糊的范围触发的事件
//// */
////- (void)tapBlurView;
//
//
///**
// *  纯色设置高斯模糊
// *
// *  @param blurTintColor 颜色
// */
//- (void) setBlurTintColor:(UIColor *)blurTintColor;


/**
 *  添加高斯模糊
 *
 *  @param block 点击模糊的范围触发的事件
 */
- (void)blur;

/**
 *  撤销高斯模糊
 */
- (void)unBlur;




@end
