//
//  UserModuleProtocol.h
//  Accountant
//
//  Created by aaa on 2017/3/2.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserModule_LoginProtocol <NSObject>

- (void)didUserLoginSuccessed;

- (void)didUserLoginFailed:(NSString *)failedInfo;

@end

@protocol UserModule_BindPhoneNumber <NSObject>

- (void)didBindPhoneNumberSuccessed;
- (void)didBindPhoneNumberFailed:(NSString *)failInfo;

@end

@protocol UserModule_RegistProtocol <NSObject>

- (void)didRegistSuccessed;
- (void)didRegistFailed:(NSString *)failInfo;

@end

@protocol UserModule_CompleteUserInfoProtocol <NSObject>

- (void)didCompleteUserSuccessed;
- (void)didCompleteUserFailed:(NSString *)failInfo;

@end

@protocol UserModule_ForgetPasswordProtocol <NSObject>

- (void)didForgetPasswordSuccessed;
- (void)didForgetPasswordFailed:(NSString *)failInfo;

@end

@protocol UserModule_VerifyCodeProtocol <NSObject>

- (void)didVerifyCodeSuccessed;
- (void)didVerifyCodeFailed:(NSString *)failInfo;

@end

@protocol UserModule_ResetPwdProtocol <NSObject>

- (void)didResetPwdSuccessed;
- (void)didResetPwdFailed:(NSString *)failInfo;

@end

@protocol UserModule_AppInfoProtocol <NSObject>

- (void)didRequestAppInfoSuccessed;
- (void)didRequestAppInfoFailed:(NSString *)failedInfo;

@end
@protocol UserModule_BindJPushProtocol <NSObject>

- (void)didRequestBindJPushSuccessed;
- (void)didRequestBindJPushFailed:(NSString *)failedInfo;

@end

@protocol UserModule_MyClassroomProtocol <NSObject>

- (void)didRequestMyClassroomSuccessed;
- (void)didRequestMyClassroomFailed:(NSString *)failedInfo;

@end

#pragma mark - 积分
@protocol Integral_MyIntegral <NSObject>

- (void)didRequestMyIntegralSuccessed;
- (void)didRequestMyIntegralFailed:(NSString *)failedInfo;

@end

@protocol Integral_MyIntegralRecord <NSObject>

- (void)didRequestMyIntegralRecordSuccessed;
- (void)didRequestMyIntegralRecordFailed:(NSString *)failedInfo;

@end

@protocol Integral_PrizeList <NSObject>

- (void)didRequestPrizeListSuccessed;
- (void)didRequestPrizeListFailed:(NSString *)failedInfo;

@end

@protocol Integral_ConvertPrize <NSObject>

- (void)didRequestConvertPrizeSuccessed;
- (void)didRequestConvertPrizeFailed:(NSString *)failedInfo;

@end
@protocol Integral_ConvertPrizeRecord <NSObject>

- (void)didRequestConvertPrizeRecordSuccessed;
- (void)didRequestConvertPrizeRecordFailed:(NSString *)failedInfo;

@end
@protocol Integral_CancelConvertPrize <NSObject>

- (void)didRequestCancelConvertPrizeSuccessed;
- (void)didRequestCancelConvertPrizeFailed:(NSString *)failedInfo;

@end
@protocol Integral_ComplateConvertPrize <NSObject>

- (void)didRequestComplateConvertPrizeSuccessed;
- (void)didRequestComplateConvertPrizeFailed:(NSString *)failedInfo;

@end

@protocol Integral_Teacher_memberPrize <NSObject>
- (void)didRequestTeacher_memberPrizeSuccessed;
- (void)didRequestTeacher_memberPrizeFailed:(NSString *)failedInfo;
@end

@protocol Integral_Teacher_haveSendIntegral <NSObject>
- (void)didRequestTeacher_haveSendIntegralSuccessed;
- (void)didRequestTeacher_haveSendIntegralFailed:(NSString *)failedInfo;
@end

