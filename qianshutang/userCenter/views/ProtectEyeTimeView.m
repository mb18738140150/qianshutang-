//
//  ProtectEyeTimeView.m
//  qianshutang
//
//  Created by aaa on 2018/8/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProtectEyeTimeView.h"

@interface ProtectEyeTimeView()
@property (nonatomic, strong)NSString * title;
@property (nonatomic, assign)BOOL animation;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UIButton * infinitBtn;
@property (nonatomic, strong)UIButton * fifteenBtn;
@property (nonatomic, strong)UIButton * thirtyBtn;
@property (nonatomic, strong)UIButton * fortyfiveBtn;

@property (nonatomic, strong)UIButton * infinitBtn_1;
@property (nonatomic, strong)UIButton * fifteenBtn_1;
@property (nonatomic, strong)UIButton * thirtyBtn_1;
@property (nonatomic, strong)UIButton * fortyfiveBtn_1;


@property (nonatomic, strong)UILabel * contentLB;

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSString * time;
@property (nonatomic, strong)NSMutableArray * timeArray;

@end


@implementation ProtectEyeTimeView

- (instancetype)initWithFrame:(CGRect)frame andTime:(NSString *)time
{
    if (self = [super initWithFrame:frame]) {
        self.time = time;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
//    self.time
    
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.56)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.2)];
    tipLB.text = @"设置提醒时长";
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_height / 5, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_height / 5 - self.tipView.hd_height * 0.45, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_height * 0.07, self.tipView.hd_height * 0.07 + tipLB.hd_height, self.tipView.hd_width - self.tipView.hd_height * 0.14, self.tipView.hd_height / 6)];
    firstView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.tipView addSubview:firstView];
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(self.tipView.hd_height * 0.07, 12 + CGRectGetMaxY(firstView.frame), self.tipView.hd_width - self.tipView.hd_height * 0.14, self.tipView.hd_height / 6)];
    secondView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.tipView addSubview:secondView];
    
    self.infinitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.infinitBtn.frame = CGRectMake(self.cancelBtn.hd_x + 20, firstView.hd_y + self.tipView.hd_height * 0.023, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.infinitBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.infinitBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.infinitBtn];
    
    UILabel * infiniteLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.infinitBtn.frame) + 5, self.infinitBtn.hd_y, 60, self.infinitBtn.hd_height)];
    infiniteLB.text = @"无限制";
    infiniteLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:infiniteLB];
    
    self.fifteenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fifteenBtn.frame = CGRectMake(CGRectGetMinX(self.sureBtn.frame)  + 5, self.infinitBtn.hd_y, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.fifteenBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.fifteenBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.fifteenBtn];
    UILabel * fifteenLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.fifteenBtn.frame) + 5, self.fifteenBtn.hd_y, 60, self.fifteenBtn.hd_height)];
    fifteenLB.text = @"15分钟";
    fifteenLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:fifteenLB];
    
    
    self.thirtyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirtyBtn.frame = CGRectMake(self.cancelBtn.hd_x + 20, secondView.hd_y + self.tipView.hd_height * 0.023, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.thirtyBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.thirtyBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.thirtyBtn];
    
    UILabel * thirtyLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.thirtyBtn.frame) + 5, self.thirtyBtn.hd_y, 60, self.thirtyBtn.hd_height)];
    thirtyLB.text = @"30分钟";
    thirtyLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:thirtyLB];
    
    self.fortyfiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fortyfiveBtn.frame = CGRectMake(CGRectGetMinX(self.sureBtn.frame)  + 5, self.thirtyBtn.hd_y, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.fortyfiveBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.fortyfiveBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.fortyfiveBtn];
    UILabel * fortyfiveLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.fortyfiveBtn.frame) + 5, self.fortyfiveBtn.hd_y, 60, self.fortyfiveBtn.hd_height)];
    fortyfiveLB.text = @"45分钟";
    fortyfiveLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:fortyfiveLB];
    
    
    self.infinitBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.infinitBtn_1.frame = CGRectMake(firstView.hd_x, firstView.hd_y , firstView.hd_width / 2, firstView.hd_height);
    [self.tipView addSubview:self.infinitBtn_1];
    
    self.fifteenBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fifteenBtn_1.frame = CGRectMake(firstView.hd_centerX, firstView.hd_y , firstView.hd_width / 2, firstView.hd_height);
    [self.tipView addSubview:self.fifteenBtn_1];
    
    self.thirtyBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirtyBtn_1.frame = CGRectMake(secondView.hd_x, secondView.hd_y , secondView.hd_width / 2, secondView.hd_height);
    [self.tipView addSubview:self.thirtyBtn_1];
    
    self.fortyfiveBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fortyfiveBtn_1.frame = CGRectMake(secondView.hd_centerX, secondView.hd_y , secondView.hd_width / 2, secondView.hd_height);
    [self.tipView addSubview:self.fortyfiveBtn_1];
    
    
    [self.infinitBtn_1 addTarget:self action:@selector(infiniteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fifteenBtn_1 addTarget:self action:@selector(infiniteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.thirtyBtn_1 addTarget:self action:@selector(infiniteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fortyfiveBtn_1 addTarget:self action:@selector(infiniteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.time isEqualToString:@"无限制"]) {
        self.infinitBtn.selected = YES;
    }else if ([self.time isEqualToString:@"15"])
    {
        self.fifteenBtn.selected = YES;
    }else if ([self.time isEqualToString:@"30"])
    {
        self.thirtyBtn.selected = YES;
    }else
    {
        self.fortyfiveBtn.selected = YES;
    }
    
    self.timeArray = [NSMutableArray array];
    [self.timeArray addObject:self.infinitBtn];
    [self.timeArray addObject:self.fifteenBtn];
    [self.timeArray addObject:self.thirtyBtn];
    [self.timeArray addObject:self.fortyfiveBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)infiniteAction:(UIButton *)button
{
    for (UIButton * button in self.timeArray) {
        button.selected = NO;
    }
    if ([button isEqual:self.infinitBtn_1]) {
        self.infinitBtn.selected = YES;
        self.time = @"0";;
    }else if ([button isEqual:self.fifteenBtn_1])
    {
        self.fifteenBtn.selected = YES;
        self.time = @"15";
    }else if ([button isEqual:self.thirtyBtn_1])
    {
        self.thirtyBtn.selected = YES;
        self.time = @"30";
    }else
    {
        self.fortyfiveBtn.selected = YES;
        self.time = @"45";
    }
}

- (void)sureAction
{
    if (self.NotifySelectBlock) {
        self.NotifySelectBlock(self.time);
    }
}

- (void)cancelAction
{
    if (self.DismissBlock) {
        self.DismissBlock();
    }
}

@end
