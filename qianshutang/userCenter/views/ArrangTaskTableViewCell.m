//
//  ArrangTaskTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ArrangTaskTableViewCell.h"

@implementation ArrangTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * collectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 20)];
    collectImageView.image = [UIImage imageNamed:@"label_icon_collection"];
    [self.contentView addSubview:collectImageView];
    
    self.moduleNameLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.hd_width / 8 * 3 - 40, self.hd_height)];
    self.moduleNameLB.numberOfLines = 0;
    self.moduleNameLB.textColor = UIColorFromRGB(0x555555);
    self.moduleNameLB.textAlignment = NSTextAlignmentCenter;
    self.moduleNameLB.text = [infoDic objectForKey:@"name"];
    [self.contentView addSubview:self.moduleNameLB];
    
    self.remarkLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moduleNameLB.frame) + 20, 0, self.hd_width / 4, self.hd_height)];
    self.remarkLB.numberOfLines = 0;
    self.remarkLB.textColor = UIColorFromRGB(0x555555);
    self.remarkLB.textAlignment = NSTextAlignmentCenter;
    self.remarkLB.text = [infoDic objectForKey:@"remark"];
    [self.contentView addSubview:self.remarkLB];
    
    self.arrangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrangeBtn.frame = CGRectMake(self.hd_width / 16 * 11 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.arrangeBtn setTitle:@"布置" forState:UIControlStateNormal];
    [self.arrangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.arrangeBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.arrangeBtn.layer.cornerRadius = 3;
    self.arrangeBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.arrangeBtn];
    
    self.operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operationBtn.frame = CGRectMake(self.hd_width / 16 * 13 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.operationBtn setTitle:@"操作" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.operationBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.operationBtn.layer.cornerRadius = 3;
    self.operationBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.operationBtn];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(self.hd_width / 16 * 15 - self.hd_height * 0.26 , self.hd_height * 0.29, self.hd_height * 0.48, self.hd_height * 0.42);
    [self.shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    self.shareBtn.layer.cornerRadius = 3;
    self.shareBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.shareBtn];
    
    if ([[infoDic objectForKey:@"isCollect"] intValue] == 1) {
        self.shareBtn.enabled = NO;
        collectImageView.hidden = NO;
    }else
    {
        self.shareBtn.enabled = YES;
        collectImageView.hidden = YES;
    }
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.arrangeBtn addTarget:self action:@selector(arrangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.operationBtn addTarget:self action:@selector(operationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)arrangeAction
{
    if (self.arrangeTaskBlock) {
        self.arrangeTaskBlock(self.infoDic, self.arrangeBtn.frame);
    }
}

- (void)operationAction
{
    if (self.isDelete) {
        if (self.deleteTaskBlock) {
            self.deleteTaskBlock(self.infoDic, self.operationBtn.frame);
        }
    }else
    {
        if (self.operationTaskBlock) {
            self.operationTaskBlock(self.infoDic, self.operationBtn.frame);
        }
    }
}

- (void)shareAction
{
    if (self.shareTaskBlock) {
        self.shareTaskBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
