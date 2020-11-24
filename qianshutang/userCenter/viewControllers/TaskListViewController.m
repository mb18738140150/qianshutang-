//
//  TaskListViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskListTableViewCell.h"
#define kTaskListCellID @"taskListCell"
#import "CommentTaskViewController.h"
#import "MyTaskViewController.h"

@interface TaskListViewController ()<UITableViewDelegate, UITableViewDataSource, MyStudy_MyEveryDayTaskDetailList, MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail,Task_CreateTaskProblemContent>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSDictionary * selectProductInfo;
@property (nonatomic, assign)TaskType tasktype;

@end

@implementation TaskListViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.titleLB.text = @"作业详情";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    
    [self loadData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + 5, kScreenWidth, kScreenHeight - self.navigationView.hd_height - 5) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TaskListTableViewCell class] forCellReuseIdentifier:kTaskListCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyEveryDayTaskDetailListWithWithDic:@{kWorkLogId:[self.infoDic objectForKey:kWorkLogId]} withNotifiedObject:self];
}

- (void)didRequestMyEveryDayTaskDetailListSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getMyEveryDayTaskDetailList] mutableCopy];
    [self.tableView reloadData];
}

- (void)didRequestMyEveryDayTaskDetailListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    TaskListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTaskListCellID forIndexPath:indexPath];
    [cell refreshWith:self.dataArray[indexPath.row]];
    cell.DotaskBlock = ^(DoTaskType type,NSDictionary * infoDic) {
        weakSelf.selectProductInfo = infoDic;
        switch (type) {
            case DoTaskType_nomal:
            {
                
            }
                break;
            case DoTaskType_do:
            {
                MyTaskViewController * vc = [[MyTaskViewController alloc]init];
                vc.infoDic = self.dataArray[indexPath.row];
                vc.bottomCollectionViewArray = [self getTaskList:self.dataArray];
                [self presentViewController:vc animated:NO completion:nil];
            }
                break;
            case DoTaskType_check:
            {
                
                if ([[infoDic objectForKey:kProductId] intValue] == 0) {
                    return ;
                }
                
                switch ([[infoDic objectForKey:@"type"] intValue]) {
                    case 3:
                    {
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                    }
                        break;
                    case 4:
                    {
                        self.tasktype = TaskType_create;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                        [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:[infoDic objectForKey:@"madeId"]} withNotifiedObject:self];
                    }
                        break;
                    case 5:
                    {
                        self.tasktype = TaskType_video;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                        [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:[infoDic objectForKey:@"madeId"]} withNotifiedObject:self];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
                
            default:
                break;
        }
    };
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"作业类型"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 2, view.hd_height) andTitle:@"作业详情"];
    [view addSubview:nameLB];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
    [view addSubview:timeLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"操作"];
    [view addSubview:detailLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.14;
}

- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.productType = ProductType_record;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestMyFriendProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    [infoDic setObject:[self.selectProductInfo objectForKey:kmadeId] forKey:kmadeId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.taskType = self.tasktype;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (UILabel *)headLB:(CGRect)rect andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}

- (NSArray *)getTaskList:(NSArray *)dataArray1
{
    NSMutableArray * moArray = [NSMutableArray array];
    NSMutableArray * readArray = [NSMutableArray array];
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    NSMutableArray * videoArray = [NSMutableArray array];
    
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary * infoDic in dataArray1) {
        switch ([[infoDic objectForKey:@"type"] intValue]) {
            case 1:
            {
                [moArray addObject:infoDic];
            }
                break;
            case 2:
            {
                [readArray addObject:infoDic];
            }
                break;
            case 3:
            {
                [recordArray addObject:infoDic];
            }
                break;
            case 4:
            {
                [createArray addObject:infoDic];
            }
                break;
            case 5:
            {
                [videoArray addObject:infoDic];
            }
                break;
                
            default:
                break;
        }
    }
    
    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
    [moDic setObject:@(1) forKey:@"type"];
    [moDic setObject:moArray forKey:@"data"];
    
    [readDic setObject:@"阅读" forKey:@"typeStr"];
    [readDic setObject:@(2) forKey:@"type"];
    [readDic setObject:readArray forKey:@"data"];
    
    [recordDic setObject:@"录音" forKey:@"typeStr"];
    [recordDic setObject:@(3) forKey:@"type"];
    [recordDic setObject:recordArray forKey:@"data"];
    
    [createDic setObject:@"创作" forKey:@"typeStr"];
    [createDic setObject:@(4) forKey:@"type"];
    [createDic setObject:createArray forKey:@"data"];
    
    [videoDic setObject:@"视频" forKey:@"typeStr"];
    [videoDic setObject:@(5) forKey:@"type"];
    [videoDic setObject:videoArray forKey:@"data"];
    
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (moArray.count > 0) {
        [dataArray addObject:moDic];
    }
    if (readArray.count > 0) {
        [dataArray addObject:readDic];
    }
    if (recordArray.count > 0) {
        [dataArray addObject:recordDic];
    }
    if (createArray.count > 0) {
        [dataArray addObject:createDic];
    }
    if (videoArray.count > 0) {
        [dataArray addObject:videoDic];
    }
    
    
    return dataArray;
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
