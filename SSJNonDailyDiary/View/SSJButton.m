//
//  TaskNoteButton.m
//  TaskNote
//
//  Created by 金汕汕 on 17/4/27.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteButton.h"

@implementation TaskNoteButton

- (void)awakeFromNib{
    if (self) {
        self.layer.cornerRadius = 6.0;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


@end
