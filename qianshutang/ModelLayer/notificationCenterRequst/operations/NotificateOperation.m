//
//  NotificateOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NotificateOperation.h"

@interface NotificateOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<Notification_SchoolNotification>          schoolNotifiedObject;
@property (nonatomic,weak) id<Notification_TaskNotification>          taskNotifiedObject;
@property (nonatomic,weak) id<Notification_FriendRequestNotification>          friendRequestNotifiedObject;
@property (nonatomic,weak) id<Notification_AgreeFriendRequestNotification>          agreeNotifiedObject;
@property (nonatomic,weak) id<Notification_RejectFriendRequestNotification>          rejectNotifiedObject;
@property (nonatomic,weak) id<Notification_OtherMessageNotification>          otherNotifiedObject;

@end

@implementation NotificateOperation

- (void)didRequestSchoolNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_SchoolNotification>)object
{
    self.schoolNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustSchoolNotificationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTaskNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_TaskNotification>)object
{
    self.taskNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTaskNotificationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_FriendRequestNotification>)object
{
    self.friendRequestNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustFriendRequestNotificationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestAgreeFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_AgreeFriendRequestNotification>)object
{
    self.agreeNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustAgreeFriendRequestNotificationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestRejectFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_RejectFriendRequestNotification>)object
{
    self.rejectNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustRejectFriendRequestNotificationWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestOtherMessageNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_OtherMessageNotification>)object
{
    self.otherNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustOtherNotificationWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 13:
        {
            self.schoolNotificationArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.schoolNotifiedObject)) {
                [self.schoolNotifiedObject didRequestSchoolNotificationSuccessed];
            }
        }
            break;
        case 14:
        {
            self.taskNotificationArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.taskNotifiedObject)) {
                [self.taskNotifiedObject didRequestTaskNotificationSuccessed];
            }
        }
            break;
        case 15:
        {
            self.friendRequestNotificationArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.friendRequestNotifiedObject)) {
                [self.friendRequestNotifiedObject didRequestFriendRequestNotificationSuccessed];
            }
        }
            break;
        case 16:
        {
            if (isObjectNotNil(self.agreeNotifiedObject)) {
                [self.agreeNotifiedObject didRequestAgreeFriendRequestNotificationSuccessed];
            }
        }
            break;
        case 17:
        {
            if (isObjectNotNil(self.rejectNotifiedObject)) {
                [self.rejectNotifiedObject didRequestRejectFriendRequestNotificationSuccessed];
            }
        }
            break;
        case 18:
        {
            self.otherMessageNotificationArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.otherNotifiedObject)) {
                [self.otherNotifiedObject didRequestOtherMessageNotificationSuccessed];
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
        case 13:
        {
            if (isObjectNotNil(self.schoolNotifiedObject)) {
                [self.schoolNotifiedObject didRequestSchoolNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 14:
        {
            if (isObjectNotNil(self.taskNotifiedObject)) {
                [self.taskNotifiedObject didRequestTaskNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 15:
        {
            if (isObjectNotNil(self.friendRequestNotifiedObject)) {
                [self.friendRequestNotifiedObject didRequestFriendRequestNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 16:
        {
            if (isObjectNotNil(self.agreeNotifiedObject)) {
                [self.agreeNotifiedObject didRequestAgreeFriendRequestNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 17:
        {
            if (isObjectNotNil(self.rejectNotifiedObject)) {
                [self.rejectNotifiedObject didRequestRejectFriendRequestNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 18:
        {
            if (isObjectNotNil(self.otherNotifiedObject)) {
                [self.otherNotifiedObject didRequestOtherMessageNotificationFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
