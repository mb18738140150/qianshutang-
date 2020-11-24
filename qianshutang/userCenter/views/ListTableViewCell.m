//
//  ListTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.rankingLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.rankingLB.textColor = UIColorFromRGB(0x585858);
    self.rankingLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"sort"]];
    self.rankingLB.font = [UIFont systemFontOfSize:15];
    self.rankingLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rankingLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rankingLB.frame) + 10, 6, self.hd_height - 12, self.hd_height - 12)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"userIcon"]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.studentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width /2 - self.iconImageView.hd_height - 15, self.hd_height)];
    self.studentLB.textColor = UIColorFromRGB(0x585858);
    self.studentLB.text = [infoDic objectForKey:@"userName"];
    self.studentLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.studentLB];
    
    self.countLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentLB.frame), 0, self.hd_width / 10, self.hd_height)];
    self.countLB.textColor = UIColorFromRGB(0x585858);
    self.countLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"typeValue"]];
    self.countLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.countLB];
    
    self.showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showBtn.frame = CGRectMake(self.hd_width * 0.066 + CGRectGetMaxX(self.countLB.frame), self.hd_height * 0.187, self.hd_width * 0.118, self.hd_height * 0.625);
    self.showBtn.layer.cornerRadius = self.showBtn.hd_height / 2;
    self.showBtn.layer.masksToBounds = YES;
    self.showBtn.backgroundColor = UIColorFromRGB(0xDDE3E1);
    [self.showBtn setTitle:@"炫耀" forState:UIControlStateNormal];
    [self.showBtn setTitleColor:UIColorFromRGB(0xA3A9A7) forState:UIControlStateNormal];
    [self.contentView addSubview:self.showBtn];
    if (self.isShow) {
        self.showBtn.hidden = NO;
        self.backgroundColor = UIColorFromRGB(0xF4FFFB);
    }else
    {
        self.showBtn.hidden = YES;
        self.backgroundColor = UIColorFromRGB(0xffffff);
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
