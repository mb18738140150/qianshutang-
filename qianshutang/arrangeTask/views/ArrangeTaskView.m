//
//  ArrangeTaskView.m
//  qianshutang
//
//  Created by aaa on 2018/8/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ArrangeTaskView.h"

typedef enum : NSUInteger {
    selectTime_today,
    selectTime_tomorrow,
    selectTime_week,
    selectTime_custom
} SelectTime;

@interface ArrangeTaskView()

@property (nonatomic, assign)SelectTime selectTime;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * taskNameView;
@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UIButton * changeTaskNamrBtn;

@property (nonatomic, strong)UIView * classroomView;
@property (nonatomic, strong)UILabel *classroomLB;

@property (nonatomic, strong)UIView * startTimeView;
@property (nonatomic, strong)UILabel * startTimeLB;
@property (nonatomic, strong)UIButton * changeStartTimeBtn;
@property (nonatomic, strong)NSDate * startDate;

@property (nonatomic, strong)UIView * endTimeView;
@property (nonatomic, strong)UILabel * endTimeLB;
@property (nonatomic, strong)UIButton * changeEndTimeBtn;
@property (nonatomic, strong)NSDate * endDate;

@property (nonatomic, strong)UIView * timeSetView;
@property (nonatomic, strong)UIButton * todayBtn;
@property (nonatomic, strong)UIButton * tomorrowBtn;
@property (nonatomic, strong)UIButton * weekBtn;
@property (nonatomic, strong)UIButton * customBtn;

@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)GSPickerView * pickerView;

@property (nonatomic, assign)BOOL isXilie;
@property (nonatomic, assign)int originContinuTime;
@property (nonatomic,assign)int actureContinuTime;

@end

@implementation ArrangeTaskView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.infoDic = infoDic;
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic andIsStudent:(BOOL)isStudent
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.infoDic = infoDic;
        [self prepareStudentUI];
    }
    return self;
}

