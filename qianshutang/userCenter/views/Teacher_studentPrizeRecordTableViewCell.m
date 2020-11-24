//
//  Teacher_studentPrizeRecordTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Teacher_studentPrizeRecordTableViewCell.h"

@implementation Teacher_studentPrizeRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.studentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 5, self.hd_height)];
    self.studentLB.textAlignment = NSTextAlignmentCenter;
    self.studentLB.textColor = UIColorFromRGB(0x515151);
    self.studentLB.font = [UIFont systemFontOfSize:15];
    self.studentLB.text = [infoDic objectForKey:kUserName];
    [self.contentView addSubview:self.studentLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentLB.frame) + 5, 5, (self.hd_height - 10), self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"imageUrl"]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.prizeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 5 * 2 - self.iconImageView.hd_width - 15, self.hd_height)];
    self.prizeLB.textColor = UIColorFromRGB(0x585858);
    self.prizeLB.text = [infoDic objectForKey:@"prizeName"];
    self.prizeLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.prizeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.prizeLB.frame), 0, self.hd_width /5, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:@"time"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
//    if ([self.stateLB.text isEqualToString:@"未完成"]) {
//        self.stateLB.textColor = UIColorFromRGB(0xFD834D);
//    }
    
    self.doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doBtn.frame = CGRectMake(self.hd_width / 10 * 9 - self.hd_height * 1.14 / 2, self.hd_height * 0.22, self.hd_height * 1.14, self.hd_height * 0.54);
    [self.doBtn setTitle:@"操作" forState:UIControlStateNormal];
    [self.doBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.doBtn.layer.cornerRadius = 3;
    self.doBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.doBtn];
    
    [self.doBtn addTarget:self action:@selector(operationAction ) forControlEvents:UIControlEventTouchUpInside];
    if ([[infoDic objectForKey:@"state"] intValue] == 1) {
        [self.doBtn setTitle:@"已完成" forState:UIControlStateNormal];
        self.doBtn.backgroundColor = [UIColor whiteColor];
        [self.doBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        self.doBtn.enabled = NO;
    }else if ([[infoDic objectForKey:@"state"] intValue] == 2)
    {
        [self.doBtn setTitle:@"已取消" forState:UIControlStateNormal];
        self.doBtn.backgroundColor = [UIColor whiteColor];
        [self.doBtn setTitleColor:kMainColor_orange forState:UIControlStateNormal];
        self.doBtn.enabled = NO;
    }else
    {
        self.doBtn.enabled = YES;
    }
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)operationAction
{
    if (self.teacher_StudentPrizeRecordBlock) {
        self.teacher_StudentPrizeRecordBlock(self.infoDic, self.doBtn.frame);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
