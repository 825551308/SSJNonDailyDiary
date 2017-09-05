//
//  SSJCustomActionSheet.h
//  MobileApplicationPlatform
//
//  Created by 金汕汕 on 17/1/11.
//  Copyright © 2017年 HCMAP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSJCustomActionSheet;

@protocol SSJCustomActionSheetDelegate <NSObject>
/* buttonIndex== 1000 代表是取消按钮 */
- (void)sSJCustomActionSheet:(SSJCustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface SSJCustomActionSheet : UIView

@property (nonatomic,weak) id<SSJCustomActionSheetDelegate> delegate;

+ (nonnull SSJCustomActionSheet *)instanceSSJCustomActionSheet;

//- (nonnull instancetype)initWithFrame:(CGRect)frame initWithTitle:(nullable NSString *)initWithTitle delegate:(nullable id<UIActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)arr;
- (void)initWithTitle:(nullable NSString *)initWithTitle delegate:(nullable id<UIActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)arr;

- (void)showInView;

/**
 *  修改按钮字体颜色
 *
 *  @param titleColorArray 字体颜色数组   默认第一个颜色是 取消按钮的字体颜色
 */
- (void)changeTitleColor:(nonnull NSArray *)titleColorArray;
@end
