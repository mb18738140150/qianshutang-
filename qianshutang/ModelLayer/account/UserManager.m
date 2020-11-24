//
//  UserManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "UserManager.h"
#import "UserModuleModels.h"
#import "ResetPwdOperation.h"
#import "AppInfoOperation.h"

#import "LoginStatusOperation.h"
#import "VerifyCodeOperation.h"
#import "RegistOperation.h"
#import "ForgetPsdOperation.h"

#import "PathUtility.h"
#import "MyClassroomOperation.h"
#import "MyIntegralOperation.h"
#import "MyIntegralRecord.h"
#import "PrizeListOperation.h"
#import "ConvertPrizeOperation.h"
#import "NotificateOperation.h"
#import "UserInfoOperation.h"
#import "MyStudyOperation.h"
#import "ProductShowOperation.h"
#import "ActiveStudyOperation.h"
#import "TaskOperation.h"
#import "BindPhoneNumberOperation.h"
#import "BindJPushOperation.h"
#import "TeacherOperation.h"
@interface UserManager()

@property (nonatomic,strong) UserModuleModels           *userModuleModels;
@property (nonatomic,strong) LoginStatusOperation       *loginOperation;
@property (nonatomic,strong) AppInfoOperation           *infoOperation;
@property (nonatomic, strong)VerifyCodeOperation         *verifyCodeOperation;
@property (nonatomic, strong)RegistOperation         *registOperation;
@property (nonatomic, strong)ForgetPsdOperation         *forgetPsdOperation;
@property (nonatomic,strong) ResetPwdOperation          *resetOperation;
@property (nonatomic, strong)MyClassroomOperation       *myClassroomOperation;
@property (nonatomic, strong)MyIntegralOperation        *myIntegralOperation;
@property (nonatomic, strong)MyIntegralRecord           *myIntegralRecordOperation;
@property (nonatomic, strong)PrizeListOperation         *prizeListOperation;
@property (nonatomic, strong)ConvertPrizeOperation      *convertPrizeOperation;
@property (nonatomic, strong)NotificateOperation        *notificationOperation;
@property (nonatomic, strong)UserInfoOperation          *userInfoOperation;
@property (nonatomic, strong)MyStudyOperation           *myStudyOperation;
@property (nonatomic, strong)ProductShowOperation       *productshowOperation;
@property (nonatomic, strong)ActiveStudyOperation       *activeStudyOperation;
@property (nonatomic, strong)TaskOperation              *taskOperation;
@property (nonatomic, strong)BindPhoneNumberOperation       *bindPhoneNumberOperation;
@property (nonatomic, strong)TeacherOperation * teacherOperation;
@property (nonatomic, strong)BindJPushOperation *bindJPushOperation;

@end

@implementation UserManager

+ (instancetype)sharedManager
{
    static UserManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[UserManager alloc] init];
    });
    return __manager__;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userModuleModels = [[UserModuleModels alloc] init];
        self.loginOperation = [[LoginStatusOperation alloc] init];
        [self.loginOperation setCurrentUser:self.userModuleModels.currentUserModel];
        self.resetOperation = [[ResetPwdOperation alloc] init];
        
        self.infoOperation = [[AppInfoOperation alloc] init];
        self.infoOperation.appInfoModel = self.userModuleModels.appInfoModel;
        self.verifyCodeOperation = [[VerifyCodeOperation alloc]init];
        self.registOperation = [[RegistOperation alloc]init];
        self.forgetPsdOperation = [[ForgetPsdOperation alloc]init];
        self.myClassroomOperation = [[MyClassroomOperation alloc]init];
        self.myIntegralOperation = [[MyIntegralOperation alloc]init];
        self.myIntegralRecordOperation = [[MyIntegralRecord alloc]init];
        self.prizeListOperation = [[PrizeListOperation alloc]init];
        self.convertPrizeOperation = [[ConvertPrizeOperation alloc]init];
        self.notificationOperation = [[NotificateOperation alloc]init];
        self.userInfoOperation = [[UserInfoOperation alloc]init];
        self.myStudyOperation = [[MyStudyOperation alloc]init];
        self.productshowOperation = [[ProductShowOperation alloc]init];
        self.activeStudyOperation = [[ActiveStudyOperation alloc]init];
        self.taskOperation = [[TaskOperation alloc]init];
        self.bindPhoneNumberOperation = [[BindPhoneNumberOperation alloc]init];
        self.teacherOperation = [[TeacherOperation alloc]init];
        self.bindJPushOperation = [[BindJPushOperation alloc]init];
    }
    return self;
}

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)pwd withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
    [self.loginOperation didLoginWithUserName:userName andPassword:pwd withNotifiedObject:object];
}

- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object
{
    [self.resetOperation didRequestResetPwdWithOldPwd:oldPwd andNewPwd:newPwd withNotifiedObject:object];
}

- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object
{
    [self.registOperation didRequestRegistWithWithDic:infoDic withNotifiedObject:object];
}

- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object
{
    [self.forgetPsdOperation didRequestForgetPsdWithWithDic:infoDic withNotifiedObject:object];
}

- (void)getBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BindPhoneNumber>)object
{
    [self.bindPhoneNumberOperation didRequestBindPhoneNumber:infoDic withNotifiedObject:object];
}

- (void)getVerifyCodeWithPhoneNumber:(NSString *)phoneNumber withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object
{
    [self.verifyCodeOperation didRequestVerifyCodeWithWithPhoneNumber:phoneNumber withNotifiedObject:object];
}
- (void)didRequestMyClassroomInfoWithNotifiedObject:(id<UserModule_MyClassroomProtocol>)object
{
    [self.myClassroomOperation didRequestMyClassroomWithWithDic:@{} withNotifiedObject:object];
}

- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object
{
    [self.infoOperation didRequestAppInfoWithNotifedObject:object];
}

- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object
{
    [self.bindJPushOperation didRequestBindJPushWithCID:cid withNotifiedObject:object];
}

- (void)logout
{
    [self.loginOperation clearLoginUserInfo];
}

- (int)getUserId
{
    return self.userModuleModels.currentUserModel.userID;
}
- (int)getDepartId
{
    return self.userModuleModels.currentUserModel.departId;
}

- (NSString *)getWangyiToken
{
    return self.userModuleModels.currentUserModel.wangYiToken;
}

- (BOOL)isUserLogin
{
    return self.userModuleModels.currentUserModel.isLogin;
}

- (int)getUserType
{
    return self.userModuleModels.currentUserModel.type;
}

