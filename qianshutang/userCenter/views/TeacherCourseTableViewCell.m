//
//  TeacherCourseTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherCourseTableViewCell.h"

@implementation TeacherCourseTableViewCell

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
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.courseLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.classroomLB.textColor = UIColorFromRGB(0x585858);
    self.classroomLB.text = [infoDic objectForKey:kClassroomName];
    self.classroomLB.font = [UIFont systemFontOfSize:15];
    self.classroomLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.classroomLB];
    
    self.progressLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.classroomLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.progressLB.textColor = UIColorFromRGB(0x585858);
    self.progressLB.text = [NSString stringWithFormat:@"%@/%@", [infoDic objectForKey:@"complateSection"],[infoDic objectForKey:@"totalSection"]];
    self.progressLB.font = [UIFont systemFontOfSize:15];
    self.progressLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.progressLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.progressLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.countLB.textColor = UIColorFromRGB(0x585858);
    self.countLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"userNum"]];
    self.countLB.font = [UIFont systemFontOfSize:15];
    self.countLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.countLB];
    
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.countLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:@"state"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
