//
//  PrizeCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PrizeCollectionViewCell.h"

@implementation PrizeCollectionViewCell

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.infoDic = infoDic;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.055, 0, self.hd_width * 0.92, self.hd_height * 0.927)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backView.hd_width * 0.03, _backView.hd_height * 0.028, _backView.hd_width * 0.94, _backView.hd_height * 0.626)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"recording_cover"]];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backView addSubview:self.iconImageView];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(_backView.hd_width * 0.03, CGRectGetMaxY(self.iconImageView.frame) + _backView.hd_height * 0.028, _backView.hd_width * 0.94, _backView.hd_height * 0.09)];
    self.nameLB.text = [infoDic objectForKey:@"title"];
    self.nameLB.textColor = UIColorFromRGB(0x555555);
    self.nameLB.font = [UIFont systemFontOfSize:18];
    [self.backView addSubview:self.nameLB];
    
    NSString * integralStr = [NSString stringWithFormat:@"%@积分", [infoDic objectForKey:@"integral"]];
    self.integrslLB = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLB.hd_x, CGRectGetMaxY(self.nameLB.frame) + _backView.hd_height * 0.06, _backView.hd_width / 2, _backView.hd_height * 0.07)];
    self.integrslLB.attributedText = [self getIntegralStr:integralStr];
    self.integrslLB.font = kMainFont;
    [self.backView addSubview:self.integrslLB];
    
    self.convertLB = [[UILabel alloc]initWithFrame:CGRectMake(_backView.hd_width * 0.58, CGRectGetMaxY(self.iconImageView.frame) + _backView.hd_height * 0.122, _backView.hd_width * 0.37, _backView.hd_height * 0.173)];
    self.convertLB.text = @"兑换";
    self.convertLB.layer.cornerRadius = 5;
    self.convertLB.layer.masksToBounds = YES;
    self.convertLB.font = [UIFont systemFontOfSize:16];
    self.convertLB.textAlignment = NSTextAlignmentCenter;
    self.convertLB.backgroundColor = kMainColor;
    self.convertLB.userInteractionEnabled = YES;
    self.convertLB.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.convertLB];
    self.convertLB.hidden = YES;
    if (self.isHaveConversion) {
        self.convertLB.hidden = YES;
    }else
    {
        self.convertLB.hidden = NO;
    }
    UITapGestureRecognizer * convertTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(convertAction)];
    [self.convertLB addGestureRecognizer:convertTap];
}

- (void)convertAction
{
    if (self.convertPrizeBlock) {
        self.convertPrizeBlock(self.infoDic);
    }
}

- (NSMutableAttributedString *)getIntegralStr:(NSString *)str
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * infoDic = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
    [mStr setAttributes:infoDic range:NSMakeRange(0, str.length - 2)];
    return mStr;
}


@end