- (NSDictionary *)getUserInfos
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.userModuleModels.currentUserModel.userName forKey:kUserName];
    [dic setObject:@(self.userModuleModels.currentUserModel.userID) forKey:kUserId];
    [dic setObject:@(self.userModuleModels.currentUserModel.departId) forKey:kDepartId];
    [dic setObject:self.userModuleModels.currentUserModel.userNickName forKey:kUserNickName];
    [dic setObject:self.userModuleModels.currentUserModel.telephone forKey:kUserTelephone];
    [dic setObject:self.userModuleModels.currentUserModel.headImageUrl forKey:kUserHeaderImageUrl];
    [dic setObject:self.userModuleModels.currentUserModel.validityTime forKey:kvalidityTime];
    [dic setObject:self.userModuleModels.currentUserModel.gender forKey:kgender];
    [dic setObject:self.userModuleModels.currentUserModel.birthday forKey:kbirthday];
    [dic setObject:self.userModuleModels.currentUserModel.city forKey:kCity];
    [dic setObject:self.userModuleModels.currentUserModel.receiveAddress forKey:kreceiveAddress];
    [dic setObject:self.userModuleModels.currentUserModel.receivePhoneNumber forKey:kreceivePhoneNumber];
    [dic setObject:@(self.userModuleModels.currentUserModel.notificationNoDisturb) forKey:knotificationNoDisturb];
    [dic setObject:@(self.userModuleModels.currentUserModel.starCount) forKey:kStarCount];
    [dic setObject:@(self.userModuleModels.currentUserModel.flowerCount) forKey:kFlowerCount];
    [dic setObject:@(self.userModuleModels.currentUserModel.prizeCount) forKey:kPrizeCount];
    [dic setObject:@(self.userModuleModels.currentUserModel.score) forKey:kScore];
    [dic setObject:self.userModuleModels.currentUserModel.receiveName forKey:kreceiveName];
    [dic setObject:@(self.userModuleModels.currentUserModel.type) forKey:@"type"];
    return dic;
}

- (NSString *)getShareUrl
{
    return self.userModuleModels.currentUserModel.shareUrl;
}
- (NSString *)getLogoUrl
{
    return self.userModuleModels.currentUserModel.logo;
}
- (NSString *)getCoverImg
{
    return self.userModuleModels.currentUserModel.coverImg;
}
- (NSArray*)getIconList
{
    return self.userModuleModels.currentUserModel.iconList;
}

- (NSString *)getUserName
{
    return self.userModuleModels.currentUserModel.userName;
}
- (NSString *)getUserNickName
{
    return self.userModuleModels.currentUserModel.userNickName;
}

- (NSString *)getVerifyCode
{
    return self.verifyCodeOperation.verifyCode;
}

- (NSString *)getWangYiToken
{
    return self.userModuleModels.currentUserModel.wangYiToken;
}
- (NSString *)getIconUrl
{
    return self.userModuleModels.currentUserModel.headImageUrl;
}

- (NSArray *)getmyClassroom
{
    return self.myClassroomOperation.infoDic;
}

- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModuleModels.currentUserModel toFile:dataPath];
}


