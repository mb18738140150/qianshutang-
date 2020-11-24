//
//  UserCenterTableView.h
//  qianshutang
//
//  Created by aaa on 2018/8/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UserCenterTableViewType_MyTask,
    UserCenterTableViewType_ClassroomTask,
    UserCenterTableViewType_daka,
    UserCenterTableViewType_shichang,
    UserCenterTableViewType_achievement,
    UserCenterTableViewType_star,
    UserCenterTableViewType_flower,
    UserCenterTableViewType_gold,
    UserCenterTableViewType_completeness,
    UserCenterTableViewType_bookmark,
    UserCenterTableViewType_myCourse,
    UserCenterTableViewType_Course,
    UserCenterTableViewType_buyCourseRecoard,
    UserCenterTableViewType_courseCost,
    UserCenterTableViewType_integralRecord,
    UserCenterTableViewType_prizeRecord,
    UserCenterTableViewType_MytaskComplateDetail,
    UserCenterTableViewType_classMemberTaskComplateDetail,
    UserCenterTableViewType_arrangeTask_main_suitang,
    UserCenterTableViewType_arrangeTask_main_xilie,
    UserCenterTableViewType_arrangeTask_school_suitang,
    UserCenterTableViewType_arrangeTask_school_xilie,
    UserCenterTableViewType_haveArrangeTask,
    UserCenterTableViewType_commentTask,
    UserCenterTableViewType_studentTaskcomplate,
    UserCenterTableViewType_teacherCourse,
    UserCenterTableViewType_teacher_studentIntegralList,
    UserCenterTableViewType_teacher_studentIntegralPrizeRecord,
    UserCenterTableViewType_teacher_haveSendIntegral,
    UserCenterTableViewType_teacher_ClassroomTaskList,
    UserCenterTableViewType_calendr,
} UserCenterTableViewType;

@interface UserCenterTableView : UIView

@property (nonatomic, assign)BOOL isCourse;

@property (nonatomic, copy)void (^arrangeTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^operationTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^deleteTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^shareTaskBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^haveArrangeTaskOperationBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^commentTaskBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^collectTaskBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^teacher_StudentPrizeRecordBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void(^checkTaskBlock)(NSDictionary * infoDic, DoTaskType type);
@property (nonatomic, copy)void(^shichangBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^editPrizeRemarkBlock)(NSDictionary *infoDic);


@property (nonatomic, assign)UserCenterTableViewType  usercenterTableViewType;
@property (nonatomic, copy)void (^UserCenterCellClickBlock)(UserCenterTableViewType type,NSDictionary * infoDic);
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, copy)void (^cancelConvertPrizeBlock)(NSDictionary * infoDic);


@property (nonatomic, assign)BOOL isMyBookmarkDelete;// 删除我的阅读书签

@property (nonatomic, assign)BOOL isClassroom;

@property (nonatomic, copy)void(^headRefreshBlock)();
- (void)endRefresh;

- (void)resetUsercenterTableViewType:(UserCenterTableViewType )usercenterTableViewType;

- (void)resetWith:(NSDictionary *)infoDic;

@end
