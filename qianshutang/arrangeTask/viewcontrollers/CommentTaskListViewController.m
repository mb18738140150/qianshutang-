//
//  CommentTaskListViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentTaskListViewController.h"
#import "CommentTaskListTableViewCell.h"
#define kCommentTaskListCellID @"CommentTaskListTableViewCell"
#import "CommentTaskViewController.h"

@interface CommentTaskListViewController ()<UITableViewDelegate, UITableViewDataSource, MyClassroom_classTaskHaveComplate,MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSDictionary * selectProductInfo;
@property (nonatomic, assign)TaskType tasktype;

@end

@implementation CommentTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.navigationView.rightView.hd_width * 0.8, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    if (self.isTeacher) {
        self.titleLB.text = @"快捷点评学员提交的录音、视频及创作作业";
    }else
    {
        self.titleLB.text = @"快捷查看老师对录音、创作及视频作业的点评";
    }
    
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(8, self.navigationView.hd_height + 8, kScreenWidth - 16, kScreenHeight - self.navigationView.hd_height - 8) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CommentTaskListTableViewCell class] forCellReuseIdentifier:kCommentTaskListCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    CommentTaskListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommentTaskListCellID forIndexPath:indexPath];
//    cell.
    [cell refreshWithInfo:self.dataArray[indexPath.row]];
    cell.CheckCourseBlock = ^(NSDictionary *infoDic) {
        self.selectProductInfo = infoDic;
        [self reloadProductDetail:infoDic];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.hd_height * 0.138;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectProductInfo = self.dataArray[indexPath.row];
    [self reloadProductDetail:self.selectProductInfo];
}

- (void)reloadProductDetail:(NSDictionary *)infoDic
{
    
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 9, view.hd_height) andTitle:@"学员"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width /9 * 2, view.hd_height) andTitle:@"作业详情"];
    [view addSubview:nameLB];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 9 *2, view.hd_height) andTitle:@"所属作业"];
    [view addSubview:timeLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 9 *2, view.hd_height) andTitle:@"上传时间"];
    [view addSubview:detailLB];
    
    UILabel * stateLB = [self headLB:CGRectMake(CGRectGetMaxX(detailLB.frame), 0, view.hd_width / 9, view.hd_height) andTitle:@"状态"];
    [view addSubview:stateLB];
    
    UILabel * operationLB = [self headLB:CGRectMake(CGRectGetMaxX(stateLB.frame), 0, view.hd_width / 9, view.hd_height) andTitle:@"操作"];
    [view addSubview:operationLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
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
//    vc.commentTaskType = CommentTaskType_studentLookSelf;
    if ([[UserManager sharedManager] getUserType] == UserType_student) {
        vc.commentTaskType = CommentTaskType_studentLookSelf;
    }else
    {
        vc.commentTaskType = CommentTaskType_teacherLookStudent;
    }
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
    [infoDic setObject:[self.selectProductInfo objectForKey:kmadeId] forKey:kmadeId];
    if ([self.selectProductInfo objectForKey:kuserWorkId] != nil) {
        [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    }else
    {
        [infoDic setObject:[self.selectProductInfo objectForKey:kmadeId] forKey:kuserWorkId];
    }
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    if ([[UserManager sharedManager] getUserType] == UserType_student) {
        vc.commentTaskType = CommentTaskType_studentLookSelf;
    }else
    {
        vc.commentTaskType = CommentTaskType_teacherLookStudent;
    }
        
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

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassTaskHaveComplateWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
}

- (void)didRequestclassTaskHaveComplateSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getClassTaskHaveComplate] mutableCopy];
    [self.tableView reloadData];
}

- (void)didRequestclassTaskHaveComplateFailed:(NSString *)failedInfo
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