@protocol Integral_Teacher_CreateConvertPrizeRecord <NSObject>
- (void)didRequestTeacher__CreateConvertPrizeRecordSuccessed;
- (void)didRequestTeacher__CreateConvertPrizeRecordFailed:(NSString *)failedInfo;
@end

@protocol Integral_Teacher_sendGoods <NSObject>
- (void)didRequestTeacher_sendGoodsSuccessed;
- (void)didRequestTeacher_sendGoodsFailed:(NSString *)failedInfo;
@end

@protocol Integral_Teacher_getAddressInfo <NSObject>
- (void)didRequestTeacher_getAddressInfoSuccessed;
- (void)didRequestTeacher_getAddressInfoFailed:(NSString *)failedInfo;
@end

#pragma mark - 消息中心
@protocol Notification_SchoolNotification <NSObject>

- (void)didRequestSchoolNotificationSuccessed;
- (void)didRequestSchoolNotificationFailed:(NSString *)failedInfo;

@end
@protocol Notification_TaskNotification <NSObject>

- (void)didRequestTaskNotificationSuccessed;
- (void)didRequestTaskNotificationFailed:(NSString *)failedInfo;

@end
@protocol Notification_FriendRequestNotification <NSObject>

- (void)didRequestFriendRequestNotificationSuccessed;
- (void)didRequestFriendRequestNotificationFailed:(NSString *)failedInfo;

@end
@protocol Notification_AgreeFriendRequestNotification <NSObject>

- (void)didRequestAgreeFriendRequestNotificationSuccessed;
- (void)didRequestAgreeFriendRequestNotificationFailed:(NSString *)failedInfo;

@end
@protocol Notification_RejectFriendRequestNotification <NSObject>

- (void)didRequestRejectFriendRequestNotificationSuccessed;
- (void)didRequestRejectFriendRequestNotificationFailed:(NSString *)failedInfo;

@end
@protocol Notification_OtherMessageNotification <NSObject>

- (void)didRequestOtherMessageNotificationSuccessed;
- (void)didRequestOtherMessageNotificationFailed:(NSString *)failedInfo;

@end

#pragma mark - 个人信息设置
@protocol UserInfo_changeIconImage <NSObject>

- (void)didRequestchangeIconImageSuccessed;
- (void)didRequestchangeIconImageFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_ChangeNickName <NSObject>

- (void)didRequestChangeNickNameSuccessed;
- (void)didRequestChangeNickNameFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_BindPhoneNumber <NSObject>

- (void)didRequestBindPhoneNumberSuccessed;
- (void)didRequestBindPhoneNumberFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_ChangeGender <NSObject>

- (void)didRequestChangeGenderSuccessed;
- (void)didRequestChangeGenderFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_ChangeBirthday <NSObject>

- (void)didRequestChangeBirthdaySuccessed;
- (void)didRequestChangeBirthdayFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_ChangeReceiveAddress <NSObject>

- (void)didRequestChangeReceiveAddressSuccessed;
- (void)didRequestChangeReceiveAddressFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_NotificationNoDisturbConfig <NSObject>

- (void)didRequestNotificationNoDisturbConfigSuccessed;
- (void)didRequestNotificationNoDisturbConfigFailed:(NSString *)failedInfo;

@end
@protocol UserInfo_Logout <NSObject>

- (void)didRequestLogoutSuccessed;
- (void)didRequestLogoutFailed:(NSString *)failedInfo;

@end

@protocol UserData_MyCollectiontextBook <NSObject>
- (void)didRequestMyCollectiontextBookSuccessed;
- (void)didRequestMyCollectiontextBookFailed:(NSString *)failedInfo;
@end

@protocol UserData_SearchMyCollectiontextBook <NSObject>
- (void)didRequestSearchMyCollectiontextBookSuccessed;
- (void)didRequestSearchMyCollectiontextBookFailed:(NSString *)failedInfo;
@end

@protocol UserData_DeleteMyCollectiontextBook <NSObject>
- (void)didRequestDeleteMyCollectiontextBookSuccessed;
- (void)didRequestDeleteMyCollectiontextBookFailed:(NSString *)failedInfo;
@end

