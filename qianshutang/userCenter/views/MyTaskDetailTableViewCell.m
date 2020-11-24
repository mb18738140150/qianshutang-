//
//  MyTaskDetailTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyTaskDetailTableViewCell.h"

@implementation MyTaskDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.typeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.typeLB.textColor = UIColorFromRGB(0x585858);
    self.typeLB.font = [UIFont systemFontOfSize:15];
    self.typeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLB];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.typeLB.frame) + 10, 6, self.hd_height - 12, self.hd_height - 12)];
    
    
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width /2 - self.iconImageView.hd_height - 15, self.hd_height)];
    self.titleLB.textColor = UIColorFromRGB(0x585858);
    
    self.titleLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLB];
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        {
            self.typeLB.text = @"磨耳朵";
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartImg]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
             self.titleLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 2:
        {
            self.typeLB.text = @"阅读";
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartImg]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
             self.titleLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 3:
        {
            self.typeLB.text = @"录音";
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartImg]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
             self.titleLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 4:
        {
            self.typeLB.text = @"创作";
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kmadeImg]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
            self.titleLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
        case 5:
        {
            self.typeLB.text = @"视频";
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kmadeImg]]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
            self.titleLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
            
        default:
            break;
    }
    
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:@"doState"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.stateLB];
    if ([self.stateLB.text isEqualToString:@"已完成"]) {
        self.stateLB.textColor = UIColorFromRGB(0x585858);
    }
    
    self.showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showBtn.frame = CGRectMake(self.hd_width / 12 * 11 - self.hd_height * 0.6, self.hd_height * 0.21, self.hd_width * 0.12, self.hd_height * 0.58);
    self.showBtn.layer.cornerRadius = 5;
    self.showBtn.layer.masksToBounds = YES;
    self.showBtn.backgroundColor = kMainColor;
    [self.showBtn setTitle:@"去做" forState:UIControlStateNormal];
    [self.showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.showBtn];
    
    if ([self.stateLB.text isEqualToString:@"未完成"]) {
        if ([[infoDic objectForKey:kIsOverdue] intValue] == 0) {
            [self.showBtn setTitle:@"去做" forState:UIControlStateNormal];
        }else
        {
            [self.showBtn setTitle:@"已过期" forState:UIControlStateNormal];
            self.showBtn.backgroundColor = [UIColor whiteColor];
            [self.showBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }
    }else if ([self.stateLB.text isEqualToString:@"已完成"])
    {
        if ([[infoDic objectForKey:@"type"] intValue] == 2 || [[infoDic objectForKey:@"type"] intValue] == 1) {
            [self.showBtn setTitle:@"-" forState:UIControlStateNormal];
            self.showBtn.backgroundColor = [UIColor whiteColor];
            [self.showBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }else
        {
            [self.showBtn setTitle:@"查看" forState:UIControlStateNormal];
        }
        
    }else if ([self.stateLB.text isEqualToString:@"已检查"] )
    {
        if ([[infoDic objectForKey:@"type"] intValue] == 1 || [[infoDic objectForKey:@"type"] intValue] == 2) {// 磨耳朵录音已检查不需查看
            [self.showBtn setTitle:@"-" forState:UIControlStateNormal];
            self.showBtn.backgroundColor = [UIColor whiteColor];
            [self.showBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
            
        }else
        {
            [self.showBtn setTitle:@"查看" forState:UIControlStateNormal];
        }
    }else if ([self.stateLB.text isEqualToString:@"已点评"])
    {
        [self.showBtn setTitle:@"查看" forState:UIControlStateNormal];
    }
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.contentView.bounds;
    [self.contentView addSubview:button];
    [button addTarget:self action:@selector(doTaskAction ) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)doTaskAction
{
    DoTaskType type;
    if ([self.showBtn.titleLabel.text isEqualToString:@"去做"]) {
        type = DoTaskType_do;
    }else if([self.showBtn.titleLabel.text isEqualToString:@"查看"])
    {
        type = DoTaskType_check;
    }else
    {
        type = DoTaskType_nomal;
    }
    
    if (self.checkTaskBlock) {
        self.checkTaskBlock(self.infoDic, type);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
