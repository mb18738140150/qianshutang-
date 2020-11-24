//
//  TodayCourseCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TodayCourseCollectionViewCell.h"

@interface TodayCourseCollectionViewCell()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UIImageView * courseTypeImageView;
@property (nonatomic, strong)UILabel * courseTypeLB;
@property (nonatomic, strong)UIButton * courseDetailBtn;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * livingTimeLB;
@property (nonatomic, strong)UILabel * courseNameLB;
@property (nonatomic, strong)UILabel * classroomLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * courseTeacherLB;
@property (nonatomic, strong)UIButton * watchBtn;

@end

@implementation TodayCourseCollectionViewCell

- (void)resetWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.116, 0, self.hd_width * 0.77, self.hd_height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backViewHeight = self.backView.hd_height;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 7, self.backView.hd_width - 18, self.backView.hd_height * 0.486)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"courseImageUrl"]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    [self.backView addSubview:self.imageView];
    
    self.courseTypeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 19, backViewWidth * 0.295, backViewHeight * 0.107)];
    self.courseTypeImageView.image = [UIImage imageNamed:@"one_to_many"];
    [self.backView addSubview:self.courseTypeImageView];
    
    self.courseTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.courseTypeImageView.hd_height * 0.25, self.courseTypeImageView.hd_width - self.courseTypeImageView.hd_width * 0.12, self.courseTypeImageView.hd_height * 0.5)];
    self.courseTypeLB.textColor = [UIColor whiteColor];
    self.courseTypeLB.text = [infoDic objectForKey:@"courseTypeName"];
    self.courseTypeLB.adjustsFontSizeToFitWidth = YES;
    self.courseTypeLB.textAlignment = NSTextAlignmentCenter;
    [self.courseTypeImageView addSubview:self.courseTypeLB];
    
    self.courseDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.courseDetailBtn.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - backViewWidth * 0.2, self.imageView.hd_y, backViewWidth * 0.2, backViewHeight * 0.134);
    self.courseDetailBtn.backgroundColor = kMainColor;
    [self.courseDetailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.courseDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBezierPath * detailBtnPath = [UIBezierPath bezierPathWithRoundedRect:self.courseDetailBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.courseDetailBtn.bounds;
    layer.path = detailBtnPath.CGPath;
    [self.courseDetailBtn.layer setMask:layer];
    [self.backView addSubview:self.courseDetailBtn];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.imageView.hd_width * 0.1, self.imageView.hd_height * 0.387, self.imageView.hd_width * 0.8, self.imageView.hd_height * 0.232)];
    self.timeLB.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.textColor = [UIColor whiteColor];
    self.timeLB.font = [UIFont systemFontOfSize:14];
    self.timeLB.layer.cornerRadius = self.timeLB.hd_height / 2;
    self.timeLB.layer.masksToBounds = YES;
    self.timeLB.attributedText = [self getTimeStrWithHour:1 andMinute:15 andSec:28];
    [self.imageView addSubview:self.timeLB];
    
    self.livingTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.hd_height - 20, self.imageView.hd_width, 20)];
    self.livingTimeLB.textColor = [UIColor whiteColor];
    self.livingTimeLB.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.livingTimeLB.textAlignment = NSTextAlignmentCenter;
    self.livingTimeLB.font = [UIFont systemFontOfSize:14];
    self.livingTimeLB.text = [infoDic objectForKey:@"beginendTime"];
    [self.imageView addSubview:self.livingTimeLB];
    
    self.courseNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.imageView.hd_x, CGRectGetMaxY(self.imageView.frame) + backViewHeight * 0.04, backViewWidth - 19, backViewHeight * 0.053)];
    self.courseNameLB.textColor = UIColorFromRGB(0x6d6d6d);
    self.courseNameLB.text = [infoDic objectForKey:@"unitTitle"];
    [self.backView addSubview:self.courseNameLB];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(self.imageView.hd_x, CGRectGetMaxY(self.courseNameLB.frame) + backViewHeight * 0.086, backViewWidth - 19, backViewHeight * 0.053)];
    self.classroomLB.textColor = UIColorFromRGB(0x6d6d6d);
    self.classroomLB.text = [NSString stringWithFormat:@"班级:%@", [infoDic objectForKey:kClassroomName]];
    [self.backView addSubview:self.classroomLB];
    
    UIView * separateLine = [[UIView alloc]initWithFrame:CGRectMake(self.imageView.hd_x, CGRectGetMaxY(self.classroomLB.frame) + backViewHeight * 0.04, backViewWidth - 18, 1)];
    separateLine.backgroundColor = UIColorFromRGB(0xdcdcdc);
    [self.backView addSubview:separateLine];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.imageView.hd_x, CGRectGetMaxY(separateLine.frame) + backViewHeight * 0.04, backViewHeight * 0.129, backViewHeight * 0.129)];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"teacherIconUrl"]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    [self.backView addSubview:self.iconImageView];
    
    self.courseTeacherLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10, CGRectGetMaxY(separateLine.frame) + backViewHeight * 0.08, backViewWidth * 0.357, backViewHeight * 0.053)];
    self.courseTeacherLB.textColor = UIColorFromRGB(0x6d6d6d);
    self.courseTeacherLB.text = [infoDic objectForKey:kTeacherName];
    [self.backView addSubview:self.courseTeacherLB];
    
    self.watchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.watchBtn.frame = CGRectMake(backViewWidth * 0.557, self.iconImageView.hd_y, backViewWidth * 0.4, self.iconImageView.hd_height);
    self.watchBtn.backgroundColor = kMainColor;
    [self.watchBtn setTitle:@"进入教室" forState:UIControlStateNormal];
    [self.watchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.watchBtn.layer.cornerRadius = self.watchBtn.hd_height / 2;
    self.watchBtn.layer.masksToBounds = YES;
    [self.backView addSubview:self.watchBtn];
    
}

- (NSAttributedString *)getTimeStrWithHour:(NSInteger)hour andMinute:(NSInteger)minute andSec:(NSInteger)second
{
    NSString * timeString = [NSString stringWithFormat:@"距离开课%ld时%ld分%ld秒", (long)hour,(long)minute,(long)second];
    
    NSRange secrange = [timeString rangeOfString:[NSString stringWithFormat:@"%ld秒", (long)second]];
    NSRange hourRange = [timeString rangeOfString:[NSString stringWithFormat:@"%ld时", (long)hour]];
    NSRange minuteRange = [timeString rangeOfString:[NSString stringWithFormat:@"%ld分", (long)minute]];
    
    NSMutableAttributedString * mTimeStr = [[NSMutableAttributedString alloc]initWithString:timeString];
    
    NSDictionary * timeAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0xFFCE54)};
    [mTimeStr setAttributes:timeAttribute range:NSMakeRange(hourRange.location, hourRange.length - 1)];
    [mTimeStr setAttributes:timeAttribute range:NSMakeRange(minuteRange.location, minuteRange.length - 1)];
    [mTimeStr setAttributes:timeAttribute range:NSMakeRange(secrange.location, secrange.length - 1)];
    
    return mTimeStr;
}

@end