@protocol UserData_MyBookMarkList <NSObject>
- (void)didRequestMyBookMarkListSuccessed;
- (void)didRequestMyBookMarkListFailed:(NSString *)failedInfo;
@end

@protocol UserData_DeleteMyBookmark <NSObject>
- (void)didRequestDeleteMyBookmarkSuccessed;
- (void)didRequestDeleteMyBookmarkFailed:(NSString *)failedInfo;
@end

@protocol UserData_ClearnMyBookmark <NSObject>
- (void)didRequestClearnMyBookmarkSuccessed;
- (void)didRequestClearnMyBookmarkFailed:(NSString *)failedInfo;
@end

@protocol UserData_MyHeadQuestion <NSObject>
- (void)didRequestMyHeadQuestionSuccessed;
- (void)didRequestMyHeadQuestionFailed:(NSString *)failedInfo;
@end

@protocol UserData_MyQuestionlist <NSObject>
- (void)didRequestMyQuestionlistSuccessed;
- (void)didRequestMyQuestionlistFailed:(NSString *)failedInfo;
@end

@protocol UserData_MyQuestionDetail <NSObject>
- (void)didRequestMyQuestionDetailSuccessed;
- (void)didRequestMyQuestionDetailFailed:(NSString *)failedInfo;
@end

@protocol UserData_SetaHaveReadQuestion <NSObject>
- (void)didRequestSetaHaveReadQuestionSuccessed;
- (void)didRequestSetaHaveReadQuestionFailed:(NSString *)failedInfo;
@end

#pragma mark - task
@protocol Task_UploadWholeRecordProduct <NSObject>
- (void)didRequestUploadWholeRecordProductSuccessed;
- (void)didRequestUploadWholeRecordProductFailed:(NSString *)failedInfo;
@end

@protocol Task_AgainUploadWholeRecordProduct <NSObject>
- (void)didRequestAgainUploadWholeRecordProductSuccessed;
- (void)didRequestAgainUploadWholeRecordProductFailed:(NSString *)failedInfo;
@end

@protocol Task_UploadPagingRecordProduct <NSObject>
- (void)didRequestUploadPagingRecordProductSuccessed;
- (void)didRequestUploadPagingRecordProductFailed:(NSString *)failedInfo;
@end

@protocol Task_ReadText <NSObject>
- (void)didRequestReadTextSuccessed;
- (void)didRequestReadTextFailed:(NSString *)failedInfo;
@end

@protocol Task_SubmitMoerduoAndReadTask <NSObject>
- (void)didRequestSubmitMoerduoAndReadTaskSuccessed;
- (void)didRequestSubmitMoerduoAndReadTaskFailed:(NSString *)failedInfo;
@end

@protocol Task_SubmitCreateProduct <NSObject>
- (void)didRequestSubmitCreateProductSuccessed;
- (void)didRequestSubmitCreateProductFailed:(NSString *)failedInfo;
@end

@protocol Task_CreateTaskProblemContent <NSObject>
- (void)didRequestCreateTaskProblemContentSuccessed;
- (void)didRequestCreateTaskProblemContentFailed:(NSString *)failedInfo;
@end

#pragma mark - activeStudy
@protocol ActiveStudy_ReadList <NSObject>
- (void)didRequestReadListSuccessed;
- (void)didRequestReadListFailed:(NSString *)failedInfo;
@end

@protocol ActiveStudy_SearchReadList <NSObject>
- (void)didRequestSearchReadListSuccessed;
- (void)didRequestSearchReadListFailed:(NSString *)failedInfo;
@end

@protocol ActiveStudy_CollectTextBook <NSObject>
- (void)didRequestCollectTextBookSuccessed;
- (void)didRequestCollectTextBookFailed:(NSString *)failedInfo;
@end

@protocol ActiveStudy_TextBookContentList <NSObject>
- (void)didRequestTextBookContentListSuccessed;
- (void)didRequestTextBookContentListFailed:(NSString *)failedInfo;
@end

@protocol ActiveStudy_TextContent <NSObject>
- (void)didRequestTextContentSuccessed;
- (void)didRequestTextContentFailed:(NSString *)failedInfo;
@end



