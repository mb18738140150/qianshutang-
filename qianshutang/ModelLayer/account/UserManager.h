//
//  UserManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModuleProtocol.h"

@interface UserManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - 个人中心
/**
 请求登陆接口

 @param userName 用户名
 @param pwd 密码
 @param object 请求成功后通知的对象
 */
- (void)loginWithUserName:(NSString *)userName
              andPassword:(NSString *)pwd
       withNotifiedObject:(id<UserModule_LoginProtocol>)object;



/**
 请求重置密码接口

 @param oldPwd 旧密码
 @param newPwd 新密码
 @param object 请求成功后通知的对象
 */
- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object;


// 注册
- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object;


// 忘记密码
- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object;

// 获取验证码
- (void)getVerifyCodeWithPhoneNumber:(NSString *)phoneNumber withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object;

// 绑定手机号
- (void)getBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BindPhoneNumber>)object;

- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object;

// 获取我的班级
- (void)didRequestMyClassroomInfoWithNotifiedObject:(id<UserModule_MyClassroomProtocol>)object;
- (NSArray *)getmyClassroom;

/**
 请求app版本信息

 @param object 请求成功后通知的对象
 */
- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object;

/**
 退出登录
 */
- (void)logout;

/**
 判断是否已经登陆

 @return 是否登陆
 */
- (BOOL)isUserLogin;

/**
 获取用户id

 @return 用户id
 */
- (int)getUserId;
- (int)getDepartId;

- (NSString *)getWangyiToken;

/**
 获取用户类型
 
 @return 用户类型
 */
- (int)getUserType;

/**
 获取用户名

 @return 用户名
 */
- (NSString *)getUserName;

/**
 获取昵称
 
 @return 昵称
 */
- (NSString *)getUserNickName;

/**
 获取验证码
 
 @return 验证码
 */
- (NSString *)getVerifyCode;

/**
 获取绑定手机号
 
 @return 已绑定手机号
 */
- (NSString *)getVerifyPhoneNumber;

/**
 获取用户信息

 @return 用户信息
 */
- (NSDictionary *)getUserInfos;

- (NSString *)getShareUrl;
- (NSString *)getLogoUrl;
- (NSString *)getCoverImg;
- (NSArray*)getIconList;

- (void)refreshUserInfoWith:(NSDictionary *)infoDic;


- (NSDictionary *)getUpdateInfo;

- (void)encodeUserInfo;

#pragma mark - classroom and Friend
- (void)didRequestMyFriendListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendList>)object;
- (void)didRequestMyFriendAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendAchievementList>)object;
- (void)didRequestAddMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_AddMyFriend>)object;
- (void)didRequestDeleteMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_DeleteMyFriend>)object;
- (void)didRequestMyFriendInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendInformation>)object;
- (void)didRequestMyFriendProductListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductList>)object;
- (void)didRequestMyFriendProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductDetail>)object;
- (void)didRequestMyRecordProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyRecordProductDetail>)object;

- (void)didRequestMyGroupListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyGroupList>)object;
- (void)didRequestClassMemberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMember>)object;
- (void)didRequestClassTaskHaveComplateWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskHaveComplate>)object;
- (NSArray *)getMyClassmemberList;
- (NSArray *)getClassTaskHaveComplate;
- (NSArray *)getMyFriendList;
- (NSArray *)getMyFriendAchievementList;
-(NSDictionary *)getMyFriendInformation;
- (NSArray *)getMyFriendProductList;
- (NSDictionary *)getmyFriendProductDetailInfoDic;
- (NSDictionary *)getmyRecordProductDetailInfoDic;
- (NSArray *)getMyGroupList;


- (void)didRequestClassMemberAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberAchievementList>)object;
- (void)didRequestClassTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskList>)object;
- (void)didRequestClassMemberComplateTaskInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberComplateTaskInfo>)object;
- (void)didRequestClassTextbookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTextbook>)object;
- (void)didRequestClassCourseWareWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourseWare>)object;
- (void)didRequestClassCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourse>)object;
- (void)didRequestClassMemberInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberInformation>)object;

- (NSArray *)getClassMemberAchievementArray;
- (NSArray *)getClassTaskArray;
- (NSArray *)getClassMemberComplateTaskInfoArray;
- (NSArray *)getClassTextbookArray;
- (NSArray *)getClassCourseWareArray;
- (NSArray *)getClassCourseArray;
- (NSDictionary *)getMemberInformation;

