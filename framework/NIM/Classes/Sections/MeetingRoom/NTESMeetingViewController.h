//
//  NTESMeetingViewController.h
//  NIM
//
//  Created by fenric on 16/4/7.
//  Copyright © 2015年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NIMAVChat/NIMAVChat.h>
#import "BasicViewController.h"

@interface NTESMeetingViewController : BasicViewController

- (instancetype)initWithChatroom:(NIMChatroom *)chatroom;

- (instancetype)initWithMeetingroom:(NIMNetCallMeeting *)meeting;

@end
