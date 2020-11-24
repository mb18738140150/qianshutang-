//
//  StudentProductTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StudentProductTableViewCell.h"

@implementation StudentProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * 0.03, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kProductIconUrl]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.bookNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 2 - self.iconImageView.hd_width - 15, self.hd_height)];
    self.bookNameLB.textColor = UIColorFromRGB(0x585858);
    self.bookNameLB.text = [infoDic objectForKey:kProductName];
    self.bookNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.bookNameLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bookNameLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:kProductTime];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.commentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width /6, self.hd_height)];
    self.commentLB.textColor = UIColorFromRGB(0x585858);
    self.commentLB.font = [UIFont systemFontOfSize:15];
    self.commentLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.commentLB];
    if ([[infoDic objectForKey:@"ReviewNum"] intValue] == 1) {
        self.commentLB.text = @"有点评";
        self.commentLB.textColor = kMainColor_orange;
    }else
    {
        self.commentLB.text = @"-";
    }
    
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
