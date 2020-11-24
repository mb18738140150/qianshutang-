//
//  CalendarPickerView.m
//  qianshutang
//
//  Created by aaa on 2018/9/4.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CalendarPickerView.h"

#import "ZMCalendarPicker.h"
#import "UIColor+HEXString.h"
#import "UIView+FRAME.h"

#define kOneYear  60 * 60 * 24 * 365
#define kOneMonth 60 * 60 * 24 * 30
#define kOneDay   60 * 60 * 24

@interface CalendarPickerView()<ZMCalendarPickerDelegate>
/**
 *  normalPickView
 */
@property (nonatomic, weak) ZMCalendarPicker *normalPick;

@property (nonatomic, strong)UILabel * studyDaysLB;
@property (nonatomic, strong)UILabel * textCountLB;
@property (nonatomic, strong)UILabel * studyMinutesLB;

@property (nonatomic, strong)NSArray * dataArray;

@end

@implementation CalendarPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.studyDaysLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 3 , kScreenHeight * 0.09)];
    self.studyDaysLB.textColor = UIColorFromRGB(0x333333);
    self.studyDaysLB.textAlignment = NSTextAlignmentCenter;
    self.studyDaysLB.attributedText = [self getLB1:[NSString stringWithFormat:@"坚持学习天数%@天", @(13)]];
    [self addSubview:self.studyDaysLB];
    
    self.textCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studyDaysLB.frame), 0, self.hd_width / 3 , kScreenHeight * 0.09)];
    self.textCountLB.textColor = UIColorFromRGB(0x333333);
    self.textCountLB.textAlignment = NSTextAlignmentCenter;
    self.textCountLB.attributedText = [self getLB1:[NSString stringWithFormat:@"累计学习课文%@篇", @(13)]];
    [self addSubview:self.textCountLB];
    
    self.studyMinutesLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textCountLB.frame), 0, self.hd_width / 3 , kScreenHeight * 0.09)];
    self.studyMinutesLB.textColor = UIColorFromRGB(0x333333);
    self.studyMinutesLB.textAlignment = NSTextAlignmentCenter;
    self.studyMinutesLB.attributedText = [self getLB1:[NSString stringWithFormat:@"今日学习%@分钟", @(13)]];
    [self addSubview:self.studyMinutesLB];
    
    self.normalPick.frame = CGRectMake(kScreenWidth * 0.04 - 7, self.studyDaysLB.hd_height + kScreenHeight * 0.03, kScreenWidth * 0.72, kScreenHeight * 0.73);
}

- (NSMutableAttributedString * )getLB1:(NSString *)string
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD7D44)};
    [mStr setAttributes:attribute range:NSMakeRange(6, string.length - 7)];
    
    return mStr;
}
- (NSMutableAttributedString * )getLB2:(NSString *)string
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD7D44)};
    [mStr setAttributes:attribute range:NSMakeRange(4, string.length - 6)];
    
    return mStr;
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.studyDaysLB.attributedText = [self getLB1:[NSString stringWithFormat:@"坚持学习天数%@天", [infoDic objectForKey:@"studyDay"]]];
    self.textCountLB.attributedText = [self getLB1:[NSString stringWithFormat:@"累计学习课文%@篇", [infoDic objectForKey:@"studyPart"]]];
    self.studyMinutesLB.attributedText = [self getLB1:[NSString stringWithFormat:@"今日学习%@分钟", [infoDic objectForKey:@"studyMinite"]]];
    self.dataArray = [infoDic objectForKey:@"data"];
    [self.normalPick refreshWith:self.dataArray];
}

#pragma mark - 懒加载
- (ZMCalendarPicker *)normalPick {
    if (!_normalPick) {
        ZMCalendarPicker *picker = [[ZMCalendarPicker alloc] init];
        picker.targetDate = [NSDate date];
        picker.startDate = [NSDate dateWithTimeInterval:- kOneYear - kOneMonth * 3 sinceDate:picker.targetDate];
        picker.endDate = [NSDate dateWithTimeInterval:kOneDay sinceDate:picker.targetDate];
        picker.delegate = self;
        [self addSubview:picker];
        _normalPick = picker;
    }
    return _normalPick;
}

@end