#pragma mark - productShow
@protocol ProductShow_ProductShowList <NSObject>
- (void)didRequestProductShowListSuccessed;
- (void)didRequestProductShowListFailed:(NSString *)failedInfo;
@end

@protocol ProductShow_DeleteProductShowMyProduct <NSObject>
- (void)didRequestDeleteProductShowMyProductSuccessed;
- (void)didRequestDeleteProductShowMyProductFailed:(NSString *)failedInfo;
@end






#pragma mark -个人中心 - 我的作业、作品、课程等
@protocol MyStudy_MyProduct <NSObject>

- (void)didRequestMyProductSuccessed;
- (void)didRequestMyProductFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_DeleteMyProduct <NSObject>

- (void)didRequestDeleteMyProductSuccessed;
- (void)didRequestDeleteMyProductFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_ShareMyProduct <NSObject>

- (void)didRequestShareMyProductSuccessed;
- (void)didRequestShareMyProductFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyHeadTaskList <NSObject>

- (void)didRequestMyHeadTaskListSuccessed;
- (void)didRequestMyHeadTaskListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyEveryDayTaskDetailList <NSObject>

- (void)didRequestMyEveryDayTaskDetailListSuccessed;
- (void)didRequestMyEveryDayTaskDetailListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyEveryDayTask <NSObject>

- (void)didRequestMyEveryDayTaskSuccessed;
- (void)didRequestMyEveryDayTaskFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyCourseList <NSObject>

- (void)didRequestMyCourseListSuccessed;
- (void)didRequestMyCourseListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyAttendanceList <NSObject>

- (void)didRequestMyAttendanceListSuccessed;
- (void)didRequestMyAttendanceListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyCourseCost <NSObject>

- (void)didRequestMyCourseCostSuccessed;
- (void)didRequestMyCourseCostFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_BuyCourseRecord <NSObject>

- (void)didRequestBuyCourseRecordSuccessed;
- (void)didRequestBuyCourseRecordFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyAchievementList <NSObject>

- (void)didRequestMyAchievementListSuccessed;
- (void)didRequestMyAchievementListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyStudyTimeLengthList <NSObject>

- (void)didRequestMyStudyTimeLengthListSuccessed;
- (void)didRequestMyStudyTimeLengthListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_MyStudyTimeLengthDetailList <NSObject>

- (void)didRequestMyStudyTimeLengthDetailListSuccessed;
- (void)didRequestMyStudyTimeLengthDetailListFailed:(NSString *)failedInfo;

@end
@protocol MyStudy_PunchCardList <NSObject>

- (void)didRequestPunchCardListSuccessed;
- (void)didRequestPunchCardListFailed:(NSString *)failedInfo;

@end

@protocol MyStudy_MyCourse_BigCourseList <NSObject>
- (void)didRequestMyCourse_BigCourseListSuccessed;
- (void)didRequestMyCourse_BigCourseListFailed:(NSString *)failedInfo;
@end

@protocol MyStudy_CurrentWeekCourseList <NSObject>
- (void)didRequestCurrentWeekCourseListSuccessed;
- (void)didRequestCurrentWeekCourseListFailed:(NSString *)failedInfo;
@end

#pragma mark - classroom and Friend
@protocol MyClassroom_MyFriendList <NSObject>

- (void)didRequestMyFriendListSuccessed;
- (void)didRequestMyFriendListFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_MyFriendAchievementList <NSObject>

- (void)didRequestMyFriendAchievementListSuccessed;
- (void)didRequestMyFriendAchievementListFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_AddMyFriend <NSObject>

- (void)didRequestAddMyFriendSuccessed;
- (void)didRequestAddMyFriendFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_DeleteMyFriend <NSObject>

- (void)didRequestDeleteMyFriendSuccessed;
- (void)didRequestDeleteMyFriendFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_MyFriendInformation <NSObject>

- (void)didRequestMyFriendInformationSuccessed;
- (void)didRequestMyFriendInformationFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_MyFriendProductList <NSObject>

