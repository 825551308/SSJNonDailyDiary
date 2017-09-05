//
//  Item2_VC.m
//  选项卡Demo
//
//  Created by jssName on 16/3/24.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import "Item2_VC.h"

@interface Item2_VC ()

@end

@implementation Item2_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 50, 30)];
    lb.text=@"item2";
    
    [self.view addSubview:lb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
