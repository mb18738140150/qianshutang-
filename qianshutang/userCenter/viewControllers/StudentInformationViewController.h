//
//  StudentInformationViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface StudentInformationViewController : BasicViewController

@property (nonatomic, copy)void (^selectProductBlock)(ProductType productType);
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, assign)BOOL isTeacher;
@property (nonatomic, assign)BOOL isNotFromCommentTaskVC;

@end
