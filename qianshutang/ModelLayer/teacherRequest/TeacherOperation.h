//
//  TeacherOperation.h
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/4.
//  Copyright © 2018 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherOperation : NSObject

@property (nonatomic, strong)NSArray * myCourseArray;
@property (nonatomic, strong)NSArray * sectionListArray;
@property (nonatomic, strong)NSDictionary * sectionAttendanceRecordInfo;
@property (nonatomic, strong)NSArray * totalAttendanceArray;

@property (nonatomic, strong)NSArray * school_suitangtaskMouldArray;
@property (nonatomic, strong)NSArray * school_xilietaskMouldArray;
@property (nonatomic, strong)NSArray * main_suitangtaskMouldArray;
@property (nonatomic, strong)NSArray * main_xilietaskMouldArray;

@property (nonatomic, strong)NSArray * haveArrangeTaskArray;
@property (nonatomic, strong)NSArray * commentTaskLiatArray;
@property (nonatomic, strong)NSArray * todayTaskComplateArray;
@property (nonatomic, strong)NSArray * studentHistoryTaskArray;
@property (nonatomic, strong)NSDictionary * studentHistoryTaskInfoDic;

@property (nonatomic, strong)NSArray * suitangTaskArray;
@property (nonatomic, strong)NSArray * xilieTaskArray;

@property (nonatomic, strong)NSArray * editXilieTaskArray;
@property (nonatomic, strong)NSDictionary * studentAddressInfoDic;
@property (nonatomic, strong)NSDictionary * createMetarial_madeId;

@property (nonatomic, strong)NSArray * commentModulList;
@property (nonatomic, strong)NSArray * mainPageCategoryList;
@property (nonatomic, strong)NSMutableArray * isHaveNewMessageInfoDic;
@property (nonatomic, strong)NSArray * teacher_TodayClassroomTaskList;

@property (nonatomic, strong)NSArray * classroomAttendanceList;


- (void)didRequestTeacher_MyCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_MyCourseList>)object;

- (void)didRequestTeacher_sectionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionList>)object;

- (void)didRequestTeacher_sectionAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionAttendance>)object;

- (void)didRequestTeacher_totalAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_totalAttendance>)object;

- (void)didRequestTeacher_attendanceFormWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_attendanceForm>)object;

- (void)didRequestTeacher_addCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addCourseSection>)object;

- (void)didRequestTeacher_deleteCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCourseSection>)object;

- (void)didRequestTeacher_editCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editCourseSection>)object;

- (void)didRequestTeacher_getTaskMouldWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTaskMould>)object;

- (void)didRequestTeacher_createSuiTangTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createSuiTangTask>)object;

- (void)didRequestTeacher_createXiLieTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createXiLieTask>)object;

- (void)didRequestTeacher_createMetarialWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createMetarial>)object;

- (void)didRequestTeacher_arrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_arrangeTask>)object;

- (void)didRequestTeacher_shareTaskMouldToschoolWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_shareTaskMouldToschool>)object;

- (void)didRequestTeacher_haveArrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_haveArrangeTask>)object;

- (void)didRequestTeacher_commentTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTaskList>)object;

- (void)didRequestTeacher_commentTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTask>)object;

- (void)didRequestTeacher_todayTaskComplateListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_todayTaskComplateList>)object;

- (void)didRequestTeacher_studentHistoryTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_studentHistoryTask>)object;

- (void)didRequestTeacher_addClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addClassroomTextBook>)object;

- (void)didRequestTeacher_deleteClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteClassroomTextBook>)object;

- (void)didRequestTeacher_sectionCallRollWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionCallRoll>)object;

- (void)didRequestTeacher_classroomSignWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomSign>)object;

- (void)didRequestTeacher_checkTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_checkTask>)object;

- (void)didRequestTeacher_changeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulName>)object;

- (void)didRequestTeacher_changeHaveArrangeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeHaveArrangeModulName>)object;

- (void)didRequestTeacher_changeModulRemarkWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulRemark>)object;

- (void)didRequestTeacher_getSuitangDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getSuitangDetail>)object;

- (void)didRequestTeacher_getXilieDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getXilieDetail>)object;

- (void)didRequestTeacher_getEditXilieTaskDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getEditXilieTaskDetail>)object;
- (void)didRequestTeacher_addSuitangTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addSuitangTaskType>)object;
- (void)didRequestTeacher_addXilieTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addXilieTaskType>)object;

- (void)didRequestTeacher_DeleteModulWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteModul>)object;

- (void)didRequestTeacher_changeSuitangModulTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulTextBook>)object;
- (void)didRequestTeacher_changeSuitangModulRepeatCountWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulRepeatCount>)object;
- (void)didRequestTeacher_GetAddressInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_getAddressInfo>)object;

- (void)didRequestTeacher_collectSchoolTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_collectSchoolTaskModul>)object;
- (void)didRequestTeacher_CommentModulListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_CommentModul>)object;
- (void)didRequestTeacher_addTextToCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addTextToCommentModul>)object;
- (void)didRequestGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<GetmainPageCategory>)object;
- (void)didRequestGetIsHaveNewMessageWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<IsHaveNewMessage>)object;
- (void)didRequestTeacher_getTodayClassroomTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTodayClassroomTask>)object;

- (void)didRequestTeacher_classroomAttendanceListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomAttendanceList>)object;
- (void)didRequestTeacher_deleteCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCommentModul>)object;
- (void)didRequestTeacher_editHaveSendIntegralRemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editHaveSendIntegralRemark>)object;
- (void)didRequestTeacher_deleteTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteTaskModul>)object;
- (void)didRequestTeacher_deleteCollectTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCollectTaskModul>)object;
- (void)didRequestTeacher_editStudent_RemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editStudent_remark>)object;
- (void)didRequestTeacher_deleteHaveArrangeTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteHaveArrangeTask>)object;
- (void)didRequestTeacher_PriseAndflowerWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_PriseAndflower>)object;

@end


