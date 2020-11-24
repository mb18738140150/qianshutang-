//
//  ToolTipView.m
//  qianshutang
//
//  Created by aaa on 2018/7/23.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ToolTipView.h"
#import "AttendanceStatePickerView.h"

@interface ToolTipView()<UITextViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD * hud;
}
@property (nonatomic, strong)NSString * title;
@property (nonatomic, assign)BOOL animation;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;
@property (nonatomic, strong)UIButton * infiniteBtn;
@property (nonatomic, strong)UIButton * coustomBtn;
@property (nonatomic, strong)UITextField * timeTF;

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSString * placeHold;

@property (nonatomic, strong)UILabel * contentLB;// 内容

@property (nonatomic, strong)UIButton * minusBtn;
@property (nonatomic, strong)UIButton * addBtn;
@property (nonatomic, strong)UILabel * repeatCountLB;

@property (nonatomic, strong)MKPPlaceholderTextView * ContentTv;
@property (nonatomic, strong)UILabel * textCountLB;

@property (nonatomic, strong)UILabel * startDayTimeLB;
@property (nonatomic, strong)UIButton * addStartDayTimeBtn;
@property (nonatomic, strong)UILabel * startDayTimePlaceLB;
@property (nonatomic, strong)UIButton * changeStartDayTimeBtn;

@property (nonatomic, strong)UILabel * startTimeLB;
@property (nonatomic, strong)UIButton * addStartTimeBtn;
@property (nonatomic, strong)UILabel * startTimePlaceLB;
@property (nonatomic, strong)UIButton * changeStartTimeBtn;

@property (nonatomic,strong)GSPickerView *pickerView;
@property (nonatomic, strong)CourseTimePickerView * courseTimePickerView;
@property (nonatomic, strong)AttendanceStatePickerView *attendancePickerView;
@property (nonatomic, assign)int attendanceState;

@property (nonatomic, strong)NSString * searchStr;

@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic,strong)UITextField * costTF;
@property (nonatomic, strong)MKPPlaceholderTextView * remarkLB;


@end


@implementation ToolTipView


