//
//  CommentTaskTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentTaskTableViewCell.h"

@implementation CommentTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.studentNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.studentNameLB.textAlignment = NSTextAlignmentCenter;
    self.studentNameLB.textColor = UIColorFromRGB(0x515151);
    self.studentNameLB.font = [UIFont systemFontOfSize:15];
    self.studentNameLB.numberOfLines = 0;
    self.studentNameLB.text = [infoDic objectForKey:kUserName];
    [self.contentView addSubview:self.studentNameLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentNameLB.frame) + 5, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    NSString * imgUrlStr = @"";
    if ([[infoDic objectForKey:@"userWorkImg"] class] == [NSNull class] || [infoDic objectForKey:@"userWorkImg"] == nil) {
        imgUrlStr = @"";
    }else
    {
        imgUrlStr = [infoDic objectForKey:@"userWorkImg"];
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.taskNameLB.textColor = UIColorFromRGB(0x585858);
    self.taskNameLB.text = [infoDic objectForKey:@"taskName"];
    self.taskNameLB.font = [UIFont systemFontOfSize:15];
    self.taskNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.taskNameLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskNameLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:@"upTime"];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.numberOfLines = 0;
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width /6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:@"state"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(self.hd_width / 12 * 11 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.commentBtn setTitle:@"点评" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commentBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.commentBtn.layer.cornerRadius = 3;
    self.commentBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.commentBtn];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commentAction
{
    if (self.commentTaskBlock) {
        self.commentTaskBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
