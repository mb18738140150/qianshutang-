//
//  Teacher_studentProductTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/10/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Teacher_studentProductTableViewCell.h"

@implementation Teacher_studentProductTableViewCell

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
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake( kScreenWidth * 0.03, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"productIconUrl"]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.productNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.productNameLB.textColor = UIColorFromRGB(0x585858);
    self.productNameLB.text = [infoDic objectForKey:kProductName];
    self.productNameLB.font = [UIFont systemFontOfSize:15];
    self.productNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.productNameLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.productNameLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.contentLB.textColor = UIColorFromRGB(0x585858);
    self.contentLB.text = [infoDic objectForKey:@"content"];
    self.contentLB.font = [UIFont systemFontOfSize:15];
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.numberOfLines = 0;
    [self.contentView addSubview:self.contentLB];
    
    self.flowerAndPrizeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentLB.frame), 0, self.hd_width /9 * 2, self.hd_height)];
    self.flowerAndPrizeLB.textColor = UIColorFromRGB(0x585858);
    self.flowerAndPrizeLB.text = [NSString stringWithFormat:@"%@/%@", [infoDic objectForKey:@"flowerNum"],[infoDic objectForKey:@"medalNum"]];
    self.flowerAndPrizeLB.font = [UIFont systemFontOfSize:15];
    self.flowerAndPrizeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.flowerAndPrizeLB];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(self.hd_width / 9 * 7  , self.hd_height * 0.22, self.hd_width /9 * 2, self.hd_height * 0.56);
    self.commentBtn.backgroundColor = UIColorFromRGB(0xffffff);
    [self.contentView addSubview:self.commentBtn];
    self.commentBtn.enabled = NO;
    
    if ([[infoDic objectForKey:@"ReviewNum"] intValue] == 1) {
        [self.commentBtn setTitleColor:kMainColor_orange forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"有点评" forState:UIControlStateNormal];
    }else
    {
        [self.commentBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"-" forState:UIControlStateNormal];
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