- (instancetype)initXilieWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic andIsStudent:(BOOL)isStudent
{
    if (self = [super initWithFrame:frame]) {
        self.isXilie = YES;
        self.title = title;
        self.infoDic = infoDic;
        if (isStudent) {
            [self prepareXilieStudentUI];
        }else
        {
            [self prepareXilieUI];
        }
    }
    return self;
}
- (void)prepareXilieStudentUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight * 0.72)];
    self.backView.center = self.center;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backVIewHeight = self.backView.hd_height * 1.15;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backViewWidth, backVIewHeight * 0.133)];
    self.titleLB.text = self.title;
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.backgroundColor = kMainColor;
    [self.backView addSubview:self.titleLB];
    
    self.taskNameView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, self.titleLB.hd_height + backVIewHeight * 0.051, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.taskNameView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.taskNameView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x + 9, self.taskNameView.hd_y, self.taskNameView.hd_width - self.taskNameView.hd_height * 0.577 - 24, self.taskNameView.hd_height )];
    self.taskNameLB.text = [NSString stringWithFormat:@"作业名称:%@", [self.infoDic objectForKey:@"name"]];
    self.taskNameLB.textColor = UIColorFromRGB(0x222222);
    self.taskNameLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.taskNameLB];
    
    self.changeTaskNamrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeTaskNamrBtn.frame = CGRectMake(CGRectGetMaxX(self.taskNameView.frame) - 6 - self.taskNameView.hd_height * 0.577, 0, self.taskNameView.hd_height * 0.577, self.taskNameView.hd_height * 0.577);
    self.changeTaskNamrBtn.hd_centerY = self.taskNameView.hd_centerY;
    [self.changeTaskNamrBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeTaskNamrBtn];
    
    self.startTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.taskNameView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.startTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.startTimeView];
    
    self.startTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.startTimeView.hd_x + 9, self.startTimeView.hd_y, self.startTimeView.hd_width - self.startTimeView.hd_height * 0.577 - 24, self.startTimeView.hd_height )];
    self.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [self getStartTime]];
    self.startTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.startTimeLB];
    
    self.changeStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startTimeView.frame) - 6 - self.startTimeView.hd_height * 0.577, 0, self.startTimeView.hd_height * 0.577, self.startTimeView.hd_height * 0.577);
    self.changeStartTimeBtn.hd_centerY = self.startTimeView.hd_centerY;
    [self.changeStartTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeStartTimeBtn];
    
    self.endTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.startTimeView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.endTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.endTimeView];
    
    self.endTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x + 9, self.endTimeView.hd_y, self.endTimeView.hd_width - self.endTimeView.hd_height * 0.577 - 24, self.endTimeView.hd_height )];
    self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [self getEndTime]];
    self.endTimeLB.textColor = UIColorFromRGB(0x222222);
    self.endTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.endTimeLB];
    
    self.changeEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeEndTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.endTimeView.frame) - 6 - self.endTimeView.hd_height * 0.577, 0, self.endTimeView.hd_height * 0.577, self.endTimeView.hd_height * 0.577);
    self.changeEndTimeBtn.hd_centerY = self.endTimeView.hd_centerY;
    [self.changeEndTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeEndTimeBtn];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x, CGRectGetMaxY(self.endTimeView.frame) + 5, self.endTimeView.hd_width, backVIewHeight * 0.046)];
    self.tipLB.font = kMainFont;
    self.tipLB.textColor = UIColorFromRGB(0x555555);
    self.tipLB.attributedText = [self getattributeStr:@"今天"];
    self.tipLB.text = @"(请设置完成时间,当前为今天)";
    [self.backView addSubview:self.tipLB];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.backView.hd_width - self.backView.hd_width * 0.116 - self.backView.hd_width * 0.265, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122 * 1.15);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.backView.hd_width * 0.116, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122 * 1.15);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.cancelBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.todayBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tomorrowBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weekBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.changeTaskNamrBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeEndTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeStartTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareXilieUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight * 0.833)];
    self.backView.center = self.center;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backVIewHeight = self.backView.hd_height;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backViewWidth, backVIewHeight * 0.133)];
    self.titleLB.text = self.title;
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.backgroundColor = kMainColor;
    [self.backView addSubview:self.titleLB];
    
    self.taskNameView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, self.titleLB.hd_height + backVIewHeight * 0.051, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.taskNameView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.taskNameView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x + 9, self.taskNameView.hd_y, self.taskNameView.hd_width - self.taskNameView.hd_height * 0.577 - 24, self.taskNameView.hd_height )];
    self.taskNameLB.text = [NSString stringWithFormat:@"作业名称:%@", [self.infoDic objectForKey:@"name"]];
    self.taskNameLB.textColor = UIColorFromRGB(0x222222);
    self.taskNameLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.taskNameLB];
    
    self.changeTaskNamrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeTaskNamrBtn.frame = CGRectMake(CGRectGetMaxX(self.taskNameView.frame) - 6 - self.taskNameView.hd_height * 0.577, 0, self.taskNameView.hd_height * 0.577, self.taskNameView.hd_height * 0.577);
    self.changeTaskNamrBtn.hd_centerY = self.taskNameView.hd_centerY;
    [self.changeTaskNamrBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeTaskNamrBtn];
    
    self.classroomView = [[UIView alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x, CGRectGetMaxY(self.taskNameView.frame) + backVIewHeight * 0.018, self.taskNameView.hd_width, self.taskNameView.hd_height)];
    self.classroomView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.classroomView];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(self.classroomView.hd_x + 9, self.classroomView.hd_y, self.classroomView.hd_width - self.classroomView.hd_height * 0.577 - 24, self.classroomView.hd_height )];
    self.classroomLB.text = [NSString stringWithFormat:@"班级名称:%@", [self.infoDic objectForKey:@"classroomName"]];
    self.classroomLB.textColor = UIColorFromRGB(0x222222);
    self.classroomLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.classroomLB];
    
    
    self.startTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.classroomView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.startTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.startTimeView];
    
    self.startTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.startTimeView.hd_x + 9, self.startTimeView.hd_y, self.startTimeView.hd_width - self.startTimeView.hd_height * 0.577 - 24, self.startTimeView.hd_height )];
    self.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [self getStartTime]];
    self.startTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.startTimeLB];
    
    self.changeStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startTimeView.frame) - 6 - self.startTimeView.hd_height * 0.577, 0, self.startTimeView.hd_height * 0.577, self.startTimeView.hd_height * 0.577);
    self.changeStartTimeBtn.hd_centerY = self.startTimeView.hd_centerY;
    [self.changeStartTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeStartTimeBtn];
    
    self.endTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.startTimeView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.endTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.endTimeView];
    
    self.endTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x + 9, self.endTimeView.hd_y, self.endTimeView.hd_width - self.endTimeView.hd_height * 0.577 - 24, self.endTimeView.hd_height )];
    self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [self getEndTime]];
    self.endTimeLB.textColor = UIColorFromRGB(0x222222);
    self.endTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.endTimeLB];
    
    self.changeEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeEndTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.endTimeView.frame) - 6 - self.endTimeView.hd_height * 0.577, 0, self.endTimeView.hd_height * 0.577, self.endTimeView.hd_height * 0.577);
    self.changeEndTimeBtn.hd_centerY = self.endTimeView.hd_centerY;
    [self.changeEndTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeEndTimeBtn];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x, CGRectGetMaxY(self.endTimeView.frame) + 5, self.endTimeView.hd_width, backVIewHeight * 0.046)];
    self.tipLB.font = kMainFont;
    self.tipLB.textColor = UIColorFromRGB(0x555555);
    self.tipLB.attributedText = [self getattributeStr:@"今天"];
    self.tipLB.text = @"(请设置完成时间,当前为今天)";
    [self.backView addSubview:self.tipLB];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.backView.hd_width - self.backView.hd_width * 0.116 - self.backView.hd_width * 0.265, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.backView.hd_width * 0.116, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.cancelBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.todayBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tomorrowBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weekBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.changeTaskNamrBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeEndTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeStartTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight * 0.94)];
    self.backView.center = self.center;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backVIewHeight = self.backView.hd_height;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backViewWidth, backVIewHeight * 0.117)];
    self.titleLB.text = self.title;
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.backgroundColor = kMainColor;
    [self.backView addSubview:self.titleLB];
    
    self.taskNameView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, self.titleLB.hd_height + backVIewHeight * 0.045, backViewWidth * 0.916, backVIewHeight * 0.102)];
    self.taskNameView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.taskNameView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x + 9, self.taskNameView.hd_y, self.taskNameView.hd_width - self.taskNameView.hd_height * 0.577 - 24, self.taskNameView.hd_height )];
    self.taskNameLB.text = [NSString stringWithFormat:@"作业名称:%@", [self.infoDic objectForKey:@"name"]];
    self.taskNameLB.textColor = UIColorFromRGB(0x222222);
    self.taskNameLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.taskNameLB];
    
    self.changeTaskNamrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeTaskNamrBtn.frame = CGRectMake(CGRectGetMaxX(self.taskNameView.frame) - 6 - self.taskNameView.hd_height * 0.577, 0, self.taskNameView.hd_height * 0.577, self.taskNameView.hd_height * 0.577);
    self.changeTaskNamrBtn.hd_centerY = self.taskNameView.hd_centerY;
    [self.changeTaskNamrBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeTaskNamrBtn];
    
    self.classroomView = [[UIView alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x, CGRectGetMaxY(self.taskNameView.frame) + backVIewHeight * 0.018, self.taskNameView.hd_width, self.taskNameView.hd_height)];
    self.classroomView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.classroomView];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(self.classroomView.hd_x + 9, self.classroomView.hd_y, self.classroomView.hd_width - self.classroomView.hd_height * 0.577 - 24, self.classroomView.hd_height )];
    self.classroomLB.text = [NSString stringWithFormat:@"班级名称:%@", [self.infoDic objectForKey:@"classroomName"]];
    self.classroomLB.textColor = UIColorFromRGB(0x222222);
    self.classroomLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.classroomLB];
    
    
    self.startTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.classroomView.frame) + backVIewHeight * 0.018, backViewWidth * 0.916, backVIewHeight * 0.102)];
    self.startTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.startTimeView];
    
    self.startTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.startTimeView.hd_x + 9, self.startTimeView.hd_y, self.startTimeView.hd_width - self.startTimeView.hd_height * 0.577 - 24, self.startTimeView.hd_height )];
    self.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [self getStartTime]];
    self.startTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.startTimeLB];
    
    self.changeStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startTimeView.frame) - 6 - self.startTimeView.hd_height * 0.577, 0, self.startTimeView.hd_height * 0.577, self.startTimeView.hd_height * 0.577);
    self.changeStartTimeBtn.hd_centerY = self.startTimeView.hd_centerY;
    [self.changeStartTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeStartTimeBtn];
    
    self.endTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.startTimeView.frame) + backVIewHeight * 0.018, backViewWidth * 0.916, backVIewHeight * 0.102)];
    self.endTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.endTimeView];
    
    self.endTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x + 9, self.endTimeView.hd_y, self.endTimeView.hd_width - self.endTimeView.hd_height * 0.577 - 24, self.endTimeView.hd_height )];
    self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [self getEndTime]];
    self.endTimeLB.textColor = UIColorFromRGB(0x222222);
    self.endTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.endTimeLB];
    
    self.changeEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeEndTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.endTimeView.frame) - 6 - self.endTimeView.hd_height * 0.577, 0, self.endTimeView.hd_height * 0.577, self.endTimeView.hd_height * 0.577);
    self.changeEndTimeBtn.hd_centerY = self.endTimeView.hd_centerY;
    [self.changeEndTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeEndTimeBtn];
    
    self.timeSetView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.endTimeLB.frame) + backVIewHeight * 0.018, backViewWidth * 0.916, backVIewHeight * 0.102)];
    self.timeSetView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.timeSetView];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(0, 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.todayBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.todayBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    self.todayBtn.selected = YES;
    [self.todayBtn setTitle:@"今天" forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.todayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.todayBtn];
    
    self.tomorrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tomorrowBtn.frame = CGRectMake(CGRectGetMaxX(self.todayBtn.frame), 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.tomorrowBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.tomorrowBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.tomorrowBtn setTitle:@"明天" forState:UIControlStateNormal];
    [self.tomorrowBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.tomorrowBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.tomorrowBtn];
    
    self.weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weekBtn.frame = CGRectMake(CGRectGetMaxX(self.tomorrowBtn.frame), 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.weekBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.weekBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.weekBtn setTitle:@"一周" forState:UIControlStateNormal];
    [self.weekBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.weekBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.weekBtn];
    
    self.customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customBtn.frame = CGRectMake(CGRectGetMaxX(self.weekBtn.frame), 0, self.timeSetView.hd_width / 5 * 2, self.timeSetView.hd_height);
    [self.customBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.customBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.customBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [self.customBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.customBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.customBtn];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.timeSetView.hd_x, CGRectGetMaxY(self.timeSetView.frame) + 5, self.timeSetView.hd_width, backVIewHeight * 0.041)];
    self.tipLB.font = kMainFont;
    self.tipLB.textColor = UIColorFromRGB(0x555555);
    self.tipLB.attributedText = [self getattributeStr:@"今天"];
    self.tipLB.text = @"(请设置完成时间,当前为今天)";
    [self.backView addSubview:self.tipLB];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.backView.hd_width - self.backView.hd_width * 0.116 - self.backView.hd_width * 0.265, self.backView.hd_height * 0.85, self.backView.hd_width * 0.265, self.backView.hd_height * 0.108);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.sureBtn];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.backView.hd_width * 0.116, self.backView.hd_height * 0.85, self.backView.hd_width * 0.265, self.backView.hd_height * 0.108);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.cancelBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.todayBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tomorrowBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weekBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.changeTaskNamrBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeEndTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeStartTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self hidecgangeTimeBtn];
}


