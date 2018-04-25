//
//  MBProgressHUD+Ex.m
//  QianLongZan
//
//  Created by jm on 16/9/28.
//  Copyright © 2016年 szty. All rights reserved.
//

#import "MBProgressHUD+Ex.h"

#define MBP_KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
#define MBP_NAVIGATION_HEIGHT 64.0
#define MBP_SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define MBP_SEC 2.0f // 显示的时间长度

@implementation MBProgressHUD (Ex)

// 纯菊花模式
+ (void)show {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBP_KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
}

+ (void)hide {
    [MBProgressHUD hideHUDForView:MBP_KEY_WINDOW animated:YES];
}

+ (void)showInView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.offset = CGPointMake(0, -MBP_NAVIGATION_HEIGHT * 0.5);
//    for (UIView *nav in view.subviews) {
//        if ([nav isKindOfClass:[GTBaseNavigationBar class]]) {
//            [view bringSubviewToFront:nav]; //为了防止nav给挡住
//        }
//    }
}

+ (void)hideFromView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

// 纯文本模式
+ (void)showMsg:(NSString *)msg {
    [MBProgressHUD hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBP_KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MBP_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:MBP_KEY_WINDOW];
    });
}

+ (void)showMsg:(NSString *)msg inView:(UIView *)view {
    [MBProgressHUD hideFromView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.offset = CGPointMake(0, -MBP_NAVIGATION_HEIGHT * 0.5);
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor blackColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MBP_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:view];
    });
}

// 底部显示文字
+ (void)showMsgWithBottom:(NSString *)msg{
    [MBProgressHUD hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBP_KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    
    hud.offset = CGPointMake(0, MBP_SCREEN_HEIGHT * 0.5);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MBP_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:MBP_KEY_WINDOW];
    });
}
+ (void)showMsgWithBottom:(NSString *)msg inView:(UIView *)view{
    [MBProgressHUD hideFromView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    
    hud.offset = CGPointMake(0, MBP_SCREEN_HEIGHT * 0.5);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MBP_SEC * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:view];
    });
}

// 菊花文本模式
+ (void)showLoadingWithMsg:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBP_KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = msg;
}

+ (void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = msg;
}

@end
