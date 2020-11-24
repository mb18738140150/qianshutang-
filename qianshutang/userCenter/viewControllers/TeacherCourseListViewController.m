//
//  TeacherCourseListViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherCourseListViewController.h"

#import "TeacherCourseListCell.h"
#define kTeacherCourseListCellID @"TeacherCourseListCell"
#import "TeacherAttendanceListCell.h"
#define kTeacherAttendanceListCellID @"TeacherAttendanceListCell"

#import "CourseSectionDetailViewController.h"

#import "CallRollViewController.h"
#import "ClassroomAttendanceListViewController.h"

@interface TeacherCourseListViewController ()<UITableViewDelegate, UITableViewDataSource,HYSegmentedControlDelegate,Teacher_sectionList, Teacher_totalAttendance, Teacher_addCourseSection, Teacher_deleteCourseSection,Teacher_classroomAttendanceList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSMutableArray * teacherCourseList;
@property (nonatomic, strong)NSMutableArray * teacherAttendanceList;

@property (nonatomic, strong)UILabel * courseNameLB;
@property (nonatomic, strong)UILabel * teacherLB;
@property (nonatomic, strong)UILabel * courseTypeLB;

@property (nonatomic, strong)HYSegmentedControl * segmentConreol;

@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UIButton * addBtn;
@property (nonatomic, strong)UIButton * attendanceBtn;
@property (nonatomic, assign)BOOL isDelete;

@property (nonatomic, strong)ToolTipView * deleteToolView;
@property (nonatomic, strong)ToolTipView * addCourseToolView;

@end

@implementation TeacherCourseListViewController

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
    [self addNavigationBtn];
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
//    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.segmentConreol = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"课节列表",@"出勤汇总"] delegate:self];
    [self.segmentConreol hideBottomView];
    [self.segmentConreol hideSeparateLine];
    [self.navigationView.rightView addSubview:self.segmentConreol];
//    self.segmentConreol.hidden = YES;
    self.segmentConreol.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.segmentConreol]) {
            if (index == 0) {
                weakSelf.addBtn.hidden = NO;
                weakSelf.deleteBtn.hidden = NO;
                weakSelf.attendanceBtn.hidden = YES;
                weakSelf.dataArray = weakSelf.teacherCourseList;
            }else
            {
                weakSelf.addBtn.hidden = YES;
                weakSelf.deleteBtn.hidden = YES;
                weakSelf.attendanceBtn.hidden = NO;
                weakSelf.dataArray = weakSelf.teacherAttendanceList;
            }
            [weakSelf.tableView reloadData];
        }
    };
    
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.courseNameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 19, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.courseNameLB.textColor = [UIColor whiteColor];
    self.courseNameLB.numberOfLines = 0;
    self.courseNameLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"课程名称:\n%@", [self.infoDic objectForKey:kCourseName]]];
    [leftView addSubview:self.courseNameLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.courseNameLB.frame) + leftView.hd_width / 6, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.teacherLB.textColor = [UIColor whiteColor];
    self.teacherLB.numberOfLines = 0;
    self.teacherLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"主讲老师:\n%@", [self.infoDic objectForKey:kTeacherName]]];
    [leftView addSubview:self.teacherLB];
    
    self.courseTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(10,  CGRectGetMaxY(self.teacherLB.frame) + leftView.hd_width / 6, leftView.hd_width - 20, leftView.hd_width / 3)];
    self.courseTypeLB.textColor = [UIColor whiteColor];
    self.courseTypeLB.numberOfLines = 0;
    self.courseTypeLB.attributedText = [self getAttributeFontText:[NSString stringWithFormat:@"课程类型:\n%@", [self.infoDic objectForKey:kCourseType]]];
    [leftView addSubview:self.courseTypeLB];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(leftView.hd_width + 9, self.navigationView.hd_height + 7, kScreenWidth * 0.8 - 15, kScreenHeight * 0.85 ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TeacherCourseListCell class] forCellReuseIdentifier:kTeacherCourseListCellID];
    [self.tableView registerClass:[TeacherAttendanceListCell class] forCellReuseIdentifier:kTeacherAttendanceListCellID];
}

- (void)addNavigationBtn
{
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.hd_height + 10, 5, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.backgroundColor = kMainColor;
    self.addBtn.layer.cornerRadius = self.addBtn.hd_height / 2;
    self.addBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.addBtn.hd_x - 15 - self.addBtn.hd_width, 5, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = kMainColor;
    self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.attendanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.attendanceBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.12, 5, kScreenWidth * 0.12, self.navigationView.hd_height - 10);
    [self.attendanceBtn setTitle:@"出勤表" forState:UIControlStateNormal];
    [self.attendanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.attendanceBtn.backgroundColor = kMainColor;
    self.attendanceBtn.layer.cornerRadius = 5;
    self.attendanceBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.attendanceBtn];
    [self.attendanceBtn addTarget:self action:@selector(attendanceAction) forControlEvents:UIControlEventTouchUpInside];
    self.attendanceBtn.hidden = YES;
}

