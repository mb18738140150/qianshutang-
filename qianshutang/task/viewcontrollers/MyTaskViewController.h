//
//  MyTaskViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"



@interface MyTaskViewController : BasicViewController
// 学生
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * bottomCollectionViewArray;

// 老师
@property (nonatomic, assign)TaskShowType taskShowType;
@property (nonatomic, strong)NSMutableArray * allTaskArray;// 系列预览时全部天数作业

@end
