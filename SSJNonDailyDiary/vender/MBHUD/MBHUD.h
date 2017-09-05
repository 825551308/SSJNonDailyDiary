//
//  MBHUD.h
//  MobileApplicationPlatform
//
//  Created by administrator on 16-4-11.
//  Copyright (c) 2016年 HCMAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBHUD : NSObject
/// hud
@property (nonatomic,strong) MBProgressHUD *HUD;
+ (MBHUD *)shareHUD;
+ (void)showHudInView:(UIView *)view hint:(NSString *)hint;

+ (void)hideHud;

+ (void)showHint:(NSString *)hint;

+ (void)showHint:(NSString *)hint yOffset:(float)yOffset;

+ (void)showSuccess:(NSString *)hint;
@end
