//
//  TaskNoteBillDetailVC.m
//  TaskNote
//
//  Created by 金汕汕 on 2017/8/4.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteBillDetailVC.h"
#import "TaskNoteBillModel.h"
#import "SSTools.h"
@interface TaskNoteBillDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;//标题、变动说明
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题、变动说明
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//创建时间
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;//描述

@end

@implementation TaskNoteBillDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.describeLabel.text = @"这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行111";
    self.valueLabel.text = _model.billShow;
    self.titleLabel.text = _model.billTitle;
    NSString *ss = [SSTools timestampSwitchTime:[_model.createTime integerValue] andFormatter:@"YYYY-MM-dd HH:mm"];
    self.timeLabel.text = ss;
    self.describeLabel.text = _model.billDescribe;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
