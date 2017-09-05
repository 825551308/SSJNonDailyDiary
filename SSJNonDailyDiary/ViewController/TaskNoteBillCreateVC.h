//
//  TaskNoteCreateVC.h
//  TaskNote
//
//  Created by 金汕汕 on 17/4/27.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
@class TaskNoteModel;
typedef NS_ENUM(NSInteger, State) {
    StateOfCreate = 0,       //创建
    StateOfCheck = 1,       //查看(列表点击－－将model带过来，直接填充当前界面)
    StateOfUpdate = 2       //修改(列表点击－－将model带过来，直接填充当前界面,点击修改才能进行编辑)
};

@interface TaskNoteBillCreateVC : FatherViewController
@property (nonatomic,assign) State state;//新建还是修改
@property (nonatomic,strong) TaskNoteModel *detailModel;
@property (nonatomic,copy) void (^refurbishBlock)(BOOL updateRes);
@end
