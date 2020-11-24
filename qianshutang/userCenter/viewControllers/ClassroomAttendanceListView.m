//
//  ClassroomAttendanceListView.m
//  qianshutang
//
//  Created by aaa on 2018/11/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomAttendanceListView.h"
#define kUnitWidth  ((kScreenWidth - 10 - 16) / 11)
#define kTitleLBTag     1000

@implementation ClassroomAttendanceListView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    for (int i = 0; i < 10; i++) {
        UILabel * titleLB = [[UILabel alloc]init];
        titleLB.tag = kTitleLBTag + i;
        if (i == 0) {
            titleLB.frame = CGRectMake(0, 0, kUnitWidth * 2, self.hd_height);
        }else
        {
            titleLB.frame = CGRectMake(kUnitWidth * (i + 1) + i, 0, kUnitWidth, self.hd_height);
        }
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.textColor = kCommonMainTextColor_50;
        titleLB.font = kMainFont;
        [self.titleArray addObject:titleLB];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:titleLB.frame];
        imageView.tag = kTitleLBTag + i;
        [self.imageArray addObject:imageView];
        imageView.image = [UIImage imageNamed:@"attendance_right"];
        imageView.hidden = YES;
        
        UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, 1, self.hd_height)];
        seperateLine.backgroundColor = UIColorFromRGB(0xf7f7f7);
        
        [self addSubview:titleLB];
        [self addSubview:imageView];
        [self addSubview:seperateLine];
    }
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 1, self.hd_width, 1)];
    bottomLine.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self addSubview:bottomLine];
}

- (void)refreshUIWith:(NSDictionary *)infoDic andDataArray:(NSArray *)dataArray andPage:(int )day
{
    UILabel * titleLB = [self.titleArray firstObject];
    titleLB.text = [infoDic objectForKey:kUserName];
    
    int total = 0;
    if ((day + 1) * 9 < dataArray.count) {
        total = (day + 1) * 9;
    }else
    {
        total = dataArray.count;
    }
    
    for (int i = 0; i < 9; i++) {
        UILabel * contentLB = [self.titleArray objectAtIndex:i+ 1];
        UILabel * imageView = [self.imageArray objectAtIndex:i + 1];
        
        if (day * 9 + i >= dataArray.count) {
            return;
        }
        
        NSDictionary * infoDic = [dataArray objectAtIndex:day * 9 + i];
        if ([[infoDic objectForKey:@"state"] intValue] == 100) {
            contentLB.text = [infoDic objectForKey:kUnitName];
        }else if ([[infoDic objectForKey:@"state"] intValue] == 1 || [[infoDic objectForKey:@"state"] intValue] == 4  || [[infoDic objectForKey:@"state"] intValue] == 5)
        {
            contentLB.hidden = YES;
            imageView.hidden = NO;
        }else if ([[infoDic objectForKey:@"state"] intValue] == 0)
        {
            contentLB.text = @"未出勤";
            contentLB.textColor = kCommonMainOringeColor;
        }else if ([[infoDic objectForKey:@"state"] intValue] == 2)
        {
            contentLB.text = @"请假";
            contentLB.textColor = kCommonMainOringeColor;
        }else if ([[infoDic objectForKey:@"state"] intValue] == 3)
        {
            contentLB.text = @"旷课";
            contentLB.textColor = kCommonMainOringeColor;
        }
        
    }
    
}

@end
