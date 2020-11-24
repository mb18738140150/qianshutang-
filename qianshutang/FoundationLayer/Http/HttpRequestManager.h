//
//  HttpRequestManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestProtocol.h"

@interface HttpRequestManager : NSObject

+ (instancetype)sharedManager;

- (void)requestLoginWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
              andProcessDelegate:( id<HttpRequestProtocol>)delegate;

- (void)requestResetPwdWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustAppVersionInfoWithProcessDelegate:(id<HttpRequestProtocol>)delegate;


- (void)reqeustBindJPushWithCId:(NSString *)CID andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustVerifyAccountWithAccountNumber:(NSString *)AccountNumber andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustVerifyCodeWithPhoneNumber:(NSString *)phoneNumber andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustRegistWithdic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustForgetPasswordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustCompleteUserInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustBindPhoneBunberWith:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustmyClassroomWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - classroom and Friend
- (void)reqeustMyFriendListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustMyFriendAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustAddFriendWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustDeleteFriendWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyFriendInformationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyFriendProductListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyFriendProductDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyRecordProductDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustMyGroupListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustClassMemberAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassMemberComplateTaskInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassTextbookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassCourseWareWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassCourseWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustClassMemberWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassTaskHaveComplateWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClassMemberInformationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - userData
- (void)reqeustMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustSearchMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustDeleteMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyBookmarkListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustDeleteMyBookmarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustClearnMyBookmarkListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyHeadQuestionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyQuestionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyQuestionDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustSetHaveReadQuestionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - Task
- (void)reqeustUploadWholeRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustUploadPagingRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustReadTextWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustSubmitMoerduoAndReadTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustSubmitCreateProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustCreateTaskProblemContentWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustAgainUploadWholeRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - productShow
- (void)reqeustProductShowListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustDeleteProductShowMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - activeStudy
- (void)reqeustReadListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustSearchReadListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustCollectTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTextBookContentListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTextContentWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - 积分
- (void)reqeustmyIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustmyIntegralRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustPrizeListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustConvertPrizeRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustCancelConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustComplateConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTeacher_memberIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_haveSendIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_CreateConvertPrizeRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_sendGoodsWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_GetAddressInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_CancelConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - 消息中心
- (void)reqeustSchoolNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTaskNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustAgreeFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustRejectFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustOtherNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - 个人信息设置
- (void)reqeustChangeIconImageWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustChangeNickNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustChangePhoneNumberWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustChangeGenderWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustChangeBirthdayWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustChangeReceiveAddressWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustNotificationNoDisturWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustLogoutWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark -个人中心 - 我的作业、作品、课程等
- (void)reqeustMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustDeleteMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustShareMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyHeadTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyEveryDayTaskDetailListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyEveryDayTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyAttendanceListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyCourseCostWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustBuyCourseRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyStudyTimeLengthListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustMyStudyTimeLengthDetailListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustPunchCardListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustMyCourse_BigCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustCurrentWeekCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - teacher
- (void)reqeustTeacher_MyCourseWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_sectionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_sectionAttendanceWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_totalAttendanceWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_attendanceFormWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_addCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_editCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_getTaskMouldWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_createSuiTangTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_createXiLieTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_createMetarialWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_arrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_shareTaskMouldToschoolWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_haveArrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_commentTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_commentTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_todayTaskComplateListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_studentHistoryTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_addClassroomTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteClassroomTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_sectionCallRollWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_classroomSignWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_checkTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_changeModulNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_changeModulRemarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_changeHaveArrangeModulNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_getSuitangDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_getXilieDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTeacher_getEditXilieTaskDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_AddSuitangTaskTypeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_AddXilieTaskTypeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_DeleteModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_changeSuitangModultextbookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_changeSuitangModulRepeatCountWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTeacher_collectSchoolTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_CommentModulListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_addTextToCommentModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustGetIsHaveNewMessageWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_getTodayClassroomTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTeacher_classroomAttendanceListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteCommentModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_editHaveSendIntegralRemarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteCollectTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_editStudentInfo_remarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_deleteHaveArrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)reqeustTeacher_PriseAndflowerWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - 未使用
- (void)requestSearchKeyWord:(NSString *)keyWords;
@end
