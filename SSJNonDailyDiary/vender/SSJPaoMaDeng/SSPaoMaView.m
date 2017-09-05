//
//  SSPaoMaView.m
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import "SSPaoMaView.h"
#import "SSPaoMaLabel.h"
#import "SSTools.h"
@implementation SSPaoMaView

- (void)startBuildView{
    //创建label
    SSPaoMaLabel *contentLabel=[SSPaoMaLabel new];
   _fontSizeStr = _fontSizeStr==0?(14.0):(_fontSizeStr);
    contentLabel.font=[UIFont systemFontOfSize:_fontSizeStr];
    contentLabel.text = _txtStr;
    contentLabel.frame=CGRectMake(2, 2, [SSTools widthForText:contentLabel.text size:_fontSizeStr], self.frame.size.height-4);
    contentLabel.textColor = _textColor==nil?([UIColor blackColor]):(_textColor);
    contentLabel.backgroundColor = _bcgColor==nil?([UIColor clearColor]):(_bcgColor);
    
    contentLabel.loopCount = _loopCount;
    
    [self addSubview:contentLabel];
//    contentLabel.width = self.frame.size.width;
    
    //设置超出view部分不现实
    self.clipsToBounds=YES;
    
    //根据label字体是否超出  判断是否需要滚动
    if ([SSTools widthForText:contentLabel.text size:_fontSizeStr]>self.frame.size.width) {
        [contentLabel marqueeView];
    }
    
}



@end