- (instancetype)initWithFrame:(CGRect)frame andType:(ToolTipTye)toolType andTitle:(NSString*)title andPlaceHold:(NSString *)placeHold withAnimation:(BOOL)animation
{
    if (self = [super initWithFrame:frame]) {
        self.placeHold = placeHold;
        self.animation = animation;
        self.title = title;
        switch (toolType) {
            case ToolTipTye_tip:
                ;
                break;
            case ToolTipTye_timer:
                [self prepareTimerUI];
                break;
            case ToolTipTye_tf:
                [self prepareTFUI];
                break;
            case ToolTipTye_changeName:
                [self prepareChangeNameUI];
                break;
            case ToolTipTye_searchText:
                [self prepareSearchTextUI];
                break;
                
            default:
                break;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andType:(ToolTipTye)toolType andTitle:(NSString*)title withAnimation:(BOOL)animation
{
    if (self = [super initWithFrame:frame]) {
        self.animation = animation;
        self.title = title;
        switch (toolType) {
            case ToolTipTye_tip:
                ;
                break;
            case ToolTipTye_timer:
                [self prepareTimerUI];
                break;
            case ToolTipTye_tf:
                [self prepareTFUI];
                break;
            case ToolTipTye_recordShot:
                [self prepareRecordShotUI];
                break;
            case ToolTipTye_shareToSchoolLibrary:
                [self prepareshareToSchoolLibraryUI];
                break;
            case ToolTipTye_changeRepeatCount:
                [self preparechangeRepeatCountUI];
                break;
            case ToolTipTye_deleteTeacherCourse:
                [self preparedeleteTeacherCourseUI];
                break;
            case ToolTipTye_teacherAddCOurse:
                [self prepareteacherAddCOurseUI];
                break;
            case ToolTipTye_searchText:
                [self prepareSearchTextUI];
                break;
                case ToolTipTye_callroll:
                [self prepareCallRollUI];
                break;
            case ToolTipTye_ModifyAttendance:
            {
                [self prepareModifyAttendanceUI];
            }
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)prepareTimerUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinAction)];
    [backView addGestureRecognizer:tap];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.55)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height / 5)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    UIView * infiniteView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_height * 0.07, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.07, self.tipView.hd_width  - self.tipView.hd_height * 0.16, self.tipView.hd_height / 6)];
    infiniteView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:infiniteView];
    
    self.infiniteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.infiniteBtn.frame = CGRectMake(8, 8, infiniteView.hd_height - 16, infiniteView.hd_height - 16);
    [self.infiniteBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.infiniteBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    self.infiniteBtn.selected = YES;
    [infiniteView addSubview:self.infiniteBtn];
    
    UILabel * infiniteLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.infiniteBtn.frame) + 8, 0, infiniteView.hd_width - infiniteView.hd_height, infiniteView.hd_height)];
    infiniteLB.text = @"无限制";
    infiniteLB.textColor = UIColorFromRGB(0x515151);
    [infiniteView addSubview:infiniteLB];
    
    UIView * coustomView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_height * 0.07, CGRectGetMaxY(infiniteView.frame) + self.tipView.hd_height / 30, self.tipView.hd_width  - self.tipView.hd_height * 0.16, self.tipView.hd_height / 6)];
    coustomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:coustomView];
    
    self.coustomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coustomBtn.frame = CGRectMake(8, 8, infiniteView.hd_height - 16, infiniteView.hd_height - 16);
    [self.coustomBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.coustomBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [coustomView addSubview:self.coustomBtn];
    
    CGFloat coustomLbWidth = [@"自定义" boundingRectWithSize:CGSizeMake(MAXFLOAT, infiniteView.hd_width) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
    UILabel * coustomLB1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.infiniteBtn.frame) + 8, 0, coustomLbWidth, infiniteView.hd_height)];
    coustomLB1.text = @"自定义";
    coustomLB1.textColor = UIColorFromRGB(0x515151);
    [coustomView addSubview:coustomLB1];
    
    self.timeTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(coustomLB1.frame) + 3, 5, 80, coustomView.hd_height - 10)];
    self.timeTF.backgroundColor = [UIColor whiteColor];
    self.timeTF.textAlignment = NSTextAlignmentCenter;
    self.timeTF.textColor = UIColorFromRGB(0x515151);
    self.timeTF.keyboardType = UIKeyboardTypeNumberPad;
    [coustomView addSubview:self.timeTF];
    
    UILabel * coustomLB2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTF.frame) + 3, 0, 100, infiniteView.hd_height)];
    coustomLB2.text = @"分钟";
    coustomLB2.textColor = UIColorFromRGB(0x515151);
    [coustomView addSubview:coustomLB2];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_height / 5, self.tipView.hd_height / 15 * 11, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_height / 5 - self.tipView.hd_height * 0.45, self.tipView.hd_height / 15 * 11, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    [self.infiniteBtn addTarget:self action:@selector(infiniteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.coustomBtn addTarget:self action:@selector(coustomAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareTFUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinAction)];
    [backView addGestureRecognizer:tap];
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.08, kScreenHeight * 0.27, kScreenWidth * 0.84, kScreenHeight * 0.15)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    
    self.timeTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, whiteView.hd_width * 0.75, whiteView.hd_height - 20)];
    self.timeTF.layer.cornerRadius = self.timeTF.hd_height / 2;
    self.timeTF.textAlignment = NSTextAlignmentCenter;
    self.timeTF.layer.masksToBounds = YES;
    self.timeTF.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.timeTF.delegate = self;
    if (self.title && self.title.length > 0) {
        self.timeTF.text = self.title;
    }else
    {
        if (self.placeHold.length > 0) {
            self.timeTF.placeholder = self.placeHold;
        }else
        {
            self.timeTF.placeholder = @"请输入作品名";
        }
    }
    [whiteView addSubview:self.timeTF];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.timeTF.frame) + 15, whiteView.hd_height * 0.09, whiteView.hd_height * 0.82, whiteView.hd_height * 0.82);
    [self.sureBtn setImage:[UIImage imageNamed:@"icon_send"] forState:UIControlStateNormal];
    [whiteView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.sureBtn.frame) + 15, whiteView.hd_height * 0.09, whiteView.hd_height * 0.82, whiteView.hd_height * 0.82);
    [self.cancelBtn setImage:[UIImage imageNamed:@"icon_off"] forState:UIControlStateNormal];
    [whiteView addSubview:self.cancelBtn];
    
    [self.sureBtn addTarget:self action:@selector(TextComplateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareSearchTextUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinAction)];
    [backView addGestureRecognizer:tap];
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.08, kScreenHeight * 0.27, kScreenWidth * 0.84, kScreenHeight * 0.15)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    
    self.ContentTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(20, 10, whiteView.hd_width * 0.75, whiteView.hd_height - 20)];
    self.ContentTv.layer.cornerRadius = self.timeTF.hd_height / 2;
    self.ContentTv.textAlignment = NSTextAlignmentCenter;
    self.ContentTv.layer.masksToBounds = YES;
    self.ContentTv.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.ContentTv.delegate = self;
    if (self.title && self.title.length > 0) {
        self.ContentTv.text = self.title;
    }else
    {
        if (self.placeHold.length > 0) {
            self.ContentTv.placeholder = self.placeHold;
        }else
        {
            self.ContentTv.placeholder = @"请输入作品名";
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.ContentTv resetTextAlignment:NSTextAlignmentCenter];
    });
    [whiteView addSubview:self.ContentTv];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.ContentTv.frame) + 15, whiteView.hd_height * 0.09, whiteView.hd_height * 0.82, whiteView.hd_height * 0.82);
    [self.sureBtn setImage:[UIImage imageNamed:@"icon_send"] forState:UIControlStateNormal];
    [whiteView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.sureBtn.frame) + 15, whiteView.hd_height * 0.09, whiteView.hd_height * 0.82, whiteView.hd_height * 0.82);
    [self.cancelBtn setImage:[UIImage imageNamed:@"icon_off"] forState:UIControlStateNormal];
    [whiteView addSubview:self.cancelBtn];
    
    [self.sureBtn addTarget:self action:@selector(SearchTextComplateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

/*
 
 self.ContentTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(20, 10, whiteView.hd_width * 0.75, whiteView.hd_height - 20)];
 self.ContentTv.textAlignment = NSTextAlignmentCenter;
 self.ContentTv.layer.cornerRadius = 5;
 self.ContentTv.layer.masksToBounds = YES;
 self.ContentTv.backgroundColor = UIColorFromRGB(0xf7f7f7);
 self.ContentTv.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
 self.ContentTv.layer.borderWidth = 1;
 self.ContentTv.placeholder = self.placeHold;
 */

- (void)prepareChangeNameUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinTv)];
    [backView addGestureRecognizer:tap];
    
    //resinTv
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.94)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.117)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.108);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.108);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    
    self.ContentTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(20, self.tipView.hd_height * 0.045 + tipLB.hd_height, self.tipView.hd_width  - 40, self.tipView.hd_height * 0.64)];
    self.ContentTv.layer.cornerRadius = 5;
    self.ContentTv.layer.masksToBounds = YES;
    self.ContentTv.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.ContentTv.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.ContentTv.layer.borderWidth = 1;
    self.ContentTv.placeholder = self.placeHold;
    self.ContentTv.delegate = self;
    [self.tipView addSubview:self.ContentTv];
    
    self.textCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ContentTv.frame) - 80, CGRectGetMaxY(self.ContentTv.frame) - 20, 80, 20)];
    self.textCountLB.textColor = UIColorFromRGB(0x999999);
    self.textCountLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:self.textCountLB];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareRecordShotUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.4)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.27)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"继续录音" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消录音" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.1, self.tipView.hd_width, 20)];
    self.contentLB.text = @"录音需大于7秒，当前长度为秒";
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:self.contentLB];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareCallRollUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.64)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.27 / 3 * 2)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width * 0.5 - self.tipView.hd_width * 0.132, self.tipView.hd_height * 0.8, self.tipView.hd_width * 0.265, self.tipView.hd_height / 6);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];

    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.06, self.tipView.hd_width - 20 , 120)];
    self.contentLB.text = @"1.老师无需手动点名，直播课程会在结束后按照实际出勤情况自动刷新学院的出勤状态\n\n2.课程结束后，如有需要，老师仍可手动修改学员出勤状态";
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    
    self.contentLB.numberOfLines = 0;
    [self.tipView addSubview:self.contentLB];
    
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareshareToSchoolLibraryUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.44)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.27)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    //CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.06, self.tipView.hd_width, 45)];
    self.contentLB.text = @"确定要将《测试2》分享至学校作业库？";
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.numberOfLines = 0;
    [self.tipView addSubview:self.contentLB];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)preparedeleteTeacherCourseUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.55)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.2)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.75, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.184);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.75, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.184);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.06, self.tipView.hd_width, self.tipView.hd_height * 0.43)];
    self.contentLB.text = @"确定要将《测试2》分享至学校作业库？";
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.numberOfLines = 0;
    [self.tipView addSubview:self.contentLB];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareteacherAddCOurseUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.55)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.2)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.75, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.184);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.75, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.184);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
     // 添加上课日期 View
    UIView * startDayTimeView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.042, tipLB.hd_height + self.tipView.hd_height * 0.077, self.tipView.hd_width * 0.916, self.tipView.hd_height * 0.174)];
    startDayTimeView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:startDayTimeView];
    
    UILabel * startDayTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, startDayTimeView.hd_height)];
    startDayTimeLb.text = @"上课日期:";
    startDayTimeLb.textAlignment = NSTextAlignmentCenter;
    startDayTimeLb.font = [UIFont systemFontOfSize:16];
    startDayTimeLb.textColor = UIColorFromRGB(0x222222);
    [startDayTimeView addSubview:startDayTimeLb];
    
    self.addStartDayTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addStartDayTimeBtn.frame = CGRectMake(CGRectGetMaxX(startDayTimeLb.frame) + 5, startDayTimeView.hd_height * 0.25, startDayTimeView.hd_height * 0.5, startDayTimeView.hd_height * 0.5);
    [self.addStartDayTimeBtn setImage:[UIImage imageNamed:@"add_course_icon"] forState:UIControlStateNormal];
    [startDayTimeView addSubview:self.addStartDayTimeBtn];
    
    self.startDayTimePlaceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addStartDayTimeBtn.frame) + 5, 0, 110, startDayTimeView.hd_height)];
    self.startDayTimePlaceLB.text = @"选择上课日期";
    self.startDayTimePlaceLB.textColor = UIColorFromRGB(0x555555);
    self.startDayTimePlaceLB.font = [UIFont systemFontOfSize:16];
    [startDayTimeView addSubview:self.startDayTimePlaceLB];
    
    self.startDayTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startDayTimeLb.frame), 0, 100, startDayTimeView.hd_height)];
    self.startDayTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startDayTimeLB.font = [UIFont systemFontOfSize:16];
    [startDayTimeView addSubview:self.startDayTimeLB];
    
    self.changeStartDayTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartDayTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startDayTimeLB.frame) + 5,startDayTimeView.hd_height * 0.25, startDayTimeView.hd_height * 0.5, startDayTimeView.hd_height * 0.5);
    [self.changeStartDayTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [startDayTimeView addSubview:self.changeStartDayTimeBtn];
    
    self.startDayTimeLB.hidden = YES;
    self.changeStartDayTimeBtn.hidden = YES;
    
    UIButton * addStartDayTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addStartDayTimeBtn.frame = CGRectMake(CGRectGetMaxX(startDayTimeLb.frame), 0, 150, startDayTimeView.hd_height);
    [startDayTimeView addSubview:addStartDayTimeBtn];
    [addStartDayTimeBtn addTarget:self action:@selector(addStartDayTimeAcion) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加上课时间 View
    UIView * startTimeView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.042, CGRectGetMaxY(startDayTimeView.frame) + self.tipView.hd_height * 0.03, self.tipView.hd_width * 0.916, self.tipView.hd_height * 0.174)];
    startTimeView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:startTimeView];
    
    UILabel * startTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, startDayTimeView.hd_height)];
    startTimeLb.text = @"上课时间:";
    startTimeLb.textAlignment = NSTextAlignmentCenter;
    startTimeLb.font = [UIFont systemFontOfSize:16];
    startTimeLb.textColor = UIColorFromRGB(0x222222);
    [startTimeView addSubview:startTimeLb];
    
    self.addStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(startTimeLb.frame) + 5, startTimeView.hd_height * 0.25, startTimeView.hd_height * 0.5, startTimeView.hd_height * 0.5);
    [self.addStartTimeBtn setImage:[UIImage imageNamed:@"add_course_icon"] forState:UIControlStateNormal];
    [startTimeView addSubview:self.addStartTimeBtn];
    
    self.startTimePlaceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addStartTimeBtn.frame) + 5, 0, 140, startTimeView.hd_height)];
    self.startTimePlaceLB.text = @"点击添加上课时间";
    self.startTimePlaceLB.textColor = UIColorFromRGB(0x555555);
    self.startTimePlaceLB.font = [UIFont systemFontOfSize:16];
    [startTimeView addSubview:self.startTimePlaceLB];
    
    self.startTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startTimeLb.frame), 0, 100, startTimeView.hd_height)];
    self.startTimeLB.textColor = UIColorFromRGB(0x222222);
    self.startTimeLB.font = [UIFont systemFontOfSize:16];
    [startTimeView addSubview:self.startTimeLB];
    
    self.changeStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.startDayTimeLB.frame) + 5,startTimeView.hd_height * 0.25, startTimeView.hd_height * 0.5, startTimeView.hd_height * 0.5);
    [self.changeStartTimeBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [startTimeView addSubview:self.changeStartTimeBtn];
    
    UIButton * addStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addStartTimeBtn.frame = CGRectMake(CGRectGetMaxX(startTimeLb.frame), 0, 200, startTimeLb.hd_height);
    [startTimeView addSubview:addStartTimeBtn];
    [addStartTimeBtn addTarget:self action:@selector(addStartTimeAcion) forControlEvents:UIControlEventTouchUpInside];
    
    self.startTimeLB.hidden = YES;
    self.changeStartTimeBtn.hidden = YES;
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(addTimeAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.animation) {
        [self animationIn];
    }
}

