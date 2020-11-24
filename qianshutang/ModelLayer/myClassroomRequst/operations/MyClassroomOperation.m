//
//  MyClassroomOperation.m
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyClassroomOperation.h"

@interface MyClassroomOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_MyClassroomProtocol> notifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyFriendList> MyFriendListnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyFriendAchievementList> MyFriendAchievementListnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_AddMyFriend> AddMyFriendnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_DeleteMyFriend> DeleteMyFriendnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyFriendInformation> MyFriendInformationnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyFriendProductList> MyFriendProductListnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyFriendProductDetail> MyFriendProductDetailnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyRecordProductDetail> MyRecordProductDetailnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_MyGroupList> MyGroupListnotifiedObject;

@property (nonatomic,weak) id<MyClassroom_classMember> classMembernotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classTaskHaveComplate> classTaskHaveComplatenotifiedObject;

@property (nonatomic,weak) id<MyClassroom_classMemberAchievementList> classMemberAchievementListnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classTaskList> classTaskListnotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classMemberComplateTaskInfo> classMemberComplateTaskInfonotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classTextbook> classTextbooknotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classCourseWare> classCourseWarenotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classCourse> classCoursenotifiedObject;
@property (nonatomic,weak) id<MyClassroom_classMemberInformation> classMemberInformationnotifiedObject;

@end

@implementation MyClassroomOperation

- (void)didRequestMyClassroomWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MyClassroomProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustmyClassroomWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestMyFriendListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendList>)object
{
    self.MyFriendListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyFriendListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyFriendAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendAchievementList>)object
{
    self.MyFriendAchievementListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyFriendAchievementListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestAddMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_AddMyFriend>)object
{
    self.AddMyFriendnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustAddFriendWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestDeleteMyFriendWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_DeleteMyFriend>)object
{
    self.DeleteMyFriendnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustDeleteFriendWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyFriendInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendInformation>)object
{
    self.MyFriendInformationnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyFriendInformationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyFriendProductListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductList>)object
{
    self.MyFriendProductListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyFriendProductListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyFriendProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyFriendProductDetail>)object
{
    self.MyFriendProductDetailnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyFriendProductDetailWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyRecordProductDetailWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyRecordProductDetail>)object
{
    self.MyRecordProductDetailnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyRecordProductDetailWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestMyGroupListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_MyGroupList>)object
{
    self.MyGroupListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyGroupListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestClassMemberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMember>)object
{
    self.classMembernotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassMemberWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassTaskHaveComplateWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskHaveComplate>)object
{
    self.classTaskHaveComplatenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassTaskHaveComplateWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassMemberInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberInformation>)object
{
    self.classMemberInformationnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassMemberInformationWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - classroom

- (void)didRequestClassMemberAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberAchievementList>)object
{
    self.classMemberAchievementListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassMemberAchievementListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskList>)object
{
    self.classTaskListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassTaskListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassMemberComplateTaskInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberComplateTaskInfo>)object
{
    self.classMemberComplateTaskInfonotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassMemberComplateTaskInfoWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassTextbookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTextbook>)object
{
    self.classTextbooknotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassTextbookWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassCourseWareWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourseWare>)object
{
    self.classCourseWarenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassCourseWareWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestClassCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourse>)object
{
    self.classCoursenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustClassCourseWithDic:infoDic andProcessDelegate:self];
}


- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 5:
            self.infoDic = [successInfo objectForKey:@"classroomData"];
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestMyClassroomSuccessed];
            }
            break;
        case 43:
        {
            self.myFriendArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyFriendListnotifiedObject)) {
                [self.MyFriendListnotifiedObject didRequestMyFriendListSuccessed];
            }
        }
            break;
        case 44:
        {
            self.mryFriendAchievementArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyFriendAchievementListnotifiedObject)) {
                [self.MyFriendAchievementListnotifiedObject didRequestMyFriendAchievementListSuccessed];
            }
        }
            break;
        case 45:
        {
            if (isObjectNotNil(self.AddMyFriendnotifiedObject)) {
                [self.AddMyFriendnotifiedObject didRequestAddMyFriendSuccessed];
            }
        }
            break;
        case 46:
        {
            if (isObjectNotNil(self.DeleteMyFriendnotifiedObject)) {
                [self.DeleteMyFriendnotifiedObject didRequestDeleteMyFriendSuccessed];
            }
        }
            break;
        case 47:
        {
            self.myFriendInfrmation = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyFriendInformationnotifiedObject)) {
                [self.MyFriendInformationnotifiedObject didRequestMyFriendInformationSuccessed];
            }
        }
            break;
        case 48:
        {
            self.myFriendProductArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyFriendProductListnotifiedObject)) {
                [self.MyFriendProductListnotifiedObject didRequestMyFriendProductListSuccessed];
            }
        }
            break;
        case 91:
        {
            self.myFriendProductDetailInfoDic = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyFriendProductDetailnotifiedObject)) {
                [self.MyFriendProductDetailnotifiedObject didRequestMyFriendProductDetailSuccessed];
            }
        }
            break;
        case 50:
        {
            self.myGroupArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyGroupListnotifiedObject)) {
                [self.MyGroupListnotifiedObject didRequestMyGroupListSuccessed];
            }
        }
            break;
        case 60:
        {
            self.classMemberAchievementArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classMemberAchievementListnotifiedObject)) {
                [self.classMemberAchievementListnotifiedObject didRequestclassMemberAchievementListSuccessed];
            }
        }
            break;
        case 61:
        {
            self.classTaskArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classTaskListnotifiedObject)) {
                [self.classTaskListnotifiedObject didRequestclassTaskListSuccessed];
            }
        }
            break;
        case 62:
        {
            self.classMemberComplateTaskInfoArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classMemberComplateTaskInfonotifiedObject)) {
                [self.classMemberComplateTaskInfonotifiedObject didRequestclassMemberComplateTaskInfoSuccessed];
            }
        }
            break;
        case 63:
        {
            self.classTextbookArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classTextbooknotifiedObject)) {
                [self.classTextbooknotifiedObject didRequestclassTextbookSuccessed];
            }
        }
            break;
        case 64:
        {
            self.classCourseWareArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classCourseWarenotifiedObject)) {
                [self.classCourseWarenotifiedObject didRequestclassCourseWareSuccessed];
            }
        }
            break;
        case 65:
        {
            self.classCourseArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classCoursenotifiedObject)) {
                [self.classCoursenotifiedObject didRequestclassCourseSuccessed];
            }
        }
            break;
        case 82:
        {
            self.classMemberList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classMembernotifiedObject)) {
                [self.classMembernotifiedObject didRequestclassMemberSuccessed];
            }
        }
            break;
        case 83:
        {
            self.classTaskHaceComplateArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classTaskHaveComplatenotifiedObject)) {
                [self.classTaskHaveComplatenotifiedObject didRequestclassTaskHaveComplateSuccessed];
            }
        }
            break;
        case 89:
        {
            self.myRecordProductDetailInfoDic = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyRecordProductDetailnotifiedObject)) {
                [self.MyRecordProductDetailnotifiedObject didRequestMyRecordProductDetailSuccessed];
            }
        }
            break;
        case 92:
        {
            self.memberInfoDic = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.classMemberInformationnotifiedObject)) {
                [self.classMemberInformationnotifiedObject didRequestclassMemberInformationSuccessed];
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
        case 5:
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestMyClassroomFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
        case 43:
        {
            if (isObjectNotNil(self.MyFriendListnotifiedObject)) {
                [self.MyFriendListnotifiedObject didRequestMyFriendListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 44:
        {
            if (isObjectNotNil(self.MyFriendAchievementListnotifiedObject)) {
                [self.MyFriendAchievementListnotifiedObject didRequestMyFriendAchievementListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 45:
        {
            if (isObjectNotNil(self.AddMyFriendnotifiedObject)) {
                [self.AddMyFriendnotifiedObject didRequestAddMyFriendFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 46:
        {
            if (isObjectNotNil(self.DeleteMyFriendnotifiedObject)) {
                [self.DeleteMyFriendnotifiedObject didRequestDeleteMyFriendFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 47:
        {
            if (isObjectNotNil(self.MyFriendInformationnotifiedObject)) {
                [self.MyFriendInformationnotifiedObject didRequestMyFriendInformationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 48:
        {
            if (isObjectNotNil(self.MyFriendProductListnotifiedObject)) {
                [self.MyFriendProductListnotifiedObject didRequestMyFriendProductListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 91:
        {
            if (isObjectNotNil(self.MyFriendProductDetailnotifiedObject)) {
                [self.MyFriendProductDetailnotifiedObject didRequestMyFriendProductDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 50:
        {
            if (isObjectNotNil(self.MyGroupListnotifiedObject)) {
                [self.MyGroupListnotifiedObject didRequestMyGroupListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 60:
        {
            if (isObjectNotNil(self.classMemberAchievementListnotifiedObject)) {
                [self.classMemberAchievementListnotifiedObject didRequestclassMemberAchievementListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 61:
        {
            if (isObjectNotNil(self.classTaskListnotifiedObject)) {
                [self.classTaskListnotifiedObject didRequestclassTaskListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 62:
        {
            if (isObjectNotNil(self.classMemberComplateTaskInfonotifiedObject)) {
                [self.classMemberComplateTaskInfonotifiedObject didRequestclassMemberComplateTaskInfoFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 63:
        {
            if (isObjectNotNil(self.classTextbooknotifiedObject)) {
                [self.classTextbooknotifiedObject didRequestclassTextbookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 64:
        {
            if (isObjectNotNil(self.classCourseWarenotifiedObject)) {
                [self.classCourseWarenotifiedObject didRequestclassCourseWareFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 65:
        {
            if (isObjectNotNil(self.classCoursenotifiedObject)) {
                [self.classCoursenotifiedObject didRequestclassCourseFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 82:
        {
            if (isObjectNotNil(self.classMembernotifiedObject)) {
                [self.classMembernotifiedObject didRequestclassMemberFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 83:
        {
            if (isObjectNotNil(self.classTaskHaveComplatenotifiedObject)) {
                [self.classTaskHaveComplatenotifiedObject didRequestclassTaskHaveComplateFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 89:
        {
            if (isObjectNotNil(self.MyRecordProductDetailnotifiedObject)) {
                [self.MyRecordProductDetailnotifiedObject didRequestMyRecordProductDetailFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 92:
        {
            if (isObjectNotNil(self.classMemberInformationnotifiedObject)) {
                [self.classMemberInformationnotifiedObject didRequestclassMemberInformationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        default:
            break;
    }
    
}

@end
