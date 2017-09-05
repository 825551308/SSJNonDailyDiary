//
//  TaskNoteListVC.m
//  TaskNote
//
//  Created by 金汕汕 on 17/4/28.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "TaskNoteBillVC.h"
#import "TaskNoteBillTBCell.h"
#import "TaskNoteBillModel.h"
#import "TaskNoteCreateVC.h"
#import "SSXuanXiangVC.h"
#import "TaskNoteBillDetailVC.h"
@interface TaskNoteBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *taskNoteTableView;
@property (nonatomic,strong) NSMutableArray *listMuArray;
@property (nonatomic,strong) UIView *footView;

@end

@implementation TaskNoteBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    [self initTableView];
    //注册通知 新建完成后回调刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gainListRequest) name:kNSNotificationCenterWithTaskNoteListVCRefurbish object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******Head************************界面*****************************/

//初始化tableview
- (void)initTableView{
    removeDouble_bottomLine(self.taskNoteTableView);
    //注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TaskNoteBillTBCell class]) bundle:nil];
    [self.taskNoteTableView registerNib:nib forCellReuseIdentifier:taskNoteBillTBCellIden];
    self.taskNoteTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.taskNoteTableView.delegate=self;
    self.taskNoteTableView.dataSource=self;
    //下拉刷新，上拉加载
    [self tableView_AddAnimation];
    //第一次进来调用刷新
    [self.taskNoteTableView.mj_header beginRefreshing];
    [self setTableFootView];
    self.taskNoteTableView.backgroundColor = [UIColor clearColor];
}


//下拉刷新，上拉加载
- (void)tableView_AddAnimation{
    
    self.taskNoteTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /*do something*/
        [self gainListRequest];
    }];
    self.taskNoteTableView.mj_header.automaticallyChangeAlpha = YES;
}

// 初始化tableview的footview
-(void)setTableFootView{
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 320)];
    UIImageView *backImag=[[UIImageView alloc]initWithFrame:CGRectMake((screen_width-94)/2, 100, 94, 98)];
    backImag.image=[UIImage imageNamed:@"noData"];
    [self.footView addSubview:backImag];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-200)/2, 220, 200, 20)];
    lab.text = @"暂无数据";
    lab.textColor = [UIColor colorWithHexString:@"#cccccc"];
    lab.font = [UIFont systemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.footView addSubview:lab];
}


#pragma mark  footview
// 更改tableview的footview
-(void)changeFootview:(UITableView *)tableView
{
    if (tableView == self.taskNoteTableView) {
        if (_listMuArray.count == 0){
            self.footView.hidden=NO;
            self.footView.frame=CGRectMake(0, 0, screen_width, 320);
            self.taskNoteTableView.tableFooterView = self.footView;
        }else{
            self.footView.hidden=YES;
            self.footView.frame=CGRectZero;
            self.taskNoteTableView.tableFooterView=self.footView;
        }
    }
}


#define numberOfSection 1;//section个数
#define rowHeight 60;//行高
#define SectionRowsnumber 1;//每1个section对应的row个数
#pragma tableView-delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMuArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskNoteBillTBCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:taskNoteBillTBCellIden];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    (indexPath.row % 2 ==0)?(cell.backgroundColor=[UIColor yellowColor]):(cell.backgroundColor=[UIColor orangeColor]);
    if (self.listMuArray.count > indexPath.row) {
        [cell updateViewWithObj:self.listMuArray[indexPath.row]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listMuArray.count > indexPath.row) {
//        TaskNoteCreateVC *checkVC = [TaskNoteCreateVC new];
//        checkVC.state = StateOfCheck;
//        checkVC.detailModel = self.listMuArray[indexPath.row];
//            checkVC.hidesBottomBarWhenPushed = YES;
//        __weak typeof(self) weakSelf = self;
//        checkVC.refurbishBlock = ^(BOOL refurbishRes){
//            [weakSelf.taskNoteTableView.mj_header beginRefreshing];
//        };
//        [[SSXuanXiangVC shareManager] pushVC:checkVC];
        TaskNoteBillDetailVC *detailVC = [TaskNoteBillDetailVC new];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.model = self.listMuArray[indexPath.row];
        [[SSXuanXiangVC shareManager] pushVC:detailVC];
    }
}