- (void)preparechangeRepeatCountUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.526)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.211)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.73, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.193);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    //CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.73, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.193);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minusBtn.frame = CGRectMake(self.tipView.hd_width * 0.287, self.tipView.hd_height * 0.141 + tipLB.hd_height, self.tipView.hd_height * 0.155, self.tipView.hd_height * 0.155);
    [self.minusBtn setImage:[UIImage imageNamed:@"icon_reduce"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.minusBtn];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.tipView.hd_width * 0.635, self.tipView.hd_height * 0.141 + tipLB.hd_height, self.tipView.hd_height * 0.155, self.tipView.hd_height * 0.155);
    [self.addBtn setImage:[UIImage imageNamed:@"icon_increase"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.addBtn];
    
    self.repeatCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.minusBtn.frame) + 0.028 * self.tipView.hd_width, self.minusBtn.hd_y, self.tipView.hd_width * 0.207, self.minusBtn.hd_height)];
    self.repeatCountLB.layer.cornerRadius = 3;
    self.repeatCountLB.layer.masksToBounds = YES;
    self.repeatCountLB.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.repeatCountLB.layer.borderWidth = 1;
    self.repeatCountLB.textColor = UIColorFromRGB(0xFD8753);
    self.repeatCountLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:self.repeatCountLB];
    
    [self.minusBtn addTarget:self action:@selector(minusCountAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addTarget:self action:@selector(addCountAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.animation) {
        [self animationIn];
    }
}

- (void)prepareModifyAttendanceUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinChangeCostTF)];
    [backView addGestureRecognizer:tap];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.854)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.13)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.83, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.12);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    //CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.64, self.tipView.hd_width * 0.265, self.tipView.hd_height / 4);
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.83, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.12);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    UIView * changeStateView = [[UIView alloc]initWithFrame:CGRectMake(23, tipLB.hd_height + self.tipView.hd_height * 0.05, self.tipView.hd_width - 46, self.tipView.hd_height * 0.113)];
    changeStateView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:changeStateView];
    
    UILabel * attendanceStateLB = [[UILabel alloc]initWithFrame:CGRectMake(9, 0, 90, changeStateView.hd_height)];
    attendanceStateLB.text = @"选择状态：";
    attendanceStateLB.textColor = UIColorFromRGB(0x555555);
    [changeStateView addSubview:attendanceStateLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(attendanceStateLB.frame), 0, 100, changeStateView.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x555555);
    [changeStateView addSubview:self.stateLB];
    
    UIButton * changeStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeStateBtn.frame = CGRectMake(changeStateView.hd_width - 30, changeStateView.hd_height / 2 - 11, 23, 23);
    [changeStateBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [changeStateView addSubview:changeStateBtn];
    [changeStateBtn addTarget:self action:@selector(choceStateAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * changeCostView = [[UIView alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(changeStateView.frame) + self.tipView.hd_height * 0.02, self.tipView.hd_width - 46, self.tipView.hd_height * 0.113)];
    changeCostView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.tipView addSubview:changeCostView];

    
    UILabel * costLB = [[UILabel alloc]initWithFrame:CGRectMake(9, 0, 122, changeStateView.hd_height)];
    costLB.text = @"本节课耗数：";
    costLB.textColor = UIColorFromRGB(0x555555);
    [changeCostView addSubview:costLB];
    
    self.costTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(costLB.frame), 5, 73, changeCostView.hd_height - 10)];
    self.costTF.layer.cornerRadius = 2;
    self.costTF.layer.masksToBounds = YES;
    self.costTF.layer.borderWidth = 2;
    self.costTF.textAlignment = NSTextAlignmentCenter;
    self.costTF.layer.borderColor = UIColorFromRGB(0xededed).CGColor;
    self.costTF.text = @"1";
    self.costTF.keyboardType = UIKeyboardTypeNumberPad;
    [changeCostView addSubview:self.costTF];
    
    self.remarkLB = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(23, CGRectGetMaxY(changeCostView.frame) + self.tipView.hd_height * 0.03, self.tipView.hd_width - 46, 0.33 * self.tipView.hd_height)];
    self.remarkLB.placeholder = @" 请输入备注信息，此信息仅管理员和老师可见";
    self.remarkLB.delegate = self;
    self.remarkLB.layer.cornerRadius = 2;
    self.remarkLB.layer.masksToBounds = YES;
    self.remarkLB.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.remarkLB.layer.borderWidth = 1;
    self.remarkLB.textColor = UIColorFromRGB(0x333333);
    self.remarkLB.font = [UIFont systemFontOfSize:17];
    [self.tipView addSubview:self.remarkLB];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(changeAttendanceStateAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.animation) {
        [self animationIn];
    }
}

