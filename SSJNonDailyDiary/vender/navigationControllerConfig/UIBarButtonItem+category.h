//
//  UIBarButtonItem+category.h
//  MobileApplicationPlatform
//
//  Created by 金汕汕 on 17/5/12.
//  Copyright © 2017年 HCMAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (category)
+ (UIBarButtonItem *)initWithSender:(id)sender imageName:(NSString *)imageName methodName:(NSString *)methodName;

+ (UIBarButtonItem *)initWithSender:(id)sender title:(NSString *)title methodName:(NSString *)methodName;
+ (UIBarButtonItem *)initWithSender:(id)sender title:(NSString *)title methodName:(NSString *)methodName titleSize:(CGFloat)titleSize;

/** 模态导航条左上角“X”按钮 */
+ (UIBarButtonItem *)gainDissMissButtonWithSender:(id)sender;
@end
