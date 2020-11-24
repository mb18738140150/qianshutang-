//
//  CreatePrizeSelectStudentViewController.h
//  qianshutang
//
//  Created by aaa on 2018/10/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface CreatePrizeSelectStudentViewController : BasicViewController

@property (nonatomic, strong)NSArray * haveSelectStudentArray;
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void(^selectPrizeStudentBlock)(NSArray *array);

@end
