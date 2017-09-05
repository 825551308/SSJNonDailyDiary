//
//  SSXuanXiangVC.m
//  选项卡Demo
//
//  Created by jssName on 16/3/23.
//  Copyright © 2016年 jssName. All rights reserved.
//
#define screen  [UIScreen mainScreen].bounds.size

#import "SSXuanXiangVC.h"
#import "SSBarView.h"

@interface SSXuanXiangVC ()

@end

@implementation SSXuanXiangVC
{
    UIViewController *currentVC;
    UIScrollView *scrollView;
    UIView *bottomLineView;
    NSMutableArray *saveVcArray;
    CGRect frm;
}


- (void)setTopViewHidden:(BOOL)hiddenValue{
    scrollView.hidden = hiddenValue;
    if (hiddenValue) {
        scrollView.frame = CGRectMake(0, 0, screen.width, 0);
    }else{
        scrollView.frame = CGRectMake(0, 0, screen.width, 50);
    }
}
- (void)pushVC:(UIViewController *)vc{
    [((UIViewController *)self.delegateViewController).navigationController pushViewController:vc animated:YES];
}

+ (SSXuanXiangVC *)shareManager{
    static SSXuanXiangVC *emailSingleClass = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        emailSingleClass = [[SSXuanXiangVC alloc] init];
    });
    return emailSingleClass;
}

+(SSXuanXiangVC *)shareSSXuanXiangVC:(id)_delegate titleArray:(NSArray *)_titleArray otherBlock:(void(^)(SSXuanXiangVC *xuanvc))_otherBlock{
    SSXuanXiangVC *xuanXiang=[SSXuanXiangVC shareManager];
    
    xuanXiang.delegate=_delegate;
    xuanXiang.titleArray = _titleArray;
    xuanXiang.delegateViewController=_delegate;
    _otherBlock(xuanXiang);
//    xuanXiang.eveWidth = screen.width/3;
//    [xuanXiang buildView];
    return xuanXiang;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******Head************************核心功能*****************************/

- (void)buildView{
    saveVcArray=[NSMutableArray new];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen.width, 50)];
    scrollView.backgroundColor= [UIColor groupTableViewBackgroundColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    
//    currentVC=self.vcArray[0];
    if ([self.delegateViewController respondsToSelector:@selector(returnVC:obj:)]) {
        currentVC = [self.delegate returnVC:0 obj:self];//默认第一个
    }else{
        NSLog(@"没有实现returnVC代理方法");
        return;
    }
    if (saveVcArray.count == 0) {
        for (int i = 0 ; i < self.titleArray.count; i++) {
            [saveVcArray addObject:@""];
        }
    }
    [saveVcArray replaceObjectAtIndex:0 withObject:currentVC];
    
    
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SSBarView *view = [SSBarView new];
        view.frame=CGRectMake(idx*self.eveWidth, 0, self.eveWidth, 50);
        
        UIButton *btnView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.eveWidth, 50)];
        btnView.tag = idx;
        [btnView addTarget:self action:@selector(btnViewClick:) forControlEvents:UIControlEventTouchUpInside];//添加点击
        [btnView setTitle:self.titleArray[idx] forState:UIControlStateNormal];
        //如果titleColorValue没有赋值---标题默认黑色
        self.titleColorValue==nil?([btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]):([btnView setTitleColor:self.titleColorValue forState:UIControlStateNormal]);
        
        //如果bcgViewColorValue没有赋值---view背景色默认灰色
        self.bcgViewColorValue==nil?([btnView setBackgroundColor:[UIColor groupTableViewBackgroundColor]]):([btnView setBackgroundColor:self.bcgViewColorValue]);
//        [btnView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [view addSubview:btnView];//在view上覆盖一层button,为了点击
        
        [scrollView addSubview:view];
        
        // 默认选择第一个 红色
        if (idx==0) {
            //如果titleSelectedColorValue没有赋值---第一个标题红色
            self.titleSelectedColorValue==nil?([btnView setTitleColor:[UIColor redColor] forState:UIControlStateNormal]):([btnView setTitleColor:self.titleSelectedColorValue forState:UIControlStateNormal]);
//            [btnView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }];
    
    [self.view addSubview:scrollView];
    
    if ([self.titleArray count]*self.eveWidth>screen.width) {
        scrollView.contentSize = CGSizeMake([self.titleArray count]*self.eveWidth, 50);
    }else{
        scrollView.contentSize = CGSizeMake(screen.width, 50);
    }
    //添加底部view
    bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(_eveWidth/4, 45, _eveWidth/2, 5)];
    bottomLineView.backgroundColor=[UIColor orangeColor];
    [scrollView addSubview:bottomLineView];
    
}



- (void)addToSelfView:(CGRect)fr{
    frm = fr;
    currentVC.view.frame=CGRectMake(0, 50, screen.width, frm.size.height-50);
    [self.view addSubview:currentVC.view];
//    NSLog(@"检测当前view.subViews数量--%d",(int)[self.view.subviews count]);
}

#pragma 按钮点击事件
- (void)btnViewClick:(UIButton *)sender{
    [currentVC.view removeFromSuperview];
    if (saveVcArray.count == 0) {
        for (int i = 0 ; i < self.titleArray.count; i++) {
            [saveVcArray addObject:@""];
        }
    }
    if (saveVcArray[sender.tag] && ![saveVcArray[sender.tag] isKindOfClass:[NSString class]]) {
        currentVC =saveVcArray[sender.tag];
    }else{
        if ([self.delegateViewController respondsToSelector:@selector(returnVC: obj:)]){
            currentVC = [self.delegate returnVC:sender.tag obj:self];
        }else{
            NSLog(@"没有实现returnVC代理方法");
            return;
        }
        [saveVcArray replaceObjectAtIndex:sender.tag withObject:currentVC];
    }
    [self changeBtnTitleColor:sender];
    [self changeBottomLineViewFrame:sender];
    [self addToSelfView:frm];
    if(self.clickBlock){
        self.clickBlock(sender.tag);
    }
}
#pragma 改变按钮文字颜色
- (void)changeBtnTitleColor:(UIButton *)sender{
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            if ([obj2 isKindOfClass:[UIButton class]]) {
                UIButton *btnView = (UIButton *)obj2;
                //如果bcgViewColorValue没有赋值---view背景色默认灰色
                self.titleColorValue==nil?([btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]):([btnView setTitleColor:self.titleColorValue forState:UIControlStateNormal]);
                
//                [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }
        }];
    }];
    //如果titleSelectedColorValue没有赋值---第一个标题红色
    self.titleSelectedColorValue==nil?([sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal]):([sender setTitleColor:self.titleSelectedColorValue forState:UIControlStateNormal]);
//    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}


#pragma 改变底部view坐标
- (void)changeBottomLineViewFrame:(UIButton *)sender{
    [UIView animateWithDuration:0.75 animations:^{
        bottomLineView.frame=CGRectMake(_eveWidth/4+(sender.tag)*_eveWidth, 45, _eveWidth/2, 5);
    }];
}
/*******End************************核心功能*****************************/
@end
