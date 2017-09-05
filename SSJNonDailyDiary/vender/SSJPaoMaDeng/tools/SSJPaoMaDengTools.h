//
//  SSTools.h
//  waterPro
//
//  Created by jssName on 16/1/22.
//  Copyright © 2016年 HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SSTools : NSObject

+ (void)showMessage:(NSString *)message;

//单独计算文本的高度
+ (CGFloat)heightForText:(NSString *)text size:(CGFloat)_size;


//单独计算文本的宽度
+ (CGFloat)widthForText:(NSString *)text size:(CGFloat)_size;
@end
