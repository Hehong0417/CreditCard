#import "UIView+Effects.h"
#import <CoreImage/CoreImage.h>
#import <objc/runtime.h>
#import "FXBlurView.h"

@implementation UIView (Effects)

///**
// *  准备高斯模糊
// */
//- (void)prepareToBlur{
//    UIGraphicsBeginImageContext(self.bounds.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
//    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
//    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 8] forKey: @"inputRadius"];
//    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
//    
//    CGImageRef cgImage = [context createCGImage:resultImage fromRect:self.bounds];
//    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    imageView.tag = -1;
//    imageView.image = blurredImage;
//    
//    UIView *overlay = [[UIView alloc] initWithFrame:self.bounds];
//    overlay.tag = -2;
//    overlay.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55/255.0 blue:55/255.0 alpha:0.6];
//    
//    [imageView setAlpha:0];
//    [overlay setAlpha:0];
//    
//    [self addSubview:imageView];
//    [self addSubview:overlay];
//}
//
///**
// *  添加高斯模糊
// */
//- (void)blur{
//
//    UIImageView *imageView = (UIImageView *)[self viewWithTag:-1];
//    UIView *overlay = [self viewWithTag:-2];
//    
//    [UIView animateWithDuration:0.6 animations:^{
//        [imageView setAlpha:1];
//        [overlay setAlpha:1];
//    }];
//}
//
///**
// *  撤销高斯模糊
// */
//-(void)unBlur{
//    UIImageView *imageView = (UIImageView *)[self viewWithTag:-1];
//    UIView *overlay = [self viewWithTag:-2];
//    
//    [UIView animateWithDuration:0.6 animations:^{
//        [imageView setAlpha:0];
//        [overlay setAlpha:0];
//    }];
//}



/**
 *  添加高斯模糊
 */
- (void)blur{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:self.window.bounds];
    blurView.dynamic = NO;
    blurView.tintColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    blurView.iterations = 3; //像素偏移度
    blurView.blurRadius = 10; //模糊程度
    [blurView setAlpha:0];
    blurView.tag = 2000;
    [self.window addSubview:blurView];
    
    [UIView animateWithDuration:0.6 animations:^{
        [blurView setAlpha:1];
    }];

}

/**
 *  撤销高斯模糊
 */
-(void)unBlur{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    FXBlurView *blurView = (FXBlurView *)[self.window viewWithTag:2000];
    [UIView animateWithDuration:0.6 animations:^{
        [blurView setAlpha:0];
    } completion:^(BOOL finished) {
        [blurView removeFromSuperview];
    }];
}

@end
