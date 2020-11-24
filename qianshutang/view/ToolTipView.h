//
//  ToolTipView.h
//  qianshutang
//
//  Created by aaa on 2018/7/23.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ToolTipTye_timer,
    ToolTipTye_tip,
    ToolTipTye_tf,
    ToolTipTye_recordShot,
    ToolTipTye_shareToSchoolLibrary,
    ToolTipTye_changeRepeatCount,
    ToolTipTye_changeName,
    ToolTipTye_deleteTeacherCourse,
    ToolTipTye_teacherAddCOurse,
    ToolTipTye_searchText,
    ToolTipTye_callroll,
    ToolTipTye_ModifyAttendance
} ToolTipTye;

typedef enum : NSUInteger {
    TimerType_custom,
    TimerType_infinite,
} TimerType;

@interface ToolTipView : UIView

@property (nonatomic, assign)TimerType timerType;
@property (nonatomic, copy)void(^TimerTypeBlock)(TimerType type ,int time);
@property (nonatomic, copy)void(^TextBlock)(NSString * text);
@property (nonatomic, copy)void (^ContinueBlock)(NSString * str);
@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void (^teacherAddCourseBlock)(NSDictionary * infoDic);
@property (nonatomic, assign)int maxCount;
@property (nonatomic, copy)void(^SearchTextBlock)(NSString * text);

- (instancetype)initWithFrame:(CGRect)frame andType:(ToolTipTye)toolType andTitle:(NSString*)title withAnimation:(BOOL)animation;

- (instancetype)initWithFrame:(CGRect)frame andType:(ToolTipTye)toolType andTitle:(NSString*)title andPlaceHold:(NSString *)placeHold withAnimation:(BOOL)animation;

- (void)resetContentLbTetx:(NSString *)text;
- (void)resetSureBtnTitle:(NSString *)text;
- (void)resetCancelBtnTitle:(NSString *)text;
- (void)resetRepeatCount:(NSString *)count;
- (void)resetNameTvText:(NSString *)text;

- (void)addExplainBtn;

- (void)resetAttendanceView:(NSDictionary *)infoDic;

@end
