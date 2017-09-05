//
//  SSPaoMaLabel.m
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import "SSPaoMaLabel.h"
#import "SSTools.h"

@implementation SSPaoMaLabel
{
    int currentCount;//记录当前已经循环了的次数  默认已经循环
}
/*******Head************************跑马灯效果*****************************/
- (void)marqueeView
{
    
    CGRect frame = self.frame;
    frame.origin.x = frame.origin.x -2;
    //方案一
    if(frame.origin.x<-frame.size.width){
        frame.origin.x = CGRectGetMaxX(self.frame);
        //如果循环次数>0
        if (_loopCount >0) {
            currentCount ++;
            if (currentCount == _loopCount) {
                frame.origin.x = CGRectGetMaxX(self.frame);
                self.frame = frame;
                return;
            }
        }
        
    }
    self.frame = frame;
    //方案二
    //    if(frame.origin.x<-frame.size.width){
    //        frame.origin.x = CGRectGetMaxX(self.frame);
    //        [UIView animateWithDuration:1 animations:^{
    //            self.frame = frame;
    //        }];
    //    }else{
    //        self.frame = frame;
    //    }
    
    //延时递归调用
    [self performSelector:@selector(marqueeView) withObject:nil afterDelay:_speed==0?(0.08):(_speed)];
}
/*******End************************跑马灯效果*****************************/


@end