#pragma mark - userData
- (void)didRequestMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object;
- (void)didRequestSearchMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object;
- (void)didRequestDeleteMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object;
- (void)didRequestMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object;
- (void)didRequestDeleteMyBookmarkWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object;
- (void)didRequestClearnMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object;
- (void)didRequestMyHeadQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object;
- (void)didRequestMyQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object;
- (void)didRequestMyQuestionDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object;
- (void)didRequestSetaHaveReadQuestionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object;
- (NSArray *)getMyCollectionTextbookArray;
- (NSArray *)getSearchMyCollectionTextbookArray;
- (NSArray *)getMyBookmarkArray;
- (NSArray *)getMyHeadQuestionArray;
- (NSArray *)getMyQuestionArray;
- (NSArray *)getMyQuestionDetailArray;

#pragma mark - tsak
- (void)didRequestUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadWholeRecordProduct>)object;
- (void)didRequestUploadPagingRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadPagingRecordProduct>)object;

- (void)didRequestReadTextWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_ReadText>)object;
- (void)didRequestSubmitMoerduoAndReadTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitMoerduoAndReadTask>)object;
- (void)didRequestSubmitCreateProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitCreateProduct>)object;
- (void)didRequestCreateTaskProblemContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_CreateTaskProblemContent>)object;
- (void)didRequestAgainUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_AgainUploadWholeRecordProduct>)object;

- (int)getUploadRecordStar;
- (NSDictionary *)getTaskProbemContentInfo;
-(NSDictionary *)getUploadRecorgInfo;


#pragma mark - productShow
- (void)didRequestProductShowListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_ProductShowList>)object;
- (void)didRequestDeleteProductShowMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_DeleteProductShowMyProduct>)object;
- (NSArray * )getProductShowArray;

- (NSArray *)getProductShowRecordArray;
- (NSArray *)getProductShowCreateArray;

#pragma mark - activeStudy
- (void)didRequestReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_ReadList>)object;
- (void)didRequestSearchReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_SearchReadList>)object;
- (void)didRequestCollectTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_CollectTextBook>)object;
- (void)didRequestTextBookContentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextBookContentList>)object;
- (void)didRequestTextContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextContent>)object;

- (NSArray *)getReadArray;
- (NSArray *)getSearchReadArray;
- (NSDictionary *)getTextbookContentArray;
- (NSDictionary *)getTextContentArray;
- (void)resetTextContentArray:(NSDictionary *)infoDic;

#pragma mark - 积分
// 获取我的积分
- (void)didRequestMyIntegralWithNotifiedObject:(id<Integral_MyIntegral>)object;
- (NSDictionary *)getmyIntegral;

- (void)didRequestMyIntegralRecordWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegralRecord>)object;
- (NSArray *)getmyIntegralRecord;

- (void)didRequestPrizeListWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_PrizeList>)object;
- (NSArray *)getPrizeList;

- (void)didRequestConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrize>)object;

- (void)didRequestConvertPrizeRecordWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrizeRecord>)object;
- (NSArray *)getConvertPrizeRecordList;

- (void)didRequestComplateConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ComplateConvertPrize>)object;
- (NSArray *)getComplateConvertPrizeList;

- (void)didRequestCancelConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_CancelConvertPrize>)object;


- (void)didRequestTeacher_memberIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_memberPrize>)object;
- (void)didRequestTeacher_haveSendIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_haveSendIntegral>)object;
- (void)didRequestTeacher_createConverPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_CreateConvertPrizeRecord>)object;
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object;

- (NSArray *)teacher_memberIntegralList;
- (NSArray *)teacher_haveSendIntegralList;

#pragma mark - 消息中心
- (void)didRequestSchoolNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_SchoolNotification>)object;
- (NSArray *)getSchoolNotificationList;
- (void)didRequestTaskNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_TaskNotification>)object;
- (NSArray *)getTaskNotificationList;
- (void)didRequestFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_FriendRequestNotification>)object;
- (NSArray *)getFriendRequestNotificationList;
- (void)didRequestAgreeFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_AgreeFriendRequestNotification>)object;
- (void)didRequestRejectFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_RejectFriendRequestNotification>)object;
- (void)didRequestOtherMessageNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_OtherMessageNotification>)object;
- (NSArray *)getOtherMessageNotificationList;
#pragma mark - 个人信息设置
- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object;
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object;
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object;
- (void)didRequestChangeGenderWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object;
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object;
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object;
- (void)didRequestNotificationNoDisturbWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object;
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object;

