//
//  TeacherCourseListCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherCourseListCell.h"

@implementation TeacherCourseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.sectionLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 12, self.hd_height)];
    self.sectionLB.numberOfLines = 0;
    self.sectionLB.textColor = UIColorFromRGB(0x555555);
    self.sectionLB.textAlignment = NSTextAlignmentCenter;
    self.sectionLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"section"]];
    [self.contentView addSubview:self.sectionLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sectionLB.frame), 0, self.hd_width / 12 * 5, self.hd_height)];
    self.timeLB.numberOfLines = 0;
    self.timeLB.textColor = UIColorFromRGB(0x555555);
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.text = [infoDic objectForKey:@"beginendTime"];
    [self.contentView addSubview:self.timeLB];
    
    self.rateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width / 6, self.hd_height)];
    self.rateLB.numberOfLines = 0;
    self.rateLB.textColor = UIColorFromRGB(0x555555);
    self.rateLB.textAlignment = NSTextAlignmentCenter;
    self.rateLB.text = [infoDic objectForKey:@"chuQin"];
    [self.contentView addSubview:self.rateLB];
    
    self.operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operationBtn.frame = CGRectMake(self.hd_width / 6 * 5 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.operationBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.operationBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.operationBtn.layer.cornerRadius = 3;
    self.operationBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.operationBtn];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.hd_width  - self.hd_height * 0.5 - self.hd_height * 0.2 , self.hd_height * 0.25, self.hd_height * 0.5, self.hd_height * 0.5);
    [self.deleteBtn setImage:[UIImage imageNamed:@"icon_off"] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.deleteBtn];
    if (self.isDelete) {
        self.deleteBtn.hidden = NO;
    }else
    {
        self.deleteBtn.hidden = YES;
    }
    
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.operationBtn addTarget:self action:@selector(OperationAtion ) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)OperationAtion
{
    if (self.editBlock) {
        self.editBlock(self.infoDic);
    }
}

- (void)deleteAction
{
    if (self.deleteCourseBlock) {
        self.deleteCourseBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
