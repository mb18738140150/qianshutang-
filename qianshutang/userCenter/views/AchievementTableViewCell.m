//
//  AchievementTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AchievementTableViewCell.h"

@implementation AchievementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width * 0.25, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"time"]];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.starLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.starLB.textColor = UIColorFromRGB(0x585858);
    self.starLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kstarNum]];
    self.starLB.font = [UIFont systemFontOfSize:15];
    self.starLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.starLB];
    
    self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.flowerLB.textColor = UIColorFromRGB(0x585858);
    self.flowerLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kflowerNum]];
    self.flowerLB.font = [UIFont systemFontOfSize:15];
    self.flowerLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.flowerLB];
    
    self.goldLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerLB.frame), 0, self.hd_width * 0.25, self.hd_height)];
    self.goldLB.textColor = UIColorFromRGB(0x585858);
    self.goldLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kmedalNum]];
    self.goldLB.font = [UIFont systemFontOfSize:15];
    self.goldLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.goldLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