- (void)prepareStudentUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight * 0.833)];
    self.backView.center = self.center;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backVIewHeight = self.backView.hd_height;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backViewWidth, backVIewHeight * 0.133)];
    self.titleLB.text = self.title;
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.backgroundColor = kMainColor;
    [self.backView addSubview:self.titleLB];
    
    self.taskNameView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, self.titleLB.hd_height + backVIewHeight * 0.051, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.taskNameView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.taskNameView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameView.hd_x + 9, self.taskNameView.hd_y, self.taskNameView.hd_width - self.taskNameView.hd_height * 0.577 - 24, self.taskNameView.hd_height )];
    self.taskNameLB.text = [NSString stringWithFormat:@"作业名称:%@", [self.infoDic objectForKey:@"name"]];
    self.taskNameLB.textColor = UIColorFromRGB(0x222222);
    self.taskNameLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.taskNameLB];
    
    self.changeTaskNamrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeTaskNamrBtn.frame = CGRectMake(CGRectGetMaxX(self.taskNameView.frame) - 6 - self.taskNameView.hd_height * 0.577, 0, self.taskNameView.hd_height * 0.577, self.taskNameView.hd_height * 0.577);
    self.changeTaskNamrBtn.hd_centerY = self.taskNameView.hd_centerY;
    [self.changeTaskNamrBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeTaskNamrBtn];
    
    
    self.startTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.taskNameView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.startTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.startTimeView];
    
    self.startTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.startTimeView.hd_x + 9, self.startTimeView.hd_y, self.startTimeView.hd_width - self.startTimeView.hd_height * 0.577 - 24, self.startTimeView.hd_height )];
    self.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [self getStartTime]];
    self.startTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.startTimeLB];
    
    self.changeStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startTimeView.frame) - 6 - self.startTimeView.hd_height * 0.577, 0, self.startTimeView.hd_height * 0.577, self.startTimeView.hd_height * 0.577);
    self.changeStartTimeBtn.hd_centerY = self.startTimeView.hd_centerY;
    [self.changeStartTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeStartTimeBtn];
    
    self.endTimeView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.startTimeView.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.endTimeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.endTimeView];
    
    self.endTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.endTimeView.hd_x + 9, self.endTimeView.hd_y, self.endTimeView.hd_width - self.endTimeView.hd_height * 0.577 - 24, self.endTimeView.hd_height )];
    self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [self getEndTime]];
    self.endTimeLB.textColor = UIColorFromRGB(0x222222);
    self.endTimeLB.font = [UIFont systemFontOfSize:16];
    [self.backView addSubview:self.endTimeLB];
    
    self.changeEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeEndTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.endTimeView.frame) - 6 - self.endTimeView.hd_height * 0.577, 0, self.endTimeView.hd_height * 0.577, self.endTimeView.hd_height * 0.577);
    self.changeEndTimeBtn.hd_centerY = self.endTimeView.hd_centerY;
    [self.changeEndTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.backView addSubview:self.changeEndTimeBtn];
    
    self.timeSetView = [[UIView alloc]initWithFrame:CGRectMake(backViewWidth * 0.042, CGRectGetMaxY(self.endTimeLB.frame) + backVIewHeight * 0.02, backViewWidth * 0.916, backVIewHeight * 0.115)];
    self.timeSetView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.backView addSubview:self.timeSetView];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(0, 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.todayBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.todayBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    self.todayBtn.selected = YES;
    [self.todayBtn setTitle:@"今天" forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.todayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.todayBtn];
    
    self.tomorrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tomorrowBtn.frame = CGRectMake(CGRectGetMaxX(self.todayBtn.frame), 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.tomorrowBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.tomorrowBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.tomorrowBtn setTitle:@"明天" forState:UIControlStateNormal];
    [self.tomorrowBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.tomorrowBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.tomorrowBtn];
    
    self.weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weekBtn.frame = CGRectMake(CGRectGetMaxX(self.tomorrowBtn.frame), 0, self.timeSetView.hd_width / 5, self.timeSetView.hd_height);
    [self.weekBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.weekBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.weekBtn setTitle:@"一周" forState:UIControlStateNormal];
    [self.weekBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.weekBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.weekBtn];
    
    self.customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customBtn.frame = CGRectMake(CGRectGetMaxX(self.weekBtn.frame), 0, self.timeSetView.hd_width / 5 * 2, self.timeSetView.hd_height);
    [self.customBtn setImage:[UIImage imageNamed:@"listen_timing_small"] forState:UIControlStateNormal];
    [self.customBtn setImage:[UIImage imageNamed:@"listen_timing_selected_small"] forState:UIControlStateSelected];
    [self.customBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [self.customBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
    self.customBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeSetView addSubview:self.customBtn];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.timeSetView.hd_x, CGRectGetMaxY(self.timeSetView.frame) + 5, self.timeSetView.hd_width, backVIewHeight * 0.046)];
    self.tipLB.font = kMainFont;
    self.tipLB.textColor = UIColorFromRGB(0x555555);
    self.tipLB.attributedText = [self getattributeStr:@"今天"];
    self.tipLB.text = @"(请设置完成时间,当前为今天)";
    [self.backView addSubview:self.tipLB];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.backView.hd_width - self.backView.hd_width * 0.116 - self.backView.hd_width * 0.265, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.backView.hd_width * 0.116, self.backView.hd_height * 0.83, self.backView.hd_width * 0.265, self.backView.hd_height * 0.122);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.cancelBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.todayBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tomorrowBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weekBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.changeTaskNamrBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeEndTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeStartTimeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self hidecgangeTimeBtn];
}
- (void)resetOriginContinuTime:(int)continuTime
{
    self.originContinuTime = continuTime;
    self.actureContinuTime = continuTime;
    
    [self resetEndTime:[NSDate date]];
    
}