- (void)resetAttendanceView:(NSDictionary *)infoDic
{
    self.stateLB.text = [infoDic objectForKey:@"state"];
    self.costTF.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"cost"]];
    
}

- (void)changeAttendanceStateAction
{
    NSString * str = [NSString stringWithFormat:@"%d-???%@-???%@", self.attendanceState, self.costTF.text, self.remarkLB.text];
    if (self.ContinueBlock) {
        self.ContinueBlock(str);
    }
}

- (void)choceStateAction
{
    __weak typeof(self)weakSelf = self;
    [self.attendancePickerView appearWithTitle:@"选择状态" subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        weakSelf.attendanceState = path;
        weakSelf.stateLB.text = pathStr;
        [weakSelf.pickerView removeFromSuperview];
        
    } cancleAction:^{
        
    }];
}
- (void)resinChangeCostTF
{
    [self.costTF resignFirstResponder];
    [self.remarkLB resignFirstResponder];
}
- (void)addExplainBtn
{
    self.cancelBtn.hidden = YES;
    self.sureBtn.hd_centerX = self.tipView.hd_width / 2;
    [self.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
}

- (void)resetContentLbTetx:(NSString *)text
{
    self.contentLB.text = text;
}

- (void)resetSureBtnTitle:(NSString *)text
{
    [self.sureBtn setTitle:text forState:UIControlStateNormal];
}
- (void)resetCancelBtnTitle:(NSString *)text
{
    [self.cancelBtn setTitle:text forState:UIControlStateNormal];
}

- (void)resetRepeatCount:(NSString *)count
{
    self.repeatCountLB.text = count;
}

- (void)resetNameTvText:(NSString *)text
{
    if ([[text class] isEqual:[NSNull class]]) {
        self.ContentTv.text = @"";
        self.textCountLB.text = [NSString stringWithFormat:@"0/%d",self.maxCount];
    }else
    {
        self.ContentTv.text = text;
        self.textCountLB.text = [NSString stringWithFormat:@"%d/%d",text.length,self.maxCount];
    }
    
}

- (void)minusCountAction
{
    int count = self.repeatCountLB.text.intValue;
    if (count > 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.repeatCountLB.text = [NSString stringWithFormat:@"%d", count - 1];
        });
    }
}