- (void)changeIconUrl:(NSString *)headImageUrl;
- (void)changeUserName:(NSString *)nikeName;
- (void)changeGender:(NSString *)nikeName;
- (void)changeBirthday:(NSString *)nikeName;
- (void)changeRecieveAddress:(NSDictionary *)infoDic;
- (void)changeNotificationNoDisturb:(NSString *)notifyStr;
- (void)changePhone:(NSString *)phoneNumber;

#pragma mark -个人中心
- (void)didRequestMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyProduct>)object;
- (void)didRequestDeleteMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_DeleteMyProduct>)object;
- (void)didRequestShareMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_ShareMyProduct>)object;
- (void)didRequestMyHeadTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyHeadTaskList>)object;
- (void)didRequestMyEveryDayTaskDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTaskDetailList>)object;
- (void)didRequestMyEveryDayTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTask>)object;
- (void)didRequestMyCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseList>)object;
- (void)didRequestMyAttendanceListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAttendanceList>)object;
- (void)didRequestMyCourseCostWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseCost>)object;
- (void)didRequestBuyCourseRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_BuyCourseRecord>)object;
- (void)didRequestMyAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAchievementList>)object;
- (void)didRequestMyStudyTimeLengthListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthList>)object;
- (void)didRequestMyStudyTimeLengthDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthDetailList>)object;
- (void)didRequestPunchCardListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_PunchCardList>)object;

- (void)didRequestMyCourse_BigCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourse_BigCourseList>)object;
- (void)didRequestCurrentWeekCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_CurrentWeekCourseList>)object;
- (NSArray *)getMyCourse_BigCourseList;
- (NSArray *)getCurrentWeekCourseList;

- (NSMutableArray *)getMyProductInfoDic;
- (NSMutableArray *)getMyProduct_shareInfoDic;
- (NSMutableArray *)getMyRecordProductInfoDic;
- (NSMutableArray*)getMyCreatProductInfoDic;

- (NSMutableArray *)getMyCreatProduct_shareInfoDic;
- (NSMutableArray *)getMyTaskRecordProduct_shareInfoDic;

- (NSMutableArray *)getMyTaskRecordProductInfoDic;
- (NSMutableArray*)getMyTaskCreatProductInfoDic;

- (int)getMyProductNoReadCount;

- (NSArray *)getMyHeadTaskList;
- (NSArray *)getMyEveryDayTaskDetailList;
- (NSArray *)getMyEveryDayTaskList;
- (NSArray *)getMyEveryDayTaskListNoClassify;

- (NSArray *)getMyCourseList;
- (NSDictionary *)getMyAttendanceInfoDic;
- (NSArray *)getMyCourseCost;
- (NSArray *)getMyBuyCourseRecordList;
- (NSDictionary *)getMyAchievementList;
- (NSDictionary *)getMyStudyTimeLengthList;
- (NSArray *)getMyStudyTimeLengthDetailList;
- (NSDictionary *)getMyPunchCardList;
- (NSDictionary *)getShareMyproductInfo;

#pragma mark - teacher
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
//- (void)didRequestGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<GetmainPageCategory>)object;
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

- (NSArray *)getTeacherMyCourseArray;
- (NSArray *)getTeacherSectionListArray;
- (NSDictionary *)getTeacherSectionAttendanceRecordInfo;
- (NSArray *)getTeacherTotalAttedanceArray;
- (NSArray *)getTeacher_Main_suitangTaskModulArray;
- (NSArray *)getTeacher_Main_xilieTaskModulArray;
- (NSArray *)getTeacher_School_suitangTaskModulArray;
- (NSArray *)getTeacher_School_xilieTaskModulArray;

- (NSArray *)getTeacherHaveArrangeTaskArray;
- (NSArray *)getTeacherCommentTaskListArray;
- (NSArray *)getTeacherTodayTaskComplateArray;
- (NSArray *)getTeacherStudentHistoryTaskArray;
- (NSDictionary *)getTeacherStudentHistoryTaskInfo;
- (NSDictionary *)getCreateMetarial_madeId;

- (NSArray *)getTeacherSuitangTAskArray;
- (NSArray *)getTeacherXilieTaskArray;
- (NSArray *)getEditXilieTaskDetailArray;
- (NSDictionary *)getStudentAddressInfo;

- (NSArray *)getTeacher_CommentModulArray;
- (NSArray *)getTeacher_TodayClassroomTaskArray;
- (NSArray *)getTeacher_classroomAttendanceArray;
- (NSMutableArray *)getIsHaveNewMessageInfoDic;

@end
