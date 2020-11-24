//
//  HttpConfigCreator.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "HttpConfigCreator.h"
#import "NSString+MD5.h"
#import "NSDictionary+JsonString.h"
#import "NetMacro.h"
#import "UserManager.h"
#import "CommonMacro.h"
#import "DateUtility.h"

@implementation HttpConfigCreator
+ (HttpConfigModel *)getLoginHttpConfigWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    HttpConfigModel *loginHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandLogin,
                          @"LoginName":userName,
                          @"LoginPwd":password};
    [self setConfigModel:loginHttp withInfo:dic];
    return loginHttp;
}

+ (HttpConfigModel *)bindPhoneNumber:(NSDictionary *)infoDic
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandBindPhone,
                          @"phone":[infoDic objectForKey:@"phone"],
                          @"code":[infoDic objectForKey:@"code"],
                          @"md5Code":[infoDic objectForKey:@"md5Code"]
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)completeUserInfo:(NSDictionary *)userInfo
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandcompleteUserInfo,
                          @"iconStr":[userInfo objectForKey:@"iconStr"],
                          @"nickName":[userInfo objectForKey:@"nickName"],
                          @"qqAccount":[userInfo objectForKey:@"qqAccount"],
                          @"phoneNumber":[userInfo objectForKey:@"phoneNumber"]
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)registWith:(NSDictionary *)infoDic
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandRegist,
                          @"phone":[infoDic objectForKey:@"phone"],
                          @"password":[infoDic objectForKey:@"password"]
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)forgetPasswordWith:(NSDictionary *)infoDic
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandForgetPassword,
                          @"phoneNumber":[infoDic objectForKey:@"phoneNumber"],
                          @"password":[infoDic objectForKey:@"password"],
                          @"accountNumber":[infoDic objectForKey:@"accountNumber"]
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}
+ (HttpConfigModel *)getVerifyAccount:(NSString *)accountNumber
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandVerifyAccount,
                          @"accountNumber":accountNumber
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}
+ (HttpConfigModel *)getVerifyCode:(NSString *)phoneNumber
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandVerifyCode,
                          @"phone":phoneNumber
                          };
    [self setConfigModel:c withInfo:dic];
    return c;
}
+ (HttpConfigModel *)getBindJPushWithCId:(NSString *)CID
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandBindJPush,
                          @"device":@(1),
                          @"CID":CID};
    [self setConfigModel:c withInfo:dic];
    return c;
}
+ (HttpConfigModel *)getAppVersionInfoConfig
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandVersionInfo,
                          @"type":@(2)};
    [self setConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getResetPwdConfigWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandResetPwd,
                          @"newPassword":newPwd,
                          @"oldPassword":oldPwd};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyClassroomConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyClassroom};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - classroom and Friend
