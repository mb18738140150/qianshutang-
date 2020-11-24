//
//  XilieTaskYulanCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/10/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "XilieTaskYulanCollectionViewCell.h"

@interface XilieTaskYulanCollectionViewCell()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * titleLB;

@end

@implementation XilieTaskYulanCollectionViewCell


- (void)resetWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(5, 15, self.hd_width - 10, self.hd_height - 30)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 3;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:self.backView.bounds];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.titleLB];
    self.titleLB.textColor = UIColorFromRGB(0x656565);
    self.titleLB.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.titleLB.text = [infoDic objectForKey:@"title"];
    
}

- (void)selectReset
{
    self.titleLB.backgroundColor = kMainColor;
    self.titleLB.textColor = [UIColor whiteColor];
}

- (void)isHaveCourse:(BOOL)isHaveCourse
{
    if (isHaveCourse) {
        self.titleLB.textColor = UIColorFromRGB(0x333333);
        self.titleLB.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }else
    {
        self.titleLB.textColor = UIColorFromRGB(0x999999);
        self.titleLB.backgroundColor = UIColorFromRGB(0xffffff);
    }
}

@end
