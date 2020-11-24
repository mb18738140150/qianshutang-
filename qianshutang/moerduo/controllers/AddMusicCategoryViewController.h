//
//  AddMusicCategoryViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

typedef enum : NSUInteger {
    ArrangeTaskType_Nomal,
    ArrangeTaskType_moerduo,
    ArrangeTaskType_read,
    ArrangeTaskType_record,
    ArrangeTaskType_Create,
    ArrangeTaskType_video
} ArrangeTaskType;

@interface AddMusicCategoryViewController : BasicViewController

@property (nonatomic, assign)TaskEditType taskEditType;
@property (nonatomic, assign)ArrangeTaskType arrangeTaskType;

//@property (nonatomic, assign)BOOL isArrangeTask;
//@property (nonatomic, assign)BOOL isChangeTask;
//@property (nonatomic, assign)BOOL isAggangrXiLieTask;

@property (nonatomic, copy)void(^complateBlock)(NSArray * array);// 选择磨耳朵

@property (nonatomic, copy)void(^xilietaskBlock)(NSDictionary * infoDic);// 系列作业

@property (nonatomic, copy)void(^addClassroomTextbookBlock)(NSDictionary * infoDic);// 添加班级教材课本

@property (nonatomic, copy)void(^addClassroomCourseWareBlock)(NSDictionary * infoDic);// 添加班级教材课件
@property (nonatomic, copy)void(^changeSuitangTaskTextbookBlock)(NSDictionary *infoDic);// 修改随堂作业模板课文

@property (nonatomic, strong)NSDictionary * infoDic;

@end