- (void)addCountAction
{
    int count = self.repeatCountLB.text.intValue;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.repeatCountLB.text = [NSString stringWithFormat:@"%d", count + 1];
    });
}

#pragma mark - 完成
- (void)TextComplateAction
{
    [self.timeTF resignFirstResponder];
    if (self.timeTF.text.length > 0) {
        if (self.TextBlock) {
            self.TextBlock(self.timeTF.text);
        }
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (void)SearchTextComplateAction
{
    [self.ContentTv resignFirstResponder];
    self.ContentTv.text = self.searchStr;
    if (self.ContentTv.text.length > 0) {
        if (self.TextBlock) {
            self.TextBlock(self.ContentTv.text);
        }
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (void)cintinueAction
{
    NSString * str = @"";
    if (self.repeatCountLB.text.length > 0) {
        str = self.repeatCountLB.text;
    }
    if (self.ContentTv.text.length > 0) {
        str = self.ContentTv.text;
    }
    if (self.ContinueBlock) {
        self.ContinueBlock(str);
    }
}


#pragma mark - tima Operation
- (void)resinAction
{
    [self.timeTF resignFirstResponder];
    [self.ContentTv resignFirstResponder];
    if (self.searchStr) {
        self.ContentTv.text = self.searchStr;
    }
}

- (void)infiniteAction
{
    self.infiniteBtn.selected = YES;
    self.coustomBtn.selected = NO;
    self.timerType = TimerType_infinite;
}
- (void)coustomAction
{
    self.infiniteBtn.selected = NO;
    self.coustomBtn.selected = YES;
    self.timerType = TimerType_custom;
}
- (void)cancelAction
{
    [self.timeTF resignFirstResponder];
    if (self.animation) {
        [self animationOut];
    }else
    {
        if (self.DismissBlock) {
            self.DismissBlock();
        }
    }
}
- (void)sureAction
{
    if (self.timerType == TimerType_custom && self.timeTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else
    {
        if (self.TimerTypeBlock) {
            self.TimerTypeBlock(self.timerType, self.timeTF.text.intValue);
        }
    }
}

// 添加课程
- (void)addTimeAction
{
    if (self.startDayTimeLB.text.length == 0) {
        
        
        [SVProgressHUD showInfoWithStatus:@"请选择上课日期"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.startTimeLB.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择上课时间"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    NSArray * strArray = [self.startTimeLB.text componentsSeparatedByString:@"-"];
    
    
    if (self.teacherAddCourseBlock) {
        self.teacherAddCourseBlock(@{@"dayTime":self.startDayTimeLB.text,kbeginTime:[strArray firstObject],kminite:[strArray lastObject]});
    }
}

- (void)resinTv
{
    [self.ContentTv resignFirstResponder];
}

#pragma mark - textView delegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length > self.maxCount) {
        textView.text = [textView.text substringToIndex:self.maxCount];
    }
    self.textCountLB.text = [NSString stringWithFormat:@"%d/%d", textView.text.length, self.maxCount];
}

#pragma mark - textfiled delegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.searchStr = textView.text;
    if (self.SearchTextBlock) {
        self.SearchTextBlock(textView.text);
    }
}

#pragma mark - 添加课程日期
- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.bounds];
    }
    return _pickerView;
}

- (CourseTimePickerView *)courseTimePickerView
{
    if (!_courseTimePickerView) {
        _courseTimePickerView = [[CourseTimePickerView alloc]initWithFrame:self.bounds];
    }
    return _courseTimePickerView;
}

- (AttendanceStatePickerView *)attendancePickerView
{
    if (!_attendancePickerView) {
        _attendancePickerView = [[AttendanceStatePickerView alloc]initWithFrame:self.bounds];
    }
    return _attendancePickerView;
}

- (void)addStartDayTimeAcion
{
    __weak typeof(self)weakSelf = self;
    [self.pickerView appearWithTitle:@"选择日期(北京时间)" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
        formatter1.dateFormat = @"yyyy年MM月dd日";
        NSDate * date = [formatter1 dateFromString:pathStr];
        NSString * currentDateStr = [formatter stringFromDate:date];
        
        NSString *dateStr = [NSString stringWithFormat:@"%@(%@)", currentDateStr, [self getWeekDay:date]];
        weakSelf.startDayTimeLB.text = dateStr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.addStartDayTimeBtn.hidden = YES;
            weakSelf.startDayTimePlaceLB.hidden = YES;
            weakSelf.startDayTimeLB.hidden = NO;
            weakSelf.changeStartDayTimeBtn.hidden = NO;
            
            weakSelf.startDayTimeLB.hd_width = [dateStr boundingRectWithSize:CGSizeMake(MAXFLOAT, weakSelf.startDayTimeLB.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width + 10;
            weakSelf.changeStartDayTimeBtn.hd_x = CGRectGetMaxX(weakSelf.startDayTimeLB.frame);
        });
        
        
        [weakSelf.pickerView removeFromSuperview];
        
    } cancleAction:^{
        
    }];
}

