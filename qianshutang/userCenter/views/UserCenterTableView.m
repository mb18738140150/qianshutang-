//
//  UserCenterTableView.m
//  qianshutang
//
//  Created by aaa on 2018/8/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "UserCenterTableView.h"
#import "MyTaskTableViewCell.h"
#define kMyTaskCellID @"myTaskCell"
#import "ShichangTableViewCell.h"
#define kShichangCellID @"shichangCell"
#import "AchievementTableViewCell.h"
#define kAchievementCellID @"achievementCell"
#import "MycourseTableViewCell.h"
#define kMycourseCellID @"mycourseCell"
#import "CourseCostTableViewCell.h"
#define kCourseCostCellID @"courseCostCell"
#import "ListTableViewCell.h"
#define kListCellID @"listCell"
#import "BookMarkTableViewCell.h"
#define kBookmarkCellID @"bookmarkcell"
#import "ClassroomTaskTableViewCell.h"
#define kClassroomTaskCellID @"classroomTaskCell"
#import "IntegralRecordTableViewCell.h"
#define kIntegralRecordCellID @"IntegralRecordTableViewCell"
#import "PrizeRecordTableViewCell.h"
#define kPrizeRecordCellID @"PrizeRecordTableViewCell"
#import "MyTaskDetailTableViewCell.h"
#define kMytaskDetailCellID @"MyTaskDetailTableViewCell"
#import "ClassMemberTaskComplateTableViewCell.h"
#define kClassMemberTaskComplateDetail @"ClassMemberTaskComplateTableViewCell"
#import "ArrangTaskTableViewCell.h"
#define kArrangtaskCellID @"ArrangTaskTableViewCell"
#import "HaveArrangeTaskTableViewCell.h"
#define kHaveArrangTaskCellID @"HaveArrangeTaskTableViewCell"
#import "CommentTaskTableViewCell.h"
#define kCommentTaskCellID @"CommentTaskTableViewCell"
#import "StudentTaskComplateProgressTableViewCell.h"
#define kStudentTaskComplateProgressCellID @"StudentTaskComplateProgressTableViewCell"
#import "TaskLibraryTableViewCell.h"
#define kTaskLibraryCellID @"TaskLibraryTableViewCell"
#import "TeacherCourseTableViewCell.h"
#define kTeacherCourseCellID @"TeacherCourseTableViewCell"
#import "Teacher_stufentIntegralListCell.h"
#define kTeacherStudentIntegralListCellID @"Teacher_stufentIntegralListCell"
#import "Teacher_studentPrizeRecordTableViewCell.h"
#define kTeacher_etudentPrizeRecordCellID @"Teacher_studentPrizeRecordTableViewCell"
#import "Teacher_classroomTaskListCell.h"
#define kTeacher_classroomTaskListCellID @"Teacher_classroomTaskListCell"

#import "Teacher_haveSendIntegralTableViewCell.h"
#define kTeacher_haveSendIntegralTableViewCell @"Teacher_haveSendIntegralTableViewCellID"

#import "CalendarPickerView.h"

@interface UserCenterTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)CalendarPickerView * calendarPickerView;

@property (nonatomic, strong)FailedView * failedView;
@end


