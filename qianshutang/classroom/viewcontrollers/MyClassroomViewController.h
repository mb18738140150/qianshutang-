//
//  MyClassroomViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

typedef enum : NSUInteger {
    MyClassroomType_nomal,
    MyClassroomType_Metarial,
    MyClassroomType_arrangeTaskToClassroom_Xilie,
    MyClassroomType_arrangeTaskToClassroom_suitang,
    MyClassroomType_arrangeTaskToStudent_Xilie,
    MyClassroomType_arrangeTaskToStudent_Suitang,
    MyClassroomType_CreatePrize_selectStudent,
} MyClassroomType;

@interface MyClassroomViewController : BasicViewController

@property (nonatomic, assign)MyClassroomType classroomType;
@property (nonatomic, strong)NSDictionary * taskInfoDic;// 布置作业infoDic
@property (nonatomic, assign)BOOL isMetarial;
@property (nonatomic, strong)NSArray * haveSelectStudentArray;
@property (nonatomic, copy)void(^selectPrizeStudentBlock)(NSArray *array);

@end
