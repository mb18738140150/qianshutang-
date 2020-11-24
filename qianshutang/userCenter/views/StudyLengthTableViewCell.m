//
//  StudyLengthTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/9/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StudyLengthTableViewCell.h"

@implementation StudyLengthTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetUIWithInfoDic:(NSDictionary *) infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.typeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 9, self.hd_height)];
    self.typeLB.textColor = UIColorFromRGB(0x585858);

    self.typeLB.text = [infoDic objectForKey:@"type"];
    self.typeLB.font = [UIFont systemFontOfSize:15];
    self.typeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.typeLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.contentLB.textColor = UIColorFromRGB(0x585858);
    self.contentLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kTextName]];
    self.contentLB.font = [UIFont systemFontOfSize:15];
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.contentLB];
    
    self.textBookLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.textBookLB.textColor = UIColorFromRGB(0x585858);
    self.textBookLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kTextBookName]];
    self.textBookLB.font = [UIFont systemFontOfSize:15];
    self.textBookLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textBookLB];
    
    self.timeLengthLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textBookLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.timeLengthLB.textColor = UIColorFromRGB(0x585858);
    self.timeLengthLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kTimeLength]];
    self.timeLengthLB.font = [UIFont systemFontOfSize:15];
    self.timeLengthLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLengthLB];
    
    self.dateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLengthLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.dateLB.textColor = UIColorFromRGB(0x585858);
    self.dateLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kTime]];
    self.dateLB.font = [UIFont systemFontOfSize:15];
    self.dateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dateLB];
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
