//
//  TaskLibraryTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskLibraryTableViewCell.h"

@implementation TaskLibraryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.infoDic = infoDic;
    
    self.moduleNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 2, self.hd_height)];
    self.moduleNameLB.numberOfLines = 0;
    self.moduleNameLB.textColor = UIColorFromRGB(0x555555);
    self.moduleNameLB.textAlignment = NSTextAlignmentCenter;
    self.moduleNameLB.text = [infoDic objectForKey:@"name"];
    [self.contentView addSubview:self.moduleNameLB];
    
    self.remarkLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moduleNameLB.frame), 0, self.hd_width / 4, self.hd_height)];
    self.remarkLB.numberOfLines = 0;
    self.remarkLB.textColor = UIColorFromRGB(0x555555);
    self.remarkLB.textAlignment = NSTextAlignmentCenter;
    self.remarkLB.text = [infoDic objectForKey:@"remark"];
    [self.contentView addSubview:self.remarkLB];
    
    self.arrangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrangeBtn.frame = CGRectMake(self.hd_width / 16 * 13 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.arrangeBtn setTitle:@"布置" forState:UIControlStateNormal];
    [self.arrangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.arrangeBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.arrangeBtn.layer.cornerRadius = 3;
    self.arrangeBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.arrangeBtn];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(self.hd_width / 16 * 15 - self.hd_height * 0.26 , self.hd_height * 0.29, self.hd_height * 0.48, self.hd_height * 0.42);
    [self.collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    self.collectBtn.layer.cornerRadius = 3;
    self.collectBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.collectBtn];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.arrangeBtn addTarget:self action:@selector(arrangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.collectBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)arrangeAction
{
    if (self.arrangeTaskBlock) {
        self.arrangeTaskBlock(self.infoDic, self.arrangeBtn.frame);
    }
}

- (void)shareAction
{
    if (self.collectTaskBlock) {
        self.collectTaskBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
