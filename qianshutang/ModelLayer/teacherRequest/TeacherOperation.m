//
//  TeacherOperation.m
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/4.
//  Copyright © 2018 mcb. All rights reserved.
//

#import "TeacherOperation.h"

@interface TeacherOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<Teacher_MyCourseList> Teacher_MyCourseList;
@property (nonatomic,weak) id<Teacher_sectionList> Teacher_sectionList;
@property (nonatomic,weak) id<Teacher_sectionAttendance> Teacher_sectionAttendance;
@property (nonatomic,weak) id<Teacher_totalAttendance> Teacher_totalAttendance;
@property (nonatomic,weak) id<Teacher_attendanceForm> Teacher_attendanceForm;
@property (nonatomic,weak) id<Teacher_addCourseSection> Teacher_addCourseSection;
@property (nonatomic,weak) id<Teacher_deleteCourseSection> Teacher_deleteCourseSection;
@property (nonatomic,weak) id<Teacher_editCourseSection> Teacher_editCourseSection;
@property (nonatomic,weak) id<Teacher_getTaskMould> Teacher_getTaskMould;
@property (nonatomic,weak) id<Teacher_createSuiTangTask> Teacher_createSuiTangTask;
@property (nonatomic,weak) id<Teacher_createXiLieTask> Teacher_createXiLieTask;
@property (nonatomic,weak) id<Teacher_createMetarial> Teacher_createMetarial;
@property (nonatomic,weak) id<Teacher_arrangeTask> Teacher_arrangeTask;
@property (nonatomic,weak) id<Teacher_shareTaskMouldToschool> Teacher_shareTaskMouldToschool;
@property (nonatomic,weak) id<Teacher_haveArrangeTask> Teacher_haveArrangeTask;
@property (nonatomic,weak) id<Teacher_commentTaskList> Teacher_commentTaskList;
@property (nonatomic,weak) id<Teacher_commentTask> Teacher_commentTask;
@property (nonatomic,weak) id<Teacher_todayTaskComplateList> Teacher_todayTaskComplateList;
@property (nonatomic,weak) id<Teacher_studentHistoryTask> Teacher_studentHistoryTask;
@property (nonatomic,weak) id<Teacher_addClassroomTextBook> Teacher_addClassroomTextBook;
@property (nonatomic,weak) id<Teacher_deleteClassroomTextBook> Teacher_deleteClassroomTextBook;
@property (nonatomic,weak) id<Teacher_sectionCallRoll> Teacher_sectionCallRoll;
@property (nonatomic,weak) id<Teacher_classroomSign> Teacher_classroomSign;

@property (nonatomic,weak) id<Teacher_checkTask> Teacher_checkTask;
@property (nonatomic,weak) id<Teacher_changeModulName> Teacher_changeModulName;
@property (nonatomic,weak) id<Teacher_changeModulRemark> Teacher_changeModulRemark;
@property (nonatomic,weak) id<Teacher_changeHaveArrangeModulName> Teacher_changeHaveArrangeModulName;

@property (nonatomic,weak) id<Teacher_getSuitangDetail> Teacher_getSuitangDetail;
@property (nonatomic,weak) id<Teacher_getXilieDetail> Teacher_getXilieDetail;

@property (nonatomic,weak) id<Teacher_getEditXilieTaskDetail> Teacher_getEditXilieTaskDetail;
@property (nonatomic,weak) id<Teacher_addSuitangTaskType> Teacher_addSuitangTaskType;
@property (nonatomic,weak) id<Teacher_addXilieTaskType> Teacher_addXilieTaskType;

@property (nonatomic,weak) id<Teacher_deleteModul> Teacher_deleteModul;
@property (nonatomic, weak)id<Teacher_changeSuitangModulTextBook> Teacher_changeSuitangModulTextBook;
@property (nonatomic, weak)id<Teacher_changeSuitangModulRepeatCount> Teacher_changeSuitangModulRepeatCount;
@property (nonatomic, weak)id<Integral_Teacher_getAddressInfo> Integral_Teacher_getAddressInfo;

@property (nonatomic, weak)id<Teacher_collectSchoolTaskModul> Teacher_collectSchoolTaskModul;
@property (nonatomic, weak)id<Teacher_CommentModul> Teacher_CommentModul;
@property (nonatomic, weak)id<Teacher_addTextToCommentModul> Teacher_addTextToCommentModul;
@property (nonatomic, weak)id<GetmainPageCategory> GetmainPageCategory;
@property (nonatomic, weak)id<IsHaveNewMessage> IsHaveNewMessage;
@property (nonatomic, weak)id<Teacher_getTodayClassroomTask> Teacher_getTodayClassroomTask;