- (void)addStartTimeAcion
{
    __weak typeof(self)weakSelf = self;
    [self.courseTimePickerView appearWithTitle:@"选择时间(北京时间)" subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        
        
        weakSelf.startTimeLB.text = pathStr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.addStartTimeBtn.hidden = YES;
            weakSelf.startTimePlaceLB.hidden = YES;
            weakSelf.startTimeLB.hidden = NO;
            weakSelf.changeStartTimeBtn.hidden = NO;
            
            weakSelf.startTimeLB.hd_width = [pathStr boundingRectWithSize:CGSizeMake(MAXFLOAT, weakSelf.startTimeLB.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width + 10;
            weakSelf.changeStartTimeBtn.hd_x = CGRectGetMaxX(weakSelf.startTimeLB.frame);
        });
        
        [weakSelf.pickerView removeFromSuperview];
        
    } cancleAction:^{
        
    }];
}

- (NSString *)getWeekDay:(NSDate *)date
{
    NSArray *weekdays = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return weekdays[[comps weekday] - 1];
}


#pragma mark - animation
- (void)animationIn
{
    self.tipView.center = CGPointMake(self.hd_centerX, self.hd_centerY);
    CAKeyframeAnimation * rectAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rectAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, -self.tipView.hd_height / 2)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY + 50)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY)]];
    
    rectAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.85], [NSNumber numberWithFloat:1]];
    
    rectAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    rectAnimation.repeatCount = 1;
    rectAnimation.calculationMode = kCAAnimationLinear;
    rectAnimation.autoreverses = NO;
    rectAnimation.duration = 0.35;
    [self.tipView.layer addAnimation:rectAnimation forKey:@"rectInAnimation"];
    
}

- (void)animationOut
{
    self.tipView.center = CGPointMake(self.hd_centerX, -self.tipView.hd_height / 2);
    CAKeyframeAnimation * rectAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rectAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY + 50)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, -self.tipView.hd_height / 2)]];
    
    rectAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.15], [NSNumber numberWithFloat:1]];
    
    rectAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    rectAnimation.autoreverses = NO;
    rectAnimation.repeatCount = 1;
    rectAnimation.calculationMode = kCAAnimationLinear;
    rectAnimation.duration = 0.35;
    [self.tipView.layer addAnimation:rectAnimation forKey:@"rectInAnimation"];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.backView.alpha = 0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.DismissBlock) {
            self.DismissBlock();
        }
    });
    
}

@end
