//
//  TaskNoteBillModel.m
//  TaskNote
//
//  Created by 金汕汕 on 2017/8/3.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteBillModel.h"
#import "SSTools.h"

@implementation TaskNoteBillModel
- (void)setCreateTime:(NSString *)createTime{
    _createTime = createTime;
//    if (createTime.length > 0) {
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
    
    
//        [formatter setDateFormat:@"yyyyMM"];
//        NSDate *date = [formatter dateFromString:createTime];
//        NSString *week = [SSTools getWeekDayFordate:date];
//        
//        NSString *time =  [SSTools returnDataStrWithString:createTime formateStr:@"hh:mm"];
//        time = [SSTools dealWithTime:time];
//        
//        _weekDay = week;
//        _createTimehhmm = time;
//    }
    if (createTime.length > 0) {
        [self distanceTimeWithBeforeTime:[createTime doubleValue]];
    }
    
    
    
}

- (void)setBillValue:(NSString *)billValue{
    _billValue = billValue;
    if (billValue.length > 0) {
        if (_billType == BillTypeOfPay) {
            _billShow = [@"-" stringByAppendingString:billValue];
            _logoImageName = @"moneyPay";
        }else if (_billType == BillTypeOfGain) {
            _billShow = [@"+" stringByAppendingString:billValue];
            _logoImageName = @"moneyGain";
        }
    }
}


- (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
//        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        distanceStr =@"今天";
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
//            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
            distanceStr =@"昨天";
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    
    else if(distanceTime <24*60*60*365){
//        [df setDateFormat:@"MM-dd HH:mm"];
        [df setDateFormat:@"MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
//        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        [df setDateFormat:@"yyyy-MM-dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    _weekDay = distanceStr;
    _createTimehhmm = timeStr;
    
    [df setDateFormat:@"YYYY-MM-dd HH:mm"];
    distanceStr = [df stringFromDate:beDate];
    _dateShow = distanceStr;
    return distanceStr;
}
- (NSString *)weekDay{
    [self distanceTimeWithBeforeTime:[_createTime doubleValue]];
    return _weekDay;
}

@end