@property (nonatomic, weak)id<Teacher_classroomAttendanceList> Teacher_classroomAttendanceList;
@property (nonatomic, weak)id<Teacher_deleteCommentModul> Teacher_deleteCommentModul;
@property (nonatomic, weak)id<Teacher_editHaveSendIntegralRemark> Teacher_editHaveSendIntegralRemark;
@property (nonatomic, weak)id<Teacher_deleteTaskModul> Teacher_deleteTaskModul;
@property (nonatomic, weak)id<Teacher_deleteCollectTaskModul> Teacher_deleteCollectTaskModul;
@property (nonatomic, weak)id<Teacher_editStudent_remark> Teacher_editStudent_remark;

@property (nonatomic, weak)id<Teacher_deleteHaveArrangeTask> Teacher_deleteHaveArrangeTask;
@property (nonatomic, weak)id<Teacher_PriseAndflower> Teacher_PriseAndflower;

@property (nonatomic, strong)NSDictionary * requestInfo;

@end

@implementation TeacherOperation

- (NSMutableArray *)isHaveNewMessageInfoDic
{
    if (!_isHaveNewMessageInfoDic) {
        _isHaveNewMessageInfoDic = [NSMutableArray array];
    }
    return _isHaveNewMessageInfoDic;
}

- (void)didRequestTeacher_MyCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_MyCourseList>)object
{
    self.Teacher_MyCourseList = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_MyCourseWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_sectionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionList>)object
{
    self.Teacher_sectionList = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_sectionListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_sectionAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionAttendance>)object
{
    self.Teacher_sectionAttendance = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_sectionAttendanceWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_totalAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_totalAttendance>)object
{
    self.Teacher_totalAttendance = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_totalAttendanceWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_attendanceFormWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_attendanceForm>)object
{
    self.Teacher_attendanceForm = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_attendanceFormWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_addCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addCourseSection>)object
{
    self.Teacher_addCourseSection = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_addCourseSectionWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_deleteCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCourseSection>)object
{
    self.Teacher_deleteCourseSection = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteCourseSectionWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_editCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editCourseSection>)object
{
    self.Teacher_editCourseSection = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_editCourseSectionWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_getTaskMouldWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTaskMould>)object
{
    self.Teacher_getTaskMould = object;
    self.requestInfo = infoDic;
    [[HttpRequestManager sharedManager] reqeustTeacher_getTaskMouldWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_createSuiTangTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createSuiTangTask>)object
{
    self.Teacher_createSuiTangTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_createSuiTangTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_createXiLieTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createXiLieTask>)object
{
    self.Teacher_createXiLieTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_createXiLieTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_createMetarialWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createMetarial>)object
{
    self.Teacher_createMetarial = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_createMetarialWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_arrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_arrangeTask>)object
{
    self.Teacher_arrangeTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_arrangeTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_shareTaskMouldToschoolWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_shareTaskMouldToschool>)object
{
    self.Teacher_shareTaskMouldToschool = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_shareTaskMouldToschoolWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_haveArrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_haveArrangeTask>)object
{
    self.Teacher_haveArrangeTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_haveArrangeTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_commentTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTaskList>)object
{
    self.Teacher_commentTaskList = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_commentTaskListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_commentTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTask>)object
{
    self.Teacher_commentTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_commentTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_todayTaskComplateListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_todayTaskComplateList>)object
{
    self.Teacher_todayTaskComplateList = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_todayTaskComplateListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_studentHistoryTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_studentHistoryTask>)object
{
    self.Teacher_studentHistoryTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_studentHistoryTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_addClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addClassroomTextBook>)object
{
    self.Teacher_addClassroomTextBook = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_addClassroomTextBookWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_deleteClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteClassroomTextBook>)object
{
    self.Teacher_deleteClassroomTextBook = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteClassroomTextBookWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_sectionCallRollWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionCallRoll>)object
{
    self.Teacher_sectionCallRoll = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_sectionCallRollWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_classroomSignWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomSign>)object
{
    self.Teacher_classroomSign = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_classroomSignWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_checkTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_checkTask>)object
{
    self.Teacher_checkTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_checkTaskWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_changeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulName>)object
{
    self.Teacher_changeModulName = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_changeModulNameWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_changeHaveArrangeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeHaveArrangeModulName>)object
{
    self.Teacher_changeHaveArrangeModulName = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_changeHaveArrangeModulNameWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_changeModulRemarkWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulRemark>)object
{
    self.Teacher_changeModulRemark = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_changeModulRemarkWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_getSuitangDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getSuitangDetail>)object
{
    self.Teacher_getSuitangDetail = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_getSuitangDetailWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_getXilieDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getXilieDetail>)object{
    self.Teacher_getXilieDetail = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_getXilieDetailWithDic:infoDic andProcessDelegate:self];
}


