//
//  TaskMetarialPhotoViewController.h
//  qianshutang
//
//  Created by aaa on 2018/11/29.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface TaskMetarialPhotoViewController : BasicViewController

@property (nonatomic, copy)void(^TaskMetarialSelectComplateBlock)(NSArray *selectArray);

@property (nonatomic, strong)NSArray * dataArray;

@end
