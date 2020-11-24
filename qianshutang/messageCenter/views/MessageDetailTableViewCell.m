//
//  MessageDetailTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MessageDetailTableViewCell.h"

@implementation MessageDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.hd_width - 20, 15)];
    self.timeLB.text = [infoDic objectForKey:@"time"];
    self.timeLB.textColor = UIColorFromRGB(0xc7c7c7);
    self.timeLB.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLB];
    
    CGSize contentSize = [[infoDic objectForKey:@"content"] boundingRectWithSize:CGSizeMake(self.hd_width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + CGRectGetMaxY(self.timeLB.frame), self.hd_width - 20, contentSize.height)];
    self.contentLB.text = [infoDic objectForKey:@"content"];
    self.contentLB.numberOfLines = 0;
    self.contentLB.textColor = UIColorFromRGB(0x282828);
    self.contentLB.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.contentLB];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLB.frame) + 5, self.hd_width, 1.5)];
    bottomView.backgroundColor = UIColorFromRGB(0xF7F7F7);
    [self.contentView addSubview:bottomView];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
