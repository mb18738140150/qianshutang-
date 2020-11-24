//
//  TaskListTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskListTableViewCell.h"

@implementation TaskListTableViewCell

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
    NSLog(@"infoDic = %@", infoDic);
    
    self.taskTypeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.taskTypeLB.textAlignment = NSTextAlignmentCenter;
    self.taskTypeLB.textColor = UIColorFromRGB(0x515151);
    self.taskTypeLB.font = [UIFont systemFontOfSize:15];
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        {
            self.taskTypeLB.text = @"磨耳朵";
        }
            break;
        case 2:
        {
            self.taskTypeLB.text = @"阅读";
        }
            break;
        case 3:
        {
            self.taskTypeLB.text = @"录音";
        }
            break;
        case 4:
        {
            self.taskTypeLB.text = @"创作";
        }
            break;
        case 5:
        {
            self.taskTypeLB.text = @"视频";
        }
            break;
            
        default:
            break;
    }
    
    [self.contentView addSubview:self.taskTypeLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskTypeLB.frame) + 10, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.bookNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 2 - self.iconImageView.hd_width - 15, self.hd_height)];
    self.bookNameLB.textColor = UIColorFromRGB(0x585858);
    self.bookNameLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.bookNameLB];
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        case 2:
        case 3:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kpartImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            
            self.bookNameLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 4:
        case 5:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kmadeImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            self.bookNameLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
        default:
            break;
    }
    
    
    
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width / 3 * 2, 0, self.hd_width /6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0xFD834D);
    self.stateLB.text = [infoDic objectForKey:@"doState"];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    if ([self.stateLB.text isEqualToString:@"已完成"]) {
        self.stateLB.textColor = UIColorFromRGB(0x585858);
    }
    
    self.doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doBtn.frame = CGRectMake(CGRectGetMaxX(self.stateLB.frame) + 20, self.hd_height * 0.22, self.hd_height * 1.14, self.hd_height * 0.54);
    [self.doBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.doBtn.layer.cornerRadius = 3;
    self.doBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.doBtn];
    // 未完成|已完成|已检查|已点评|已过期
    if ([self.stateLB.text isEqualToString:@"未完成"]) {
        if ([[infoDic objectForKey:kIsOverdue] intValue] == 0) {
            [self.doBtn setTitle:@"去做" forState:UIControlStateNormal];
        }else
        {
            [self.doBtn setTitle:@"已过期" forState:UIControlStateNormal];
            self.doBtn.backgroundColor = [UIColor whiteColor];
            [self.doBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }
    }else if ([self.stateLB.text isEqualToString:@"已完成"])
    {
        
        if ([[infoDic objectForKey:@"type"] intValue] == 2 || [[infoDic objectForKey:@"type"] intValue] == 1) {
            [self.doBtn setTitle:@"-" forState:UIControlStateNormal];
            self.doBtn.backgroundColor = [UIColor whiteColor];
            [self.doBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }else
        {
            [self.doBtn setTitle:@"查看" forState:UIControlStateNormal];
        }
        
    }else if ([self.stateLB.text isEqualToString:@"已检查"] )
    {
        if ([[infoDic objectForKey:@"type"] intValue] == 1 || [[infoDic objectForKey:@"type"] intValue] == 2) {// 磨耳朵录音已检查不需查看
            [self.doBtn setTitle:@"-" forState:UIControlStateNormal];
            self.doBtn.backgroundColor = [UIColor whiteColor];
            [self.doBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
            
        }else
        {
            [self.doBtn setTitle:@"查看" forState:UIControlStateNormal];
        }
    }else if ([self.stateLB.text isEqualToString:@"已点评"])
    {
        [self.doBtn setTitle:@"查看" forState:UIControlStateNormal];
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
    if ([self.doBtn.titleLabel.text isEqualToString:@"去做"]) {
        type = DoTaskType_do;
    }else if([self.doBtn.titleLabel.text isEqualToString:@"查看"])
    {
        type = DoTaskType_check;
    }else
    {
        type = DoTaskType_nomal;
    }
    if (self.DotaskBlock) {
        self.DotaskBlock(type, self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
