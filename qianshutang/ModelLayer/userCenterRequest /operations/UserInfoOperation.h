//
//  UserInfoOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoOperation : NSObject

- (void)didRequestChangeIconImageWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_changeIconImage>)object;
- (void)didRequestChangeNickNameWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeNickName>)object;
- (void)didRequestChangePhoneNumberWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object;
- (void)didRequestChangeGenderWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeGender>)object;
- (void)didRequestChangeBirthdayWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeBirthday>)object;
- (void)didRequestChangeReceiveAddressWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_ChangeReceiveAddress>)object;
- (void)didRequestNotificationNoDisturbWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_NotificationNoDisturbConfig>)object;
- (void)didRequestlogoutWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_Logout>)object;

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



@property (nonatomic, strong)NSArray  * myCollectionTextbookArray;
@property (nonatomic, strong)NSArray * searchCollectionTextbookArray;
@property (nonatomic, strong)NSArray * myBookmarkArray;
@property (nonatomic, strong)NSArray * myHeadQuestionArray;
@property (nonatomic, strong)NSArray * myQuestionArray;
@property (nonatomic, strong)NSArray * myQuestionDetailArray;

@end
