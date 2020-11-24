//
//  HaveArrangeTaskTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "HaveArrangeTaskTableViewCell.h"

@implementation HaveArrangeTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    UIImageView * xilieImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, self.hd_height / 2 - 10, 20, 20)];
    xilieImageView.image = [UIImage imageNamed:@"series_sign"];
    [self.contentView addSubview:xilieImageView];
    if ([[infoDic objectForKey:@"tempType"] intValue] == 2) {
        xilieImageView.hidden = NO;
    }else
    {
        xilieImageView.hidden = YES;
    }
    
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.hd_width / 4 - 30, self.hd_height)];
    self.taskNameLB.numberOfLines = 0;
    self.taskNameLB.textColor = UIColorFromRGB(0x555555);
    self.taskNameLB.textAlignment = NSTextAlignmentCenter;
    self.taskNameLB.text = [infoDic objectForKey:@"logTitle"];
    [self.contentView addSubview:self.taskNameLB];
    
    self.objectLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskNameLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.objectLB.numberOfLines = 0;
    self.objectLB.textColor = UIColorFromRGB(0x555555);
    self.objectLB.textAlignment = NSTextAlignmentCenter;
    self.objectLB.text = [infoDic objectForKey:@"logObj"];
    [self.contentView addSubview:self.objectLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.objectLB.frame), 0, self.hd_width / 4, self.hd_height)];
    self.timeLB.numberOfLines = 0;
    self.timeLB.textColor = UIColorFromRGB(0x555555);
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.text = [infoDic objectForKey:@"logTime"];
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.stateLB.numberOfLines = 0;
    self.stateLB.textColor = UIColorFromRGB(0x555555);
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    self.stateLB.text = [infoDic objectForKey:@"logState"];
    [self.contentView addSubview:self.stateLB];
    
    self.operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operationBtn.frame = CGRectMake(self.hd_width / 12 * 11 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.operationBtn setTitle:@"操作" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.operationBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.operationBtn.layer.cornerRadius = 3;
    self.operationBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.operationBtn];

    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.operationBtn addTarget:self action:@selector(OperationAtion ) forControlEvents:UIControlEventTouchUpInside];
}

- (void)OperationAtion
{
    if (self.haveArrangeTaskOperationBlock) {
        self.haveArrangeTaskOperationBlock(self.infoDic, self.operationBtn.frame);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