- (void)resetEndTime:(NSDate*)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.day = self.actureContinuTime - 1;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * currentDate = date;
    NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
    NSString * nextStr = [formatter stringFromDate:nextDate];
    self.endDate = nextDate;
    
    self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [nextStr stringByAppendingString:@" 24点"]];
    [self refreshTipLB];
}

- (void)refreshTipLB
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSString * startStr = [formatter stringFromDate:self.startDate];
    if ([self.startDate isEqual:[NSDate date]]) {
        startStr = @"今日";
    }
    NSString * continuStr = [NSString stringWithFormat:@"%d", self.actureContinuTime];
    NSString * string = [NSString stringWithFormat:@"本次作业起始时间为%@,持续%@天完成", startStr, continuStr];
    NSMutableAttributedString * mString = [[NSMutableAttributedString alloc]initWithString:string];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor_orange};
    [mString addAttributes:attribute range:NSMakeRange(9, string.length - continuStr.length - 15)];
    [mString addAttributes:attribute range:NSMakeRange(string.length - continuStr.length - 3, continuStr.length)];
    
    self.tipLB.attributedText = mString;
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.bounds];
    }
    return _pickerView;
}

- (void)changeAction:(UIButton *)button
{
    __weak typeof(self)weakSelf = self;
    if ([button isEqual:self.changeTaskNamrBtn]) {
        __weak typeof(self)weakSelf = self;
        ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.bounds andType:ToolTipTye_tf andTitle:[self.infoDic objectForKey:@"name"] andPlaceHold:@"请输入作业名称" withAnimation:NO];
        __weak typeof(toolView)weakToolView = toolView;
        [self addSubview:toolView];
        toolView.TextBlock = ^(NSString *text) {
            if (text.length == 0) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"作业名称不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            
            weakSelf.taskNameLB.text = [NSString stringWithFormat:@"作业名称:%@", text];
            [weakToolView removeFromSuperview];
        };
        toolView.DismissBlock = ^{
            
            [weakToolView removeFromSuperview];
        };
    }else if ([button isEqual:self.changeStartTimeBtn])
    {
        [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy/MM/dd";
            NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
            formatter1.dateFormat = @"yyyy年MM月dd日";
            NSDate * date = [self getNowDateFromatAnDate:[formatter1 dateFromString:pathStr]];
            NSString * currentStr = [formatter stringFromDate:date];
            
            if ([self isLaterToday:date]) {// 先判断其实时间是否大于等于今天
                weakSelf.startDate = date;
                weakSelf.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [currentStr stringByAppendingString:@" 0点"]];
                [weakSelf.pickerView removeFromSuperview];
                
                if (weakSelf.isXilie) {
                    [weakSelf resetEndTime:weakSelf.startDate];
                }
                
            }
        } cancleAction:^{
            
        }];
    }else
    {
        [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy/MM/dd";
            NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
            formatter1.dateFormat = @"yyyy年MM月dd日";
            NSDate * date = [self getNowDateFromatAnDate:[formatter1 dateFromString:pathStr]];
            NSString * currentStr = [formatter stringFromDate:date];
            
            if (weakSelf.isXilie) {
                // 系列作业截止时间与起始时间间隔需要小于作业项最长持续时间，并且应晚于起始时间
                if ([weakSelf isStartAndEndTimeShorterToOriginContinuTime:weakSelf.startDate and:date]) {
                    
                    weakSelf.endDate = date;
                    weakSelf.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [currentStr stringByAppendingString:@" 24点"]];
                    [weakSelf.pickerView removeFromSuperview];
                    
                    [weakSelf refreshTipLB];
                }
            }else
            {
                if ([weakSelf isendTimeLaterStartTime:weakSelf.startDate and:date]) {// 截止时间须晚于起始时间
                    weakSelf.endDate = date;
                    weakSelf.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [currentStr stringByAppendingString:@" 24点"]];
                    [weakSelf.pickerView removeFromSuperview];
                }
            }
            
        } cancleAction:^{
            
        }];
    }
}

