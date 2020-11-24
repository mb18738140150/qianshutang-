//
//  ClassmemberAchievementCustomTimeView.m
//  qianshutang
//
//  Created by aaa on 2018/9/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassmemberAchievementCustomTimeView.h"
#import "SelectTextBookView.h"

@interface ClassmemberAchievementCustomTimeView()

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;


@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)SelectTextBookView * startTextView;
@property (nonatomic, strong)SelectTextBookView * endTextView;

@property (nonatomic, strong)NSDate * startDate;
@property (nonatomic, strong)NSDate * endDate;

@property (nonatomic, strong)GSPickerView * pickerView;

@end

@implementation ClassmemberAchievementCustomTimeView

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.bounds];
    }
    return _pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.6)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.183)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.76, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.168);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.76, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.168);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.startTextView = [[SelectTextBookView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.043, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.073, self.tipView.hd_width * 0.914, self.tipView.hd_height * 0.183)];
    self.startTextView.numberLB.text = @"";
    self.startTextView.titleLB.text = @"选择起始时间:";
    self.startTextView.contentTF.placeholder = @"点击此处选择起始时间";
    
    self.endTextView = [[SelectTextBookView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.043, CGRectGetMaxY(self.startTextView.frame) + self.tipView.hd_height * 0.073, self.tipView.hd_width * 0.914, self.tipView.hd_height * 0.183)];
    self.endTextView.numberLB.text = @"";
    self.endTextView.titleLB.text = @"选择截止时间:";
    self.endTextView.contentTF.placeholder = @"点击此处选择截止时间";
    
    [self.startTextView hideNumberLB];
    [self.endTextView hideNumberLB];
    
    [self.tipView addSubview:self.startTextView];
    [self.tipView addSubview:self.endTextView];
    
    __weak typeof(self)weakSelf = self;
    self.startTextView.selectBlock = ^{
        [weakSelf startTimeAction];
    };
    self.endTextView.selectBlock = ^{
        [weakSelf endTimeAction];
    };
}

- (void)startTimeAction
{
    __weak typeof(self)weakSelf = self;
    [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        
        NSDateFormatter * formater1 = [[NSDateFormatter alloc]init];
        formater1.dateFormat = @"yyyy年MM月dd日";
        NSDateFormatter * formater2 = [[NSDateFormatter alloc]init];
        formater2.dateFormat = @"yyyy/MM/dd";
        NSDate * date = [formater1 dateFromString:pathStr];
        weakSelf.startDate = date;
        NSString * dateStr = [formater2 stringFromDate:date];
        weakSelf.startTextView.contentTF.text = dateStr;
        
    } cancleAction:^{
        
    }];
}

- (void)endTimeAction
{
    __weak typeof(self)weakSelf = self;
    [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        
        NSDateFormatter * formater1 = [[NSDateFormatter alloc]init];
        formater1.dateFormat = @"yyyy年MM月dd日";
        NSDateFormatter * formater2 = [[NSDateFormatter alloc]init];
        formater2.dateFormat = @"yyyy/MM/dd";
        NSDate * date = [formater1 dateFromString:pathStr];
        weakSelf.endDate = date;
        NSString * dateStr = [formater2 stringFromDate:date];
        weakSelf.endTextView.contentTF.text = dateStr;
        
    } cancleAction:^{
        
    }];
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)cintinueAction
{
    if (!(self.startDate != nil && self.endDate != nil)) {
        [SVProgressHUD showInfoWithStatus:@"起止日期均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
     NSTimeInterval secondsBetweenDates = [self.endDate timeIntervalSinceDate:self.startDate];
    
    if (secondsBetweenDates < 0) {
        [SVProgressHUD showInfoWithStatus:@"起始时间不能晚于截止时间"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    
    if (self.continueBlock) {
        self.continueBlock(@{@"startTime":self.startTextView.contentTF.text, @"endTime":self.endTextView.contentTF.text, @"title":[NSString stringWithFormat:@"%@-%@", self.startTextView.contentTF.text, self.endTextView.contentTF.text]});
    }
    [self removeFromSuperview];
}

@end
