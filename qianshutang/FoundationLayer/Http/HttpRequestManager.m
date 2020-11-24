//
//  HttpRequestManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "HttpRequestManager.h"
#import "AFNetworking.h"
#import "NetMacro.h"
#import "NSString+MD5.h"
#import "NSDictionary+JsonString.h"
#import "HttpConfigCreator.h"


@interface HttpRequestManager ()

@property (nonatomic,strong) NSMutableDictionary        *requestDelegateDictionary;

@end

@implementation HttpRequestManager

+ (instancetype)sharedManager
{
    static HttpRequestManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[HttpRequestManager alloc] init];
    });
    return __manager__;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.requestDelegateDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}


#pragma mark -

- (void)requestLoginWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
              andProcessDelegate:(__weak id<HttpRequestProtocol>)delegate;
{
    HttpConfigModel *loginHttp = [HttpConfigCreator getLoginHttpConfigWithUserName:userName andPassword:password];
    [self startPostWithConfig:loginHttp andProcessDelegate:delegate];
}

- (void)requestResetPwdWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel *reset = [HttpConfigCreator getResetPwdConfigWithOldPwd:oldPwd andNewPwd:newPwd];
    [self startPostWithConfig:reset andProcessDelegate:delegate];
}

- (void)reqeustAppVersionInfoWithProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel *s = [HttpConfigCreator getAppVersionInfoConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustBindJPushWithCId:(NSString *)CID andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getBindJPushWithCId:CID];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustVerifyAccountWithAccountNumber:(NSString *)AccountNumber andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getVerifyAccount:AccountNumber];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustVerifyCodeWithPhoneNumber:(NSString *)phoneNumber andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getVerifyCode:phoneNumber];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustRegistWithdic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator registWith:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustForgetPasswordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator forgetPasswordWith:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustCompleteUserInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator completeUserInfo:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustBindPhoneBunberWith:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator bindPhoneNumber:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustmyClassroomWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyClassroomConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - classroom and Friend
- (void)reqeustMyFriendListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyFriendConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustMyFriendAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyFriendAchievementListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustAddFriendWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getAddFriendConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustDeleteFriendWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getDeleteFriendConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyFriendInformationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyFriendInformationConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyFriendProductListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyFriendProductListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyFriendProductDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyFriendProductDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustMyRecordProductDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyRecordProductDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustMyGroupListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyGroupListConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustClassMemberAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassMemberAchievementListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassTaskListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassMemberComplateTaskInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassMemberComplateTaskInfoConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassTextbookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassTextbookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassCourseWareWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassCourseWareConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassCourseWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassCourseConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustClassMemberWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassMemberConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassTaskHaveComplateWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassTaskHaveComplateConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClassMemberInformationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClassMemberInformationConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - userData
- (void)reqeustMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyCollectionTextBookConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustSearchMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSearchMyCollectionTextBookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustDeleteMyCollectionTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getDeleteMyCollectionTextBookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyBookmarkListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyBookmarkListConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustDeleteMyBookmarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getDeleteMyBookmarkConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustClearnMyBookmarkListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getClearnMyBookmarkListConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyHeadQuestionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyHeadQuestionListConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyQuestionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyQuestionListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyQuestionDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyQuestionDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustSetHaveReadQuestionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSetHaveReadQuestionConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - Task
- (void)reqeustUploadWholeRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getUploadWholeRecordProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustUploadPagingRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getUploadPagingRecordProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustReadTextWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getReadTextConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustSubmitMoerduoAndReadTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSubmitMoerduoAndReadTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustSubmitCreateProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSubmitCreateProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustCreateTaskProblemContentWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getCreateTaskProblemContentConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustAgainUploadWholeRecordProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getAgainUploadWholeRecordProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - productShow
- (void)reqeustProductShowListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getProductShowListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustDeleteProductShowMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getDeleteProductShowMyProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - activeStudy
- (void)reqeustReadListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getReadListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustSearchReadListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSearchReadListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustCollectTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getCollectTextBookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTextBookContentListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTextBookContentListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTextContentWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTextContentConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}



