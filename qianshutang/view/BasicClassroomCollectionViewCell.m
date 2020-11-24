//
//  BasicClassroomCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicClassroomCollectionViewCell.h"

@implementation BasicClassroomCollectionViewCell

- (void)resetWith:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    self.infoDic = infoDic;
    [self.contentView removeAllSubviews];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 4, 20, self.hd_width / 2, self.hd_width / 2)];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + 5, self.hd_width, 15)];
    
    self.titleLB.font = [UIFont boldSystemFontOfSize:14];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLB];
    
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBtn.frame = CGRectMake(0, 0, self.hd_width, self.hd_height);
    [self.clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickBtn];
    
//    self.iconImageView.image = [UIImage imageNamed:[infoDic objectForKey:@"imageStr"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageStr"]] placeholderImage:[UIImage imageNamed:[infoDic objectForKey:@"imageStr"]]];
    
    self.titleLB.text = [infoDic objectForKey:@"title"];
    
}

- (void)clickAction
{
    if (self.classroomClickBlock) {
        self.classroomClickBlock(self.infoDic);
    }
}

@end
