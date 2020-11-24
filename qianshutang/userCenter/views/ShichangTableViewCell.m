//
//  ShichangTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ShichangTableViewCell.h"

@implementation ShichangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width * 0.2, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"time"]];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.lisenLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width * 0.2, self.hd_height)];
    self.lisenLB.textColor = UIColorFromRGB(0x585858);
    self.lisenLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kHearLength]];
    self.lisenLB.font = [UIFont systemFontOfSize:15];
    self.lisenLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.lisenLB];
    
    self.readLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lisenLB.frame), 0, self.hd_width * 0.2, self.hd_height)];
    self.readLB.textColor = UIColorFromRGB(0x585858);
    self.readLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kReadLength]];
    self.readLB.font = [UIFont systemFontOfSize:15];
    self.readLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.readLB];
    
    self.recoardLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.readLB.frame), 0, self.hd_width * 0.2, self.hd_height)];
    self.recoardLB.textColor = UIColorFromRGB(0x585858);
    self.recoardLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kRecordLength]];
    self.recoardLB.font = [UIFont systemFontOfSize:15];
    self.recoardLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.recoardLB];
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.frame = CGRectMake(self.hd_width * 0.9 - self.hd_width * 0.0586, self.hd_height * 0.2, self.hd_width * 0.117, self.hd_height * 0.6);
    [self.checkBtn setTitle:@"查看" forState:UIControlStateNormal];
    [self.checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.checkBtn.layer.cornerRadius = 3;
    self.checkBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.checkBtn];
    [self.checkBtn addTarget:self action:@selector(shichangAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.isLastItem) {
        self.checkBtn.hidden = YES;
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)shichangAction
{
    if (self.shichangBlock) {
        self.shichangBlock(self.infoDic);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