- (void)addAction
{
    __weak typeof(self)weakSelf = self;
    self.addCourseToolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_teacherAddCOurse andTitle:@"添加课节" withAnimation:NO];
    [self.view addSubview:self.addCourseToolView];
    self.addCourseToolView.DismissBlock = ^{
        [weakSelf.addCourseToolView removeFromSuperview];
    };
    
    self.addCourseToolView.teacherAddCourseBlock = ^(NSDictionary *infoDic) {
        NSString * startDayStr = [infoDic objectForKey:kDayTime];
        startDayStr = [startDayStr substringToIndex:10];
        startDayStr = [startDayStr stringByAppendingString:@" "];
        NSString * beginTime = [infoDic objectForKey:kbeginTime];
        beginTime = [beginTime substringFromIndex:3];
        int minite = [[infoDic objectForKey:kminite] intValue];
        
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addCourseSectionWithWithDic:@{kchapterId:[weakSelf.infoDic objectForKey:kchapterId], kDayTime:startDayStr,kbeginTime:beginTime,kminite:@(minite)} withNotifiedObject:weakSelf];
        [weakSelf.addCourseToolView removeFromSuperview];
    };
}


- (void)deleteAction
{
    self.deleteBtn.selected = !self.deleteBtn.selected;
    if (self.deleteBtn.selected) {
        [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.isDelete = YES;
    }else
    {
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.isDelete = NO;
    }
    [self.tableView reloadData];
}

- (void)attendanceAction
{
    NSLog(@"出勤表");
   
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_classroomAttendanceListWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId]} withNotifiedObject:self];
}

- (void)loadData
{
    self.teacherCourseList = [NSMutableArray array];
    self.dataArray = self.teacherCourseList;
    self.teacherAttendanceList = [NSMutableArray array];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_sectionListWithWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId],@"phone":@""} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestTeacher_totalAttendanceWithWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_sectionListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}
- (void)didRequestTeacher_sectionListSuccessed
{
    [SVProgressHUD dismiss];
    self.teacherCourseList = [[[UserManager sharedManager] getTeacherSectionListArray] mutableCopy];
    if (self.segmentConreol.selectIndex == 0) {
        self.dataArray = self.teacherCourseList;
        [self.tableView reloadData];
    }
}

- (void)didRequestTeacher_totalAttendanceFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

- (void)didRequestTeacher_totalAttendanceSuccessed
{
    [SVProgressHUD dismiss];
    self.teacherAttendanceList = [[[UserManager sharedManager] getTeacherTotalAttedanceArray] mutableCopy];
    if (self.segmentConreol.selectIndex == 1) {
        self.dataArray = self.teacherAttendanceList;
        [self.tableView reloadData];
    }
}

- (void)didRequestTeacher_addCourseSectionSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_sectionListWithWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId],@"phone":@""} withNotifiedObject:self];
}

- (void)didRequestTeacher_addCourseSectionFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteCourseSectionFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteCourseSectionSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_sectionListWithWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId],@"phone":@""} withNotifiedObject:self];
}


- (void)didRequestTeacher_classroomAttendanceListSuccessed
{
    [SVProgressHUD dismiss];
    ClassroomAttendanceListViewController * vc = [[ClassroomAttendanceListViewController alloc]init];
    vc.infoDic = self.infoDic;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTeacher_classroomAttendanceListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - tableViewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSlef = self;
    if (self.segmentConreol.selectIndex == 0) {
        TeacherCourseListCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacherCourseListCellID forIndexPath:indexPath];
        cell.isDelete = self.isDelete;
        
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[indexPath.row]];
        [mInfo setObject:@(indexPath.row + 1) forKey:@"section"];
        [cell resetWithInfoDic:mInfo];
        cell.editBlock = ^(NSDictionary *infoDic) {
            CourseSectionDetailViewController * vc = [[CourseSectionDetailViewController alloc]init];
            vc.isTeacher = YES;
            vc.courseInfo = infoDic;
            vc.editeBlock = ^(BOOL isEdit) {
                if (isEdit) {
                    [[UserManager sharedManager] didRequestTeacher_sectionListWithWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId],@"phone":@""} withNotifiedObject:weakSlef];

                }
            };
            [weakSlef presentViewController:vc animated:NO completion:nil];
        };
        cell.deleteCourseBlock = ^(NSDictionary *infoDic) {
             [weakSlef deleteCourse:infoDic];
        };
        return cell;
    }else
    {
        TeacherAttendanceListCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacherAttendanceListCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    if (self.segmentConreol.selectIndex == 0) {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 12, view.hd_height) andTitle:@"课节"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 12 * 5, view.hd_height) andTitle:@"上课时间"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"出勤率"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"课节详情"];
        [view addSubview:detailLB];

    }else
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"学员"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"出勤次数"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"课耗时数"];
        [view addSubview:timeLB];
        
    }
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentConreol.selectIndex == 0) {
        if (self.isDelete) {
            // 删除课节
            [self deleteCourse:self.dataArray[indexPath.row]];
        }else
        {
            // 学生点名页
            NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
            CallRollViewController * callrollVC = [[CallRollViewController alloc]init];
            callrollVC.infoDic = infoDic;
            [self presentViewController:callrollVC animated:NO completion:nil];
        }
    }
}

// 删除课程
- (void)deleteCourse:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    self.deleteToolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_deleteTeacherCourse andTitle:@"提示" withAnimation:YES];
    [self.deleteToolView resetContentLbTetx:[NSString stringWithFormat:@"删除课节\n%@?\n删除后返还学员在本节的课耗", [infoDic objectForKey:@"beginendTime"]]];
    [self.view addSubview:self.deleteToolView];
    self.deleteToolView.DismissBlock = ^{
        [weakSelf.deleteToolView removeFromSuperview];
    };
    self.deleteToolView.ContinueBlock = ^(NSString *str) {
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_deleteCourseSectionWithWithDic:@{kunitId:[infoDic objectForKey:kunitId]} withNotifiedObject:weakSelf];
        
        [weakSelf.deleteToolView removeFromSuperview];
    };
    
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

@end
