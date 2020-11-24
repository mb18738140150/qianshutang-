//
//  TeakEveryDayDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeakEveryDayDetailViewController.h"
#import "SelectDayView.h"
#import "TaskEveryDayListTableViewCell.h"
#define kTaskEveryDayListCellID @"TaskEveryDayListTableViewCell"
#import "CommentTaskViewController.h"

@interface TeakEveryDayDetailViewController ()<UITableViewDelegate, UITableViewDataSource,MyStudy_MyEveryDayTask, MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail, Task_CreateTaskProblemContent>
@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)SelectDayView * selectDayView;
@property (nonatomic, strong)UIButton * todayBtn;
@property (nonatomic, assign)TaskType tasktype;
@property (nonatomic, strong)NSDictionary * selectProductInfo;

@property (nonatomic, assign)BOOL isToday;

@end

@implementation TeakEveryDayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isToday = YES;
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(239, 239, 239);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissAction];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.selectDayView = [[SelectDayView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - (self.navigationView.hd_height * 7 + 80) / 2, 0, self.navigationView.hd_height * 7 + 80, self.navigationView.hd_height)];
    self.selectDayView.SelectDayBlock = ^(NSDate *date) {
        [weakSelf loadDataWithDate:date];
    };
    [self.view addSubview:self.selectDayView];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.rightView.hd_height + 10, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.todayBtn.backgroundColor = kMainColor;
    self.todayBtn.layer.cornerRadius = self.todayBtn.hd_height / 2;
    self.todayBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.todayBtn];
    [self.todayBtn addTarget:self action:@selector(todayAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(8, self.navigationView.hd_height + 8, kScreenWidth - 16, kScreenHeight - self.navigationView.hd_height - 8) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TaskEveryDayListTableViewCell class] forCellReuseIdentifier:kTaskEveryDayListCellID];
    [self.view addSubview:self.tableView];
    
}

- (void)dismissAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    TaskEveryDayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTaskEveryDayListCellID forIndexPath:indexPath];
    cell.isToday = self.isToday;
    cell.isTeacher = self.isTeacher;
    [cell refreshWith:self.dataArray[indexPath.row]];
    cell.operationTaskBlock = ^(NSDictionary *infoDic) {
        
        if ([[infoDic objectForKey:@"doState"] isEqualToString:@"已完成"] || [[infoDic objectForKey:@"doState"] isEqualToString:@"已检查"] || [[infoDic objectForKey:@"doState"] isEqualToString:@"已点评"]) {
            weakSelf.selectProductInfo = infoDic;
            
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
                }
                    break;
                case 5:
                {
                    self.tasktype = TaskType_video;
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                }
                    break;
                    
                default:
                    break;
            }
            return ;
        }
        
        if (weakSelf.doBlock) {
            weakSelf.doBlock(self.dataArray[indexPath.row]);
        }
        [weakSelf dismissAction];
    };
    return cell;
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.139;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"作业类型"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width /4, view.hd_height) andTitle:@"作业详情"];
    [view addSubview:nameLB];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"所属作业"];
    [view addSubview:timeLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
    [view addSubview:detailLB];
    
    UILabel * operationLB = [self headLB:CGRectMake(CGRectGetMaxX(detailLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"操作"];
    [view addSubview:operationLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
}

- (void)todayAction
{
    [self.selectDayView resetTiday];
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

- (void)loadData
{
    self.dataArray = [[[UserManager sharedManager] getMyEveryDayTaskListNoClassify] mutableCopy];
    [self.tableView reloadData];
}

- (void)loadDataWithDate:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:date];
    
    NSString * currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    if ([currentTimeStr isEqualToString:timeStr]) {
        self.isToday = YES;
    }else
    {
        self.isToday = NO;
    }
    
    if (self.isTeacher) {
        //[self.infoDic objectForKey:@"userId"]
        [[UserManager sharedManager] didRequestMyEveryDayTaskWithWithDic:@{@"dayTime":timeStr,kmemberId:@(self.memberId)} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestMyEveryDayTaskWithWithDic:@{@"dayTime":timeStr,kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    }
}

- (void)didRequestMyEveryDayTaskSuccessed
{
    [SVProgressHUD dismiss];
    [self loadData];
}

- (void)didRequestMyEveryDayTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
