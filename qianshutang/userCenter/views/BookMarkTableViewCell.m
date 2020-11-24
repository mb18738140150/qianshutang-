//
//  BookMarkTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BookMarkTableViewCell.h"

@implementation BookMarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * 0.03, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kTextBookImageUrl]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    
    self.bookNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 15, self.hd_height)];
    self.bookNameLB.textColor = UIColorFromRGB(0x585858);
    self.bookNameLB.text = [infoDic objectForKey:kTextBookName];
    self.bookNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.bookNameLB];
    
    self.textLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 3, 0, self.hd_width /3, self.hd_height)];
    self.textLB.textColor = UIColorFromRGB(0x585858);
    self.textLB.text = [infoDic objectForKey:kpartName];
    self.textLB.font = [UIFont systemFontOfSize:15];
    self.textLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:kReadTime];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame) - 20 - self.hd_height / 2, self.hd_height / 4, self.hd_height / 2, self.hd_height /  2)];
    self.deleteImage.image = [UIImage imageNamed:@"icon_off"];
    [self.contentView addSubview:self.deleteImage];
    self.deleteImage.hidden = YES;
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)resetDeleteView
{
    self.deleteImage.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
