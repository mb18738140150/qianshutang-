//
//  TaskEveryDayListTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskEveryDayListTableViewCell.h"

@implementation TaskEveryDayListTableViewCell

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
    
    self.studentNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.studentNameLB.textAlignment = NSTextAlignmentCenter;
    self.studentNameLB.textColor = UIColorFromRGB(0x515151);
    self.studentNameLB.font = [UIFont systemFontOfSize:15];
    self.studentNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.studentNameLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentNameLB.frame) + 5, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    self.iconImageView.image = [UIImage imageNamed:@"protect_eye_bg"];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 4 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.taskNameLB.textColor = UIColorFromRGB(0x585858);
    self.taskNameLB.font = [UIFont systemFontOfSize:15];
    self.taskNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.taskNameLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskNameLB.frame), 0, self.hd_width / 4, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.numberOfLines = 0;
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width /6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:kdoState];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(self.hd_width / 12 * 11 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.commentBtn setTitle:@"去做" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commentBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.commentBtn.layer.cornerRadius = 3;
    self.commentBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.commentBtn];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        case 2:
        case 3:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kpartImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            
            self.taskNameLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 4:
        case 5:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kmadeImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            self.taskNameLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
        default:
            break;
    }
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        {
            self.studentNameLB.text = @"磨耳朵";
        }
            break;
        case 2:
        {
            self.studentNameLB.text = @"阅读";
        }
            break;
        case 3:
        {
            self.studentNameLB.text = @"录音";
        }
            break;
        case 4:
        {
            self.studentNameLB.text = @"创作";
        }
            break;
        case 5:
        {
            self.studentNameLB.text = @"视频";
        }
            break;
            
        default:
            break;
    }
    
    self.timeLB.text = [infoDic objectForKey:klogName];
    
    if ([[infoDic objectForKey:kdoState] isEqualToString:@"已完成"]) {
        if ([[infoDic objectForKey:@"type"] intValue] == 2 || [[infoDic objectForKey:@"type"] intValue] == 1) {
            [self.commentBtn setTitle:@"-" forState:UIControlStateNormal];
            self.commentBtn.backgroundColor = [UIColor whiteColor];
            [self.commentBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }else
        {
            [self.commentBtn setTitle:@"查看" forState:UIControlStateNormal];
        }
    }else if ([[infoDic objectForKey:kdoState] isEqualToString:@"未完成"])
    {
        if ([[infoDic objectForKey:kIsOverdue] intValue] == 1) {
            [self.commentBtn setTitle:@"-" forState:UIControlStateNormal];
            self.commentBtn.backgroundColor = [UIColor whiteColor];
            [self.commentBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
        }else
        {
            [self.commentBtn setTitle:@"去做" forState:UIControlStateNormal];
        }
    }else if ([[infoDic objectForKey:kdoState] isEqualToString:@"已检查"] || [[infoDic objectForKey:kdoState] isEqualToString:@"已点评"])
    {
        [self.commentBtn setTitle:@"查看" forState:UIControlStateNormal];
    }
    if (!self.isToday) {
        self.stateLB.text = @"-";
        [self.commentBtn setTitle:@"-" forState:UIControlStateNormal];
        self.commentBtn.backgroundColor = [UIColor whiteColor];
        [self.commentBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
    }
    if (self.isTeacher) {
        if ([[infoDic objectForKey:kdoState] isEqualToString:@"未完成"])
        {
            self.stateLB.text = @"未完成";
            self.stateLB.textColor = kMainColor_orange;
        }else
        {
            self.stateLB.text = @"-";
            self.stateLB.textColor = UIColorFromRGB(0x585858);
        }
        [self.commentBtn setTitle:@"-" forState:UIControlStateNormal];
        self.commentBtn.backgroundColor = [UIColor whiteColor];
        [self.commentBtn setTitleColor:UIColorFromRGB(0x585858) forState:UIControlStateNormal];
    }
    
}

- (void)commentAction
{
    if (self.operationTaskBlock) {
        self.operationTaskBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
