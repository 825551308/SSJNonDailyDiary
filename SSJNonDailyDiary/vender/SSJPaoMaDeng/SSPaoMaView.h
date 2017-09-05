//
//  SSPaoMaView.h
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPaoMaView : UIView
@property (nonatomic , strong) NSString *txtStr;//label内容
@property (nonatomic , assign) CGFloat fontSizeStr;//字体大小

//延伸属性设置
@property (nonatomic , strong) UIColor *textColor;//label背景色
@property (nonatomic , strong) UIColor *bcgColor;//label背景色
@property (nonatomic , assign) NSInteger loopCount ;//循环次数   默认为无限循环

- (void)startBuildView;
@end
