//
//  NotificateOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificateOperation : NSObject

@property (nonatomic, strong)NSArray * schoolNotificationArray;
@property (nonatomic, strong)NSArray * taskNotificationArray;
@property (nonatomic, strong)NSArray * friendRequestNotificationArray;
@property (nonatomic, strong)NSArray * otherMessageNotificationArray;

- (void)didRequestSchoolNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_SchoolNotification>)object;
- (void)didRequestTaskNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_TaskNotification>)object;
- (void)didRequestFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_FriendRequestNotification>)object;
- (void)didRequestAgreeFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_AgreeFriendRequestNotification>)object;
- (void)didRequestRejectFriendRequestNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_RejectFriendRequestNotification>)object;
- (void)didRequestOtherMessageNotificationWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Notification_OtherMessageNotification>)object;

@end
