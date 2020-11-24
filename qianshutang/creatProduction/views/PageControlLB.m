//
//  PageControlLB.m
//  qianshutang
//
//  Created by aaa on 2018/8/2.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PageControlLB.h"

@implementation PageControlLB

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backView = [[UIView alloc]initWithFrame:self.bounds];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = self.backView.hd_height / 2;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderColor = kMainColor.CGColor;
    self.backView.layer.borderWidth = 1;
    [self addSubview:self.backView];
    
    self.pageLB = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, self.hd_width - 6, self.hd_height - 6)];
    self.pageLB.backgroundColor = kMainColor;
    self.pageLB.textColor = [UIColor whiteColor];
    self.pageLB.layer.cornerRadius = self.pageLB.hd_height / 2;
    self.pageLB.layer.masksToBounds = YES;
    self.pageLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.pageLB];
}

@end
