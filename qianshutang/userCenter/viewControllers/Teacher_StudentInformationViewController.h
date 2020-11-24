//
//  Teacher_StudentInformationViewController.h
//  qianshutang
//
//  Created by aaa on 2018/10/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface Teacher_StudentInformationViewController : BasicViewController

@property (nonatomic, copy)void (^selectProductBlock)(ProductType productType);
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, assign)BOOL isTeacher;
@property (nonatomic, assign)BOOL isNotFromCommentTaskVC;

@end
