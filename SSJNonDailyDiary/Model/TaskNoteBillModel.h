//
//  TaskNoteBillModel.h
//  TaskNote
//
//  Created by 金汕汕 on 2017/8/3.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"
typedef NS_ENUM(NSUInteger, BillType) {
    BillTypeOfPay = 0,      //支出
    BillTypeOfGain = 1,       //收入
};
@interface TaskNoteBillModel : JKDBModel
@property (nonatomic,strong) NSString *billID;
/** 标题 */
@property (nonatomic,strong) NSString *billTitle;

/** 描述 */
@property (nonatomic,strong) NSString *billDescribe;

/** 类型 */
@property (nonatomic,assign) BillType billType;

/** 创建时间 时间戳*/
@property (nonatomic,strong) NSString *createTime;

/** 数额 */
@property (nonatomic,strong) NSString *billValue;


/** 创建时间 小时:分钟*/
@property (nonatomic,strong) NSString *createTimehhmm;
/** 创建时间 周几 */
@property (nonatomic,strong) NSString *weekDay;
/** 图片名字 */
@property (nonatomic,strong) NSString *logoImageName;
/** 要显示的数额 */
@property (nonatomic,strong) NSString *billShow;
/** 要显示的日期 */
@property (nonatomic,strong) NSString *dateShow;
@end
