//
//  TeacherAttendanceListCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherAttendanceListCell.h"

@implementation TeacherAttendanceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.studentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 3, self.hd_height)];
    self.studentLB.textColor = UIColorFromRGB(0x585858);
    self.studentLB.text = [infoDic objectForKey:kUserName];
    self.studentLB.font = [UIFont systemFontOfSize:15];
    self.studentLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.studentLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.countLB.textColor = UIColorFromRGB(0x585858);
    self.countLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"chuNum"]];
    self.countLB.font = [UIFont systemFontOfSize:15];
    self.countLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.countLB];
    
    self.costLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.countLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.costLB.textColor = UIColorFromRGB(0x585858);
    self.costLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"costNum"]];
    self.costLB.font = [UIFont systemFontOfSize:15];
    self.costLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.costLB];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