+ (HttpConfigModel *)getMyFriendConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyFriend};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyFriendAchievementListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyFriendAchievementList,
                          @"type":[infoDic objectForKey:@"type"],
                          @"time":[infoDic objectForKey:kTime]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getAddFriendConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAddFriend,
                          kFriendName:[infoDic objectForKey:kFriendName]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getDeleteFriendConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteFriend,
                          kFriendId:[infoDic objectForKey:kFriendId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyFriendInformationConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyFriendInformation,
                          kFriendId:[infoDic objectForKey:kFriendId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyFriendProductListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyFriendProductList,
                          kFriendId:[infoDic objectForKey:kFriendId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyFriendProductDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyFriendProductDetail,
                          kProductId:[infoDic objectForKey:kProductId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyRecordProductDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyRecordProductDetail,
                          kProductId:[infoDic objectForKey:kProductId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyGroupListConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyGroupList
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getClassMemberAchievementListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassMemberAchievementList,
                          kClassroomId:[infoDic objectForKey:kClassroomId],
                          @"type":[infoDic objectForKey:@"type"],
                          @"timeType":[infoDic objectForKey:@"timeType"],
                          @"timeFormat":[infoDic objectForKey:@"timeFormat"],
                          @"beginTime":[infoDic objectForKey:@"beginTime"],
                          @"endTime":[infoDic objectForKey:@"endTime"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClassTaskListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassTaskList,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClassMemberComplateTaskInfoConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassMemberComplateTaskInfo,
                          @"worklogId":[infoDic objectForKey:kWorkLogId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClassTextbookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassTextbook,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClassCourseWareConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassCourseWare,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClassCourseConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassCourse,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getClassMemberConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassMember,
                          kClassroomId:[infoDic objectForKey:kClassroomId],
                          kUserName:[infoDic objectForKey:kUserName]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getClassMemberInformationConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassMemberInformation,
                          @"memberId":[infoDic objectForKey:@"memberId"],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getClassTaskHaveComplateConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClassTaskHaveComplate,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

/*
 
 */

#pragma mark - task
+ (HttpConfigModel *)getUploadWholeRecordProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandUploadWholeRecordProduct,
                          kProductId:[infoDic objectForKey:kProductId],
                          kpartId:[infoDic objectForKey:kpartId],
                          @"userWorkId":[infoDic objectForKey:@"userWorkId"],
                          @"recordUrl":[infoDic objectForKey:@"recordUrl"],
                          @"pageList":[infoDic objectForKey:@"pageList"],
                          @"pointList":[infoDic objectForKey:@"pointList"],
                          @"second":[infoDic objectForKey:@"second"],
                          @"bookId":[infoDic objectForKey:kitemId],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getUploadPagingRecordProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandUploadWholeRecordProduct,
                          kProductId:[infoDic objectForKey:kProductId],
                          kpartId:[infoDic objectForKey:kpartId],
                          @"userWorkId":[infoDic objectForKey:@"userWorkId"],
                          @"recordUrl":[infoDic objectForKey:@"recordUrl"],
                          @"pageList":[infoDic objectForKey:@"pageList"],
                          @"pointList":[infoDic objectForKey:@"pointList"],
                          @"second":[infoDic objectForKey:@"second"],
                          @"bookId":[infoDic objectForKey:kitemId],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getAgainUploadWholeRecordProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAgainUploadWholeRecordProduct,
                          kProductId:[infoDic objectForKey:kProductId],
                          @"recordUrl":[infoDic objectForKey:@"recordUrl"],
                          @"pageList":[infoDic objectForKey:@"pageList"],
                          @"pointList":[infoDic objectForKey:@"pointList"],
                          @"fileSecond":[infoDic objectForKey:@"second"],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getReadTextConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandReadText,
                          kpartId:[infoDic objectForKey:kpartId],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getSubmitMoerduoAndReadTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSubmitMoerduoAndReadTask,
                          kuserWorkId:[infoDic objectForKey:kuserWorkId],
                          @"bookId":[infoDic objectForKey:kitemId],
                          kpartId:[infoDic objectForKey:kpartId],
                          @"type":[infoDic objectForKey:@"type"],
                          @"second":[infoDic objectForKey:@"second"],
                          @"isEnd":[infoDic objectForKey:@"isEnd"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getSubmitCreateProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSubmitCreateProduct,
                          @"type":[infoDic objectForKey:@"type"],
                          kProductName:[infoDic objectForKey:kProductName],
                          kProductIcon:[infoDic objectForKey:kProductIcon],
                          kuserWorkId:[infoDic objectForKey:kuserWorkId],
                          kProductId:[infoDic objectForKey:kProductId],
                          @"fileList":[infoDic objectForKey:@"fileList"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getCreateTaskProblemContentConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCreateTaskProblemContent,
                          kmadeId:[infoDic objectForKey:kmadeId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

/*
 kCommandUploadWholeRecordProduct
 kCommandUploadPagingRecordProduct
 kCommandReadText
 kCommandSubmitMoerduoAndReadTask
 kCommandSubmitCreateProduct
 */

#pragma mark - pruductShow
+ (HttpConfigModel *)getProductShowListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandProductShowList,
                          @"gradeId":[infoDic objectForKey:kClassroomId],
                          @"selType":[infoDic objectForKey:@"selType"],
                          @"memberType":[infoDic objectForKey:@"memberType"],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getDeleteProductShowMyProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteProductShowMyProduct,
                          kProductId:[infoDic objectForKey:kProductId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - ActiveStudy
+ (HttpConfigModel *)getReadListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandReadList,
                          kcategoryId:@0,
                          kitemName:@""
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getSearchReadListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandReadList,
                          kcategoryId:[infoDic objectForKey:kcategoryId],
                          kitemName:[infoDic objectForKey:kitemName]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getCollectTextBookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCollectTextBook,
                          kitemId:[infoDic objectForKey:kitemId],
                          kitemType:[infoDic objectForKey:kitemType]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTextBookContentListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTextBookContentList,
                          kTextBookId:[infoDic objectForKey:kTextBookId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTextContentConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTextContent,
                          kpartId:[infoDic objectForKey:kpartId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - userData
+ (HttpConfigModel *)getMyCollectionTextBookConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSearchMyCollectionTextBook,
                          kTextBookName:@""
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getSearchMyCollectionTextBookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSearchMyCollectionTextBook,
                          kTextBookName:[infoDic objectForKey:kTextBookName]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getDeleteMyCollectionTextBookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteMyCollectionTextBook,
                          @"collectId":[infoDic objectForKey:kTextBookId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyBookmarkListConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyBookmarkList
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getDeleteMyBookmarkConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteMyBookmark,
                          kBookmarkId:[infoDic objectForKey:kBookmarkId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getClearnMyBookmarkListConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandClearnMyBookmarkList
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyHeadQuestionListConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyHeadQuestionList,
                          @"userType":@([[UserManager sharedManager] getUserType])
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyQuestionListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyQuestionList,
                          kHeadQuestionId:[infoDic objectForKey:kHeadQuestionId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyQuestionDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyQuestionDetail,
                          kQuestionId:[infoDic objectForKey:kQuestionId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getSetHaveReadQuestionConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSetHaveReadQuestion,
                          kHeadQuestionId:[infoDic objectForKey:kHeadQuestionId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

/*
 
 */


#pragma mark - 积分
+ (HttpConfigModel *)getMyIntegralConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyIntegral};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyIntegralRecordConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyIntegralRecord,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getPrizeListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandPrizeList,
                          @"type":[infoDic objectForKey:@"type"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)convertPrizeConfigWith:(NSDictionary *)infoDic;
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandConvertPrize,
                          @"prizeId":[infoDic objectForKey:kPrizeId],
                          @"deliveryState":@0
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)convertPrizeRecordConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandConvertPrizeRecord,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)cancelConvertPrizeConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCancelConvertPrize,
                          kLogId:[infoDic objectForKey:kLogId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)complateConvertPrizeListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandComplateConvertPrize,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)teacher_memberIntegralListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_memberIntegralList};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)teacher_haveSendIntegralListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_haveSendIntegral};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)teacher_createConvertPrizeRecordListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_createConvertPrizeRecord,
                          kmemberId:[infoDic objectForKey:kmemberId],
                          kPrizeId:[infoDic objectForKey:kPrizeId],
                          @"doType":[infoDic objectForKey:@"doType"],
                          @"deliveryTime":[infoDic objectForKey:@"deliveryTime"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)teacher_teacherSendGoodsListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_sendGoods,
                          kLogId:[infoDic objectForKey:kLogId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)teacher_teacherGetAddressInfoConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getAddressInfo,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)teacher_teacherCancelConvertPrizeConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_cancelConvertPrize,
                          kLogId:[infoDic objectForKey:kLogId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - 消息中心
+ (HttpConfigModel *)getSchoolNotificationConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSchoolNotification,
                          @"typeName":@"学校通知"
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTaskNotificationConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSchoolNotification,
                          @"typeName":@"作业提醒"
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getFriendRequestNotificationConfig
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandFriendRequest
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getAgreeFriendRequestNotificationConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAgreeFriendRequest,
                          kFriendId:[infoDic objectForKey:kFriendId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getRejectFriendRequestNotificationConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandRejectFriendRequest,
                          kFriendId:[infoDic objectForKey:kFriendId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getOtherMessageNotificationConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandSchoolNotification,
                          @"typeName":@"其他消息"
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - 个人信息设置
+ (HttpConfigModel *)getChangeIconImageConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandChangeIconImage,
                          @"icoImageUrl":[infoDic objectForKey:@"icoImageUrl"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getChangeNickNameConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandChangeNickName,
                          @"nickName":[infoDic objectForKey:@"nickName"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getBindPhoneNumberConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandBindPhoneNumber,
                          @"phoneNumber":[infoDic objectForKey:@"phoneNumber"],
                          @"verifyCode":[infoDic objectForKey:@"verifyCode"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getChangeGenderConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandChangeGender,
                          @"gender":[infoDic objectForKey:@"gender"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getChangeBirthdayConfig:(NSDictionary *)infoDic
{
    //birthday
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandChangeBirthday,
                          @"birthday":[infoDic objectForKey:@"birthday"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getChangeReceiveAddressConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandChangeReceiveAddress,
                          @"receiveAddress":[infoDic objectForKey:kreceiveAddress],
                          @"phoneNumber":[infoDic objectForKey:kreceivePhoneNumber],
                          @"receiveName":[infoDic objectForKey:kreceiveName]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getNotificationNoDisturbConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandNotificationNoDisturb,
                          @"notificationNoDisturb":[infoDic objectForKey:@"notificationNoDisturb"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getLogoutConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandLogout,
                          @"CID":[infoDic objectForKey:@"CID"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyProduct,
                          @"memberId":[infoDic objectForKey:@"memberId"],
                          @"isShare":[infoDic objectForKey:@"isShare"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getDeleteMyProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteMyProduct,
                          @"productId":[infoDic objectForKey:kProductId],
                          @"productType":[infoDic objectForKey:@"productType"],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getShareMyProductConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandShareMyProduct,
                          @"productId":[infoDic objectForKey:kProductId],
                          @"shareType":[infoDic objectForKey:kshareType]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyHeadTaskListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyHeadTaskList,
                          kClassroomId:[infoDic objectForKey:kClassroomId],
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyEveryDayTaskDetailListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyEveryDayTaskDetailList,
                          @"workLogId":[infoDic objectForKey:kWorkLogId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyEveryDayTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyEveryDayTask,
                          @"dayTime":[infoDic objectForKey:kDayTime],
                          @"memberId":[infoDic objectForKey:@"memberId"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyCourseListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyCourseList,
                          kClassroomId:[infoDic objectForKey:kClassroomId],
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyAttendanceListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyAttendanceList,
                          @"chapterId":[infoDic objectForKey:kchapterId],
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyCourseCostConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyCourseCost,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getBuyCourseRecordConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandBuyCourseRecord,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyAchievementListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyAchievementList,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyStudyTimeLengthListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyStudyTimeLengthList,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getMyStudyTimeLengthDetailListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyStudyTimeLengthDetailList,
                          kTime:[infoDic objectForKey:kTime],
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getPunchCardListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandPunchCardList,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getMyCourse_BigCourseListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyCourse_BigCourseList,
                          kTime:[infoDic objectForKey:kTime]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getCurrentWeekCourseListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCurrentWeekCourseList,
                          kTime:[infoDic objectForKey:kTime]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

#pragma mark - teacher
+ (HttpConfigModel *)getTeacher_MyCourseListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_MyCourse,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_sectionListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_sectionList,
                          @"phone":[infoDic objectForKey:@"phone"],
                          kchapterId:[infoDic objectForKey:kchapterId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_sectionAttendanceConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_sectionAttendance,
                          kunitId:[infoDic objectForKey:kunitId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_totalAttendanceConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_totalAttendance,
                          kchapterId:[infoDic objectForKey:kchapterId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_attendanceFormConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_attendanceForm,
                          kLoginName:[infoDic objectForKey:kLoginName],
                          kLoginPwd:[infoDic objectForKey:kLoginPwd]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_addCourseSectionConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_addCourseSection,
                          kchapterId:[infoDic objectForKey:kchapterId],
                          kDayTime:[infoDic objectForKey:kDayTime],
                          kbeginTime:[infoDic objectForKey:kbeginTime],
                          kminite:[infoDic objectForKey:kminite]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_deleteCourseSectionConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteCourseSection,
                          kunitId:[infoDic objectForKey:kunitId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_editCourseSectionConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_editCourseSection,
                          kunitId:[infoDic objectForKey:kunitId],
                          kunitTitle:[infoDic objectForKey:kunitTitle],
                          kunitIntro:[infoDic objectForKey:kunitIntro]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_getTaskMouldConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getTaskMould,
                          ktempType:[infoDic objectForKey:ktempType],
                          kshareType:[infoDic objectForKey:kshareType],
                          @"key":[infoDic objectForKey:@"key"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_createSuiTangTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_createSuiTangTask,
                          kworkId:[infoDic objectForKey:kworkId],
                          @"name":[infoDic objectForKey:@"name"],
                          kRemark:[infoDic objectForKey:kRemark],
                          ktypeList:[infoDic objectForKey:ktypeList]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_createXiLieTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_createXiLieTask,
                          kworkId:[infoDic objectForKey:kworkId],
                          @"name":[infoDic objectForKey:@"name"],
                          kRemark:[infoDic objectForKey:kRemark],
                          ktypeList:[infoDic objectForKey:ktypeList]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_createMetarialConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_createMetarial,
                          @"title":[infoDic objectForKey:@"title"],
                          kcoverImg:[infoDic objectForKey:kcoverImg],
                          ktxtDescribe:[infoDic objectForKey:ktxtDescribe],
                          kmp3Describe:[infoDic objectForKey:kmp3Describe],
                          kimagemp4Describe:[infoDic objectForKey:kimagemp4Describe],
                          kmaterImg:[infoDic objectForKey:kmaterImg],
                          kmadeId:[infoDic objectForKey:kmadeId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_arrangeTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_arrangeTask,
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          kbeginTime:[infoDic objectForKey:kbeginTime],
                          kendTime:[infoDic objectForKey:kendTime],
                          kgradeId:[infoDic objectForKey:kClassroomId],
                          @"title":[infoDic objectForKey:@"title"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_shareTaskMouldToschoolConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_shareTaskMouldToschool,
                          kworkTempId:[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_haveArrangeTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_haveArrangeTask,
                          @"key":[infoDic objectForKey:@"key"],
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_commentTaskListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_commentTaskList,
                          kClassroomId:[infoDic objectForKey:kClassroomId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_commentTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_commentTask,
                          kuserWorkId:[infoDic objectForKey:kuserWorkId],
                          kProductId:[infoDic objectForKey:kProductId],
                          @"txtReview":[infoDic objectForKey:ktextReview],
                          kscore:[infoDic objectForKey:kscore],
                          kmp3Review:[infoDic objectForKey:kmp3Review]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_todayTaskComplateListConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_todayTaskComplateList
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_studentHistoryTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_studentHistoryTask,
                          kmemberId:[infoDic objectForKey:kmemberId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_addClassroomTextBookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_addClassroomTextBook,
                          kgradeId:[infoDic objectForKey:kgradeId],
                          kitemType:[infoDic objectForKey:kitemType],
                          kitemId:[infoDic objectForKey:kitemId],
                          kbookId:[infoDic objectForKey:kbookId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_deleteClassroomTextBookConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteClassroomTextBook,
                          kgradeId:[infoDic objectForKey:kgradeId],
                          kitemType:[infoDic objectForKey:kitemType],
                          kitemId:[infoDic objectForKey:kitemId],
                          kbookId:[infoDic objectForKey:kbookId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_sectionCallRollConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_sectionCallRoll,
                          kLogId:[infoDic objectForKey:kLogId],
                          kState:[infoDic objectForKey:kState],
                          kCost:[infoDic objectForKey:kCost],
                          kintro:[infoDic objectForKey:kintro]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_classroomSignConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_classroomSign,
                          kunitId:[infoDic objectForKey:kunitId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_checkTaskConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_checkTask,
                          kuserWorkId:[infoDic objectForKey:kuserWorkId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_changeModulNameConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_changeModulName,
                          @"name":[infoDic objectForKey:@"name"],
                          kworkTempId:[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_changeMoulRemarkConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_changeModulRemark,
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          kRemark:[infoDic objectForKey:kRemark]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_changeHaveArrangeMoulNameConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_changeHaveArrangeModulName,
                          kWorkLogId:[infoDic objectForKey:kWorkLogId],
                          @"name":[infoDic objectForKey:@"name"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_getSuitangTaskDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getSuitangDetail,
                          kworkTempId:[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_getXilieTaskDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getXilieDetail,
                          kworkTempId:[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}


+ (HttpConfigModel *)getTeacher_getEditXilieModulDetailConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getEditXilieModulDetail,
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_AddSuitangTaskTypeConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_addSuitangModulType,
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          ktypeList:[infoDic objectForKey:ktypeList]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_AddXilieTaskTypeConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_addXilieModulType,
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          ktypeList:[infoDic objectForKey:ktypeList]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_DeleteModulConfig:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteModul,
                          kworkTempType:[infoDic objectForKey:kworkTempType],
                          kworkTempId:[infoDic objectForKey:kworkTempId],
                          kinfoId:[infoDic objectForKey:kinfoId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_changeSuitangModultextbook:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_changeSuitangMudulTextbook,
                          kinfoId:[infoDic objectForKey:kinfoId],
                          kpartId:[infoDic objectForKey:kpartId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_changeSuitangModulRepeatCount:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_changeSuitangMudulrepeatCount,
                          krepeatNum:[infoDic objectForKey:krepeatNum],
                          kinfoId:[infoDic objectForKey:kinfoId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_collectSchoolTaskModul:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_collectSchoolTaskModul,
                          kworkId:[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_CommentModulList:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_CommentModul
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_addTextToCommentModul:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_addTextToCommentModul,
                          @"content":[infoDic objectForKey:@"content"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getGetmainPageCategory:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kGetmainPageCategory
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getIsHaveNewMessage:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kIsHaveNewMessage
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_getTodayClassroomTask:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_getTodayClassroomTask,
                          kClassroomId:[infoDic objectForKey:kClassroomId],
                          kDayTime:[infoDic objectForKey:kDayTime]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_classroomAttendanceList:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_classroomAttendanceList,
                          kchapterId:[infoDic objectForKey:kchapterId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_deleteCommentModul:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteCommentModul,
                          @"id":[infoDic objectForKey:@"id"]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_editHaveSendIntegralRemark:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_editHaveSendIntegralRemark,
                          kLogId:[infoDic objectForKey:kLogId],
                          kRemark:[infoDic objectForKey:kRemark]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_deleteTaskModul:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteTaskModul,
                          @"id":[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_deleteCollectTaskModul:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteCollectTaskModul,
                          @"workId":[infoDic objectForKey:kworkTempId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_editStudentInfo_remark:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_editStudentInfo_remark,
                          kmemberId:[infoDic objectForKey:kmemberId],
                          kRemark:[infoDic objectForKey:kRemark]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getTeacher_deleteHaveArrangeTask :(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_deleteHaveArrangeTask,
                          kLogId:[infoDic objectForKey:kLogId],
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}
+ (HttpConfigModel *)getTeacher_PriseAndflower:(NSDictionary *)infoDic
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kTeacher_PriseAndflower,
                          kflowerNum:[infoDic objectForKey:kflowerNum],
                          kProductId:[infoDic objectForKey:kProductId]
                          };
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}


#pragma mark - utility
+ (void)setConfigModel:(HttpConfigModel *)configModel withInfo:(NSDictionary *)parameters
{
    if ([[UserManager sharedManager] isUserLogin]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [dic setObject:@([[UserManager sharedManager] getUserId]) forKey:@"userId"];
        [dic setObject:@([[UserManager sharedManager] getDepartId]) forKey:kDepartId];
        [dic setObject:@([[UserManager sharedManager] getUserType]) forKey:@"roleId"];
        configModel.parameters = dic;
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [dic setObject:@(0) forKey:@"userId"];
        [dic setObject:@(0) forKey:kDepartId];
        [dic setObject:@(0) forKey:@"roleId"];
        configModel.parameters = dic;
        
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[configModel.parameters jsonString],kMD5String];
    configModel.urlString = [NSString stringWithFormat:@"%@?md5=%@",kRootUrl,[str MD5]];
    int command = [[parameters objectForKey:@"command"] intValue];
    configModel.command = @(command);
}



@end
