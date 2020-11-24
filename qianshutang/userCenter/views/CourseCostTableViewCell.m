//
//  CourseCostTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CourseCostTableViewCell.h"

@implementation CourseCostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 3, self.hd_height)];
    self.classroomLB.textColor = UIColorFromRGB(0x585858);
    self.classroomLB.text = [infoDic objectForKey:kClassroomName];
    self.classroomLB.font = [UIFont systemFontOfSize:15];
    self.classroomLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.classroomLB];
    
    self.courseCostLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.classroomLB.frame), 0, self.hd_width /3, self.hd_height)];
    self.courseCostLB.textColor = UIColorFromRGB(0x585858);
    self.courseCostLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kCost]];
    self.courseCostLB.font = [UIFont systemFontOfSize:15];
    self.courseCostLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.courseCostLB];
    
    self.surplusLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.courseCostLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.surplusLB.textColor = UIColorFromRGB(0x585858);
    self.surplusLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kLeaveClassHour]];
    self.surplusLB.font = [UIFont systemFontOfSize:15];
    self.surplusLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.surplusLB];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