- (void)didRequestMyFriendProductListSuccessed;
- (void)didRequestMyFriendProductListFailed:(NSString *)failedInfo;

@end
@protocol MyClassroom_MyFriendProductDetail <NSObject>

- (void)didRequestMyFriendProductDetailSuccessed;
- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo;

@end

@protocol MyClassroom_MyRecordProductDetail <NSObject>
- (void)didRequestMyRecordProductDetailSuccessed;
- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_MyGroupList <NSObject>

- (void)didRequestMyGroupListSuccessed;
- (void)didRequestMyGroupListFailed:(NSString *)failedInfo;

@end

@protocol MyClassroom_classMemberAchievementList <NSObject>
- (void)didRequestclassMemberAchievementListSuccessed;
- (void)didRequestclassMemberAchievementListFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classTaskList <NSObject>
- (void)didRequestclassTaskListSuccessed;
- (void)didRequestclassTaskListFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classMemberComplateTaskInfo <NSObject>
- (void)didRequestclassMemberComplateTaskInfoSuccessed;
- (void)didRequestclassMemberComplateTaskInfoFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classTextbook <NSObject>
- (void)didRequestclassTextbookSuccessed;
- (void)didRequestclassTextbookFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classCourseWare <NSObject>
- (void)didRequestclassCourseWareSuccessed;
- (void)didRequestclassCourseWareFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classCourse <NSObject>
- (void)didRequestclassCourseSuccessed;
- (void)didRequestclassCourseFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classMember <NSObject>
- (void)didRequestclassMemberSuccessed;
- (void)didRequestclassMemberFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classMemberInformation <NSObject>
- (void)didRequestclassMemberInformationSuccessed;
- (void)didRequestclassMemberInformationFailed:(NSString *)failedInfo;
@end

@protocol MyClassroom_classTaskHaveComplate <NSObject>
- (void)didRequestclassTaskHaveComplateSuccessed;
- (void)didRequestclassTaskHaveComplateFailed:(NSString *)failedInfo;
@end

#pragma mark - teacher
@protocol Teacher_MyCourseList <NSObject>
- (void)didRequestTeacher_MyCourseListSuccessed;
- (void)didRequestTeacher_MyCourseListFailed:(NSString *)failedInfo;
@end

@protocol Teacher_sectionList <NSObject>
- (void)didRequestTeacher_sectionListSuccessed;
- (void)didRequestTeacher_sectionListFailed:(NSString *)failedInfo;
@end

@protocol Teacher_sectionAttendance <NSObject>
- (void)didRequestTeacher_sectionAttendanceSuccessed;
- (void)didRequestTeacher_sectionAttendanceFailed:(NSString *)failedInfo;
@end

@protocol Teacher_totalAttendance <NSObject>
- (void)didRequestTeacher_totalAttendanceSuccessed;
- (void)didRequestTeacher_totalAttendanceFailed:(NSString *)failedInfo;
@end

@protocol Teacher_attendanceForm <NSObject>
- (void)didRequestTeacher_attendanceFormSuccessed;
- (void)didRequestTeacher_attendanceFormFailed:(NSString *)failedInfo;
@end

@protocol Teacher_addCourseSection <NSObject>
- (void)didRequestTeacher_addCourseSectionSuccessed;
- (void)didRequestTeacher_addCourseSectionFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteCourseSection <NSObject>
- (void)didRequestTeacher_deleteCourseSectionSuccessed;
- (void)didRequestTeacher_deleteCourseSectionFailed:(NSString *)failedInfo;
@end

@protocol Teacher_editCourseSection <NSObject>
- (void)didRequestTeacher_editCourseSectionSuccessed;
- (void)didRequestTeacher_editCourseSectionFailed:(NSString *)failedInfo;
@end

@protocol Teacher_getTaskMould <NSObject>
- (void)didRequestTeacher_getTaskMouldSuccessed;
- (void)didRequestTeacher_getTaskMouldFailed:(NSString *)failedInfo;
@end

