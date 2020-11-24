//
//  CheckAndCommentTaskNumberTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CheckAndCommentTaskNumberTableViewCell.h"

@implementation CheckAndCommentTaskNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.numberLB = [self getTitleLBWith:@"" andRect:CGRectMake(0, 0, self.hd_width, self.hd_height)];
    [self.contentView addSubview:self.numberLB];
    
    self.nameLB = [self getTitleLBWith:@"" andRect:CGRectMake(CGRectGetMaxX(self.numberLB.frame), 0, self.hd_width, self.hd_height)];
    [self.contentView addSubview:self.numberLB];
}

- (UILabel *)getTitleLBWith:(NSString *)title andRect:(CGRect)rect
{
    UILabel * lb = [[UILabel alloc]initWithFrame:rect];
    lb.backgroundColor = UIColorFromRGB(0xeeeeee);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = UIColorFromRGB(0x222222);
    
    return lb;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
