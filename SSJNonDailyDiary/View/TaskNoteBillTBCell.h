//
//  TaskNoteMainTBCell.h
//  TaskNote
//
//  Created by 金汕汕 on 17/4/26.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskNoteBillModel;

static NSString *taskNoteBillTBCellIden = @"TaskNoteBillTBCellIden";
@interface TaskNoteBillTBCell : UITableViewCell

/** 更新cell数据 */
- (void)updateViewWithObj:(TaskNoteBillModel *)obj;

@end
