//
//  MBHUD.m
//  MobileApplicationPlatform
//
//  Created by administrator on 16-4-11.
//  Copyright (c) 2016年 HCMAP. All rights reserved.
//

#import "MBHUD.h"

#import <objc/runtime.h>

@implementation MBHUD

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
static MBHUD *share = nil;
+(MBHUD *)shareHUD{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc] init];
        share.HUD = [[MBProgressHUD alloc] init];
    });
    return share;
}

+ (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

+ (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    HUD.dimBackground = NO;
    //    HUD.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [self setHUD:HUD];
}

+ (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

+ (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.yOffset = yOffset;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

+ (void)hideHud{
    [[self HUD] hide:YES];
}

+ (void)showSuccess:(NSString *)hint{
    //    [[self HUD] hide:YES];
    //    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    }
    hud.mode = MBProgressHUDModeCustomView;
    // 循环播放的图片
    UIImage *image1 = [UIImage imageNamed:@"draw_1"];
    UIImage *image2 = [UIImage imageNamed:@"draw_2"];
    UIImage *image3 = [UIImage imageNamed:@"draw_3"];
    UIImage *image4 = [UIImage imageNamed:@"draw_4"];
    // 初始化UIImageView
    UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 37, 37)];
    [yourImageView setImage:image4];
    // 设置循环播放的图片
    yourImageView.animationImages = [[NSArray alloc] initWithObjects:image1, image2, image3, image4, nil];
    // 设置图片循环播放的次数
    [yourImageView setAnimationRepeatCount:1];
    // 设置每张图片播放的时间(单位为秒)
    yourImageView.animationDuration = 0.5;
    // 开始播放
    [yourImageView startAnimating];
    
    hud.customView = yourImageView;
    hud.labelText = hint;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.7];
}

@end
