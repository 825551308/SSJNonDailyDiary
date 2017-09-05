//
//  UIBarButtonItem+category.m
//  MobileApplicationPlatform
//
//  Created by 金汕汕 on 17/5/12.
//  Copyright © 2017年 HCMAP. All rights reserved.
//

#import "UIBarButtonItem+category.h"

@implementation UIBarButtonItem (category)
+ (UIBarButtonItem *)initWithSender:(id)sender imageName:(NSString *)imageName methodName:(NSString *)methodName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    SEL sel = NSSelectorFromString(methodName);
    [button addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}

+ (UIBarButtonItem *)initWithSender:(id)sender title:(NSString *)title methodName:(NSString *)methodName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setTitle:title forState:UIControlStateNormal];
    SEL sel = NSSelectorFromString(methodName);
    [button addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}
+ (UIBarButtonItem *)initWithSender:(id)sender title:(NSString *)title methodName:(NSString *)methodName titleSize:(CGFloat)titleSize{
    CGFloat widthF = [self getAttributeSizeWithText:title fontSize:titleSize].width;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, widthF, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    }
    SEL sel = NSSelectorFromString(methodName);
    [button addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}


/** 模态导航条左上角“X”按钮 */
+ (UIBarButtonItem *)gainDissMissButtonWithSender:(id)sender {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setImage:[UIImage imageNamed:@"nav_X"] forState:UIControlStateNormal];
    SEL sel = NSSelectorFromString(@"buttonWithDissMiss:");
    [button addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}
+ (void)buttonWithDissMiss:(id)sender{
    [sender dismissViewControllerAnimated:YES completion:nil];
}




+ (CGSize) getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //    if (isIos7Later) {
    size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //    }else{
    //        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //        size = [attributeSting size];
    //    }
    return size;
}
@end