#pragma mark - classroom and Friend
- (void)didRequestMyFriendListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendList>)object
{
    [self.myClassroomOperation didRequestMyFriendListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyFriendAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendAchievementList>)object
{
    [self.myClassroomOperation didRequestMyFriendAchievementListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestAddMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_AddMyFriend>)object
{
    [self.myClassroomOperation didRequestAddMyFriendWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDeleteMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_DeleteMyFriend>)object
{
    [self.myClassroomOperation didRequestDeleteMyFriendWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyFriendInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendInformation>)object
{
    [self.myClassroomOperation didRequestMyFriendInformationWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyFriendProductListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductList>)object
{
    [self.myClassroomOperation didRequestMyFriendProductListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyFriendProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductDetail>)object
{
    [self.myClassroomOperation didRequestMyFriendProductDetailWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyRecordProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyRecordProductDetail>)object
{
    [self.myClassroomOperation didRequestMyRecordProductDetailWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyGroupListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyGroupList>)object
{
    [self.myClassroomOperation didRequestMyGroupListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestClassMemberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMember>)object
{
    [self.myClassroomOperation didRequestClassMemberWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassTaskHaveComplateWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskHaveComplate>)object
{
    [self.myClassroomOperation didRequestClassTaskHaveComplateWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getMyClassmemberList
{
    return self.myClassroomOperation.classMemberList;
}
- (NSArray *)getClassTaskHaveComplate
{
    return self.myClassroomOperation.classTaskHaceComplateArray;
}

- (NSArray *)getMyFriendList
{
    return self.myClassroomOperation.myFriendArray;
}
- (NSArray *)getMyFriendAchievementList
{
    return self.myClassroomOperation.mryFriendAchievementArray;
}
-(NSDictionary *)getMyFriendInformation
{
    return self.myClassroomOperation.myFriendInfrmation;
}
- (NSArray *)getMyFriendProductList
{
    return self.myClassroomOperation.myFriendProductArray;
}
- (NSDictionary *)getmyRecordProductDetailInfoDic
{
    return self.myClassroomOperation.myRecordProductDetailInfoDic;
}
- (NSDictionary *)getmyFriendProductDetailInfoDic
{
    return self.myClassroomOperation.myFriendProductDetailInfoDic;
}
- (NSArray *)getMyGroupList
{
    return self.myClassroomOperation.myGroupArray;
}

- (void)didRequestClassMemberAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberAchievementList>)object
{
    [self.myClassroomOperation didRequestClassMemberAchievementListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskList>)object
{
    [self.myClassroomOperation didRequestClassTaskListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassMemberComplateTaskInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberComplateTaskInfo>)object
{
    [self.myClassroomOperation didRequestClassMemberComplateTaskInfoWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassTextbookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTextbook>)object
{
    [self.myClassroomOperation didRequestClassTextbookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassCourseWareWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourseWare>)object
{
    [self.myClassroomOperation didRequestClassCourseWareWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourse>)object
{
    [self.myClassroomOperation didRequestClassCourseWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClassMemberInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberInformation>)object
{
    [self.myClassroomOperation didRequestClassMemberInformationWithWithDic:infoDic withNotifiedObject:object];
}


- (NSArray *)getClassMemberAchievementArray
{
    return self.myClassroomOperation.classMemberAchievementArray;
}
- (NSArray *)getClassTaskArray
{
    return self.myClassroomOperation.classTaskArray;
}
- (NSArray *)getClassMemberComplateTaskInfoArray
{
    return self.myClassroomOperation.classMemberComplateTaskInfoArray;
}
- (NSArray *)getClassTextbookArray
{
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in self.myClassroomOperation.classTextbookArray) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        if ([[infoDic objectForKey:kTextBookName] class] == [NSNull class] || [infoDic objectForKey:kTextBookName] == nil || [[infoDic objectForKey:kTextBookName] isEqualToString:@""]) {
            
            [mInfo setObject:@"" forKey:@"title"];
        }else{
            [mInfo setObject:[infoDic objectForKey:kTextBookName] forKey:@"title"];
        }
        if ([[infoDic objectForKey:kTextBookImageUrl] class] == [NSNull class] || [infoDic objectForKey:kTextBookImageUrl] == nil || [[infoDic objectForKey:kTextBookImageUrl] isEqualToString:@""]) {
            
            [mInfo setObject:@"" forKey:@"imagrUrl"];
        }else{
            [mInfo setObject:[infoDic objectForKey:kTextBookImageUrl] forKey:@"imagrUrl"];
        }
        [dataArray addObject:mInfo];
    }
    
    return dataArray;
}
- (NSArray *)getClassCourseWareArray
{
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in self.myClassroomOperation.classCourseWareArray) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        
        if ([[infoDic objectForKey:@"coursewareName"] class] == [NSNull class] || [infoDic objectForKey:@"coursewareName"] == nil || [[infoDic objectForKey:@"coursewareName"] isEqualToString:@""]) {
            
            [mInfo setObject:@"" forKey:@"title"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:@"title"];
        }
        if ([[infoDic objectForKey:@"coursewareUrl"] class] == [NSNull class] || [infoDic objectForKey:@"coursewareUrl"] == nil || [[infoDic objectForKey:@"coursewareUrl"] isEqualToString:@""]) {
            
            [mInfo setObject:@"" forKey:@"imagrUrl"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"coursewareUrl"] forKey:@"imagrUrl"];
        }
        
        [mInfo setObject:[infoDic objectForKey:@"coursewareType"] forKey:@"type"];
        
        [dataArray addObject:mInfo];
    }
    
    return dataArray;
}
- (NSArray *)getClassCourseArray
{
    return self.myClassroomOperation.classCourseArray;
}

- (NSDictionary *)getMemberInformation
{
    return self.myClassroomOperation.memberInfoDic;
}

#pragma mark - 积分
- (void)didRequestMyIntegralWithNotifiedObject:(id<Integral_MyIntegral>)object
{
    [self.myIntegralOperation didRequestMyIntegralWithWithDic:@{} withNotifiedObject:object];
}
- (NSDictionary *)getmyIntegral
{
    NSDictionary * infoDic = @{kMyIntegral:[self.myIntegralOperation.infoDic objectForKey:@"myIntegral"], kMyConvertIntegral:[self.myIntegralOperation.infoDic objectForKey:@"convertIntegral"], kIntegralRulerImageStr:[self.myIntegralOperation.infoDic objectForKey:@"integralRulerImageStr"]};
    
    return infoDic;
}

- (void)didRequestMyIntegralRecordWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegralRecord>)object
{
    [self.myIntegralRecordOperation didRequestMyIntegralRecordWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getmyIntegralRecord
{
    return self.myIntegralRecordOperation.infoDic;
}

- (void)didRequestPrizeListWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_PrizeList>)object
{
    [self.prizeListOperation didRequestPrizeListWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getPrizeList
{
    return self.prizeListOperation.infoDic;
}

- (void)didRequestConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrize>)object
{
    [self.convertPrizeOperation didRequestConvertPrizeWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestConvertPrizeRecordWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrizeRecord>)object
{
    [self.convertPrizeOperation didRequestConvertPrizeRecordWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getConvertPrizeRecordList
{
    return self.convertPrizeOperation.convertPrizeRecordList;
}

- (void)didRequestComplateConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ComplateConvertPrize>)object
{
    [self.convertPrizeOperation didRequestComplateConvertPrizeWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getComplateConvertPrizeList
{
    return self.convertPrizeOperation.ComplateConvertPrizeList;
}

- (void)didRequestCancelConvertPrizeWith:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_CancelConvertPrize>)object
{
    [self.convertPrizeOperation didRequestCancelConvertPrizeWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_memberIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_memberPrize>)object
{
    [self.myIntegralOperation didRequestTeacher_memberIntegralWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_haveSendIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_haveSendIntegral>)object
{
    [self.myIntegralOperation didRequestTeacher_haveSendIntegralWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_createConverPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_CreateConvertPrizeRecord>)object
{
    [self.myIntegralOperation didRequestTeacher_createConverPrizeRecordWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object
{
    [self.myIntegralOperation didRequestTeacher_sendGoodsWithWithDic:infoDic withNotifiedObject:object];
}

- (NSArray *)teacher_memberIntegralList
{
    return self.myIntegralOperation.teacher_memberIntegralList;
}
- (NSArray *)teacher_haveSendIntegralList
{
    return self.myIntegralOperation.teacher_haveSendIntegralList;
}

#pragma mark - 消息中心
- (void)didRequestSchoolNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_SchoolNotification>)object
{
    [self.notificationOperation didRequestSchoolNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getSchoolNotificationList
{
    return self.notificationOperation.schoolNotificationArray;
}
- (void)didRequestTaskNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_TaskNotification>)object
{
    [self.notificationOperation didRequestTaskNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getTaskNotificationList
{
    return self.notificationOperation.taskNotificationArray;
}
- (void)didRequestFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_FriendRequestNotification>)object
{
    [self.notificationOperation didRequestFriendRequestNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getFriendRequestNotificationList
{
    return self.notificationOperation.friendRequestNotificationArray;
}
- (void)didRequestAgreeFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_AgreeFriendRequestNotification>)object
{
    [self.notificationOperation didRequestAgreeFriendRequestNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestRejectFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_RejectFriendRequestNotification>)object
{
    [self.notificationOperation didRequestRejectFriendRequestNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestOtherMessageNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_OtherMessageNotification>)object
{
    [self.notificationOperation didRequestOtherMessageNotificationWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getOtherMessageNotificationList
{
    return self.notificationOperation.otherMessageNotificationArray;
}
#pragma mark - 个人信息设置
- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object
{
    [self.userInfoOperation didRequestChangeIconImageWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object
{
    [self.userInfoOperation didRequestChangeNickNameWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object
{
    [self.userInfoOperation didRequestChangePhoneNumberWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeGenderWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object
{
    [self.userInfoOperation didRequestChangeGenderWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object
{
    [self.userInfoOperation didRequestChangeBirthdayWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object
{
    [self.userInfoOperation didRequestChangeReceiveAddressWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestNotificationNoDisturbWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object
{
    [self.userInfoOperation didRequestNotificationNoDisturbWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object
{
    [self.userInfoOperation didRequestlogoutWithWithDic:infoDic withNotifiedObject:object];
}

- (void)changeIconUrl:(NSString *)headImageUrl
{
    if (headImageUrl == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.headImageUrl = headImageUrl;
    [self encodeUserInfo];
}

- (void)changeUserName:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.userNickName = nikeName;
    [self encodeUserInfo];
}

- (void)changePhone:(NSString *)phoneNumber
{
    if (phoneNumber == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.telephone = phoneNumber;
    [self encodeUserInfo];
}

- (void)changeGender:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.gender = nikeName;
    [self encodeUserInfo];
}
- (void)changeBirthday:(NSString *)nikeName
{
    if (nikeName == nil) {
        return;
    }
    self.userModuleModels.currentUserModel.birthday = nikeName;
    [self encodeUserInfo];
}
- (void)changeRecieveAddress:(NSDictionary *)infoDic
{
    self.userModuleModels.currentUserModel.receiveAddress = [infoDic objectForKey:kreceiveAddress];
    self.userModuleModels.currentUserModel.receiveName = [infoDic objectForKey:kreceiveName];
    self.userModuleModels.currentUserModel.receivePhoneNumber = [infoDic objectForKey:kreceivePhoneNumber];
    [self encodeUserInfo];
}

- (void)changeNotificationNoDisturb:(NSString *)notifyStr
{
    int notificationNoDisturb = 0;
    if ([notifyStr isEqualToString:@"关闭"]) {
        notificationNoDisturb = 0;
    }else
    {
        notificationNoDisturb = 1;
    }
    self.userModuleModels.currentUserModel.notificationNoDisturb = notificationNoDisturb;
    [self encodeUserInfo];
}


#pragma mark -个人中心
- (void)didRequestMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyProduct>)object
{
    [self.myStudyOperation didRequestMyProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDeleteMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_DeleteMyProduct>)object
{
    [self.myStudyOperation didRequestDeleteMyProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestShareMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_ShareMyProduct>)object
{
    [self.myStudyOperation didRequestShareMyProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyHeadTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyHeadTaskList>)object
{
    [self.myStudyOperation didRequestMyHeadTaskListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyEveryDayTaskDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTaskDetailList>)object
{
    [self.myStudyOperation didRequestMyEveryDayTaskDetailListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyEveryDayTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTask>)object
{
    [self.myStudyOperation didRequestMyEveryDayTaskWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseList>)object
{
    [self.myStudyOperation didRequestMyCourseListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyAttendanceListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAttendanceList>)object
{
    [self.myStudyOperation didRequestMyAttendanceListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyCourseCostWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseCost>)object
{
    [self.myStudyOperation didRequestMyCourseCostWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestBuyCourseRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_BuyCourseRecord>)object
{
    [self.myStudyOperation didRequestBuyCourseRecordWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAchievementList>)object
{
    [self.myStudyOperation didRequestMyAchievementListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyStudyTimeLengthListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthList>)object
{
    [self.myStudyOperation didRequestMyStudyTimeLengthListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyStudyTimeLengthDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthDetailList>)object
{
    [self.myStudyOperation didRequestMyStudyTimeLengthDetailListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestPunchCardListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_PunchCardList>)object
{
    [self.myStudyOperation didRequestPunchCardListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestMyCourse_BigCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourse_BigCourseList>)object
{
    [self.myStudyOperation didRequestMyCourse_BigCourseListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestCurrentWeekCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_CurrentWeekCourseList>)object
{
    [self.myStudyOperation didRequestCurrentWeekCourseListWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getMyCourse_BigCourseList
{
    return self.myStudyOperation.myCourse_BigCourseList;
}
- (NSArray *)getCurrentWeekCourseList
{
    return self.myStudyOperation.currentWeekCourseList;
}

- (int)getMyProductNoReadCount
{
    return [[self.myStudyOperation.MyProductDic objectForKey:@"noReadCommentCount"] intValue];
}
- (NSMutableArray *)getMyProductInfoDic
{
    return [self.myStudyOperation.MyProductDic objectForKey:@"data"];
}

- (NSMutableArray *)getMyProduct_shareInfoDic
{
    return [self.myStudyOperation.myProduct_shareInfoDic objectForKey:@"data"];
}

- (NSMutableArray *)getMyRecordProductInfoDic
{
    NSMutableArray * recordArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.MyProductDic objectForKey:@"data"];
    
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 1) {
            // 录音作品
            [recordArr addObject:infoDic];
        }
    }
    return recordArr;
}
- (NSMutableArray *)getMyCreatProductInfoDic
{
    NSMutableArray * createdArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.MyProductDic objectForKey:@"data"];
    
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 2) {
            // 录音作品
            [createdArr addObject:infoDic];
        }
    }
    return createdArr;
}

- (NSMutableArray *)getMyTaskRecordProductInfoDic
{
    NSMutableArray * recordArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.MyProductDic objectForKey:@"data"];
    
    NSMutableArray * taskArray = [NSMutableArray array];
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"userWorkId"] intValue] != 0) {
            [taskArray addObject:infoDic];
        }
    }
    
    for (NSDictionary * infoDic in taskArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 1) {
            // 录音作品
            [recordArr addObject:infoDic];
        }
    }
    return recordArr;
}

- (NSMutableArray *)getMyCreatProduct_shareInfoDic
{
    NSMutableArray * createdArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.myProduct_shareInfoDic objectForKey:@"data"];
    
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 2) {
            // 录音作品
            [createdArr addObject:infoDic];
        }
    }
    return createdArr;
}

- (NSMutableArray *)getMyTaskRecordProduct_shareInfoDic
{
    NSMutableArray * recordArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.myProduct_shareInfoDic objectForKey:@"data"];
    
    NSMutableArray * taskArray = [NSMutableArray array];
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"userWorkId"] intValue] != 0) {
            [taskArray addObject:infoDic];
        }
    }
    
    for (NSDictionary * infoDic in taskArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 1) {
            // 录音作品
            [recordArr addObject:infoDic];
        }
    }
    return recordArr;
}


- (NSMutableArray*)getMyTaskCreatProductInfoDic
{
    NSMutableArray * createdArr = [NSMutableArray array];
    NSArray * dataArray = [self.myStudyOperation.MyProductDic objectForKey:@"data"];
    
    NSMutableArray * taskArray = [NSMutableArray array];
    for (NSDictionary * infoDic in dataArray) {
        if ([[infoDic objectForKey:@"userWorkId"] intValue] != 0) {
            [taskArray addObject:infoDic];
        }
    }
    
    for (NSDictionary * infoDic in taskArray) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 2) {
            // 录音作品
            [createdArr addObject:infoDic];
        }
    }
    return createdArr;
}

- (NSArray *)getMyHeadTaskList
{
    return self.myStudyOperation.MyHeadTaskListArray;
}
- (NSArray *)getMyEveryDayTaskDetailList
{
    return self.myStudyOperation.MyEveryDayTaskDetailListArray;
}

- (NSArray *)getMyEveryDayTaskListNoClassify
{
    return self.myStudyOperation.MyEveryDayTaskArray;
}

- (NSArray *)getMyEveryDayTaskList
{
    NSMutableArray * moArray = [NSMutableArray array];
    NSMutableArray * readArray = [NSMutableArray array];
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    NSMutableArray * videoArray = [NSMutableArray array];
    
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary * infoDic in self.myStudyOperation.MyEveryDayTaskArray) {
        switch ([[infoDic objectForKey:@"type"] intValue]) {
            case 1:
            {
                [moArray addObject:infoDic];
            }
                break;
            case 2:
            {
                [readArray addObject:infoDic];
            }
                break;
            case 3:
            {
                [recordArray addObject:infoDic];
            }
                break;
            case 4:
            {
                [createArray addObject:infoDic];
            }
                break;
            case 5:
            {
                [videoArray addObject:infoDic];
            }
                break;
                
            default:
                break;
        }
    }
    
    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
    [moDic setObject:@(1) forKey:@"type"];
    [moDic setObject:moArray forKey:@"data"];
    
    [readDic setObject:@"阅读" forKey:@"typeStr"];
    [readDic setObject:@(2) forKey:@"type"];
    [readDic setObject:readArray forKey:@"data"];
    
    [recordDic setObject:@"录音" forKey:@"typeStr"];
    [recordDic setObject:@(3) forKey:@"type"];
    [recordDic setObject:recordArray forKey:@"data"];
    
    [createDic setObject:@"创作" forKey:@"typeStr"];
    [createDic setObject:@(4) forKey:@"type"];
    [createDic setObject:createArray forKey:@"data"];
    
    [videoDic setObject:@"视频" forKey:@"typeStr"];
    [videoDic setObject:@(5) forKey:@"type"];
    [videoDic setObject:videoArray forKey:@"data"];
    
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (moArray.count > 0) {
        [dataArray addObject:moDic];
    }
    if (readArray.count > 0) {
        [dataArray addObject:readDic];
    }
    if (recordArray.count > 0) {
        [dataArray addObject:recordDic];
    }
    if (createArray.count > 0) {
        [dataArray addObject:createDic];
    }
    if (videoArray.count > 0) {
        [dataArray addObject:videoDic];
    }
    
    
    return dataArray;
}
- (NSArray *)getMyCourseList
{
    return self.myStudyOperation.MyCourseListArray;
}
- (NSDictionary *)getMyAttendanceInfoDic
{
    return self.myStudyOperation.MyAttendanceInfoDic;
}
- (NSArray *)getMyCourseCost
{
    return self.myStudyOperation.MyCourseCostArray;
}
- (NSArray *)getMyBuyCourseRecordList
{
    return self.myStudyOperation.BuyCourseRecordArray;
}
- (NSDictionary *)getMyAchievementList
{
    return self.myStudyOperation.MyAchievementListArray;
}
- (NSDictionary *)getMyStudyTimeLengthList
{
    return self.myStudyOperation.MyStudyTimeLengthListArray;
}
- (NSArray *)getMyStudyTimeLengthDetailList
{
    return self.myStudyOperation.MyStudyTimeLengthDetailListArray;
}
- (NSDictionary *)getMyPunchCardList
{
    return self.myStudyOperation.PunchCardInfoDic;
}

- (NSDictionary *)getShareMyproductInfo
{
    return self.myStudyOperation.shareMyProductInfo;
}

#pragma mark - tsak
- (void)didRequestUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadWholeRecordProduct>)object
{
    [self.taskOperation didRequestUploadWholeRecordProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestUploadPagingRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadPagingRecordProduct>)object
{
    [self.taskOperation didRequestUploadPagingRecordProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestReadTextWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_ReadText>)object
{
    [self.taskOperation didRequestReadTextWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestSubmitMoerduoAndReadTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitMoerduoAndReadTask>)object
{
    [self.taskOperation didRequestSubmitMoerduoAndReadTaskWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestSubmitCreateProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitCreateProduct>)object
{
    [self.taskOperation didRequestSubmitCreateProductWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestCreateTaskProblemContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_CreateTaskProblemContent>)object
{
    [self.taskOperation didRequestCreateTaskProblemContentWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestAgainUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_AgainUploadWholeRecordProduct>)object
{
    [self.taskOperation didRequestAgainUploadWholeRecordProductWithWithDic:infoDic withNotifiedObject:object];
}

- (int)getUploadRecordStar
{
    return self.taskOperation.starCount;
}

- (NSDictionary *)getTaskProbemContentInfo
{
    return self.taskOperation.taskProbemContentInfo;
}

-(NSDictionary *)getUploadRecorgInfo
{
    return self.taskOperation.uploadRecordInfo;
}

#pragma mark - productShow
- (void)didRequestProductShowListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_ProductShowList>)object
{
    [self.productshowOperation didRequestProductShowListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDeleteProductShowMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_DeleteProductShowMyProduct>)object
{
    [self.productshowOperation didRequestDeleteProductShowMyProductWithWithDic:infoDic withNotifiedObject:object];
}



- (NSArray * )getProductShowArray
{
    return self.productshowOperation.productShowList;
}

- (NSArray *)getProductShowRecordArray
{
    return [self getProductShowArrayWith:NO];
}
- (NSArray *)getProductShowCreateArray
{
    return [self getProductShowArrayWith:YES];
}

- (NSArray * )getProductShowArrayWith:(BOOL)isCreate
{
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    for (NSDictionary * infoDic in self.productshowOperation.productShowList) {
        if ([[infoDic objectForKey:@"prductType"] intValue] == 2) {
            [createArray addObject:infoDic];
        }else
        {
            [recordArray addObject:infoDic];
        }
    }
    
    if (isCreate) {
        return createArray;
    }else
    {
        return recordArray;
    }
}

#pragma mark - activeStudy
- (void)didRequestReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_ReadList>)object
{
    [self.activeStudyOperation didRequestReadListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestSearchReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_SearchReadList>)object
{
    [self.activeStudyOperation didRequestSearchReadListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestCollectTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_CollectTextBook>)object
{
    [self.activeStudyOperation didRequestCollectTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTextBookContentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextBookContentList>)object
{
    [self.activeStudyOperation didRequestTextBookContentListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTextContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextContent>)object
{
    [self.activeStudyOperation didRequestTextContentWithWithDic:infoDic withNotifiedObject:object];
}

- (NSArray *)getReadArray
{
    return self.activeStudyOperation.readList;
}
- (NSArray *)getSearchReadArray
{
    return self.activeStudyOperation.searchReadList;
}
- (NSDictionary *)getTextbookContentArray
{
    return self.activeStudyOperation.textbookContentInfo;
}
- (NSDictionary *)getTextContentArray
{
    return self.activeStudyOperation.textContentInfo;
}

- (void)resetTextContentArray:(NSDictionary *)infoDic
{
    
    self.activeStudyOperation.textContentInfo = infoDic;
}

#pragma mark - userData
- (void)didRequestMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestMyCollectionTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestSearchMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SearchMyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestSearchMyCollectionTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDeleteMyCollectionTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyCollectiontextBook>)object
{
    [self.userInfoOperation didRequestDeleteMyCollectionTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyBookMarkList>)object
{
    [self.userInfoOperation didRequestMyBookmarkListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestDeleteMyBookmarkWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_DeleteMyBookmark>)object
{
    [self.userInfoOperation didRequestDeleteMyBookmarkWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestClearnMyBookmarkListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_ClearnMyBookmark>)object
{
    [self.userInfoOperation didRequestClearnMyBookmarkListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyHeadQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyHeadQuestion>)object
{
    [self.userInfoOperation didRequestMyHeadQuestionListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyQuestionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionlist>)object
{
    [self.userInfoOperation didRequestMyQuestionListWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestMyQuestionDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_MyQuestionDetail>)object
{
    [self.userInfoOperation didRequestMyQuestionDetailWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestSetaHaveReadQuestionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserData_SetaHaveReadQuestion>)object
{
    [self.userInfoOperation didRequestSetaHaveReadQuestionWithWithDic:infoDic withNotifiedObject:object];
}

- (NSArray *)getMyCollectionTextbookArray
{
    return self.userInfoOperation.myCollectionTextbookArray;
}
- (NSArray *)getSearchMyCollectionTextbookArray
{
    return self.userInfoOperation.searchCollectionTextbookArray;
}
- (NSArray *)getMyBookmarkArray
{
    return self.userInfoOperation.myBookmarkArray;
}
- (NSArray *)getMyHeadQuestionArray
{
    return self.userInfoOperation.myHeadQuestionArray;
}
- (NSArray *)getMyQuestionArray
{
    return self.userInfoOperation.myQuestionArray;
}
- (NSArray *)getMyQuestionDetailArray
{
    return self.userInfoOperation.myQuestionDetailArray;
}

#pragma mark - teacher
- (void)didRequestTeacher_MyCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_MyCourseList>)object
{
    [self.teacherOperation didRequestTeacher_MyCourseWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_sectionListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionList>)object
{
    [self.teacherOperation didRequestTeacher_sectionListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_sectionAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionAttendance>)object
{
    [self.teacherOperation didRequestTeacher_sectionAttendanceWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_totalAttendanceWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_totalAttendance>)object
{
    [self.teacherOperation didRequestTeacher_totalAttendanceWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_attendanceFormWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_attendanceForm>)object
{
    [self.teacherOperation didRequestTeacher_attendanceFormWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_addCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addCourseSection>)object
{
    [self.teacherOperation didRequestTeacher_addCourseSectionWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_deleteCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCourseSection>)object
{
    [self.teacherOperation didRequestTeacher_deleteCourseSectionWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_editCourseSectionWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editCourseSection>)object
{
    [self.teacherOperation didRequestTeacher_editCourseSectionWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_getTaskMouldWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTaskMould>)object
{
    [self.teacherOperation didRequestTeacher_getTaskMouldWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_createSuiTangTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createSuiTangTask>)object
{
    [self.teacherOperation didRequestTeacher_createSuiTangTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_createXiLieTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createXiLieTask>)object
{
    [self.teacherOperation didRequestTeacher_createXiLieTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_createMetarialWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_createMetarial>)object
{
    [self.teacherOperation didRequestTeacher_createMetarialWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_arrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_arrangeTask>)object
{
    [self.teacherOperation didRequestTeacher_arrangeTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_shareTaskMouldToschoolWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_shareTaskMouldToschool>)object
{
    [self.teacherOperation didRequestTeacher_shareTaskMouldToschoolWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_haveArrangeTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_haveArrangeTask>)object
{
    [self.teacherOperation didRequestTeacher_haveArrangeTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_commentTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTaskList>)object
{
    [self.teacherOperation didRequestTeacher_commentTaskListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_commentTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_commentTask>)object
{
    [self.teacherOperation didRequestTeacher_commentTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_todayTaskComplateListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_todayTaskComplateList>)object
{
    [self.teacherOperation didRequestTeacher_todayTaskComplateListWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_studentHistoryTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_studentHistoryTask>)object
{
    [self.teacherOperation didRequestTeacher_studentHistoryTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_addClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addClassroomTextBook>)object
{
    [self.teacherOperation didRequestTeacher_addClassroomTextBookWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_deleteClassroomTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteClassroomTextBook>)object
{
    [self.teacherOperation didRequestTeacher_deleteClassroomTextBookWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_sectionCallRollWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_sectionCallRoll>)object
{
    [self.teacherOperation didRequestTeacher_sectionCallRollWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_classroomSignWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomSign>)object
{
    [self.teacherOperation didRequestTeacher_classroomSignWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_checkTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_checkTask>)object
{
    [self.teacherOperation didRequestTeacher_checkTaskWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_changeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulName>)object
{
    [self.teacherOperation didRequestTeacher_changeModulNameWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_changeHaveArrangeModulNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeHaveArrangeModulName>)object
{
    [self.teacherOperation didRequestTeacher_changeHaveArrangeModulNameWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_changeModulRemarkWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeModulRemark>)object
{
    [self.teacherOperation didRequestTeacher_changeModulRemarkWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_getSuitangDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getSuitangDetail>)object
{
    [self.teacherOperation didRequestTeacher_getSuitangDetailWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_getXilieDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getXilieDetail>)object
{
    [self.teacherOperation didRequestTeacher_getXilieDetailWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_getEditXilieTaskDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getEditXilieTaskDetail>)object
{
    [self.teacherOperation didRequestTeacher_getEditXilieTaskDetailWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_addSuitangTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addSuitangTaskType>)object
{
    [self.teacherOperation didRequestTeacher_addSuitangTaskTypeWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_addXilieTaskTypeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addXilieTaskType>)object
{
    [self.teacherOperation didRequestTeacher_addXilieTaskTypeWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_DeleteModulWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteModul>)object
{
    [self.teacherOperation didRequestTeacher_DeleteModulWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_changeSuitangModulTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulTextBook>)object
{
    [self.teacherOperation didRequestTeacher_changeSuitangModulTextBookWithWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_changeSuitangModulRepeatCountWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_changeSuitangModulRepeatCount>)object
{
    [self.teacherOperation didRequestTeacher_changeSuitangModulRepeatCountWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_GetAddressInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_getAddressInfo>)object
{
    [self.teacherOperation didRequestTeacher_GetAddressInfoWithWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_collectSchoolTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_collectSchoolTaskModul>)object
{
    [self.teacherOperation didRequestTeacher_collectSchoolTaskModulWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_CommentModulListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_CommentModul>)object
{
    [self.teacherOperation didRequestTeacher_CommentModulListWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_addTextToCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_addTextToCommentModul>)object
{
    [self.teacherOperation didRequestTeacher_addTextToCommentModulWithDic:infoDic withNotifiedObject:object];
}
//- (void)didRequestGetGetmainPageCategoryWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<GetmainPageCategory>)object;
- (void)didRequestGetIsHaveNewMessageWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<IsHaveNewMessage>)object
{
    [self.teacherOperation didRequestGetIsHaveNewMessageWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_getTodayClassroomTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_getTodayClassroomTask>)object
{
    [self.teacherOperation didRequestTeacher_getTodayClassroomTaskWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_classroomAttendanceListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_classroomAttendanceList>)object
{
    [self.teacherOperation didRequestTeacher_classroomAttendanceListWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_deleteCommentModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCommentModul>)object
{
    [self.teacherOperation didRequestTeacher_deleteCommentModulWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_editHaveSendIntegralRemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editHaveSendIntegralRemark>)object
{
    [self.teacherOperation didRequestTeacher_editHaveSendIntegralRemarkWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_deleteTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteTaskModul>)object
{
    [self.teacherOperation didRequestTeacher_deleteTaskModulWithDic:infoDic withNotifiedObject:object];
}
- (void)didRequestTeacher_deleteCollectTaskModulWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteCollectTaskModul>)object
{
    [self.teacherOperation didRequestTeacher_deleteCollectTaskModulWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_editStudent_RemarkWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_editStudent_remark>)object
{
    [self.teacherOperation didRequestTeacher_editStudent_RemarkWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_deleteHaveArrangeTaskWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_deleteHaveArrangeTask>)object
{
    [self.teacherOperation didRequestTeacher_deleteHaveArrangeTaskWithDic:infoDic withNotifiedObject:object];
}

- (void)didRequestTeacher_PriseAndflowerWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Teacher_PriseAndflower>)object
{
    [self.teacherOperation didRequestTeacher_PriseAndflowerWithDic:infoDic withNotifiedObject:object];
}

- (NSArray *)getTeacherMyCourseArray
{
    return self.teacherOperation.myCourseArray;
}
- (NSArray *)getTeacherSectionListArray
{
    return self.teacherOperation.sectionListArray;
}
- (NSDictionary *)getTeacherSectionAttendanceRecordInfo;
{
    return self.teacherOperation.sectionAttendanceRecordInfo;
}
- (NSArray *)getTeacherTotalAttedanceArray
{
    return self.teacherOperation.totalAttendanceArray;
}

- (NSArray *)getTeacher_Main_suitangTaskModulArray
{
    return self.teacherOperation.main_suitangtaskMouldArray;
}
- (NSArray *)getTeacher_Main_xilieTaskModulArray
{
    return self.teacherOperation.main_xilietaskMouldArray;
}
- (NSArray *)getTeacher_School_suitangTaskModulArray
{
    return self.teacherOperation.school_suitangtaskMouldArray;
}
- (NSArray *)getTeacher_School_xilieTaskModulArray
{
    return self.teacherOperation.school_xilietaskMouldArray;
}

- (NSArray *)getTeacherHaveArrangeTaskArray
{
    return self.teacherOperation.haveArrangeTaskArray;
}
- (NSArray *)getTeacherCommentTaskListArray
{
    return self.teacherOperation.commentTaskLiatArray;
}
- (NSArray *)getTeacherTodayTaskComplateArray
{
    return self.teacherOperation.todayTaskComplateArray;
}
- (NSArray *)getTeacherStudentHistoryTaskArray
{
    return self.teacherOperation.studentHistoryTaskArray;
}

- (NSDictionary *)getTeacherStudentHistoryTaskInfo
{
    return self.teacherOperation.studentHistoryTaskInfoDic;
}

- (NSDictionary *)getCreateMetarial_madeId
{
    return self.teacherOperation.createMetarial_madeId;
}

- (NSArray *)getTeacherSuitangTAskArray
{
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    for (NSDictionary * infoDic in self.teacherOperation.suitangTaskArray) {
        switch ([[infoDic objectForKey:@"typeId"] intValue]) {
            case 1:
            {
                [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
                [moDic setObject:@(1) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                [moDic setObject:partArray forKey:@"data"];
            }
                break;
            case 2:
            {
                [readDic setObject:@"阅读" forKey:@"typeStr"];
                [readDic setObject:@(2) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                
                [readDic setObject:partArray forKey:@"data"];
            }
                break;
            case 3:
            {
                [recordDic setObject:@"录音" forKey:@"typeStr"];
                [recordDic setObject:@(3) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                
                [recordDic setObject:partArray forKey:@"data"];
            }
                break;
            case 4:
            {
                [createDic setObject:@"创作" forKey:@"typeStr"];
                [createDic setObject:@(4) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                    [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                    [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                    [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                    [mInfo setObject:@(4) forKey:@"type"];
                    [partArray addObject:mInfo];
                }
                
                [createDic setObject:partArray forKey:@"data"];
            }
                break;
            case 5:
            {
                [videoDic setObject:@"视频" forKey:@"typeStr"];
                [videoDic setObject:@(5) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                    [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                    [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                    [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                    [mInfo setObject:@(5) forKey:@"type"];
                    [partArray addObject:mInfo];
                }
                [videoDic setObject:partArray forKey:@"data"];
            }
                break;
                
            default:
                break;
        }
    }
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if ([[moDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:moDic];
    }
    if ([[readDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:readDic];
    }
    if ([[recordDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:recordDic];
    }
    if ([[createDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:createDic];
    }
    if ([[videoDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:videoDic];
    }
    
    return dataArray;
}

- (NSMutableArray *)getPartaArray:(NSArray *)array
{
    NSMutableArray * partArray = [NSMutableArray array];
    for (NSDictionary * partInfo in array) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kpartImg];
        
        NSMutableArray * audioArray = [NSMutableArray array];
        for (NSString * audioUrl in [partInfo objectForKey:@"mp3List"]) {
            NSDictionary * audioInfo = @{@"mp3Url":audioUrl};
            [audioArray addObject:audioInfo];
        }
        [mInfo setObject:audioArray forKey:@"partMp3List"];
        
        [mInfo setObject:@(1) forKey:@"type"];
        [partArray addObject:mInfo];
    }
    
    return partArray;
}

- (NSArray *)getTeacherXilieTaskArray
{
    NSMutableArray * dayArray = [NSMutableArray array];
    for (NSDictionary * dayInfoDic in self.teacherOperation.xilieTaskArray) {
        NSArray * xilieArray = [dayInfoDic objectForKey:@"typeList"];
        
        NSMutableDictionary * typeInfoDic = [NSMutableDictionary dictionary];
        [typeInfoDic setObject:[dayInfoDic objectForKey:@"dayNum"] forKey:@"dayNum"];
        
        NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
        NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
        NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
        NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
        NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
        for (NSDictionary * infoDic in xilieArray) {
            switch ([[infoDic objectForKey:@"typeId"] intValue]) {
                case 1:
                {
                    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
                    [moDic setObject:@(1) forKey:@"type"];
                    NSMutableArray * partArray = [NSMutableArray array];
                    for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kpartImg];
                        
                        NSMutableArray * audioArray = [NSMutableArray array];
                        for (NSString * audioUrl in [partInfo objectForKey:@"mp3List"]) {
                            NSDictionary * audioInfo = @{@"mp3Url":audioUrl};
                            [audioArray addObject:audioInfo];
                        }
                        [mInfo setObject:audioArray forKey:@"partMp3List"];
                        
                        [mInfo setObject:@(1) forKey:@"type"];
                        [partArray addObject:mInfo];
                    }
                    
                    [moDic setObject:partArray forKey:@"data"];
                }
                    break;
                case 2:
                {
                    [readDic setObject:@"阅读" forKey:@"typeStr"];
                    [readDic setObject:@(2) forKey:@"type"];
                    NSMutableArray * partArray = [NSMutableArray array];
                    for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kpartImg];
                        
                        NSMutableArray * audioArray = [NSMutableArray array];
                        for (NSString * audioUrl in [partInfo objectForKey:@"mp3List"]) {
                            NSDictionary * audioInfo = @{@"mp3Url":audioUrl};
                            [audioArray addObject:audioInfo];
                        }
                        [mInfo setObject:audioArray forKey:@"partMp3List"];
                        
                        [mInfo setObject:@(2) forKey:@"type"];
                        [partArray addObject:mInfo];
                    }
                    
                    [readDic setObject:partArray forKey:@"data"];
                }
                    break;
                case 3:
                {
                    [recordDic setObject:@"录音" forKey:@"typeStr"];
                    [recordDic setObject:@(3) forKey:@"type"];
                    NSMutableArray * partArray = [NSMutableArray array];
                    for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kpartImg];
                        
                        NSMutableArray * audioArray = [NSMutableArray array];
                        for (NSString * audioUrl in [partInfo objectForKey:@"mp3List"]) {
                            NSDictionary * audioInfo = @{@"mp3Url":audioUrl};
                            [audioArray addObject:audioInfo];
                        }
                        [mInfo setObject:audioArray forKey:@"partMp3List"];
                        
                        [mInfo setObject:@(3) forKey:@"type"];
                        [partArray addObject:mInfo];
                    }
                    
                    [recordDic setObject:partArray forKey:@"data"];
                }
                    break;
                case 4:
                {
                    [createDic setObject:@"创作" forKey:@"typeStr"];
                    [createDic setObject:@(4) forKey:@"type"];
                    NSMutableArray * partArray = [NSMutableArray array];
                    for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                        [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                        [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                        [mInfo setObject:@(4) forKey:@"type"];
                        [partArray addObject:mInfo];
                    }
                    
                    [createDic setObject:partArray forKey:@"data"];
                }
                    break;
                case 5:
                {
                    [videoDic setObject:@"视频" forKey:@"typeStr"];
                    [videoDic setObject:@(5) forKey:@"type"];
                    NSMutableArray * partArray = [NSMutableArray array];
                    for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                        [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                        [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                        [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                        [mInfo setObject:@(5) forKey:@"type"];
                        [partArray addObject:mInfo];
                    }
                    [videoDic setObject:partArray forKey:@"data"];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        NSMutableArray * dataArray = [NSMutableArray array];
        if ([[moDic objectForKey:@"data"] count] > 0) {
            [dataArray addObject:moDic];
        }
        if ([[readDic objectForKey:@"data"] count] > 0) {
            [dataArray addObject:readDic];
        }
        if ([[recordDic objectForKey:@"data"] count] > 0) {
            [dataArray addObject:recordDic];
        }
        if ([[createDic objectForKey:@"data"] count] > 0) {
            [dataArray addObject:createDic];
        }
        if ([[videoDic objectForKey:@"data"] count] > 0) {
            [dataArray addObject:videoDic];
        }
        
        [typeInfoDic setObject:dataArray forKey:@"dataArray"];
        [dayArray addObject:typeInfoDic];
    }
    
    return dayArray;
}

- (NSDictionary *)getStudentAddressInfo
{
    return self.teacherOperation.studentAddressInfoDic;
}

- (NSArray *)getTeacher_CommentModulArray
{
    return self.teacherOperation.commentModulList;
}
- (NSArray *)getTeacher_TodayClassroomTaskArray
{
    NSMutableArray * moArray = [NSMutableArray array];
    NSMutableArray * readArray = [NSMutableArray array];
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    NSMutableArray * videoArray = [NSMutableArray array];
    
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary * infoDic in self.teacherOperation.teacher_TodayClassroomTaskList) {
        switch ([[infoDic objectForKey:@"type"] intValue]) {
            case 1:
            {
                [moArray addObject:infoDic];
            }
                break;
            case 2:
            {
                [readArray addObject:infoDic];
            }
                break;
            case 3:
            {
                [recordArray addObject:infoDic];
            }
                break;
            case 4:
            {
                [createArray addObject:infoDic];
            }
                break;
            case 5:
            {
                [videoArray addObject:infoDic];
            }
                break;
                
            default:
                break;
        }
    }
    
    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
    [moDic setObject:@(1) forKey:@"type"];
    [moDic setObject:moArray forKey:@"data"];
    
    [readDic setObject:@"阅读" forKey:@"typeStr"];
    [readDic setObject:@(2) forKey:@"type"];
    [readDic setObject:readArray forKey:@"data"];
    
    [recordDic setObject:@"录音" forKey:@"typeStr"];
    [recordDic setObject:@(3) forKey:@"type"];
    [recordDic setObject:recordArray forKey:@"data"];
    
    [createDic setObject:@"创作" forKey:@"typeStr"];
    [createDic setObject:@(4) forKey:@"type"];
    [createDic setObject:createArray forKey:@"data"];
    
    [videoDic setObject:@"视频" forKey:@"typeStr"];
    [videoDic setObject:@(5) forKey:@"type"];
    [videoDic setObject:videoArray forKey:@"data"];
    
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (moArray.count > 0) {
        [dataArray addObject:moDic];
    }
    if (readArray.count > 0) {
        [dataArray addObject:readDic];
    }
    if (recordArray.count > 0) {
        [dataArray addObject:recordDic];
    }
    if (createArray.count > 0) {
        [dataArray addObject:createDic];
    }
    if (videoArray.count > 0) {
        [dataArray addObject:videoDic];
    }
    
    return dataArray;
}
- (NSArray *)getTeacher_classroomAttendanceArray
{
    return self.teacherOperation.classroomAttendanceList;
}
- (NSMutableArray *)getIsHaveNewMessageInfoDic
{
    return self.teacherOperation.isHaveNewMessageInfoDic;
}

- (NSArray *)getEditXilieTaskDetailArray
{
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    for (NSDictionary * infoDic in self.teacherOperation.suitangTaskArray) {
        switch ([[infoDic objectForKey:@"typeId"] intValue]) {
            case 1:
            {
                [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
                [moDic setObject:@(1) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                [moDic setObject:partArray forKey:@"data"];
            }
                break;
            case 2:
            {
                [readDic setObject:@"阅读" forKey:@"typeStr"];
                [readDic setObject:@(2) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                
                [readDic setObject:partArray forKey:@"data"];
            }
                break;
            case 3:
            {
                [recordDic setObject:@"录音" forKey:@"typeStr"];
                [recordDic setObject:@(3) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                partArray = [self getPartaArray:[infoDic objectForKey:@"partList"]];
                
                [recordDic setObject:partArray forKey:@"data"];
            }
                break;
            case 4:
            {
                [createDic setObject:@"创作" forKey:@"typeStr"];
                [createDic setObject:@(4) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                    [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                    [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                    [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                    [mInfo setObject:@(4) forKey:@"type"];
                    [partArray addObject:mInfo];
                }
                
                [createDic setObject:partArray forKey:@"data"];
            }
                break;
            case 5:
            {
                [videoDic setObject:@"视频" forKey:@"typeStr"];
                [videoDic setObject:@(5) forKey:@"type"];
                
                NSMutableArray * partArray = [NSMutableArray array];
                for (NSDictionary * partInfo in [infoDic objectForKey:@"partList"]) {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:partInfo];
                    [mInfo setObject:[partInfo objectForKey:@"partIcon"] forKey:kmadeImg];
                    [mInfo setObject:[partInfo objectForKey:@"partName"] forKey:kmadeName];
                    [mInfo setObject:[partInfo objectForKey:@"partId"] forKey:kmadeId];
                    [mInfo setObject:@(5) forKey:@"type"];
                    [partArray addObject:mInfo];
                }
                [videoDic setObject:partArray forKey:@"data"];
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if ([[moDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:moDic];
    }
    if ([[readDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:readDic];
    }
    if ([[recordDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:recordDic];
    }
    if ([[createDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:createDic];
    }
    if ([[videoDic objectForKey:@"data"] count] > 0) {
        [dataArray addObject:videoDic];
    }
    
    return dataArray;
}

@end
