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

//返回日期对象 直接调用[comps year],[comps month]
+ (NSDateComponents *)returnNSDateComponents;

//返回年月日时分秒格式的日期根据你传进来的格式
+ (NSString *)returnTodayDateForYour_FormatString:(NSString *)_formatStr;

//单独计算图片的高度
+ (CGFloat)heightForImage:(UIImage *)image;

//单独计算文本的高度
+ (CGFloat)heightForText:(NSString *)text size:(CGFloat)_size;
+ (CGFloat)widthForText:(NSString *)text size:(CGFloat)_size;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//画圆形头像
+ (void)buildCircleImageView:(UIImageView *)imageView  view:(UIView *)_view;
+ (void)buildCircleImageView:(UIImageView *)imageView  view:(UIView *)_view wid:(float)widFloat;

//压缩图片
+ (UIImage *)imgYaSuo_100:(UIImage *)_img;
+ (UIImage *)imgYaSuo_800:(UIImage *)_img;

/** md5 一般加密 */

+ ( NSString *)md5String:( NSString *)str;

+ (NSString*)fileMD5:(NSString*)pathStr;
+(NSString*)getFileMD5WithPath:(NSString*)path;

//根据传进来的字节返回大小
+(NSString *)sizeValue:(float)size;

//字典转json字符串
+(NSString *)JsonModel:(NSDictionary *)dictModel;

//时间戳转字符串
+ (NSString *)returnDataStrWithString:(NSString *)time formateStr:(NSString *)formateStr;

#pragma mark - 将某个时间戳转化成 时间

+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

//判断时间差几天 跟当前时间比较
+ (NSInteger)getDifferenceByDate:(NSString *)date;


/**
 *  判断是否是纯汉字
 *
 */
+ (BOOL)isChinese:(NSString *)str;

/**
 *  判断是否含有汉字
 *
 */
+ (BOOL)includeChinese:(NSString *)str;

/**
 *  颠倒顺序 数组
 *
 *  @param array 数据源
 *
 *  @return 返回颠倒之后的数组
 */
+ (NSMutableArray *)transposeArray:(NSArray *)array;


/**
 *  替换指定字符附件区间的字符串
 *  比如"dss<div>g<div><b>To:</b><div><b> zju"  想要替换To:附件的前后<div>之间的所有内容 变成“dss<div>g<b> zju”
 *  @param oldString 原字符串
 *  @param rep       指定字符串
 *  @param searchFromString       前一个匹配搜索字符串
 *  @param searchToString       后一个匹配搜索字符串
 *  @param replaceWithString       需要替换的字符串
 *
 *  @return 返回替换后的字符串
 */
+ (NSString *)replaceWithOldString:(NSString *)oldString  rep:(NSString *)rep searchFromString:(NSString *)searchFromString
                    searchToString:(NSString *)searchToString  replaceWithString:(NSString *)replaceWithString;


//搜索指定的字符串   并返回所搜到的所有位置集合
+ (NSMutableArray *)searchCharFromString:(NSString *)searchStrSource  searChar:(NSString *)searChar;



/**
 *  将数组元素拆分，用charValue隔开 组成一个全新的字符串并返回该字符串
 *
 *  @param arr 数组
 *
 *  @return 返回拼接好的字符串
 */
+ (NSString *)stringFromMutable:(NSMutableArray *)arr cutApartWithChar:(NSString *)charValue;



+ (UIBarButtonItem *)createBarButtonItem:(id)sender WithTitleName:(NSString *)titleName withTitleColor:(UIColor *)titleColor withSelName:(NSString *)selName;

/** 如果为12小时制 就在小时后面+12 */
+ (NSString *)dealWithTime:(NSString *)time;
//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(long long)data;

//获得当前viewControll
+(UIViewController *)getCurrentVC;
@end