@implementation UserCenterTableView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyTaskTableViewCell class] forCellReuseIdentifier:kMyTaskCellID];
    [self.tableView registerClass:[ShichangTableViewCell class] forCellReuseIdentifier:kShichangCellID];
    [self.tableView registerClass:[AchievementTableViewCell class] forCellReuseIdentifier:kAchievementCellID];
    [self.tableView registerClass:[MycourseTableViewCell class] forCellReuseIdentifier:kMycourseCellID];
    [self.tableView registerClass:[CourseCostTableViewCell class] forCellReuseIdentifier:kCourseCostCellID];
    [self.tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:kListCellID];
    [self.tableView registerClass:[BookMarkTableViewCell class] forCellReuseIdentifier:kBookmarkCellID];
    [self.tableView registerClass:[ClassroomTaskTableViewCell class] forCellReuseIdentifier:kClassroomTaskCellID];
    [self.tableView registerClass:[IntegralRecordTableViewCell class] forCellReuseIdentifier:kIntegralRecordCellID];
    [self.tableView registerClass:[PrizeRecordTableViewCell class] forCellReuseIdentifier:kPrizeRecordCellID];
    [self.tableView registerClass:[MyTaskDetailTableViewCell class] forCellReuseIdentifier:kMytaskDetailCellID];
    [self.tableView registerClass:[ClassMemberTaskComplateTableViewCell class] forCellReuseIdentifier:kClassMemberTaskComplateDetail];
    [self.tableView registerClass:[ArrangTaskTableViewCell class] forCellReuseIdentifier:kArrangtaskCellID];
    [self.tableView registerClass:[HaveArrangeTaskTableViewCell class] forCellReuseIdentifier:kHaveArrangTaskCellID];
    [self.tableView registerClass:[CommentTaskTableViewCell class] forCellReuseIdentifier:kCommentTaskCellID];
    [self.tableView registerClass:[StudentTaskComplateProgressTableViewCell class] forCellReuseIdentifier:kStudentTaskComplateProgressCellID];
    [self.tableView registerClass:[TaskLibraryTableViewCell class] forCellReuseIdentifier:kTaskLibraryCellID];
    [self.tableView registerClass:[TeacherCourseTableViewCell class] forCellReuseIdentifier:kTeacherCourseCellID];
    [self.tableView registerClass:[Teacher_stufentIntegralListCell class] forCellReuseIdentifier:kTeacherStudentIntegralListCellID];
    [self.tableView registerClass:[Teacher_studentPrizeRecordTableViewCell class] forCellReuseIdentifier:kTeacher_etudentPrizeRecordCellID];
    [self.tableView registerClass:[Teacher_classroomTaskListCell class] forCellReuseIdentifier:kTeacher_classroomTaskListCellID];
    [self.tableView registerClass:[Teacher_haveSendIntegralTableViewCell class] forCellReuseIdentifier:kTeacher_haveSendIntegralTableViewCell];
    
    self.calendarPickerView = [[CalendarPickerView alloc]initWithFrame:self.bounds];
    [self addSubview:self.calendarPickerView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.failedView = [[FailedView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50) andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self addSubview:self.failedView];
    self.failedView.hidden = YES;
}

