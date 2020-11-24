//
//  PrizeDetailViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface PrizeDetailViewController : BasicViewController

@property (nonatomic, copy)void(^convertBlock)(BOOL isSuccess);
@property (nonatomic, strong)NSDictionary * infoDic;

@end
