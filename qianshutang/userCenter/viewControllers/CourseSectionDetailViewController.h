//
//  CourseSectionDetailViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface CourseSectionDetailViewController : BasicViewController

@property (nonatomic, copy)void(^editeBlock)(BOOL isEdit);

@property (nonatomic, assign)BOOL isHavePlayBack;
@property (nonatomic, assign)BOOL isTeacher;

@property (nonatomic, strong)NSDictionary * courseInfo;

@end
