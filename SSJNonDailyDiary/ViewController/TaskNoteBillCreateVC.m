//
//  TaskNoteCreateVC.m
//  TaskNote
//
//  Created by 金汕汕 on 17/4/27.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteBillCreateVC.h"
#import "PlaceholderTextView.h"
#import "TaskNoteBillModel.h"
#import "TaskNoteButton.h"
#import "SSTools.h"
#import "SSJCustomActionSheet.h"
#import "UIBarButtonItem+category.h"

static NSInteger  const textViewHeightForMax = 10000;
static NSInteger  const textViewTextCountForMax = 500;//限制输入500个字
@interface TaskNoteBillCreateVC ()<SSJCustomActionSheetDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *describeTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describeTextViewLayoutHeight;
/** 完成按钮 */
@property (weak, nonatomic) IBOutlet TaskNoteButton *finishButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishButtonLayoutHeight;
/** 选择类型 */
@property (weak, nonatomic) IBOutlet TaskNoteButton *selectedButton;

@property (nonatomic,strong) SSJCustomActionSheet *customActionSheet;
/** 金额 */
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

/** 完成情况 */
@property (weak, nonatomic) IBOutlet UIView *finishStateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishStateViewLayoutHeight;


@end

@implementation TaskNoteBillCreateVC

- (void)viewDidAppear:(BOOL)animated{
    /** viewDidAppear里可以得到准确的TextView高度 */
    //适应文字高度
    [self fitHeight:self.describeTextView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**< kvo 为textView添加观察者 */
    [self.describeTextView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    /**< 设置导航模态返回 */
    if (_state == StateOfCreate) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem gainDissMissButtonWithSender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/** 背景图片点击  收回键盘 */
- (IBAction)closeKeyBoard:(id)sender {
    [self.view endEditing:YES];
}

/** 完成按钮点击 */
- (IBAction)submitClickAction:(id)sender {
    if ([self validatereate]) {
        TaskNoteBillModel *mdl = [TaskNoteBillModel new];
        mdl.billTitle = self.titleTextField.text;
        mdl.billDescribe = self.describeTextView.text;
        mdl.billType  = [self gainNoteType];
        mdl.billValue = self.moneyTextField.text;
        mdl.createTime = [[NSString secondTime] substringToIndex:([NSString secondTime].length - 3)];
        if ([mdl save]) {
            [MBHUD showHint:@"添加成功！"];
            /**< 刷新首页列表数据 */
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterWithTaskNoteListVCRefurbish object:nil];
                }];
            });
        };
    }
}


/** 测试设备：iPhone4s / 8.1.2系统
 *  中文输入法：输入字母，会走shouldChangeTextInRange＋textViewDidChange ，点击选择中文后会走两次textViewDidChange
 *  其它输入法：输入字母或数字，会走shouldChangeTextInRange＋textViewDidChange
 */
#pragma mark -- UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![text isEqualToString:@""] && [self gainTextCount:textView] > textViewTextCountForMax) {
        [MBHUD showHint:@"已超过最大限度文字数"];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([self gainTextCount:textView] > textViewTextCountForMax) {
        [MBHUD showHint:@"已超过最大限度文字数"];
        textView.text = [textView.text substringToIndex:textViewTextCountForMax];
    }
    
    CGRect newFrame = textView.frame;
    CGSize s = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)];
    if (newFrame.size.height > textViewHeightForMax) {
        newFrame.size.height = textViewHeightForMax;
    }
    newFrame.size.height = s.height;
    textView.frame= newFrame;
    
    if (textView == self.describeTextView) {
        self.describeTextViewLayoutHeight.constant = newFrame.size.height;
        [self.describeTextView layoutIfNeeded];
    }
}

/** 获得textview文字个数 过滤高亮状态文字 */
- (NSInteger)gainTextCount:(UITextView *)textView{
    if (textView.text.length) {
        //_placeLabel.hidden = YES;
    }else{
        //_placeLabel.hidden = NO;
    }
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    NSLog(@"字数：%ld",(long)length);
    return length;
}

/** 自适应高度 */
- (float)fitHeight:(UITextView *)textView{
    
    CGRect newFrame = textView.frame;
    CGSize s = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)];
    if (newFrame.size.height > textViewHeightForMax) {
        newFrame.size.height = textViewHeightForMax;
    }
    newFrame.size.height = s.height;
    textView.frame= newFrame;
    if (textView == self.describeTextView) {
        if (textView.text.length == 0) {
            self.describeTextViewLayoutHeight.constant = 40;
            [self.describeTextView layoutIfNeeded];
            return 40;
        }else{
            self.describeTextViewLayoutHeight.constant = newFrame.size.height;
            [self.describeTextView layoutIfNeeded];
        }
    }
    return newFrame.size.height;
}

/** 选择类型 */
- (IBAction)selectedButtonActionClick:(id)sender {
    if (!self.customActionSheet) {
        self.customActionSheet = [SSJCustomActionSheet instanceSSJCustomActionSheet];
    }
    [self.customActionSheet initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"支出", @"收入"]];
    [self.customActionSheet changeTitleColor:@[[UIColor redColor],[UIColor blueColor],[UIColor blueColor]]];
    [self.customActionSheet showInView];
}

#pragma  mark -- SSJCustomActionSheetDelegate
/* buttonIndex== 1000 代表是取消按钮 */
- (void)sSJCustomActionSheet:(SSJCustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1000:
        {
            [self.customActionSheet removeFromSuperview];
        }
            break;
        case 1001:
        {
            [self.selectedButton setTitle:@"支出" forState:UIControlStateNormal];
            [self.customActionSheet removeFromSuperview];
        }
            break;
        case 1002:
        {
            [self.selectedButton setTitle:@"收入" forState:UIControlStateNormal];
            [self.customActionSheet removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

/** 创建验证 */
- (BOOL)validatereate{
    if (self.titleTextField.text.length == 0) {
        [MBHUD showHint:@"亲，您还没有输入标题呢！"];
        return NO;
    }
    return YES;
}
- (NSInteger)gainNoteType{
    NSString *typeString = self.selectedButton.titleLabel.text;
    if ([typeString isEqualToString:@"支出"]) {
        return BillTypeOfPay;
    }else  {
        return BillTypeOfGain;
    }
}

/** 模态Diss返回 */
- (void)buttonWithDissMiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 添加观察者必须要实现的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if (object == self.describeTextView) {
            [self fitHeight:self.describeTextView];
        }
    }
}
//取消kvo监听
- (void)dealloc{
    @try {
        [self.describeTextView removeObserver:self forKeyPath:@"text" context:nil];
    }@catch(NSException *exception){
        NSLog(@"崩溃了");
    }
}
@end
