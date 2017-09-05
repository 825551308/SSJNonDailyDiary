//
//  UIViewController+category.m
//  class_getClassMethodDemo
//
//  Created by 金汕汕 on 17/5/25.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "UIViewController+category.h"
#import <objc/runtime.h>
@implementation UIViewController (category)

+ (void)load{
    [super load];
    /**< 交换方法：viewDidLoad和viewDidLoadCategory  在viewDidLoadCategory里可以做一些统计 */
    Method methodFrom = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method methodTo = class_getInstanceMethod([self class], @selector(viewDidLoadCategory));
    method_exchangeImplementations(methodFrom, methodTo);
    /**< 设置导航栏背景色 */
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#07AC84"]];
    /**< 设置导航栏返回按钮字体颜色 */
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoadCategory{
    NSString *classStr = [NSString stringWithFormat:@"%@",[self class]];
    NSString *superClassStr = [NSString stringWithFormat:@"%@",[self.superclass class]];
    /**< 过滤UINavigationController 和 [super viewDidLoad] */
    if (([classStr containsString:@"UIViewController"] || [superClassStr containsString:@"UIViewController"])&& ![classStr isEqualToString:@"UINavigationController"]) {
        NSLog(@"统计＋1");
    }
    [self viewDidLoadCategory];
    /** 设置导航栏标题字体 */
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17] };
//    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, 300, 40)];
//    titleView.backgroundColor = [UIColor redColor];
//    UIButton *titleButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 90, 40)];
//    [titleButton setTitle:@"标题按钮" forState:UIControlStateNormal];
//    [titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [titleView addSubview:titleButton];
//    self.navigationItem.titleView = titleView;
    
//    UIView *topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//    topBkView.backgroundColor = [UIColor clearColor];
//   UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
//    topImageView.backgroundColor = [UIColor whiteColor];
//    topImageView.layer.cornerRadius = topImageView.bounds.size.width/2;
//    topImageView.layer.masksToBounds = YES;
//    topImageView.image = [UIImage imageNamed:@"head"];
//    [topBkView addSubview:topImageView];
//    self.navigationItem.titleView = topBkView;
    
}

- (void)titleButtonClick{
    
}
@end
