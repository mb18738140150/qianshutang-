//
//  UserCenterViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface UserCenterViewController : BasicViewController

@property (nonatomic, copy)void(^quitBlock)(BOOL sQuit);

@end
