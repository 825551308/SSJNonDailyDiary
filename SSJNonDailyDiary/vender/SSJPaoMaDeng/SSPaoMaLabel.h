//
//  SSPaoMaLabel.h
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPaoMaLabel : UILabel
@property (nonatomic , assign) NSInteger loopCount ;//循环次数   默认为无限循环
@property (nonatomic , assign) CGFloat speed;//滚动速度  默认为0.08
//跑马灯
- (void)marqueeView;
@end
