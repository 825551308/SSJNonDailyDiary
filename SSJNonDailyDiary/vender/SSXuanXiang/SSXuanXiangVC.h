//
//  SSXuanXiangVC.h
//  选项卡Demo
//
//  Created by jssName on 16/3/23.
//  Copyright © 2016年 jssName. All rights reserved.
//


/*****************************************************************
 *                  选项卡Demo性能优化_
 *
 * 1、 控制器数组存储_第二次加载直接从数组读取控制器
 *
 * 2、 调用代理方法之前先判断有没有实现代理方法_respondsToSelector方法
 *****************************************************************/

#import <UIKit/UIKit.h>

@protocol SSXuanXiangVCDelegate <NSObject>

- (UIViewController *)returnVC:(NSInteger)_index obj:(id)obj;

@end

@interface SSXuanXiangVC : UIViewController
/**
 *  eveWidth:单个view的宽度
    titleArray:标题数组
    titleColorValue:字体颜色
    titleSelectedColorValue:选中后的字体颜色
    bcgViewColorValue:单个view的背景色
    delegateViewController:代理控制层
 */
@property (nonatomic , assign) CGFloat eveWidth;
@property (nonatomic , strong) NSArray *titleArray;
@property (nonatomic , strong) UIColor *titleColorValue;
@property (nonatomic , strong) UIColor *titleSelectedColorValue;
@property (nonatomic , strong) UIColor *bcgViewColorValue;

@property (nonatomic , strong) id<SSXuanXiangVCDelegate> delegate;
@property (nonatomic , strong) id delegateViewController;
typedef void(^ClickBlock)(NSInteger index);
@property (nonatomic,strong)  ClickBlock clickBlock;//点击时候会调用一次，针对业务要求可实现亦不实现
- (void)buildView;
- (void)addToSelfView:(CGRect)fr;

+ (SSXuanXiangVC *)shareManager;
#pragma 初始化 废弃
//+(SSXuanXiangVC *)shareSSXuanXiangVC:(id)delegate titleArray:(NSArray *)_titleArray vcArray:(NSArray *)_vcArray;
#pragma 初始化 这个方式更加灵活
+(SSXuanXiangVC *)shareSSXuanXiangVC:(id)delegate titleArray:(NSArray *)_titleArray;
#pragma 初始化 这个方式更加灵活--再次优化
+(SSXuanXiangVC *)shareSSXuanXiangVC:(id)_delegate titleArray:(NSArray *)_titleArray otherBlock:(void(^)(SSXuanXiangVC *xuanvc))_otherBlock;
/** 设置头部滚动菜单栏是否隐藏 */
- (void)setTopViewHidden:(BOOL)hiddenValue;
- (void)pushVC:(UIViewController *)vc;
@end