@protocol Teacher_createSuiTangTask <NSObject>
- (void)didRequestTeacher_createSuiTangTaskSuccessed;
- (void)didRequestTeacher_createSuiTangTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_createXiLieTask <NSObject>
- (void)didRequestTeacher_createXiLieTaskSuccessed;
- (void)didRequestTeacher_createXiLieTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_createMetarial <NSObject>
- (void)didRequestTeacher_createMetarialSuccessed;
- (void)didRequestTeacher_createMetarialFailed:(NSString *)failedInfo;
@end

@protocol Teacher_arrangeTask <NSObject>
- (void)didRequestTeacher_arrangeTaskSuccessed;
- (void)didRequestTeacher_arrangeTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_shareTaskMouldToschool <NSObject>
- (void)didRequestTeacher_shareTaskMouldToschoolSuccessed;
- (void)didRequestTeacher_shareTaskMouldToschoolFailed:(NSString *)failedInfo;
@end

@protocol Teacher_haveArrangeTask <NSObject>
- (void)didRequestTeacher_haveArrangeTaskSuccessed;
- (void)didRequestTeacher_haveArrangeTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_commentTaskList <NSObject>
- (void)didRequestTeacher_commentTaskListSuccessed;
- (void)didRequestTeacher_commentTaskListFailed:(NSString *)failedInfo;
@end

@protocol Teacher_commentTask <NSObject>
- (void)didRequestTeacher_commentTaskSuccessed;
- (void)didRequestTeacher_commentTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_todayTaskComplateList <NSObject>
- (void)didRequestTeacher_todayTaskComplateListSuccessed;
- (void)didRequestTeacher_todayTaskComplateListFailed:(NSString *)failedInfo;
@end

@protocol Teacher_studentHistoryTask <NSObject>
- (void)didRequestTeacher_studentHistoryTaskSuccessed;
- (void)didRequestTeacher_studentHistoryTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_addClassroomTextBook <NSObject>
- (void)didRequestTeacher_addClassroomTextBookSuccessed;
- (void)didRequestTeacher_addClassroomTextBookFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteClassroomTextBook <NSObject>
- (void)didRequestTeacher_deleteClassroomTextBookSuccessed;
- (void)didRequestTeacher_deleteClassroomTextBookFailed:(NSString *)failedInfo;
@end

@protocol Teacher_sectionCallRoll <NSObject>
- (void)didRequestTeacher_sectionCallRollSuccessed;
- (void)didRequestTeacher_sectionCallRollFailed:(NSString *)failedInfo;
@end

@protocol Teacher_classroomSign <NSObject>
- (void)didRequestTeacher_classroomSignSuccessed;
- (void)didRequestTeacher_classroomSignFailed:(NSString *)failedInfo;
@end

@protocol Teacher_checkTask <NSObject>
- (void)didRequestTeacher_checkTaskSuccessed;
- (void)didRequestTeacher_checkTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_changeModulName <NSObject>
- (void)didRequestTeacher_changeMOdulNameSuccessed;
- (void)didRequestTeacher_changeMOdulNameFailed:(NSString *)failedInfo;
@end
@protocol Teacher_changeHaveArrangeModulName <NSObject>
- (void)didRequestTeacher_changeHaveArrangeMOdulNameSuccessed;
- (void)didRequestTeacher_changeHaveArrangeMOdulNameFailed:(NSString *)failedInfo;
@end

@protocol Teacher_changeModulRemark <NSObject>
- (void)didRequestTeacher_changeMOdulRemarkSuccessed;
- (void)didRequestTeacher_changeMOdulRemarkFailed:(NSString *)failedInfo;
@end
@protocol Teacher_getSuitangDetail <NSObject>
- (void)didRequestTeacher_getSuitangDetailSuccessed;
- (void)didRequestTeacher_getSuitangDetailFailed:(NSString *)failedInfo;
@end
@protocol Teacher_getXilieDetail <NSObject>
- (void)didRequestTeacher_getXilieDetailSuccessed;
- (void)didRequestTeacher_getXilieDetailFailed:(NSString *)failedInfo;
@end

