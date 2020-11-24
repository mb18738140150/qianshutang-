//
//  Teacher_classroomTaskListCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Teacher_classroomTaskListCell.h"

@implementation Teacher_classroomTaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width * 0.5, self.hd_height)];
    self.taskNameLB.textColor = UIColorFromRGB(0x585858);
    self.taskNameLB.text = [infoDic objectForKey:@"taskName"];
    self.taskNameLB.font = [UIFont systemFontOfSize:15];
    self.taskNameLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.taskNameLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskNameLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:@"time"];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width * 0.125, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:@"state"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.frame = CGRectMake(self.hd_width / 16 * 15 - self.hd_width * 0.0586, self.hd_height * 0.2, self.hd_width * 0.117, self.hd_height * 0.6);
    [self.checkBtn setTitle:@"操作" forState:UIControlStateNormal];
    [self.checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.checkBtn.layer.cornerRadius = 3;
    self.checkBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.checkBtn];
    [self.checkBtn addTarget:self action:@selector(operationAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)operationAction
{
    if (self.teacher_ClassroomTaskOperationBlock) {
        self.teacher_ClassroomTaskOperationBlock(self.infoDic, self.checkBtn.frame);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