#pragma mark - 积分
- (void)reqeustmyIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyIntegralConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustmyIntegralRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyIntegralRecordConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustPrizeListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getPrizeListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator convertPrizeConfigWith:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustConvertPrizeRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    {
        HttpConfigModel * s = [HttpConfigCreator convertPrizeRecordConfig:infoDic];
        [self startPostWithConfig:s andProcessDelegate:delegate];
    }
}
- (void)reqeustCancelConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator cancelConvertPrizeConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustComplateConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator complateConvertPrizeListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_memberIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate{
    HttpConfigModel * s = [HttpConfigCreator teacher_memberIntegralListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_haveSendIntegralWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator teacher_haveSendIntegralListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_CreateConvertPrizeRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator teacher_createConvertPrizeRecordListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_sendGoodsWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator teacher_teacherSendGoodsListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_GetAddressInfoWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator teacher_teacherGetAddressInfoConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_CancelConvertPrizeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator teacher_teacherCancelConvertPrizeConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - 消息中心
- (void)reqeustSchoolNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getSchoolNotificationConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTaskNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTaskNotificationConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getFriendRequestNotificationConfig];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustAgreeFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getAgreeFriendRequestNotificationConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustRejectFriendRequestNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getRejectFriendRequestNotificationConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustOtherNotificationWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getOtherMessageNotificationConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
#pragma mark - 个人信息设置
- (void)reqeustChangeIconImageWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getChangeIconImageConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustChangeNickNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getChangeNickNameConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustChangePhoneNumberWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getBindPhoneNumberConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustChangeGenderWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getChangeGenderConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustChangeBirthdayWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getChangeBirthdayConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustChangeReceiveAddressWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getChangeReceiveAddressConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustNotificationNoDisturWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getNotificationNoDisturbConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustLogoutWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getLogoutConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark -个人中心 - 我的作业、作品、课程等
- (void)reqeustMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustDeleteMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getDeleteMyProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustShareMyProductWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getShareMyProductConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyHeadTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyHeadTaskListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyEveryDayTaskDetailListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyEveryDayTaskDetailListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyEveryDayTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyEveryDayTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyCourseListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyAttendanceListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyAttendanceListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyCourseCostWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyCourseCostConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustBuyCourseRecordWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getBuyCourseRecordConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyAchievementListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyAchievementListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyStudyTimeLengthListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyStudyTimeLengthListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustMyStudyTimeLengthDetailListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyStudyTimeLengthDetailListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustPunchCardListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getPunchCardListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustMyCourse_BigCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getMyCourse_BigCourseListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustCurrentWeekCourseListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getCurrentWeekCourseListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - teacher
- (void)reqeustTeacher_MyCourseWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_MyCourseListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_sectionListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_sectionListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_sectionAttendanceWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_sectionAttendanceConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_totalAttendanceWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_totalAttendanceConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_attendanceFormWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_attendanceFormConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_addCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_addCourseSectionConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_deleteCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteCourseSectionConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_editCourseSectionWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_editCourseSectionConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_getTaskMouldWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_getTaskMouldConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_createSuiTangTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_createSuiTangTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_createXiLieTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_createXiLieTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_createMetarialWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_createMetarialConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_arrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_arrangeTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_shareTaskMouldToschoolWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_shareTaskMouldToschoolConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_haveArrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_haveArrangeTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_commentTaskListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_commentTaskListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_commentTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_commentTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_todayTaskComplateListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_todayTaskComplateListConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_studentHistoryTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_studentHistoryTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_addClassroomTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_addClassroomTextBookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_deleteClassroomTextBookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteClassroomTextBookConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_sectionCallRollWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_sectionCallRollConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_classroomSignWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_classroomSignConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_checkTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_checkTaskConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_changeModulNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_changeModulNameConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_changeHaveArrangeModulNameWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_changeHaveArrangeMoulNameConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_changeModulRemarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_changeMoulRemarkConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_getSuitangDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_getSuitangTaskDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_getXilieDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_getXilieTaskDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}


