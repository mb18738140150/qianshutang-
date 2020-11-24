//
//  MyTaskAttendanceRecordViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyTaskAttendanceRecordViewController.h"
#import "MtTaskAttendanceTableViewCell.h"
#define kMyTaskAttendanceCellID @"mytaskAttendanceCell"

#import "CourseSectionDetailViewController.h"


@interface MyTaskAttendanceRecordViewController ()<UITableViewDelegate, UITableViewDataSource, MyStudy_MyAttendanceList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSDictionary * attendanceInfoDic;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UILabel * courseNameLB;
@property (nonatomic, strong)UILabel * teacherLB;
@property (nonatomic, strong)UILabel * courseTypeLB;

@property (nonatomic, strong)UILabel * attendanceLB;
@property (nonatomic, strong)UILabel * leaveLB;
@property (nonatomic, strong)UILabel * absenteeism;
@property (nonatomic, strong)UILabel * courseCostLB;

@end

@implementation MyTaskAttendanceRecordViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
    
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"我的作业出勤记录";
    if (self.isTeacher) {
        self.titleLB.text = @"学员出勤记录";
    }
    [self.navigationView.rightView addSubview:self.titleLB];
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.courseNameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 19, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.courseNameLB.textColor = [UIColor whiteColor];
    self.courseNameLB.numberOfLines = 0;
    self.courseNameLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"课程名称:\n%@", [self.myCourseInfo objectForKey:kCourseName]]];
    [leftView addSubview:self.courseNameLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.courseNameLB.frame) + leftView.hd_width / 6, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.teacherLB.textColor = [UIColor whiteColor];
    self.teacherLB.numberOfLines = 0;
    self.teacherLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"主讲老师:\n%@", [self.myCourseInfo objectForKey:kTeacherName]]];
    [leftView addSubview:self.teacherLB];
    
    self.courseTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(10,  CGRectGetMaxY(self.teacherLB.frame) + leftView.hd_width / 6, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.courseTypeLB.textColor = [UIColor whiteColor];
    self.courseTypeLB.numberOfLines = 0;
    
    self.courseTypeLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"课程类型:\n%@", [self.myCourseInfo objectForKey:kCourseType]]];
    [leftView addSubview:self.courseTypeLB];
    
    
    self.attendanceLB = [[UILabel alloc]initWithFrame:CGRectMake(leftView.hd_width + 13, kScreenHeight - 40, kScreenWidth * 0.1, 20)];
    self.attendanceLB.font = [UIFont systemFontOfSize:16];
    self.attendanceLB.textColor = UIColorFromRGB(0x232323);
    self.attendanceLB.attributedText = [self getAttributeColorText:@"出勤: 0"];
    [self.view addSubview:self.attendanceLB];
    
    self.leaveLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.attendanceLB.frame) + 10, kScreenHeight - 40, kScreenWidth * 0.1, 20)];
    self.leaveLB.font = [UIFont systemFontOfSize:16];
    self.leaveLB.textColor = UIColorFromRGB(0x232323);
    self.leaveLB.attributedText = [self getAttributeColorText:@"请假: 0"];
    [self.view addSubview:self.leaveLB];
    
    self.absenteeism = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leaveLB.frame) + 10, kScreenHeight - 40, kScreenWidth * 0.1, 20)];
    self.absenteeism.font = [UIFont systemFontOfSize:16];
    self.absenteeism.textColor = UIColorFromRGB(0x232323);
    self.absenteeism.attributedText = [self getAttributeColorText:@"旷课: 0"];
    [self.view addSubview:self.absenteeism];
    
    self.courseCostLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.absenteeism.frame) + 10, kScreenHeight - 40, kScreenWidth * 0.1, 20)];
    self.courseCostLB.font = [UIFont systemFontOfSize:16];
    self.courseCostLB.textColor = UIColorFromRGB(0x232323);
    self.courseCostLB.attributedText = [self getAttributeColorText:@"课耗: 0"];
    [self.view addSubview:self.courseCostLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(leftView.hd_width + 9, self.navigationView.hd_height + 7, kScreenWidth * 0.8 - 15, kScreenHeight * 0.85 - 67) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MtTaskAttendanceTableViewCell class] forCellReuseIdentifier:kMyTaskAttendanceCellID];
    
}

- (void)loadData
{
    [[UserManager sharedManager] didRequestMyAttendanceListWithWithDic:@{kchapterId:[self.myCourseInfo objectForKey:kchapterId],kmemberId:@([[UserManager sharedManager] getUserType])} withNotifiedObject:self];
}

- (void)didRequestMyAttendanceListSuccessed
{
    [SVProgressHUD dismiss];
    self.attendanceInfoDic = [[UserManager sharedManager] getMyAttendanceInfoDic];
    self.dataArray = [[[UserManager sharedManager] getMyAttendanceInfoDic] objectForKey:@"data"];
    [self refreshUI];
}

- (void)refreshUI
{
    self.attendanceLB.attributedText = [self getAttributeColorText:[NSString stringWithFormat:@"出勤: %@", [self.attendanceInfoDic objectForKey:kattendanceCount]]];
    self.leaveLB.attributedText = [self getAttributeColorText:[NSString stringWithFormat:@"请假: %@", [self.attendanceInfoDic objectForKey:kleaveCount]]];
    self.absenteeism.attributedText = [self getAttributeColorText:[NSString stringWithFormat:@"旷课: %@", [self.attendanceInfoDic objectForKey:kabsenteeism]]];
    self.courseCostLB.attributedText = [self getAttributeColorText:[NSString stringWithFormat:@"课耗: %@", [self.attendanceInfoDic objectForKey:kcostCount]]];
    
    [self.tableView reloadData];
}

- (void)didRequestMyAttendanceListFailed:(NSString *)failedInfo
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
    MtTaskAttendanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMyTaskAttendanceCellID forIndexPath:indexPath];
    
    NSMutableDictionary * infoDic = self.dataArray[indexPath.row];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [mInfo setObject:@(indexPath.row + 1) forKey:@"unitNumber"];
    
    [cell refreshWithInfo:mInfo];
    __weak typeof(self)weakSelf = self;
    cell.CheckCourseBlock = ^(NSDictionary *infoDic) {
        CourseSectionDetailViewController * vc = [[CourseSectionDetailViewController alloc]init];
        
        NSMutableDictionary * infoDic1 = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [infoDic1 setObject:[infoDic objectForKey:kunitIntro] forKey:@"Intro"];
        [infoDic1 setObject:[infoDic objectForKey:kunitTeacher] forKey:kTeacherName];
        [infoDic1 setObject:[infoDic objectForKey:kunitTime] forKey:@"beginendTime"];
        [infoDic1 setObject:[infoDic objectForKey:kunitTitle] forKey:@"title"];
        vc.courseInfo = infoDic1;
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"课节"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"上课时间"];
    [view addSubview:nameLB];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
    [view addSubview:timeLB];
    
    UILabel * costLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"课耗"];
    [view addSubview:costLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(costLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"课节详情"];
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

- (UILabel *)headLB:(CGRect)rect andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}


- (NSMutableAttributedString *)getAttributeFontText:(NSString *)str
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [mStr setAttributes:attribute range:NSMakeRange(5, str.length - 5)];
    
    return mStr;
}

- (NSMutableAttributedString *)getAttributeColorText:(NSString *)str
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD824C)};
    [mStr setAttributes:attribute range:NSMakeRange(3, str.length - 3)];
    
    return mStr;
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