@protocol Teacher_getEditXilieTaskDetail <NSObject>
- (void)didRequestTeacher_getEditXilieTaskDetailSuccessed;
- (void)didRequestTeacher_getEditXilieTaskDetailFailed:(NSString *)failedInfo;
@end
@protocol Teacher_addSuitangTaskType <NSObject>
- (void)didRequestTeacher_addSuitangTaskTypeSuccessed;
- (void)didRequestTeacher_addSuitangTaskTypeFailed:(NSString *)failedInfo;
@end
@protocol Teacher_addXilieTaskType <NSObject>
- (void)didRequestTeacher_addXilieTaskTypeSuccessed;
- (void)didRequestTeacher_addXilieTaskTypeFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteModul <NSObject>
- (void)didRequestTeacher_deleteModulSuccessed;
- (void)didRequestTeacher_deleteModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_changeSuitangModulTextBook <NSObject>
- (void)didRequestTeacher_changeSuitangModulTextBookSuccessed;
- (void)didRequestTeacher_changeSuitangModulTextBookFailed:(NSString *)failedInfo;
@end

@protocol Teacher_changeSuitangModulRepeatCount <NSObject>
- (void)didRequestTeacher_changeSuitangModulRepeatCountSuccessed;
- (void)didRequestTeacher_changeSuitangModulRepeatCountFailed:(NSString *)failedInfo;
@end

@protocol Teacher_collectSchoolTaskModul <NSObject>
- (void)didRequestTeacher_collectSchoolTaskModulSuccessed;
- (void)didRequestTeacher_collectSchoolTaskModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_CommentModul <NSObject>
- (void)didRequestTeacher_CommentModulSuccessed;
- (void)didRequestTeacher_CommentModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_addTextToCommentModul <NSObject>
- (void)didRequestTeacher_addTextToCommentModulSuccessed;
- (void)didRequestTeacher_addTextToCommentModulFailed:(NSString *)failedInfo;
@end

@protocol GetmainPageCategory <NSObject>
- (void)didRequestGetmainPageCategorySuccessed;
- (void)didRequestGetmainPageCategoryFailed:(NSString *)failedInfo;
@end

@protocol IsHaveNewMessage <NSObject>
- (void)didRequestIsHaveNewMessageSuccessed;
- (void)didRequestIsHaveNewMessageFailed:(NSString *)failedInfo;
@end

@protocol Teacher_getTodayClassroomTask <NSObject>
- (void)didRequestTeacher_getTodayClassroomTaskSuccessed;
- (void)didRequestTeacher_getTodayClassroomTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_classroomAttendanceList <NSObject>
- (void)didRequestTeacher_classroomAttendanceListSuccessed;
- (void)didRequestTeacher_classroomAttendanceListFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteCommentModul <NSObject>
- (void)didRequestTeacher_deleteCommentModulSuccessed;
- (void)didRequestTeacher_deleteCommentModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_editHaveSendIntegralRemark <NSObject>
- (void)didRequestTeacher_editHaveSendIntegralRemarkSuccessed;
- (void)didRequestTeacher_editHaveSendIntegralRemarkFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteTaskModul <NSObject>
- (void)didRequestTeacher_deleteTaskModulSuccessed;
- (void)didRequestTeacher_deleteTaskModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteCollectTaskModul <NSObject>
- (void)didRequestTeacher_deleteCollectTaskModulSuccessed;
- (void)didRequestTeacher_deleteCollectTaskModulFailed:(NSString *)failedInfo;
@end

@protocol Teacher_editStudent_remark <NSObject>
- (void)didRequestTeacher_editStudent_remarkSuccessed;
- (void)didRequestTeacher_editStudent_remarkFailed:(NSString *)failedInfo;
@end

@protocol Teacher_deleteHaveArrangeTask <NSObject>
- (void)didRequestTeacher_deleteHaveArrangeTaskSuccessed;
- (void)didRequestTeacher_deleteHaveArrangeTaskFailed:(NSString *)failedInfo;
@end

@protocol Teacher_PriseAndflower <NSObject>
- (void)didRequestTeacher_PriseAndflowerSuccessed;
- (void)didRequestTeacher_PriseAndflowerFailed:(NSString *)failedInfo;
@end

