//
//  LearnTextViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface LearnTextViewController : BasicViewController

@property (nonatomic, copy)void (^againRecordSuccessBlock)(BOOL isSuccess);

@property (nonatomic, assign)BOOL isAgainRecord;
@property (nonatomic, assign)int productId;
@property (nonatomic, assign)int  userWorkId;
@property (nonatomic, assign)LearnTextType  learntextType;
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, assign)TaskShowType taskShowType;

@end
