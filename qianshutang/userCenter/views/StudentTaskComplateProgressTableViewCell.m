//
//  StudentTaskComplateProgressTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StudentTaskComplateProgressTableViewCell.h"

@implementation StudentTaskComplateProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.numberLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 9, self.hd_height)];
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.textColor = UIColorFromRGB(0x515151);
    self.numberLB.font = [UIFont systemFontOfSize:15];
    self.numberLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"sort"]];
    [self.contentView addSubview:self.numberLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.numberLB.frame) + 5, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"userIcon"]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.studentNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.studentNameLB.textColor = UIColorFromRGB(0x585858);
    self.studentNameLB.text = [infoDic objectForKey:kUserName];
    self.studentNameLB.font = [UIFont systemFontOfSize:15];
    self.studentNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.studentNameLB];
    
    self.classroomLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentNameLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.classroomLB.textColor = UIColorFromRGB(0x585858);
    self.classroomLB.text = [infoDic objectForKey:@"grades"];
    self.classroomLB.textAlignment = NSTextAlignmentCenter;
    self.classroomLB.font = [UIFont systemFontOfSize:15];
    self.classroomLB.numberOfLines = 0;
    [self.contentView addSubview:self.classroomLB];
    
    self.progressLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.classroomLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.progressLB.textColor = UIColorFromRGB(0x585858);
    self.progressLB.text = [infoDic objectForKey:@"complete"];
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
