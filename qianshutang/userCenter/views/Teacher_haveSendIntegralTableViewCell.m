//
//  Teacher_haveSendIntegralTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/10/23.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Teacher_haveSendIntegralTableViewCell.h"

@implementation Teacher_haveSendIntegralTableViewCell

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
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake( 5, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"userIcon"]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.nameLB.textColor = UIColorFromRGB(0x585858);
    self.nameLB.text = [infoDic objectForKey:kUserName];
    self.nameLB.font = [UIFont systemFontOfSize:15];
    self.nameLB.numberOfLines = 0;
    [self.contentView addSubview:self.nameLB];
    
    self.integralLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.integralLB.textColor = UIColorFromRGB(0x585858);
    self.integralLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"score"]];
    self.integralLB.font = [UIFont systemFontOfSize:15];
    self.integralLB.textAlignment = NSTextAlignmentCenter;
    self.integralLB.numberOfLines = 0;
    [self.contentView addSubview:self.integralLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.integralLB.frame), 0, self.hd_width / 6 , self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:@"time"];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.remarkLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width / 9 * 2 , self.hd_height)];
    self.remarkLB.textColor = UIColorFromRGB(0x585858);
    self.remarkLB.text = [infoDic objectForKey:@"remark"];
    self.remarkLB.font = [UIFont systemFontOfSize:15];
    self.remarkLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.remarkLB];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(self.hd_width / 18 * 17 - 11 , self.hd_height / 2 - 11, 22, 22);
    self.commentBtn.backgroundColor = UIColorFromRGB(0xffffff);
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn setImage:[UIImage imageNamed:@"class_management_edit"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(editRemarkAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)editRemarkAction
{
    if (self.editPrizeRemarkBlock) {
        self.editPrizeRemarkBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