- (void)didRequestTeacher_getEditXilieTaskDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getEditXilieTaskDetail>)object
{
    self.Teacher_getEditXilieTaskDetail = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_getEditXilieTaskDetailWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_addSuitangTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addSuitangTaskType>)object
{
    self.Teacher_addSuitangTaskType = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_AddSuitangTaskTypeWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_addXilieTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addXilieTaskType>)object
{
    self.Teacher_addXilieTaskType = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_AddXilieTaskTypeWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_DeleteModulWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteModul>)object
{
    self.Teacher_deleteModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_DeleteModulWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_changeSuitangModulTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulTextBook>)object
{
    self.Teacher_changeSuitangModulTextBook = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_changeSuitangModultextbookWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_changeSuitangModulRepeatCountWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulRepeatCount>)object
{
    self.Teacher_changeSuitangModulRepeatCount = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_changeSuitangModulRepeatCountWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_GetAddressInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_getAddressInfo>)object
{
    self.Integral_Teacher_getAddressInfo = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_GetAddressInfoWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_collectSchoolTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_collectSchoolTaskModul>)object
{
    self.Teacher_collectSchoolTaskModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_collectSchoolTaskModulWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_CommentModulListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_CommentModul>)object
{
    self.Teacher_CommentModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_CommentModulListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_addTextToCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addTextToCommentModul>)object
{
    self.Teacher_addTextToCommentModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_addTextToCommentModulWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<GetmainPageCategory>)object
{
    self.GetmainPageCategory = object;
    [[HttpRequestManager sharedManager] reqeustGetGetmainPageCategoryWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestGetIsHaveNewMessageWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<IsHaveNewMessage>)object
{
    self.IsHaveNewMessage = object;
    [[HttpRequestManager sharedManager] reqeustGetIsHaveNewMessageWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_getTodayClassroomTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTodayClassroomTask>)object
{
    self.Teacher_getTodayClassroomTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_getTodayClassroomTaskWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_classroomAttendanceListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomAttendanceList>)object
{
    self.Teacher_classroomAttendanceList = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_classroomAttendanceListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_deleteCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCommentModul>)object
{
    self.Teacher_deleteCommentModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteCommentModulWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_editHaveSendIntegralRemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editHaveSendIntegralRemark>)object
{
    self.Teacher_editHaveSendIntegralRemark = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_editHaveSendIntegralRemarkWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_deleteTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteTaskModul>)object
{
    self.Teacher_deleteTaskModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteTaskModulWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_deleteCollectTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCollectTaskModul>)object
{
    self.Teacher_deleteCollectTaskModul = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteCollectTaskModulWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_editStudent_RemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editStudent_remark>)object
{
    self.Teacher_editStudent_remark = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_editStudentInfo_remarkWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_deleteHaveArrangeTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteHaveArrangeTask>)object
{
    self.Teacher_deleteHaveArrangeTask = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_deleteHaveArrangeTaskWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_PriseAndflowerWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_PriseAndflower>)object
{
    self.Teacher_PriseAndflower = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_PriseAndflowerWithDic:infoDic andProcessDelegate:self];
}


#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        
        case 101:
        {
            self.myCourseArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_MyCourseList)) {
                [self.Teacher_MyCourseList didRequestTeacher_MyCourseListSuccessed];
            }
        }
            break;
        case 102:
        {
            self.sectionListArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_sectionList)) {
                [self.Teacher_sectionList didRequestTeacher_sectionListSuccessed];
            }
        }
            break;
        case 103:
        {
            self.sectionAttendanceRecordInfo = successInfo;

            if (isObjectNotNil(self.Teacher_sectionAttendance)) {
                [self.Teacher_sectionAttendance didRequestTeacher_sectionAttendanceSuccessed];
            }
        }
            break;
        case 104:
        {
            self.totalAttendanceArray = [successInfo objectForKey:@"data"];

            if (isObjectNotNil(self.Teacher_totalAttendance)) {
                [self.Teacher_totalAttendance didRequestTeacher_totalAttendanceSuccessed];
            }
        }
            break;
        case 105:
        {
            if (isObjectNotNil(self.Teacher_attendanceForm)) {
                [self.Teacher_attendanceForm didRequestTeacher_attendanceFormSuccessed];
            }
        }
            break;
        case 106:
        {
            if (isObjectNotNil(self.Teacher_addCourseSection)) {
                [self.Teacher_addCourseSection didRequestTeacher_addCourseSectionSuccessed];
            }
        }
            break;
        case 107:
        {
            if (isObjectNotNil(self.Teacher_deleteCourseSection)) {
                [self.Teacher_deleteCourseSection didRequestTeacher_deleteCourseSectionSuccessed];
            }
        }
            break;
        case 108:
        {
            if (isObjectNotNil(self.Teacher_editCourseSection)) {
                [self.Teacher_editCourseSection didRequestTeacher_editCourseSectionSuccessed];
            }
        }
            break;
        case 109:
        {
            if ([[self.requestInfo objectForKey:ktempType] intValue] == 1 && [[self.requestInfo objectForKey:kshareType] intValue] == 1) {
                self.main_suitangtaskMouldArray = [successInfo objectForKey:@"data"];
            }else if ([[self.requestInfo objectForKey:ktempType] intValue] == 2 && [[self.requestInfo objectForKey:kshareType] intValue] == 1){
                self.main_xilietaskMouldArray = [successInfo objectForKey:@"data"];
            }else if ([[self.requestInfo objectForKey:ktempType] intValue] == 1 && [[self.requestInfo objectForKey:kshareType] intValue] == 2)
            {
                self.school_suitangtaskMouldArray = [successInfo objectForKey:@"data"];
            }else if ([[self.requestInfo objectForKey:ktempType] intValue] == 2 && [[self.requestInfo objectForKey:kshareType] intValue] == 2){
                self.school_xilietaskMouldArray = [successInfo objectForKey:@"data"];
            }

            if (isObjectNotNil(self.Teacher_getTaskMould)) {
                [self.Teacher_getTaskMould didRequestTeacher_getTaskMouldSuccessed];
            }
        }
            break;
        case 110:
        {
            if (isObjectNotNil(self.Teacher_createSuiTangTask)) {
                [self.Teacher_createSuiTangTask didRequestTeacher_createSuiTangTaskSuccessed];
            }
        }
            break;
        case 111:
        {
            if (isObjectNotNil(self.Teacher_createXiLieTask)) {
                [self.Teacher_createXiLieTask didRequestTeacher_createXiLieTaskSuccessed];
            }
        }
            break;
        case 112:
        {
            self.createMetarial_madeId = successInfo;
            if (isObjectNotNil(self.Teacher_createMetarial)) {
                [self.Teacher_createMetarial didRequestTeacher_createMetarialSuccessed];
            }
        }
            break;
        case 113:
        {
            if (isObjectNotNil(self.Teacher_arrangeTask)) {
                [self.Teacher_arrangeTask didRequestTeacher_arrangeTaskSuccessed];
            }
        }
            break;
        case 114:
        {
            if (isObjectNotNil(self.Teacher_shareTaskMouldToschool)) {
                [self.Teacher_shareTaskMouldToschool didRequestTeacher_shareTaskMouldToschoolSuccessed];
            }
        }
            break;
        case 115:
        {
            self.haveArrangeTaskArray = [successInfo objectForKey:@"data"];

            if (isObjectNotNil(self.Teacher_haveArrangeTask)) {
                [self.Teacher_haveArrangeTask didRequestTeacher_haveArrangeTaskSuccessed];
            }
        }
            break;
        case 116:
        {
            self.commentTaskLiatArray = [successInfo objectForKey:@"data"];

            if (isObjectNotNil(self.Teacher_commentTaskList)) {
                [self.Teacher_commentTaskList didRequestTeacher_commentTaskListSuccessed];
            }
        }
            break;
        case 117:
        {
            if (isObjectNotNil(self.Teacher_commentTask)) {
                [self.Teacher_commentTask didRequestTeacher_commentTaskSuccessed];
            }
        }
            break;
        case 118:
        {
            self.todayTaskComplateArray = [successInfo objectForKey:@"data"];

            if (isObjectNotNil(self.Teacher_todayTaskComplateList)) {
                [self.Teacher_todayTaskComplateList didRequestTeacher_todayTaskComplateListSuccessed];
            }
        }
            break;
        case 119:
        {
            self.studentHistoryTaskArray = [successInfo objectForKey:@"data"];
            self.studentHistoryTaskInfoDic = successInfo;
            if (isObjectNotNil(self.Teacher_studentHistoryTask)) {
                [self.Teacher_studentHistoryTask didRequestTeacher_studentHistoryTaskSuccessed];
            }
        }
            break;
        case 120:
        {
            if (isObjectNotNil(self.Teacher_addClassroomTextBook)) {
                [self.Teacher_addClassroomTextBook didRequestTeacher_addClassroomTextBookSuccessed];
            }
        }
            break;
        case 121:
        {
            if (isObjectNotNil(self.Teacher_deleteClassroomTextBook)) {
                [self.Teacher_deleteClassroomTextBook didRequestTeacher_deleteClassroomTextBookSuccessed];
            }
        }
            break;
        case 122:
        {
            if (isObjectNotNil(self.Teacher_sectionCallRoll)) {
                [self.Teacher_sectionCallRoll didRequestTeacher_sectionCallRollSuccessed];
            }
        }
            break;
        case 123:
        {
            if (isObjectNotNil(self.Teacher_classroomSign)) {
                [self.Teacher_classroomSign didRequestTeacher_classroomSignSuccessed];
            }
        }
            break;
        case 124:
        {
            if (isObjectNotNil(self.Teacher_checkTask)) {
                [self.Teacher_checkTask didRequestTeacher_checkTaskSuccessed];
            }
        }
            break;
        case 125:
        {
            if (isObjectNotNil(self.Teacher_changeModulName)) {
                [self.Teacher_changeModulName didRequestTeacher_changeMOdulNameSuccessed];
            }
        }
            break;
        case 126:
        {
            if (isObjectNotNil(self.Teacher_changeModulRemark)) {
                [self.Teacher_changeModulRemark didRequestTeacher_changeMOdulRemarkSuccessed];
            }
        }
            break;
        case 127:
        {
            if (isObjectNotNil(self.Teacher_changeHaveArrangeModulName)) {
                [self.Teacher_changeHaveArrangeModulName didRequestTeacher_changeHaveArrangeMOdulNameSuccessed];
            }
        }
            break;
        case 128:
        {
            self.suitangTaskArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_getSuitangDetail)) {
                [self.Teacher_getSuitangDetail didRequestTeacher_getSuitangDetailSuccessed];
            }
        }
            break;
        case 129:
        {
            self.xilieTaskArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_getXilieDetail)) {
                [self.Teacher_getXilieDetail didRequestTeacher_getXilieDetailSuccessed];
            }
        }
            break;
        case 130:
        {
            self.editXilieTaskArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_getEditXilieTaskDetail)) {
                [self.Teacher_getEditXilieTaskDetail didRequestTeacher_getEditXilieTaskDetailSuccessed];
            }
        }
            break;
        case 131:
        {
            if (isObjectNotNil(self.Teacher_addSuitangTaskType)) {
                [self.Teacher_addSuitangTaskType didRequestTeacher_addSuitangTaskTypeSuccessed];
            }
        }
            break;
        case 132:
        {
            if (isObjectNotNil(self.Teacher_addXilieTaskType)) {
                [self.Teacher_addXilieTaskType didRequestTeacher_addXilieTaskTypeSuccessed];
            }
        }
            break;
        case 133:
        {
            if (isObjectNotNil(self.Teacher_deleteModul)) {
                [self.Teacher_deleteModul didRequestTeacher_deleteModulSuccessed];
            }
        }
            break;
        case 140:
        {
            if (isObjectNotNil(self.Teacher_changeSuitangModulTextBook)) {
                [self.Teacher_changeSuitangModulTextBook didRequestTeacher_changeSuitangModulTextBookSuccessed];
            }
        }
            break;
        case 141:
        {
            if (isObjectNotNil(self.Teacher_changeSuitangModulRepeatCount)) {
                [self.Teacher_changeSuitangModulRepeatCount didRequestTeacher_changeSuitangModulRepeatCountSuccessed];
            }
        }
            break;
        case 142:
        {
            self.studentAddressInfoDic = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Integral_Teacher_getAddressInfo)) {
                [self.Integral_Teacher_getAddressInfo didRequestTeacher_getAddressInfoSuccessed];
            }
        }
            break;
        case 144:
        {
            self.teacher_TodayClassroomTaskList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_getTodayClassroomTask)) {
                [self.Teacher_getTodayClassroomTask didRequestTeacher_getTodayClassroomTaskSuccessed];
            }
        }
            break;
        case 145:
        {
            self.classroomAttendanceList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_classroomAttendanceList)) {
                [self.Teacher_classroomAttendanceList didRequestTeacher_classroomAttendanceListSuccessed];
            }
        }
            break;
        case 146:
        {
            [self.isHaveNewMessageInfoDic removeAllObjects];
            for (NSDictionary * infoDic in [successInfo objectForKey:@"data"]) {
                [self.isHaveNewMessageInfoDic addObject:infoDic];
            }
            
            if (isObjectNotNil(self.IsHaveNewMessage)) {
                [self.IsHaveNewMessage didRequestIsHaveNewMessageSuccessed];
            }
        }
            break;
        case 147:
        {
            self.commentModulList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_CommentModul)) {
                [self.Teacher_CommentModul didRequestTeacher_CommentModulSuccessed];
            }
        }
            break;
        case 148:
        {
            if (isObjectNotNil(self.Teacher_addTextToCommentModul)) {
                [self.Teacher_addTextToCommentModul didRequestTeacher_addTextToCommentModulSuccessed];
            }
        }
            break;
        case 149:
        {
            if (isObjectNotNil(self.Teacher_deleteCommentModul)) {
                [self.Teacher_deleteCommentModul didRequestTeacher_deleteCommentModulSuccessed];
            }
        }
            break;
        case 150:
        {
            if (isObjectNotNil(self.Teacher_editHaveSendIntegralRemark)) {
                [self.Teacher_editHaveSendIntegralRemark didRequestTeacher_editHaveSendIntegralRemarkSuccessed];
            }
        }
            break;
        case 151:
        {
            if (isObjectNotNil(self.Teacher_deleteTaskModul)) {
                [self.Teacher_deleteTaskModul didRequestTeacher_deleteTaskModulSuccessed];
            }
        }
            break;
            
        case 152:
        {
            if (isObjectNotNil(self.Teacher_collectSchoolTaskModul)) {
                [self.Teacher_collectSchoolTaskModul didRequestTeacher_collectSchoolTaskModulSuccessed];
            }
        }
            break;
        case 153:
        {
            if (isObjectNotNil(self.Teacher_deleteCollectTaskModul)) {
                [self.Teacher_deleteCollectTaskModul didRequestTeacher_deleteCollectTaskModulSuccessed];
            }
        }
            break;
        case 154:
        {
            if (isObjectNotNil(self.Teacher_editStudent_remark)) {
                [self.Teacher_editStudent_remark didRequestTeacher_editStudent_remarkSuccessed];
            }
        }
            break;
        case 155:
        {
            if (isObjectNotNil(self.Teacher_deleteHaveArrangeTask)) {
                [self.Teacher_deleteHaveArrangeTask didRequestTeacher_deleteHaveArrangeTaskSuccessed];
            }
        }
            break;
        case 156:
        {
            if (isObjectNotNil(self.Teacher_PriseAndflower)) {
                [self.Teacher_PriseAndflower didRequestTeacher_PriseAndflowerSuccessed];
            }
        }
            break;
            
            
            
        case 160:
        {
            self.mainPageCategoryList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.GetmainPageCategory)) {
                [self.GetmainPageCategory didRequestGetmainPageCategorySuccessed];
            }
        }
            break;
       
        default:
            break;
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
            
        case 101:
        {
            if (isObjectNotNil(self.Teacher_MyCourseList)) {
                [self.Teacher_MyCourseList didRequestTeacher_MyCourseListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 102:
        {
            if (isObjectNotNil(self.Teacher_sectionList)) {
                [self.Teacher_sectionList didRequestTeacher_sectionListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 103:
        {
            if (isObjectNotNil(self.Teacher_sectionAttendance)) {
                [self.Teacher_sectionAttendance didRequestTeacher_sectionAttendanceFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 104:
        {
            if (isObjectNotNil(self.Teacher_totalAttendance)) {
                [self.Teacher_totalAttendance didRequestTeacher_totalAttendanceFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 105:
        {
            if (isObjectNotNil(self.Teacher_attendanceForm)) {
                [self.Teacher_attendanceForm didRequestTeacher_attendanceFormFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 106:
        {
            if (isObjectNotNil(self.Teacher_addCourseSection)) {
                [self.Teacher_addCourseSection didRequestTeacher_addCourseSectionFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 107:
        {
            if (isObjectNotNil(self.Teacher_deleteCourseSection)) {
                [self.Teacher_deleteCourseSection didRequestTeacher_deleteCourseSectionFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 108:
        {
            if (isObjectNotNil(self.Teacher_editCourseSection)) {
                [self.Teacher_editCourseSection didRequestTeacher_editCourseSectionFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 109:
        {
            if (isObjectNotNil(self.Teacher_getTaskMould)) {
                [self.Teacher_getTaskMould didRequestTeacher_getTaskMouldFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 110:
        {
            if (isObjectNotNil(self.Teacher_createSuiTangTask)) {
                [self.Teacher_createSuiTangTask didRequestTeacher_createSuiTangTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 111:
        {
            if (isObjectNotNil(self.Teacher_createXiLieTask)) {
                [self.Teacher_createXiLieTask didRequestTeacher_createXiLieTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 112:
        {
            if (isObjectNotNil(self.Teacher_createMetarial)) {
                [self.Teacher_createMetarial didRequestTeacher_createMetarialFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 113:
        {
            if (isObjectNotNil(self.Teacher_arrangeTask)) {
                [self.Teacher_arrangeTask didRequestTeacher_arrangeTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 114:
        {
            if (isObjectNotNil(self.Teacher_shareTaskMouldToschool)) {
                [self.Teacher_shareTaskMouldToschool didRequestTeacher_shareTaskMouldToschoolFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 115:
        {
            if (isObjectNotNil(self.Teacher_haveArrangeTask)) {
                [self.Teacher_haveArrangeTask didRequestTeacher_haveArrangeTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 116:
        {
            if (isObjectNotNil(self.Teacher_commentTaskList)) {
                [self.Teacher_commentTaskList didRequestTeacher_commentTaskListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 117:
        {
            if (isObjectNotNil(self.Teacher_commentTask)) {
                [self.Teacher_commentTask didRequestTeacher_commentTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 118:
        {
            if (isObjectNotNil(self.Teacher_todayTaskComplateList)) {
                [self.Teacher_todayTaskComplateList didRequestTeacher_todayTaskComplateListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 119:
        {
            if (isObjectNotNil(self.Teacher_studentHistoryTask)) {
                [self.Teacher_studentHistoryTask didRequestTeacher_studentHistoryTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 120:
        {
            if (isObjectNotNil(self.Teacher_addClassroomTextBook)) {
                [self.Teacher_addClassroomTextBook didRequestTeacher_addClassroomTextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 121:
        {
            if (isObjectNotNil(self.Teacher_deleteClassroomTextBook)) {
                [self.Teacher_deleteClassroomTextBook didRequestTeacher_deleteClassroomTextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 122:
        {
            if (isObjectNotNil(self.Teacher_sectionCallRoll)) {
                [self.Teacher_sectionCallRoll didRequestTeacher_sectionCallRollFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 123:
        {
            if (isObjectNotNil(self.Teacher_classroomSign)) {
                [self.Teacher_classroomSign didRequestTeacher_classroomSignFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 124:
        {
            if (isObjectNotNil(self.Teacher_checkTask)) {
                [self.Teacher_checkTask didRequestTeacher_checkTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 125:
        {
            if (isObjectNotNil(self.Teacher_changeModulName)) {
                [self.Teacher_changeModulName didRequestTeacher_changeMOdulNameFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 126:
        {
            if (isObjectNotNil(self.Teacher_changeModulRemark)) {
                [self.Teacher_changeModulRemark didRequestTeacher_changeMOdulRemarkFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 127:
        {
            if (isObjectNotNil(self.Teacher_changeHaveArrangeModulName)) {
                [self.Teacher_changeHaveArrangeModulName didRequestTeacher_changeHaveArrangeMOdulNameFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 128:
        {
            if (isObjectNotNil(self.Teacher_getSuitangDetail)) {
                [self.Teacher_getSuitangDetail didRequestTeacher_getSuitangDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 129:
        {
            if (isObjectNotNil(self.Teacher_getXilieDetail)) {
                [self.Teacher_getXilieDetail didRequestTeacher_getXilieDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 130:
        {
            if (isObjectNotNil(self.Teacher_getEditXilieTaskDetail)) {
                [self.Teacher_getEditXilieTaskDetail didRequestTeacher_getEditXilieTaskDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 131:
        {
            if (isObjectNotNil(self.Teacher_addSuitangTaskType)) {
                [self.Teacher_addSuitangTaskType didRequestTeacher_addSuitangTaskTypeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 132:
        {
            if (isObjectNotNil(self.Teacher_addXilieTaskType)) {
                [self.Teacher_addXilieTaskType didRequestTeacher_addXilieTaskTypeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 133:
        {
            if (isObjectNotNil(self.Teacher_deleteModul)) {
                [self.Teacher_deleteModul didRequestTeacher_deleteModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 140:
        {
            if (isObjectNotNil(self.Teacher_changeSuitangModulTextBook)) {
                [self.Teacher_changeSuitangModulTextBook didRequestTeacher_changeSuitangModulTextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 141:
        {
            if (isObjectNotNil(self.Teacher_changeSuitangModulRepeatCount)) {
                [self.Teacher_changeSuitangModulRepeatCount didRequestTeacher_changeSuitangModulRepeatCountFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 142:
        {
            if (isObjectNotNil(self.Integral_Teacher_getAddressInfo)) {
                [self.Integral_Teacher_getAddressInfo didRequestTeacher_getAddressInfoFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 144:
        {
            if (isObjectNotNil(self.Teacher_getTodayClassroomTask)) {
                [self.Teacher_getTodayClassroomTask didRequestTeacher_getTodayClassroomTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 145:
        {
            if (isObjectNotNil(self.Teacher_classroomAttendanceList)) {
                [self.Teacher_classroomAttendanceList didRequestTeacher_classroomAttendanceListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 146:
        {
            if (isObjectNotNil(self.IsHaveNewMessage)) {
                [self.IsHaveNewMessage didRequestIsHaveNewMessageFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 147:
        {
            if (isObjectNotNil(self.Teacher_CommentModul)) {
                [self.Teacher_CommentModul didRequestTeacher_CommentModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 148:
        {
            if (isObjectNotNil(self.Teacher_addTextToCommentModul)) {
                [self.Teacher_addTextToCommentModul didRequestTeacher_addTextToCommentModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 149:
        {
            if (isObjectNotNil(self.Teacher_deleteCommentModul)) {
                [self.Teacher_deleteCommentModul didRequestTeacher_deleteCommentModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 150:
        {
            if (isObjectNotNil(self.Teacher_editHaveSendIntegralRemark)) {
                [self.Teacher_editHaveSendIntegralRemark didRequestTeacher_editHaveSendIntegralRemarkFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 151:
        {
            if (isObjectNotNil(self.Teacher_deleteTaskModul)) {
                [self.Teacher_deleteTaskModul didRequestTeacher_deleteTaskModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        case 152:
        {
            if (isObjectNotNil(self.Teacher_collectSchoolTaskModul)) {
                [self.Teacher_collectSchoolTaskModul didRequestTeacher_collectSchoolTaskModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 153:
        {
            if (isObjectNotNil(self.Teacher_deleteCollectTaskModul)) {
                [self.Teacher_deleteCollectTaskModul didRequestTeacher_deleteCollectTaskModulFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 154:
        {
            if (isObjectNotNil(self.Teacher_editStudent_remark)) {
                [self.Teacher_editStudent_remark didRequestTeacher_editStudent_remarkFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 155:
        {
            if (isObjectNotNil(self.Teacher_deleteHaveArrangeTask)) {
                [self.Teacher_deleteHaveArrangeTask didRequestTeacher_deleteHaveArrangeTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 156:
        {
            if (isObjectNotNil(self.Teacher_PriseAndflower)) {
                [self.Teacher_PriseAndflower didRequestTeacher_PriseAndflowerFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
            
        case 160:
        {
            if (isObjectNotNil(self.GetmainPageCategory)) {
                [self.GetmainPageCategory didRequestGetmainPageCategoryFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        default:
            break;
    }
}


@end
