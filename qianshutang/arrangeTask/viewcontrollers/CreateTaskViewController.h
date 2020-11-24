//
//  CreateTaskViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"



@interface CreateTaskViewController : BasicViewController

@property (nonatomic, copy)void(^createMetarialBlock)(NSDictionary *infoDic);
@property (nonatomic, copy)void(^changeMetarialBlock)(NSDictionary *infoDic);
@property (nonatomic, assign)BOOL isCreateTask;
@property (nonatomic, assign)int madeId;


@end