- (BOOL)isStartAndEndTimeShorterToOriginContinuTime:(NSDate *)startDate and:(NSDate *)endDate
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    if (nowCmps.day + 1 > self.originContinuTime) {
        [SVProgressHUD showInfoWithStatus:@"不可大于本次作业项的最长天数"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }else if(nowCmps.day < 0)
    {
        [SVProgressHUD showInfoWithStatus:@"截止时间不可早于起始时间"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }else
    {
        if (nowCmps.hour > 0) {
            self.actureContinuTime = nowCmps.day + 2;
        }else
        {
            self.actureContinuTime = nowCmps.day + 1;
        }
    }
    
    return YES;
}

- (BOOL)isendTimeLaterStartTime:(NSDate *)startDate and:(NSDate *)endDate
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    if(nowCmps.day < 0)
    {
        [SVProgressHUD showInfoWithStatus:@"截止时间不可早于起始时间"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    
    return YES;
}

- (BOOL)isLaterToday:(NSDate *)date
{
    NSDate * todatDate = [self getNowDateFromatAnDate:[NSDate date]];
    NSDate * tagetDate = date;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:todatDate toDate:tagetDate options:0];
    
    if (nowCmps.day < 0) {
        [SVProgressHUD showInfoWithStatus:@"起始时间必须大于等于今日\n请重新设置"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}

- (void)hidecgangeTimeBtn
{
    self.changeStartTimeBtn.hidden = YES;
    self.changeEndTimeBtn.hidden = YES;
}

- (void)showcgangeTimeBtn
{
    self.changeStartTimeBtn.hidden = NO;
    self.changeEndTimeBtn.hidden = NO;
}

- (void)timeAction:(UIButton *)button
{
    [self hidecgangeTimeBtn];
    button.selected = !button.selected;
    if ([button isEqual:self.tomorrowBtn]) {
        self.selectTime = selectTime_tomorrow;
        self.todayBtn.selected = NO;
        self.weekBtn.selected = NO;
        self.customBtn.selected = NO;
        self.tipLB.text = @"(请设置完成时间,当前为明天)";
    }else if ([button isEqual:self.todayBtn])
    {
        self.selectTime = selectTime_today;
        self.weekBtn.selected = NO;
        self.customBtn.selected = NO;
        self.tomorrowBtn.selected = NO;
        self.tipLB.text = @"(请设置完成时间,当前为今天)";
    }else if ([button isEqual:self.weekBtn])
    {
        self.selectTime = selectTime_week;
        self.customBtn.selected = NO;
        self.tomorrowBtn.selected = NO;
        self.todayBtn.selected = NO;
        self.tipLB.text = @"(请设置完成时间,当前为一周)";
    }
    else if ([button isEqual:self.customBtn])
    {
        [self showcgangeTimeBtn];
        self.selectTime = selectTime_custom;
        self.tomorrowBtn.selected = NO;
        self.todayBtn.selected = NO;
        self.weekBtn.selected = NO;
        self.tipLB.text = @"(请设置完成时间,当前为自定义)";
    }
    if (![button isEqual:self.customBtn]) {
        self.startTimeLB.text = [NSString stringWithFormat:@"起始时间:%@", [self getStartTime]];
        self.endTimeLB.text = [NSString stringWithFormat:@"截止时间:%@", [self getEndTime]];
    }
}

- (NSString *)getStartTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    if (self.selectTime == selectTime_week || self.selectTime == selectTime_today) {
        NSDate * date = [NSDate date];
        NSString * currentStr = [formatter stringFromDate:date];
        self.startDate = [self getNowDateFromatAnDate:date];
        return [currentStr stringByAppendingString:@" 0点"];
        
    }else if (self.selectTime == selectTime_tomorrow)
    {
        NSDateComponents * components = [[NSDateComponents alloc]init];
        components.day = 1;
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDate * currentDate = [NSDate date];
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
        NSString * nextStr = [formatter stringFromDate:nextDate];
        self.startDate = [self getNowDateFromatAnDate:nextDate];
        return [nextStr stringByAppendingString:@" 0点"];
    }else
    {
        
    }
    
    return nil;
}

- (NSString *)getEndTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    if ( self.selectTime == selectTime_today) {
        NSDate * date = [NSDate date];
        NSString * currentStr = [formatter stringFromDate:date];
        self.endDate = [self getNowDateFromatAnDate:date];
        return [currentStr stringByAppendingString:@" 24点"];
        
    }else if (self.selectTime == selectTime_tomorrow)
    {
        NSDateComponents * components = [[NSDateComponents alloc]init];
        components.day = 1;
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDate * currentDate = [NSDate date];
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
        NSString * nextStr = [formatter stringFromDate:nextDate];
        self.endDate = [self getNowDateFromatAnDate:nextDate];
        return [nextStr stringByAppendingString:@" 24点"];
    }else if (self.selectTime == selectTime_week)
    {
        NSDateComponents * components = [[NSDateComponents alloc]init];
        components.day = 7;
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDate * currentDate = [NSDate date];
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
        NSString * nextStr = [formatter stringFromDate:nextDate];
        self.endDate = [self getNowDateFromatAnDate:nextDate];
        return [nextStr stringByAppendingString:@" 24点"];
    }
    else
    {
        
    }
    return nil;
}

- (void)cancelAction
{
    if (self.DismissBlock) {
        self.DismissBlock();
    }
}
- (void)cintinueAction
{
    NSString * name = [self.taskNameLB.text substringFromIndex:5];
    NSString * start = [self.startTimeLB.text substringFromIndex:5];
    start = [start substringToIndex:10];
    NSString * end = [self.endTimeLB.text substringFromIndex:5];
    end = [end substringToIndex:10];
    
    
    if (self.ContinueBlock) {
        self.ContinueBlock(@{@"name":name,@"startTime":start,@"endTime":end});
    }
}

- (NSMutableAttributedString *)getattributeStr:(NSString *)text
{
    NSString *str = [NSString stringWithFormat:@"(请设置完成时间,当前为%@)", text];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFF6C33)};
    [mStr setAttributes:attribute range:NSMakeRange(12, text.length)];
    return mStr;
}

//- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
//{
//    //设置源日期时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
//    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
//    return destinationDateNow;
//}
- (NSDate *)getNowDateFromatAnDate:(NSDate *)sourceDate

{
        NSTimeZone *srcTimeZone = [NSTimeZone timeZoneWithName:@"GMT/Shanghai"];
    
        NSTimeZone *dstTimeZone = [NSTimeZone systemTimeZone];
       NSInteger srcGMTOffset = [srcTimeZone secondsFromGMTForDate:sourceDate];
       NSInteger dstGMTOffset = [dstTimeZone secondsFromGMTForDate:sourceDate];
    
        
       NSTimeInterval interval = dstGMTOffset - srcGMTOffset;
    
        
    
        NSDate *dstDate = [[NSDate alloc]initWithTimeInterval:interval sinceDate:sourceDate];
       return dstDate;
}

@end
