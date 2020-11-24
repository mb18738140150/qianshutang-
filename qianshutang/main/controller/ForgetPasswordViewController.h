//
//  ForgetPasswordViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface ForgetPasswordViewController : BasicViewController

@property (nonatomic, copy)void(^ResetPsdSuccessBlock)(BOOL isSuccess);
@property (nonatomic, strong)NSString * account;

@end
