//
//  PrizeRecordTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PrizeRecordTableViewCell.h"

@implementation PrizeRecordTableViewCell

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
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_height * 0.3, 5,self.hd_height - 10, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageUrl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        ;
    }];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.taskTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - CGRectGetMaxX(self.iconImageView.frame) - 10, self.hd_height)];
    self.taskTypeLB.textColor = UIColorFromRGB(0x515151);
    self.taskTypeLB.font = [UIFont systemFontOfSize:15];
    self.taskTypeLB.text = [infoDic objectForKey:kPrizeName];
    [self.contentView addSubview:self.taskTypeLB];
    
    
    self.bookNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskTypeLB.frame), 0, self.hd_width / 6 , self.hd_height)];
    self.bookNameLB.textColor = UIColorFromRGB(0x585858);
    self.bookNameLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kPrizeIntegral]];
    self.bookNameLB.textAlignment = NSTextAlignmentCenter;
    self.bookNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.bookNameLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 2, 0, self.hd_width / 3, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:kTime];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    self.doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doBtn.frame = CGRectMake(self.hd_width  / 12 * 11 - self.hd_height * 0.6, self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.doBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.doBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.doBtn.backgroundColor = UIColorFromRGB(0xffffff);
    self.doBtn.layer.cornerRadius = 3;
    self.doBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.doBtn];
    
    [self.doBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[infoDic objectForKey:kState] intValue] == 0) {
    }else if ([[infoDic objectForKey:kState] intValue] == 1)
    {
        [self.doBtn setTitle:@"已完成" forState:UIControlStateNormal];
//        self.doBtn.enabled = NO;
    }else if ([[infoDic objectForKey:kState] intValue] == 2)
    {
        [self.doBtn setTitle:@"已取消" forState:UIControlStateNormal];
        self.doBtn.enabled = NO;
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)cancelAction
{
    if (self.cancelConvertPrizeBlock) {
        self.cancelConvertPrizeBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
