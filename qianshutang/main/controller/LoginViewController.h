//
//  LoginViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface LoginViewController : BasicViewController

@property (nonatomic, copy)void(^loginSuccessBlock)(BOOL isSuccess);

@end
