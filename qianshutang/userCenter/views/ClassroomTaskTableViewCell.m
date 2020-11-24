//
//  ClassroomTaskTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomTaskTableViewCell.h"

@implementation ClassroomTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 2, self.hd_height)];
    self.titleLB.textColor = UIColorFromRGB(0x585858);
    self.titleLB.text = [infoDic objectForKey:kWorkLogName];
    self.titleLB.font = [UIFont systemFontOfSize:15];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:kWorkLogTime];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.checkBtn = [[UILabel alloc]init];
    self.checkBtn.frame = CGRectMake(self.hd_width * 0.875 - self.hd_width * 0.0586, self.hd_height * 0.2, self.hd_width * 0.117, self.hd_height * 0.6);
    self.checkBtn.text = @"查看";
    self.checkBtn.textColor = [UIColor whiteColor];
    self.checkBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.checkBtn.layer.cornerRadius = 3;
    self.checkBtn.layer.masksToBounds = YES;
    self.checkBtn.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.checkBtn];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
