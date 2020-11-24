//
//  MainLeftTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MainLeftTableViewCell.h"

@implementation MainLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = kMainColor;
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(3, 7, self.hd_width - 7, self.hd_height - 7)];
    titleLB.textColor = [UIColor whiteColor];
    titleLB.text = [infoDic objectForKey:@"title"];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.layer.cornerRadius = 4;
    titleLB.layer.masksToBounds = YES;
    titleLB.font = [UIFont systemFontOfSize:20];
    titleLB.backgroundColor = UIColorFromRGB(0x8BC6AF);
    self.titleLB = titleLB;
    [self.contentView addSubview:self.titleLB];
    
    self.cateGoryImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) - 26, self.titleLB.hd_centerY - 8, 11, 16)];
    self.cateGoryImage.image = [UIImage imageNamed:@"arrows_up_white"];
    [self.contentView addSubview:self.cateGoryImage];
    self.cateGoryImage.hidden = YES;
    if (self.ishaveCategory) {
        self.cateGoryImage.hidden = NO;
    }
    
    self.messageCenterTipView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB.frame) - 15, self.hd_height / 2 - 10, 5, 5)];
    self.messageCenterTipView.backgroundColor = [UIColor redColor];
    self.messageCenterTipView.layer.cornerRadius = self.messageCenterTipView.hd_height / 2.0;
    self.messageCenterTipView.layer.masksToBounds = YES;
    self.messageCenterTipView.hidden = YES;
    [self.contentView addSubview:self.messageCenterTipView];
    
}

- (void)selectReset
{
    self.titleLB.backgroundColor = [UIColor whiteColor];
    self.titleLB.textColor = kMainColor;
    self.cateGoryImage.image = [UIImage imageNamed:@"arrows_up_green"];
}

- (void)cannotClickReset
{
    self.isCanClick = NO;
    self.titleLB.backgroundColor = UIRGBColor(105, 177, 148);
    self.titleLB.textColor = UIRGBColor(146, 206, 181);
}

- (void)refreshTipPointHide:(BOOL)hide
{
    self.messageCenterTipView.hidden = hide;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
