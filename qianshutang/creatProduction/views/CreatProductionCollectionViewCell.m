//
//  CreatProductionCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreatProductionCollectionViewCell.h"

@implementation CreatProductionCollectionViewCell

- (void)resetWithInfoDic:(NSDictionary *)model
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIRGBColor(239, 239, 239);
    self.model = model;
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, 5, self.hd_width * 0.85, self.hd_height - 5)];
    backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.backView = backView;
    [self.contentView addSubview:self.backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, backView.hd_width - 16, backView.hd_width - 16 - 26)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [model objectForKey:kProductIconUrl]]] placeholderImage:[UIImage imageNamed:@""]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    self.typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, backView.hd_width * 0.4, backView.hd_width * 4 / 15.0)];
    [backView addSubview:self.typeImageView];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.iconImageView.frame) + 5, backView.hd_width - 16, 37)];
    self.nameLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.nameLB.numberOfLines = 0;
    [backView addSubview:self.nameLB];
    self.nameLB.font = kMainFont;
    self.nameLB.text = [model objectForKey:kProductName];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.nameLB.frame), backView.hd_width - 16, backView.hd_height - CGRectGetMaxY(self.nameLB.frame))];
    self.timeLB.textColor = UIColorFromRGB(0xc5c5c5);
    self.timeLB.numberOfLines = 0;
    self.timeLB.font = kMainFont;
    [backView addSubview:self.timeLB];
    self.timeLB.text = [model objectForKey:kProductTime];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(CGRectGetMaxX(backView.frame) - 3 - backView.hd_width / 4, 9, backView.hd_width / 4, backView.hd_width / 4);
    [self.deleteBtn setImage:[UIImage imageNamed:@"icon_off"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    self.deleteBtn.hidden = YES;
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(CGRectGetMaxX(backView.frame) - 3 - backView.hd_width / 4, 9, backView.hd_width / 4, backView.hd_width / 4);
    [self.shareBtn setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.shareBtn];
    self.shareBtn.hidden = YES;
    
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentView = [[UIView alloc]initWithFrame:CGRectMake(9, 9, backView.hd_width * 0.46, backView.hd_width * 0.184)];
    [backView addSubview:self.commentView];
    
    UILabel * commentLB = [[UILabel alloc]initWithFrame:self.commentView.bounds];
    commentLB.textColor = UIColorFromRGB(0x333333);
    commentLB.backgroundColor = UIColorFromRGB(0xFFCE54);
    commentLB.text = @"有点评";
    commentLB.textAlignment = NSTextAlignmentCenter;
    [self.commentView addSubview:commentLB];
    
    UIView * commentTipView = [[UIView alloc]initWithFrame:CGRectMake(self.commentView.hd_width - self.commentView.hd_height / 4, - self.commentView.hd_height / 4, self.commentView.hd_height / 2,  self.commentView.hd_height / 2)];
    commentTipView.backgroundColor = UIColorFromRGB(0xff0000);
    commentTipView.layer.cornerRadius = commentTipView.hd_height / 2;
    commentTipView.layer.masksToBounds = YES;
    commentTipView.hidden = YES;
    [self.commentView addSubview:commentTipView];
    
    if ([[model objectForKey:kIsHaveComment] intValue] == 1) {
        // 是否有点评
        self.commentView.hidden = NO;
        if ([[model objectForKey:kIsHaveRead] intValue] == 0) {
            // 点评是否已阅读
            commentTipView.hidden = NO;
        }else
        {
            commentTipView.hidden = YES;
        }
    }else
    {
        self.commentView.hidden = YES;
    }
}

- (void)resetAddView
{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, 5, self.hd_width * 0.85, self.hd_height - 5)];
    backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.backView = backView;
    [self.contentView addSubview:self.backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, backView.hd_width - 16, backView.hd_width - 16 - 26)];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.iconImageView.frame = CGRectMake(self.backView.hd_width / 4, self.backView.hd_height / 4, self.backView.hd_width / 2, self.backView.hd_height / 2);
        self.iconImageView.image = [UIImage imageNamed:@"add_creation_btn"];
    });
}

- (void)deleteAction
{
    if (self.delateBlock) {
        self.delateBlock(self.model);
    }
}

- (void)shareAction
{
    if (self.shareBlock) {
        self.shareBlock(self.model);
    }
}

- (void)resetShareView
{
    self.deleteBtn.hidden = YES;
    self.shareBtn.hidden = NO;
}
- (void)resetShareListView
{
    self.deleteBtn.hidden = YES;
    self.shareBtn.hidden = NO;
    [self.shareBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
}

- (void)resetDeleteView
{
    self.deleteBtn.hidden = NO;
    self.shareBtn.hidden = YES;
}

@end
