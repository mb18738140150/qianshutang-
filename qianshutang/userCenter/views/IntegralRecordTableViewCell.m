//
//  IntegralRecordTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "IntegralRecordTableViewCell.h"

@implementation IntegralRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.integralLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width * 0.2, self.hd_height)];
    self.integralLB.textColor = UIColorFromRGB(0x585858);
    if ([[infoDic objectForKey:@"changeType"] intValue] == 1) {
        self.integralLB.text = [NSString stringWithFormat:@"+%@", [infoDic objectForKey:kChangeIntegral]];
    }else
    {
        self.integralLB.text = [NSString stringWithFormat:@"-%@", [infoDic objectForKey:kChangeIntegral]];
    }
    self.integralLB.font = [UIFont systemFontOfSize:15];
    self.integralLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.integralLB];
    
    self.wayLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.integralLB.frame), 0, self.hd_width * 0.2, self.hd_height)];
    self.wayLB.textColor = UIColorFromRGB(0x585858);
    self.wayLB.text = [infoDic objectForKey:@"way"];
    self.wayLB.font = [UIFont systemFontOfSize:15];
    self.wayLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.wayLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.wayLB.frame), 0, self.hd_width * 0.2, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:@"time"];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.remarkLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width * 0.4, self.hd_height)];
    self.remarkLB.textColor = UIColorFromRGB(0x585858);
    self.remarkLB.text = [infoDic objectForKey:@"remark"];
    self.remarkLB.font = [UIFont systemFontOfSize:15];
    self.remarkLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.remarkLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 1.5, self.hd_width, 1.5)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
