//
//  MycourseTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MycourseTableViewCell.h"

@implementation MycourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.courseLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width * 0.25, self.hd_height)];
    self.courseLB.textColor = UIColorFromRGB(0x585858);
    self.courseLB.text = [infoDic objectForKey:kCourseName];
    self.courseLB.font = [UIFont systemFontOfSize:15];
    self.courseLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.courseLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.courseLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.teacherLB.textColor = UIColorFromRGB(0x585858);
    self.teacherLB.text = [infoDic objectForKey:kTeacherName];
    self.teacherLB.font = [UIFont systemFontOfSize:15];
    self.teacherLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.teacherLB];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.teacherLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.classroomLB.textColor = UIColorFromRGB(0x585858);
    self.classroomLB.text = [infoDic objectForKey:kClassroomName];
    self.classroomLB.font = [UIFont systemFontOfSize:15];
    self.classroomLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.classroomLB];
    
    self.progressLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.classroomLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.progressLB.textColor = UIColorFromRGB(0x585858);
    self.progressLB.text = [NSString stringWithFormat:@"%@/%@", [infoDic objectForKey:kComplateSection], [infoDic objectForKey:kTotalSection]];
    self.progressLB.font = [UIFont systemFontOfSize:15];
    self.progressLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.progressLB];
    
    if (self.isCourse) {
        self.classroomLB.hidden = YES;
        self.progressLB.frame = CGRectMake(CGRectGetMaxX(self.teacherLB.frame), 0, self.hd_width * 0.25, self.hd_height);
        
        self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.classroomLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
        self.timeLB.textColor = UIColorFromRGB(0x585858);
        if ([[infoDic objectForKey:kbeginendTime] class] == [NSNull class] || [infoDic objectForKey:kbeginendTime] == nil || [[infoDic objectForKey:kbeginendTime] isEqualToString:@""]) {
            self.timeLB.text = @"";
        }else{
            self.timeLB.text = [infoDic objectForKey:kbeginendTime];
        }
        self.timeLB.font = [UIFont systemFontOfSize:15];
        self.timeLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timeLB];
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
