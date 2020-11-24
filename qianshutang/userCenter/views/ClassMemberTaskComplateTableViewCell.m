//
//  ClassMemberTaskComplateTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassMemberTaskComplateTableViewCell.h"

@implementation ClassMemberTaskComplateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    
    self.numberLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 4, self.hd_height)];
    self.numberLB.textColor = UIColorFromRGB(0x585858);
    self.numberLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"number"]];
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.numberLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 4, 5, self.hd_height - 10, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"userIconUrl"]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.memberLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 2 - self.iconImageView.hd_width - 10 , self.hd_height)];
    self.memberLB.textColor = UIColorFromRGB(0x585858);
    self.memberLB.text = [infoDic objectForKey:@"userName"];
    self.memberLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.memberLB];
    
    self.progressLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.memberLB.frame), 0, self.hd_width / 4, self.hd_height)];
    self.progressLB.text = [NSString stringWithFormat:@"%@/%@", [infoDic objectForKey:@"complateTaskCount"], [infoDic objectForKey:@"totalTaskCount"]];
    self.progressLB.font = [UIFont systemFontOfSize:15];
    self.progressLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.progressLB];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