/********************** 滑动删除 *****Head***/
//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//滑动删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.taskNoteTableView.isEditing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//滑动删除begin预处理
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    //PeopleAllCell *cell = (PeopleAllCell *)[tableView cellForRowAtIndexPath:indexPath];
    //[cell.verifyBtn setHidden:YES];
}

//滑动删除结束处理
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    //PeopleAllCell *cell = (PeopleAllCell *)[tableView cellForRowAtIndexPath:indexPath];
    //[cell.verifyBtn setHidden:NO];
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
        TaskNoteBillModel  *itemClass = self.listMuArray[indexPath.row];
        if (itemClass.billID) {
            
            if ([TaskNoteBillModel deleteObjects:@[itemClass]]) {
                [MBHUD showSuccess:@"删除成功"];
                //本地数据库删除成功后执行
                [self.listMuArray removeObjectAtIndex:indexPath.row];//tableview数据源
                if (![self.listMuArray count]) { //删除此行后数据源为空
                    [self.taskNoteTableView deleteSections: [NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
                } else {
                    [self.taskNoteTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
            }else{
                [MBHUD showSuccess:@"删除失败"];
            }
        }
        
        
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
/********************** 滑动删除 *****End***/


/*******End************************界面*****************************/

#pragma mark   获取数据
- (void)gainListRequest{
    dispatch_after(0.2, dispatch_get_main_queue(), ^{
        [self.taskNoteTableView.mj_header endRefreshing];
//        self.listMuArray = [[TaskNoteModel findAll] mutableCopy];
        self.listMuArray = [[TaskNoteBillModel findByCriteria:[NSString stringWithFormat:@"order by createTime desc"]] mutableCopy];
//        [self jiaShuJu];
        [self.taskNoteTableView reloadData];
        [self changeFootview:self.taskNoteTableView];
    });
}

#pragma mark -- set / get Method
- (NSMutableArray *)listMuArray{
    if (!_listMuArray) {
        _listMuArray = [NSMutableArray new];
    }
    return _listMuArray;
}

- (void)jiaShuJu{
    
    TaskNoteBillModel *md1 = [TaskNoteBillModel new];
    md1.billID = @"12";
    md1.billTitle = @"早饭";
    md1.billDescribe = @"早饭花费5.5";
    md1.billType = BillTypeOfPay;
    md1.createTime = @"1501798019";
    md1.billValue = @"5.5";
    
    TaskNoteBillModel *md2 = [TaskNoteBillModel new];
    md2.billID = @"13";
    md2.billTitle = @"支付宝到账";
    md2.billDescribe = @"支付宝余额宝收入,这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行这下面都可以打印出新的frame的值了，但是view里就是没有换行，要么是...要是设置了NSLineBreakByCharWrapping就直接切掉了后面的，是不是应该换成手写代码才能设置这是我控件的截图，在这里设置也没有效果要么切断要么无效，都没换行111";
    md2.billType = BillTypeOfGain;
    md2.createTime = [[NSString secondTime] substringToIndex:([NSString secondTime].length - 3)];
    md2.billValue = @"0.9";
    
    
    TaskNoteBillModel *md3 = [TaskNoteBillModel new];
    md3.billID = @"12";
    md3.billTitle = @"午饭";
    md3.billDescribe = @"午饭花费5.5";
    md3.billType = BillTypeOfPay;
    md3.createTime = @"1501815839";
    md3.billValue = @"13.5";
    
    TaskNoteBillModel *md4 = [TaskNoteBillModel new];
    md4.billID = @"12";
    md4.billTitle = @"午饭";
    md4.billDescribe = @"午饭花费5.5";
    md4.billType = BillTypeOfPay;
    md4.createTime = @"1501818119";
    md4.billValue = @"13.5";
    
    TaskNoteBillModel *md5 = [TaskNoteBillModel new];
    md5.billID = @"12";
    md5.billTitle = @"午饭";
    md5.billDescribe = @"午饭花费5.5";
    md5.billType = BillTypeOfPay;
    md5.createTime = @"1501556219";
    md5.billValue = @"13.5";
    
    TaskNoteBillModel *md6 = [TaskNoteBillModel new];
    md6.billID = @"12";
    md6.billTitle = @"午饭";
    md6.billDescribe = @"午饭花费5.5";
    md6.billType = BillTypeOfPay;
    md6.createTime = @"1470020219";
    md6.billValue = @"13.5";
    
    self.listMuArray = [@[md1,md2,md3,md4,md5,md6] mutableCopy];
    
}

@end
