//
//  NSString+MAPMonitorTime.m
//  MobileApplicationPlatform
//
//  Created by zhangdd on 15-6-1.
//  Copyright (c) 2015年 HCMAP. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)
+(NSString *)formattedTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSString *formattedTime = [[NSString alloc]initWithFormat:@"%@",date];
    return formattedTime;
    
}

+(NSString *)secondTime{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss:SSS"];
//    NSDate* date1 = [formatter dateFromString:@"2016-04-08 11:50:59.111"];
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",time];
    return timeStr;
}
@end