- (void)headRefresh
{
    if (self.usercenterTableViewType == UserCenterTableViewType_achievement || self.usercenterTableViewType == UserCenterTableViewType_shichang ) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    
    if (self.headRefreshBlock) {
        self.headRefreshBlock();
    }
}
- (void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (self.usercenterTableViewType == UserCenterTableViewType_MyTask) {
        MyTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMyTaskCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_ClassroomTask){
        ClassroomTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kClassroomTaskCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_shichang){
        ShichangTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kShichangCellID forIndexPath:indexPath];
        if (indexPath.row == self.dataArray.count - 1) {
            cell.isLastItem = YES;
        }else
        {
            cell.isLastItem = NO;
        }
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        
        cell.shichangBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.shichangBlock) {
                weakSelf.shichangBlock(infoDic);
            }
        };
        
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_achievement){
        AchievementTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAchievementCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_myCourse || self.usercenterTableViewType == UserCenterTableViewType_Course){
        MycourseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMycourseCellID forIndexPath:indexPath];
        
        if (self.usercenterTableViewType == UserCenterTableViewType_Course) {
            cell.isCourse = self.isCourse;
        }
        
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_courseCost){
        CourseCostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCourseCostCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_gold || self.usercenterTableViewType == UserCenterTableViewType_star || self.usercenterTableViewType == UserCenterTableViewType_flower || self.usercenterTableViewType == UserCenterTableViewType_completeness)
    {
        ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kListCellID forIndexPath:indexPath];
        if (indexPath.row == 0) {
            
            NSDictionary * userInfo = self.dataArray[indexPath.row];
            if ([[userInfo objectForKey:kUserId] intValue] == [[UserManager sharedManager] getUserId]) {
                cell.isShow = YES;
            }else
            {
               cell.isShow = NO;
            }
        }else
        {
            cell.isShow = NO;
        }
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_bookmark)
    {
        BookMarkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBookmarkCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        if (self.isMyBookmarkDelete) {
            [cell resetDeleteView];
        }
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_integralRecord)
    {
        IntegralRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kIntegralRecordCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_prizeRecord)
    {
        PrizeRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kPrizeRecordCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        cell.cancelConvertPrizeBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.cancelConvertPrizeBlock) {
                weakSelf.cancelConvertPrizeBlock(infoDic);
            }
        };
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_MytaskComplateDetail)
    {
        MyTaskDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMytaskDetailCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        cell.checkTaskBlock = ^(NSDictionary *infoDic, DoTaskType type) {
            if (weakSelf.checkTaskBlock) {
                weakSelf.checkTaskBlock(infoDic, type);
            }
        };
        
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_classMemberTaskComplateDetail)
    {
        ClassMemberTaskComplateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kClassMemberTaskComplateDetail forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_main_xilie || self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_main_suitang)
    {
        ArrangTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kArrangtaskCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        __weak typeof(cell)weakCell = cell;
        cell.arrangeTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
            CGRect convertRect = [weakCell convertRect:rect toView:self];
            if (weakSelf.arrangeTaskBlock) {
                weakSelf.arrangeTaskBlock(infoDic, convertRect);
            }
        };
        cell.deleteTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
            CGRect convertRect = [weakCell convertRect:rect toView:self];
            if (weakSelf.deleteTaskBlock) {
                weakSelf.deleteTaskBlock(infoDic, convertRect);
            }
        };
        cell.operationTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
            CGRect convertRect = [weakCell convertRect:rect toView:self];
            if (weakSelf.operationTaskBlock) {
                weakSelf.operationTaskBlock(infoDic, convertRect);
            };
        };
        
        cell.shareTaskBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.shareTaskBlock) {
                weakSelf.shareTaskBlock(infoDic);
            }
        };
        
        
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_haveArrangeTask)
    {
        HaveArrangeTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kHaveArrangTaskCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
         __weak typeof(cell)weakCell = cell;
        cell.haveArrangeTaskOperationBlock = ^(NSDictionary *infoDic, CGRect rect) {
            CGRect convertRect = [weakCell convertRect:rect toView:self];
            if (weakSelf.haveArrangeTaskOperationBlock) {
                weakSelf.haveArrangeTaskOperationBlock(infoDic, convertRect);
            };
        };
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_commentTask)
    {
        CommentTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommentTaskCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        cell.commentTaskBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.commentTaskBlock) {
                weakSelf.commentTaskBlock(infoDic);
            }
        };
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_studentTaskcomplate)
    {
        StudentTaskComplateProgressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kStudentTaskComplateProgressCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_school_xilie || self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_school_suitang)
    {
        TaskLibraryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTaskLibraryCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
         __weak typeof(cell)weakCell = cell;
        cell.arrangeTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
            CGRect convertRect = [weakCell convertRect:rect toView:weakSelf];
            if (weakSelf.arrangeTaskBlock) {
                weakSelf.arrangeTaskBlock(infoDic, convertRect);
            }
        };
        cell.collectTaskBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.collectTaskBlock) {
                weakSelf.collectTaskBlock(infoDic);
            }
        };
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacherCourse)
    {
        TeacherCourseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacherCourseCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_studentIntegralList)
    {
        Teacher_stufentIntegralListCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacherStudentIntegralListCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_studentIntegralPrizeRecord)
    {
        Teacher_studentPrizeRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacher_etudentPrizeRecordCellID forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
         __weak typeof(cell)weakCell = cell;
        cell.teacher_StudentPrizeRecordBlock = ^(NSDictionary *infoDic,CGRect rect) {
            
            CGRect convertRect = [weakCell convertRect:rect toView:weakSelf];
            if (weakSelf.teacher_StudentPrizeRecordBlock) {
                weakSelf.teacher_StudentPrizeRecordBlock(infoDic, convertRect);
            }
        };
        
        return cell;
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_ClassroomTaskList)
    {
        Teacher_classroomTaskListCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacher_classroomTaskListCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        __weak typeof(cell)weakCell = cell;
        cell.teacher_ClassroomTaskOperationBlock = ^(NSDictionary *infoDic,CGRect rect) {
            
            CGRect convertRect = [weakCell convertRect:rect toView:weakSelf];
            if (weakSelf.haveArrangeTaskOperationBlock) {
                weakSelf.haveArrangeTaskOperationBlock(infoDic, convertRect);
            }
        };
        
        return cell;
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_haveSendIntegral)
    {
        Teacher_haveSendIntegralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacher_haveSendIntegralTableViewCell forIndexPath:indexPath];
        [cell refreshWith:self.dataArray[indexPath.row]];
        
        cell.editPrizeRemarkBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.editPrizeRemarkBlock) {
                weakSelf.editPrizeRemarkBlock(infoDic);
            }
        };
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.UserCenterCellClickBlock) {
        self.UserCenterCellClickBlock(self.usercenterTableViewType,self.dataArray[indexPath.row]);
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    if (self.usercenterTableViewType == UserCenterTableViewType_MyTask) {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.3, view.hd_height) andTitle:@"作业名称"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width * 0.3, view.hd_height) andTitle:@"对象"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"起止日期"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"作业详情"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_ClassroomTask)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 2, view.hd_height) andTitle:@"作业名称"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"起止日期"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"完成情况"];
        [view addSubview:timeLB];
        
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_shichang)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.2, view.hd_height) andTitle:@"时间"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"听"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"阅读"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"录音"];
        [view addSubview:recoardLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(recoardLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"详情"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_achievement)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.25, view.hd_height) andTitle:@"时间"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"星星数"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"红花数"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"奖章数"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_myCourse)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.25, view.hd_height) andTitle:@"课程"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"老师"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"班级"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"进度"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_Course)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.25, view.hd_height) andTitle:@"课程"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"老师"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"进度"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.25, view.hd_height) andTitle:@"起止日期"];
        [view addSubview:detailLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_courseCost)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"班级"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"课耗"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"剩余课时"];
        [view addSubview:timeLB];
        
    }else if (self.usercenterTableViewType == UserCenterTableViewType_gold || self.usercenterTableViewType == UserCenterTableViewType_star || self.usercenterTableViewType == UserCenterTableViewType_flower || self.usercenterTableViewType == UserCenterTableViewType_completeness)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"排名"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 2, view.hd_height) andTitle:@"学员"];
        [view addSubview:nameLB];
        
        if (self.usercenterTableViewType == UserCenterTableViewType_star) {
            UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"星星数"];
            timeLB.textAlignment = NSTextAlignmentLeft;
            [view addSubview:timeLB];
        }else if (self.usercenterTableViewType == UserCenterTableViewType_flower)
        {
            UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"红花数"];
            timeLB.textAlignment = NSTextAlignmentLeft;
            [view addSubview:timeLB];
        }else if (self.usercenterTableViewType == UserCenterTableViewType_completeness)
        {
            UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"完成度"];
            timeLB.textAlignment = NSTextAlignmentLeft;
            [view addSubview:timeLB];
        }
        else
        {
            UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"奖章数"];
            timeLB.textAlignment = NSTextAlignmentLeft;
            [view addSubview:timeLB];
        }
    }else if(self.usercenterTableViewType == UserCenterTableViewType_bookmark)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"所属课本"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"课文"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"阅读时间"];
        [view addSubview:timeLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_integralRecord)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width * 0.2, view.hd_height) andTitle:@"积分"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"途径"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width * 0.2, view.hd_height) andTitle:@"时间"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.4, view.hd_height) andTitle:@"备注"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_prizeRecord)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width /3 , view.hd_height) andTitle:@"奖品"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"积分"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"申请时间"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_MytaskComplateDetail)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width /6 , view.hd_height) andTitle:@"作业类型"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 2, view.hd_height) andTitle:@"作业详情"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"操作"];
        [view addSubview:detailLB];
    }else if(self.usercenterTableViewType == UserCenterTableViewType_classMemberTaskComplateDetail)
    {
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 4, view.hd_height) andTitle:@"序号"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 2, view.hd_height) andTitle:@"学员"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"完成度"];
        [view addSubview:timeLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_main_xilie ||self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_main_suitang)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 8 * 3, view.hd_height) andTitle:@"模板名称"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"备注"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 8, view.hd_height) andTitle:@"布置"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width /8, view.hd_height) andTitle:@"操作"];
        [view addSubview:recoardLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(recoardLB.frame), 0, view.hd_width /8, view.hd_height) andTitle:@"分享"];
        [view addSubview:detailLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_haveArrangeTask)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 4, view.hd_height) andTitle:@"作业名称"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"对象"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"起止日期"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"状态"];
        [view addSubview:recoardLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(recoardLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"操作"];
        [view addSubview:detailLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_commentTask)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"学员"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"作业"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"上传时间"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"状态"];
        [view addSubview:recoardLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(recoardLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"操作"];
        [view addSubview:detailLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_studentTaskcomplate)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 9, view.hd_height) andTitle:@"排行"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"学员"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"所在班级"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"今日完成度"];
        [view addSubview:recoardLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_school_suitang || self.usercenterTableViewType == UserCenterTableViewType_arrangeTask_school_xilie)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 2, view.hd_height) andTitle:@"模板名称"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"备注"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 8, view.hd_height) andTitle:@"布置"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width /8, view.hd_height) andTitle:@"收藏"];
        [view addSubview:recoardLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacherCourse)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 4, view.hd_height) andTitle:@"课程"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"班级"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"进度(节)"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"学员数"];
        [view addSubview:recoardLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(recoardLB.frame), 0, view.hd_width /6, view.hd_height) andTitle:@"状态"];
        [view addSubview:detailLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_studentIntegralList)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 10, view.hd_height) andTitle:@"排名"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width * 0.3, view.hd_height) andTitle:@"学员"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width * 0.3, view.hd_height) andTitle:@"所在班级"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width * 0.3, view.hd_height) andTitle:@"可兑积分/积分"];
        [view addSubview:recoardLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_studentIntegralPrizeRecord)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 5, view.hd_height) andTitle:@"兑奖人"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 5 * 2, view.hd_height) andTitle:@"奖品"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width/ 5, view.hd_height) andTitle:@"申请时间"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width / 5, view.hd_height) andTitle:@"操作"];
        [view addSubview:recoardLB];
    }
    else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_ClassroomTaskList)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 2, view.hd_height) andTitle:@"作业名称"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"起止日期"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width/ 8, view.hd_height) andTitle:@"状态"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width / 8, view.hd_height) andTitle:@"操作"];
        [view addSubview:recoardLB];
    }else if (self.usercenterTableViewType == UserCenterTableViewType_teacher_haveSendIntegral)
    {
        UILabel * timeLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"学员"];
        [view addSubview:timeLB];
        
        UILabel * lisenLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"已送积分"];
        [view addSubview:lisenLB];
        
        UILabel * readLB = [self headLB:CGRectMake(CGRectGetMaxX(lisenLB.frame), 0, view.hd_width/ 6, view.hd_height) andTitle:@"时间"];
        [view addSubview:readLB];
        
        UILabel * recoardLB = [self headLB:CGRectMake(CGRectGetMaxX(readLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"备注"];
        [view addSubview:recoardLB];
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.hd_height * 0.163;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
    UIImage * image = [UIImage imageNamed:@""];
    NSString * content = @"";
    NSMutableAttributedString * detail =  [[NSMutableAttributedString alloc]initWithString:@""];
    
    switch (self.usercenterTableViewType) {
        case UserCenterTableViewType_MyTask:
            {
                self.dataArray = [[[UserManager sharedManager] getMyHeadTaskList] mutableCopy];
                image = [UIImage imageNamed:@"default_homework_icon"];
                content = @"暂无作业";
                detail = [[NSMutableAttributedString alloc]initWithString:@""];
            }
            break;
        case UserCenterTableViewType_ClassroomTask:
        {
            self.dataArray = [[[UserManager sharedManager] getClassTaskArray] mutableCopy];
            image = [UIImage imageNamed:@"default_homework_icon"];
            content = @"班级内暂无作业";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_shichang:
        {
            
            NSDictionary * infoDic = [[UserManager sharedManager] getMyStudyTimeLengthList];
            if (infoDic == nil) {
                return;
            }
            NSMutableArray * dataArray = [[infoDic objectForKey:@"data"] mutableCopy];
            NSDictionary * totalDic = @{kTime:@"总计",kHearLength:[infoDic objectForKey:@"allHear"], kReadLength:[infoDic objectForKey:@"allRead"], kRecordLength:[infoDic objectForKey:@"allRecord"]};
            [dataArray addObject:totalDic];
            self.dataArray = dataArray;
        }
            break;
        case UserCenterTableViewType_achievement:
        {
            NSDictionary * infoDic = [[UserManager sharedManager] getMyAchievementList];
            
            if (infoDic == nil) {
                return;
            }
            NSMutableArray * dataArray = [[infoDic objectForKey:@"data"] mutableCopy];
            NSDictionary * totalDic = @{kTime:@"总计",kstarNum:[infoDic objectForKey:@"allStar"], kflowerNum:[infoDic objectForKey:@"allFlower"], kmedalNum:[infoDic objectForKey:@"allMedal"]};
            [dataArray addObject:totalDic];
            self.dataArray = dataArray;
        }
            break;
        case UserCenterTableViewType_courseCost:
        {
            self.dataArray = [[[UserManager sharedManager] getMyCourseCost] mutableCopy];
            image = [UIImage imageNamed:@"default_teaching_material_icon"];
            content = @"暂无课耗信息";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_myCourse:
        {
            self.dataArray = [[[UserManager sharedManager] getMyCourseList] mutableCopy];
            image = [UIImage imageNamed:@"default_teaching_material_icon"];
            content = @"暂无课程信息";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_Course:
        {
            self.dataArray = [[[UserManager sharedManager] getMyCourseList] mutableCopy];
            image = [UIImage imageNamed:@"default_teaching_material_icon"];
            content = @"班级内暂无课程";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_star:
        {
            self.dataArray = [[[UserManager sharedManager] getClassMemberAchievementArray] mutableCopy];
            image = [UIImage imageNamed:@"default_ranking_icon"];
            if (self.isClassroom) {
                content = @"暂无学员";
            }else
            {
                content = @"无好友排行";
                detail = [[NSMutableAttributedString alloc]initWithString:@"先去好友页面添加你的小伙伴吧"];
            }
        }
            break;
        case UserCenterTableViewType_flower:
        {
            self.dataArray = [[[UserManager sharedManager] getClassMemberAchievementArray] mutableCopy];
            image = [UIImage imageNamed:@"default_ranking_icon"];
            if (self.isClassroom) {
                content = @"暂无学员";
            }else
            {
                content = @"无好友排行";
                detail = [[NSMutableAttributedString alloc]initWithString:@"先去好友页面添加你的小伙伴吧"];
            }
        }
            break;
        case UserCenterTableViewType_gold:
        {
            self.dataArray = [[[UserManager sharedManager] getClassMemberAchievementArray] mutableCopy];
            image = [UIImage imageNamed:@"default_ranking_icon"];
            if (self.isClassroom) {
                content = @"暂无学员";
            }else
            {
                content = @"无好友排行";
                detail = [[NSMutableAttributedString alloc]initWithString:@"先去好友页面添加你的小伙伴吧"];
            }
        }
            break;
        case UserCenterTableViewType_completeness:
        {
            self.dataArray = [[[UserManager sharedManager] getClassMemberAchievementArray] mutableCopy];
            image = [UIImage imageNamed:@"default_ranking_icon"];
            content = @"暂无学员";
        }
            break;
        case UserCenterTableViewType_bookmark:
        {
            self.dataArray = [[[UserManager sharedManager] getMyBookmarkArray] mutableCopy];
            image = [UIImage imageNamed:@"default_bookmark_icon"];
            content = @"你还没有留下任何足迹哦";
            detail = [[NSMutableAttributedString alloc]initWithString:@"去“阅读录音”看看"];
            NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
            [detail setAttributes:attribute range:NSMakeRange(1, 6)];
        }
            break;
        case UserCenterTableViewType_integralRecord:
        {
            self.dataArray = [[[UserManager sharedManager] getmyIntegralRecord] mutableCopy];
            image = [UIImage imageNamed:@"default_integral_icon"];
            content = @"";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_prizeRecord:
        {
            self.dataArray = [[[UserManager sharedManager] getConvertPrizeRecordList] mutableCopy];
            image = [UIImage imageNamed:@"default_prize_icon"];
            content = @"";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_MytaskComplateDetail:
        {
            self.dataArray = [[[UserManager sharedManager] getMyEveryDayTaskDetailList] mutableCopy];
        }
            break;
        case UserCenterTableViewType_classMemberTaskComplateDetail:
        {
            self.dataArray = [[[UserManager sharedManager] getClassMemberComplateTaskInfoArray] mutableCopy];
            
        }
            break;
        case UserCenterTableViewType_arrangeTask_main_suitang:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacher_Main_suitangTaskModulArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_arrangeTask_main_xilie:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacher_Main_xilieTaskModulArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_arrangeTask_school_suitang:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacher_School_suitangTaskModulArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_arrangeTask_school_xilie:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacher_School_xilieTaskModulArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_haveArrangeTask:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacherHaveArrangeTaskArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_commentTask:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacherCommentTaskListArray] mutableCopy];
        }
            break;
        case UserCenterTableViewType_studentTaskcomplate:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacherTodayTaskComplateArray] mutableCopy];
        }
            break;
        
        case UserCenterTableViewType_teacherCourse:
        {
            self.dataArray = [[[UserManager sharedManager] getTeacherMyCourseArray] mutableCopy];
            image = [UIImage imageNamed:@"default_teaching_material_icon"];
            content = @"暂无课程信息";
            detail = [[NSMutableAttributedString alloc]initWithString:@""];
        }
            break;
        case UserCenterTableViewType_teacher_studentIntegralList:
        {
            self.dataArray = [[[UserManager sharedManager] teacher_memberIntegralList] mutableCopy];
        }
            break;
        case UserCenterTableViewType_teacher_studentIntegralPrizeRecord:
        {
            self.dataArray = [[[UserManager sharedManager] getConvertPrizeRecordList] mutableCopy];
        }
            break;
        case UserCenterTableViewType_teacher_ClassroomTaskList:
        {
            self.dataArray = [[NSMutableArray alloc]initWithArray:@[@{@"taskName":@"毛毛",@"state":@"千书堂",@"time":@"08/20-08/28"},@{@"taskName":@"cehsi",@"state":@"千书堂",@"time":@"08/20-08/28"},@{@"taskName":@"mcb",@"state":@"千书堂",@"time":@"08/20-08/28"}]];
        }
            break;
        case UserCenterTableViewType_teacher_haveSendIntegral:
        {
            self.dataArray = [[[UserManager sharedManager] teacher_haveSendIntegralList] mutableCopy];
        }
            break;
        default:
        {
            self.dataArray = nil;
        }
            break;
    }
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
    if (self.dataArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
    }
}

- (void)resetUsercenterTableViewType:(UserCenterTableViewType )usercenterTableViewType
{
    self.usercenterTableViewType = usercenterTableViewType;
    [self.tableView.mj_header endRefreshing];
    if (self.usercenterTableViewType == UserCenterTableViewType_calendr) {
        self.calendarPickerView.hidden = NO;
        
        [self.calendarPickerView refreshWith:[[UserManager sharedManager] getMyPunchCardList]];
        
        self.tableView.hidden = YES;
        self.failedView.hidden = YES;
    }else
    {
        self.calendarPickerView.hidden = YES;
        self.tableView.hidden = NO;
        [self loadData];
        [self.tableView reloadData];
    }
}

- (void)resetWith:(NSDictionary *)infoDic
{
    int number = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary * dic = [self.dataArray objectAtIndex:i];
        if ([[dic objectForKey:@"id"] isEqualToString:[infoDic objectForKey:@"id"]]) {
            number = i;
            break;
        }
    }
    [self.dataArray removeObjectAtIndex:number];
    [self.dataArray insertObject:infoDic atIndex:number];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
