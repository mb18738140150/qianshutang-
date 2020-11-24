//
//  MessageOfRequestTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MessageOfRequestTableViewCell.h"

@implementation MessageOfRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 8, 59, 59)];
    self.iconImageView.image = [UIImage imageNamed:@"head_portrait"];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, 9, self.hd_width - 214 - CGRectGetMaxX(self.iconImageView.frame) - 15, 20)];
    self.titleLB.textColor = UIColorFromRGB(0x505050);
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15, CGRectGetMaxY(self.titleLB.frame) + 17, self.hd_width - 214 - CGRectGetMaxX(self.iconImageView.frame) - 15, 18)];
    self.contentLB.textColor = UIColorFromRGB(0x505050);
    self.contentLB.font = [UIFont systemFontOfSize:15];
    self.contentLB.text = [infoDic objectForKey:@"content"];
    [self.contentView addSubview:self.contentLB];
    
    self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeBtn.frame = CGRectMake(self.hd_width - 214, 15, 88, 44);
    self.agreeBtn.backgroundColor = kMainColor;
    [self.agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [self.agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.agreeBtn.layer.cornerRadius = 4;
    self.agreeBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.agreeBtn];
    
    self.rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rejectBtn.frame = CGRectMake(self.hd_width - 109, 15, 88, 44);
    self.rejectBtn.backgroundColor = kMainColor;
    [self.rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.rejectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rejectBtn.layer.cornerRadius = 4;
    self.rejectBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.rejectBtn];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 73.5, self.hd_width, 1.5)];
    bottomView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.contentView addSubview:bottomView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
