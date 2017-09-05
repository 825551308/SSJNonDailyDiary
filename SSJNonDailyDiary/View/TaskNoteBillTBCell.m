//
//  TaskNoteMainTBCell.m
//  TaskNote
//
//  Created by 金汕汕 on 17/4/26.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteBillTBCell.h"
#import "TaskNoteBillModel.h"
#import "SSTools.h"
@interface TaskNoteBillTBCell()

@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@end
@implementation TaskNoteBillTBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 更新cell数据 */
- (void)updateViewWithObj:(TaskNoteBillModel *)obj{
//    if (obj.createTime.length > 0) {
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        
//        [formatter setDateFormat:@"yyyyMM"];
//        NSDate *date = [formatter dateFromString:obj.createTime];
//         NSString *week = [SSTools getWeekDayFordate:date];
//        
//       NSString *time =  [SSTools returnDataStrWithString:obj.createTime formateStr:@"hh:mm"];
//        time = [SSTools dealWithTime:time];
//       
//        self.weekDayLabel.text = week;
//        self.timeLabel.text = time;
//    }
    
    
//
//    if (obj.billType == BillTypeOfPay) {
//        self.logoImageView.image = [UIImage imageNamed:@"moneyPay"];
//    }else if (obj.billType == BillTypeOfGain) {
//        self.logoImageView.image = [UIImage imageNamed:@"moneyGain"];
//    }
    
    
//    if (obj.billValue.length > 0) {
//        if (obj.billType == BillTypeOfPay) {
//            self.countLabel.text = [@"-" stringByAppendingString:obj.billValue];
//        }else if (obj.billType == BillTypeOfGain) {
//            self.countLabel.text = [@"+" stringByAppendingString:obj.billValue];
//        }
//    }
    

    self.weekDayLabel.text = obj.weekDay;
    self.timeLabel.text = obj.createTimehhmm;
    self.logoImageView.image = [UIImage imageNamed:obj.logoImageName];
    self.countLabel.text = obj.billShow;
        self.describeLabel.text = obj.billDescribe;
}


- (NSString *)getDateAccordingTime:(NSString *)aTime formatStyle:(NSString *)formate{
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:[aTime intValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formate];
    return[formatter stringFromDate:nowDate];
}
@end
