//
//  TeakEveryDayDetailViewController.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface TeakEveryDayDetailViewController : BasicViewController

@property (nonatomic, copy)void(^doBlock)(NSDictionary * infoDic);
@property (nonatomic, assign)BOOL isTeacher;
@property (nonatomic, assign)int memberId;

@end
