//
//  MPPickView.m
//  PickViewDemo
//
//  Created by 金汕汕 on 16/12/3.
//  Copyright © 2016年 ccs. All rights reserved.
//



#import "MPPickView.h"

#define textLabelColor  [UIColor redColor]
#define textSizeColor  16.0

@interface MPPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *mpPickView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger selectedRow;
@end

@implementation MPPickView

+ (MPPickView *)instanceMPPickView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MPPickView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}




- (void)createView:(NSMutableArray *)datas{
    _dataArray = datas;
    _mpPickView.delegate = self;
    _mpPickView.dataSource = self;
}



#pragma mark- 设置数据
//一共多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每列对应多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //2.返回当前列对应的行数
    return _dataArray.count;
}

//每列每行对应显示的数据是什么
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *name=_dataArray[row];
//    return name;
//}

//自定义view
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *mycom1 = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 20.0f)];
    
    NSString *imgstr1 = [_dataArray objectAtIndex:row];
    mycom1.text = imgstr1;
    [mycom1 setFont:[UIFont systemFontOfSize: textSizeColor]];
    mycom1.backgroundColor = [UIColor clearColor];
    mycom1.textColor = textLabelColor;
    mycom1.textAlignment = NSTextAlignmentCenter;
    CFShow((__bridge CFTypeRef)(mycom1));
    
    return mycom1;
}


#pragma mark-设置下方的数据刷新
// 当选中了pickerView的某一行的时候调用
// 会将选中的列号和行号作为参数传入
// 只有通过手指选中某一行的时候才会调用
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRow =row;
}

#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}




- (IBAction)sureButtonClick:(id)sender {
    
    NSLog(@"sss %@",_dataArray[_selectedRow]);
    _returnTextBlock(_dataArray[_selectedRow]);
}

- (IBAction)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}
@end
