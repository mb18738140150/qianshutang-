//
//  MyClassroomOperation.h
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClassroomOperation : NSObject

@property (nonatomic, strong)NSArray * infoDic;

@property (nonatomic, strong)NSArray * myFriendArray;
@property (nonatomic, strong)NSArray * mryFriendAchievementArray;
@property (nonatomic, strong)NSDictionary * myFriendInfrmation;
@property (nonatomic, strong)NSArray * myFriendProductArray;
@property (nonatomic, strong)NSDictionary * myFriendProductDetailInfoDic;
@property (nonatomic, strong)NSDictionary * myRecordProductDetailInfoDic;
@property (nonatomic, strong)NSArray * myGroupArray;
@property (nonatomic, strong)NSArray * classMemberList;
@property (nonatomic, strong)NSArray * classTaskHaceComplateArray;
@property (nonatomic, strong)NSDictionary * memberInfoDic;

- (void)didRequestMyClassroomWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MyClassroomProtocol>)object;

#pragma mark - friend
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
- (void)didRequestClassMemberInformationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberInformation>)object;


#pragma mark - classroom

@property (nonatomic, strong)NSArray * classMemberAchievementArray;
@property (nonatomic, strong)NSArray * classTaskArray;
@property (nonatomic, strong)NSArray * classMemberComplateTaskInfoArray;
@property (nonatomic, strong)NSArray * classTextbookArray;
@property (nonatomic, strong)NSArray * classCourseWareArray;
@property (nonatomic, strong)NSArray * classCourseArray;

- (void)didRequestClassMemberAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberAchievementList>)object;
- (void)didRequestClassTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTaskList>)object;
- (void)didRequestClassMemberComplateTaskInfoWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classMemberComplateTaskInfo>)object;
- (void)didRequestClassTextbookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classTextbook>)object;
- (void)didRequestClassCourseWareWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourseWare>)object;
- (void)didRequestClassCourseWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyClassroom_classCourse>)object;

@end