- (void)reqeustTeacher_getEditXilieTaskDetailWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_getEditXilieModulDetailConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_AddSuitangTaskTypeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_AddSuitangTaskTypeConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_AddXilieTaskTypeWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_AddXilieTaskTypeConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_DeleteModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_DeleteModulConfig:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_changeSuitangModultextbookWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_changeSuitangModultextbook:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_changeSuitangModulRepeatCountWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_changeSuitangModulRepeatCount:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_collectSchoolTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_collectSchoolTaskModul:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_CommentModulListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_CommentModulList:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_addTextToCommentModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_addTextToCommentModul:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getGetmainPageCategory:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustGetIsHaveNewMessageWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getIsHaveNewMessage:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_getTodayClassroomTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_getTodayClassroomTask:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_classroomAttendanceListWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_classroomAttendanceList:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_deleteCommentModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteCommentModul:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_editHaveSendIntegralRemarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_editHaveSendIntegralRemark:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_deleteTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteTaskModul:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_deleteCollectTaskModulWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteCollectTaskModul:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_editStudentInfo_remarkWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_editStudentInfo_remark:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

- (void)reqeustTeacher_deleteHaveArrangeTaskWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_deleteHaveArrangeTask:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}
- (void)reqeustTeacher_PriseAndflowerWithDic:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate
{
    HttpConfigModel * s = [HttpConfigCreator getTeacher_PriseAndflower:infoDic];
    [self startPostWithConfig:s andProcessDelegate:delegate];
}

#pragma mark - post method
- (void)startPostWithConfig:(HttpConfigModel *)configModel andProcessDelegate:(__weak id<HttpRequestProtocol>)delegate
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSLog(@"configModel.urlString = %@", configModel.urlString);
    
    NSLog(@"%@",[configModel.parameters jsonString]);
    [session POST:configModel.urlString parameters:configModel.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int result = [[responseObject objectForKey:@"result"] intValue];
        NSLog(@"[responseObject description] = %@",[responseObject description]);
        if (delegate != nil) {
            if (result == 1) {
                [delegate didRequestSuccessed:responseObject];
            }else{
                
                if ([[responseObject objectForKey:@"errorMsg"] isKindOfClass:[NSNull class]] ||  [[responseObject objectForKey:@"errorMsg"] length] == 0) {
                    
                    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
                    [infoDic setObject:@"暂无数据" forKey:@"errorMsg"];
                    [delegate didRequestFailedWithInfo:infoDic];
                }else{
                    [delegate didRequestFailedWithInfo:responseObject];
                }
            }
        }else{
            
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
//        NSLog(@"****code = %ld \n*** userinfo = %@ \n***%@",error.code,error.userInfo,error.domain);
        if (delegate != nil) {
//            [delegate didRequestFailed:kNetError];
            NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
            [infoDic setObject:kNetError forKey:@"errorMsg"];
            [infoDic setObject:configModel.command forKey:@"command"];
            [delegate didRequestFailedWithInfo:infoDic];
        }else{
            return ;
        }
    }];
    
    
    
    /*
     NSURL * url = [NSURL URLWithString:configModel.urlString];
     
     // 创建请求
     NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
     [request setHTTPMethod:@"POST"];
     [request setHTTPBody:[[configModel.parameters jsonString] dataUsingEncoding:NSUTF8StringEncoding]];
     
     NSURLSession *mySession = [NSURLSession sharedSession];
     NSURLSessionTask * task = [mySession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if (error) {
     
     if (error.code == -1009) {
     ;
     }
     // 此处如果不返回主线程的话，请求是异步线程，直接执行代理方法可能会修改程序的线程布局，就可能会导致崩溃
     dispatch_sync(dispatch_get_main_queue(), ^{
     
     NSError * error1 = [NSError errorWithDomain:@"" code:10000 userInfo:@{@"Reason":@"服务器连接失败"}];
     });
     NSLog(@"++++++=%@", error);
     
     }else
     {
     
     NSLog(@"+++++++++++++++++++++++++++++++++\njsonStr = %@\n++++++++++++++++", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
     NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     //            NSLog(@"*****%@", [dic description]);
     // 此处如果不返回主线程的话，请求是异步线程，直接执行代理方法可能会修改程序的线程布局，就可能会导致崩溃
     dispatch_sync(dispatch_get_main_queue(), ^{
     
     if (dic == nil) {
     
     NSError * error = [NSError errorWithDomain:@"" code:10000 userInfo:@{@"Reason":@"服务器处理失败"}];
     
     
     }else
     {
     
     }
     });
     }
     }];
     
     [task resume];
     */
    

    
    
}


@end
