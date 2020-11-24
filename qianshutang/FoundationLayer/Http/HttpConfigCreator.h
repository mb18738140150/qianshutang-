//
//  HttpConfigCreator.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConfigModel.h"

@interface HttpConfigCreator : NSObject



+ (HttpConfigModel *)getLoginHttpConfigWithUserName:(NSString *)userName andPassword:(NSString *)password;

+ (HttpConfigModel *)getResetPwdConfigWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd;
+ (HttpConfigModel *)getAppVersionInfoConfig;
+ (HttpConfigModel *)getBindJPushWithCId:(NSString *)CID;

+ (HttpConfigModel *)getVerifyCode:(NSString *)phoneNumber;

+ (HttpConfigModel *)registWith:(NSDictionary *)infoDic;

+ (HttpConfigModel *)forgetPasswordWith:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getVerifyAccount:(NSString *)accountNumber;
+ (HttpConfigModel *)bindPhoneNumber:(NSDictionary *)infoDic;
+ (HttpConfigModel *)completeUserInfo:(NSDictionary *)userInfo;

+ (HttpConfigModel *)getMyClassroomConfig;

#pragma mark - classroom and Friend
+ (HttpConfigModel *)getMyFriendConfig;
+ (HttpConfigModel *)getMyFriendAchievementListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getAddFriendConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getDeleteFriendConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyFriendInformationConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyFriendProductListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyFriendProductDetailConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyRecordProductDetailConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyGroupListConfig;


+ (HttpConfigModel *)getClassMemberAchievementListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassTaskListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassMemberComplateTaskInfoConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassTextbookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassCourseWareConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassCourseConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getClassMemberConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassMemberInformationConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClassTaskHaveComplateConfig:(NSDictionary *)infoDic;

#pragma mark - task
+ (HttpConfigModel *)getUploadWholeRecordProductConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getUploadPagingRecordProductConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getReadTextConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getAgainUploadWholeRecordProductConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getSubmitMoerduoAndReadTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getSubmitCreateProductConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getCreateTaskProblemContentConfig:(NSDictionary *)infoDic;

#pragma mark - pruductShow
+ (HttpConfigModel *)getProductShowListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getDeleteProductShowMyProductConfig:(NSDictionary *)infoDic;

#pragma mark - ActiveStudy
+ (HttpConfigModel *)getReadListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getSearchReadListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getCollectTextBookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTextBookContentListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTextContentConfig:(NSDictionary *)infoDic;

#pragma mark - userData
+ (HttpConfigModel *)getMyCollectionTextBookConfig;
+ (HttpConfigModel *)getSearchMyCollectionTextBookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getDeleteMyCollectionTextBookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyBookmarkListConfig;
+ (HttpConfigModel *)getDeleteMyBookmarkConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getClearnMyBookmarkListConfig;
+ (HttpConfigModel *)getMyHeadQuestionListConfig;
+ (HttpConfigModel *)getMyQuestionListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyQuestionDetailConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getSetHaveReadQuestionConfig:(NSDictionary *)infoDic;

#pragma mark - 积分兑奖
+ (HttpConfigModel *)getMyIntegralConfig;
+ (HttpConfigModel *)getMyIntegralRecordConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getPrizeListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)convertPrizeConfigWith:(NSDictionary *)infoDic;
+ (HttpConfigModel *)convertPrizeRecordConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)cancelConvertPrizeConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)complateConvertPrizeListConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)teacher_memberIntegralListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)teacher_haveSendIntegralListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)teacher_createConvertPrizeRecordListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)teacher_teacherSendGoodsListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)teacher_teacherGetAddressInfoConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)teacher_teacherCancelConvertPrizeConfig:(NSDictionary *)infoDic;


#pragma mark - 消息中心
+ (HttpConfigModel *)getSchoolNotificationConfig;
+ (HttpConfigModel *)getTaskNotificationConfig;
+ (HttpConfigModel *)getFriendRequestNotificationConfig;
+ (HttpConfigModel *)getAgreeFriendRequestNotificationConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getRejectFriendRequestNotificationConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getOtherMessageNotificationConfig:(NSDictionary *)infoDic;

#pragma mark - 个人信息设置
+ (HttpConfigModel *)getChangeIconImageConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getChangeNickNameConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getBindPhoneNumberConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getChangeGenderConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getChangeBirthdayConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getChangeReceiveAddressConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getNotificationNoDisturbConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getLogoutConfig:(NSDictionary *)infoDic;

#pragma mark -个人中心 - 我的作业、作品、课程等
+ (HttpConfigModel *)getMyProductConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getDeleteMyProductConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getShareMyProductConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyHeadTaskListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyEveryDayTaskDetailListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyEveryDayTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyCourseListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyAttendanceListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyCourseCostConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getBuyCourseRecordConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyAchievementListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyStudyTimeLengthListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getMyStudyTimeLengthDetailListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getPunchCardListConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getMyCourse_BigCourseListConfig:(NSDictionary *)infoDic;// CurrentWeekCourseList
+ (HttpConfigModel *)getCurrentWeekCourseListConfig:(NSDictionary *)infoDic;

#pragma mark - teacher
+ (HttpConfigModel *)getTeacher_MyCourseListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_sectionListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_sectionAttendanceConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_totalAttendanceConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_attendanceFormConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_addCourseSectionConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteCourseSectionConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_editCourseSectionConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_getTaskMouldConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_createSuiTangTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_createXiLieTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_createMetarialConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_arrangeTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_shareTaskMouldToschoolConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_haveArrangeTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_commentTaskListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_commentTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_todayTaskComplateListConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_studentHistoryTaskConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_addClassroomTextBookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteClassroomTextBookConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_sectionCallRollConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_classroomSignConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_checkTaskConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getTeacher_changeModulNameConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_changeMoulRemarkConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_changeHaveArrangeMoulNameConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_getSuitangTaskDetailConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_getXilieTaskDetailConfig:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getTeacher_getEditXilieModulDetailConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_AddSuitangTaskTypeConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_AddXilieTaskTypeConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_DeleteModulConfig:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_changeSuitangModultextbook:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_changeSuitangModulRepeatCount:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getTeacher_getTodayClassroomTask:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getIsHaveNewMessage:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_CommentModulList:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_addTextToCommentModul:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_collectSchoolTaskModul:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getGetmainPageCategory:(NSDictionary *)infoDic;

+ (HttpConfigModel *)getTeacher_classroomAttendanceList:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteCommentModul:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_editHaveSendIntegralRemark:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteTaskModul:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteCollectTaskModul:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_editStudentInfo_remark:(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_deleteHaveArrangeTask :(NSDictionary *)infoDic;
+ (HttpConfigModel *)getTeacher_PriseAndflower:(NSDictionary *)infoDic;

@end
