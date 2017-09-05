//
//  SSJCustomActionSheet.m
//  MobileApplicationPlatform
//
//  Created by 金汕汕 on 17/1/11.
//  Copyright © 2017年 HCMAP. All rights reserved.
//

#import "SSJCustomActionSheet.h"

@implementation SSJCustomActionSheet


+ (nonnull SSJCustomActionSheet *)instanceSSJCustomActionSheet
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SSJCustomActionSheet" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
#define btnHeight  40
- (void)initWithTitle:(nullable NSString *)initWithTitle delegate:(nullable id<SSJCustomActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)arr{
    self.delegate = delegate;
    double cancelButtonTitleHeight = 0.0 ;
    if(cancelButtonTitle.length > 0){
        
        UIButton *cancelBtn = [UIButton new];
        cancelBtn.tag = 1000;
        cancelBtn.frame = CGRectMake(5, screen_height - btnHeight -10, screen_width-10, btnHeight);
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [cancelBtn addTarget:self action:@selector(calcelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.layer.cornerRadius = 10.0;
        [self addSubview:cancelBtn];
        cancelButtonTitleHeight = btnHeight +10 +10;
    }
    
    double borderTop = 5.0;double borderBottom = 5.0;
    UIView *otherButtonView = [UIView new];
    otherButtonView.tag = 1999;
        otherButtonView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    otherButtonView.frame = CGRectMake(5, screen_height - cancelButtonTitleHeight - arr.count*btnHeight - (borderTop + borderBottom), screen_width-10 , arr.count*btnHeight + (borderTop + borderBottom) );
    
    for (int i = 0 ; i < arr.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = 1001+ i;
        //        btn.frame = CGRectMake(0, screen_height - cancelButtonTitleHeight - (arr.count-i)*btnHeight, screen_width-10, btnHeight);
        btn.frame = CGRectMake(5, borderTop + i*btnHeight, otherButtonView.frame.size.width - 10, btnHeight);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(calcelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [otherButtonView addSubview:btn];
    }
    otherButtonView.layer.cornerRadius = 10.0;
    [self addSubview:otherButtonView];
}

//- (void)showInView:(UIView *)view{
////    [((UIViewController *)delegate).view addSubview:self];
////    self.frame = CGRectMake(0, 0, screen_width, screen_height-64);
////    self.frame = view.frame;
////    [view addSubview:self];
//    self.backgroundColor = [UIColor clearColor];
//    self.frame = CGRectMake(0, 0, screen_width, screen_height);
//    UIWindow *winDow =  [UIApplication sharedApplication].keyWindow;
//    [winDow addSubview:self];
//}

- (void)showInView{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, screen_width, screen_height);
    UIWindow *winDow =  [UIApplication sharedApplication].keyWindow;
    [winDow addSubview:self];
}

/**
 *  修改按钮字体颜色
 *
 *  @param titleColorArray 字体颜色数组   默认第一个颜色是 取消按钮的字体颜色
 */
- (void)changeTitleColor:(NSArray *)titleColorArray{
//    for (int i = 0 ; i < self.subviews.count; i++) {
//        UIView *subView  =  self.subviews[i];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag == 1000) {
            [((UIButton *)subView) setTitleColor:titleColorArray[0] forState:UIControlStateNormal];
        }
        if ([subView isKindOfClass:[UIView class]] && subView.tag == 1999) {
            for (UIView *subView1 in ((UIView *)subView).subviews) {
                if ([subView1 isKindOfClass:[UIButton class]]) {
                    [((UIButton *)subView1) setTitleColor:titleColorArray[subView1.tag - 1000] forState:UIControlStateNormal];
                }
                
            }
        }
    }
}

- (IBAction)backgroundBtnAction:(id)sender {
    self.hidden = YES;
}
//标题按钮点击
- (void)calcelButtonClick:(id)seneder{
    
    if(self.delegate && [self.delegate performSelector:@selector(sSJCustomActionSheet:clickedButtonAtIndex:) withObject:nil withObject:nil]){
        [self.delegate sSJCustomActionSheet:self clickedButtonAtIndex:((UIButton *)seneder).tag];
    }
}

@end
