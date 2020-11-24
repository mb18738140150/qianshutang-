//
//  BindPhoneNumberViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface BindPhoneNumberViewController : BasicViewController

@property (nonatomic, copy)void (^BindPhoneNumberBlock)(NSString * phoneNumber);

@end
