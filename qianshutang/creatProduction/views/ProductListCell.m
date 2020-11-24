//
//  ProductListCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetUI
{
    [self.contentView removeAllSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIRGBColor(239, 239, 239);
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.hd_width, self.hd_height - 5)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 3;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    self.contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 7, self.hd_width - 4, self.hd_height - 9)];
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.contentImageView.backgroundColor = [UIColor whiteColor];
    self.contentImageView.layer.cornerRadius = 3;
    self.contentImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
    
    self.numberLB = [[UILabel alloc]initWithFrame:CGRectMake(2, 7, self.hd_width * 0.2, self.hd_width * 0.2)];
    self.numberLB.backgroundColor = kMainColor;
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.textColor = [UIColor whiteColor];
    self.numberLB.layer.cornerRadius = self.numberLB.hd_height / 2;
    self.numberLB.layer.masksToBounds = YES;
    self.numberLB.layer.borderColor = [UIColor whiteColor].CGColor;
    self.numberLB.layer.borderWidth = 2;
    [self.contentView addSubview:self.numberLB];
    self.numberLB.hidden = YES;
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.hd_width * 0.72 - 2, 5, self.hd_width * 0.28, self.hd_width * 0.28);
    [self.deleteBtn setImage:[UIImage imageNamed:@"icon_material_delete"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.hidden = YES;
    
    self.playImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.hd_height - 25, 15, 15)];
    self.playImageView.image = [UIImage imageNamed:@"play_btn_small"];
    [self.contentView addSubview:self.playImageView];
    self.playImageView.hidden = YES;
}

- (void)deleteAction
{
    if (self.DeleteProcuctBlock) {
        self.DeleteProcuctBlock();
    }
}
- (void)refreshBackView
{
    self.backView.backgroundColor = kMainColor;
}

- (void)shwDelete
{
    self.deleteBtn.hidden = NO;
}

- (void)showMusicPlay
{
    self.playImageView.hidden = NO;
}

- (void)showNumber
{
    self.numberLB.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
