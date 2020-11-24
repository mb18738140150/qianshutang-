//
//  SelectDayCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SelectDayCollectionViewCell.h"

@interface SelectDayCollectionViewCell()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * weekLB;
@property (nonatomic, strong)UILabel * dayLB;

@property (nonatomic, strong)UIView * haveCourseView;

@end

@implementation SelectDayCollectionViewCell

- (void)resetWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width / 2 - (self.hd_height - 10) / 2, 5, self.hd_height - 10, self.hd_height - 10)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = self.backView.hd_height / 2;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    self.weekLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.backView.hd_height * 0.2, self.backView.hd_width, self.backView.hd_height * 0.3)];
    self.weekLB.textAlignment = NSTextAlignmentCenter;
    self.weekLB.textColor = UIColorFromRGB(0x656565);
    [self.backView addSubview:self.weekLB];
    
    self.dayLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekLB.frame) , self.backView.hd_width, self.weekLB.hd_height)];
    self.dayLB.textAlignment = NSTextAlignmentCenter;
    self.dayLB.textColor = UIColorFromRGB(0x656565);
    [self.backView addSubview:self.dayLB];
    
    self.weekLB.text = [infoDic objectForKey:@"weekDay"];
    self.dayLB.text = [[infoDic objectForKey:@"dateStr"] substringFromIndex:8];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSString * date = [formatter stringFromDate:[NSDate date]];
    
    if ([date isEqualToString:[infoDic objectForKey:@"dateStr"]]) {
        self.backView.backgroundColor = UIColorFromRGB(0xdddddd);
    }
    
    self.haveCourseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.backView.hd_height * 0.9, self.backView.hd_height * 0.1, self.backView.hd_height * 0.1)];
    self.haveCourseView.hd_centerX = self.dayLB.hd_centerX;
    self.haveCourseView.layer.cornerRadius = self.haveCourseView.hd_height / 2;
    self.haveCourseView.layer.masksToBounds = YES;
    self.haveCourseView.backgroundColor = [UIColor orangeColor];
    [self.backView addSubview:self.haveCourseView];
    self.haveCourseView.hidden = YES;
}

- (void)selectReset
{
    self.backView.backgroundColor = kMainColor;
    self.weekLB.textColor = [UIColor whiteColor];
    self.dayLB.textColor = [UIColor whiteColor];
    
    self.haveCourseView.hidden = YES;
}

- (void)isHaveCourse:(BOOL)isHaveCourse
{
    self.haveCourseView.hidden = !isHaveCourse;
}

@end
