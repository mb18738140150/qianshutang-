//
//  CreatePrizeSelectView.m
//  qianshutang
//
//  Created by aaa on 2018/10/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreatePrizeSelectView.h"

@implementation CreatePrizeSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(20 , self.hd_height * 0.2, self.hd_width  - 40, self.hd_height * 0.2)];
    self.titleLB.textColor = UIColorFromRGB(0x555555);
    [self addSubview:self.titleLB];
    
    UITextField * contentBackView = [[UITextField alloc]initWithFrame:CGRectMake(20, self.hd_height * 0.5, self.hd_width  - 40, self.hd_height * 0.5)];
    contentBackView.backgroundColor = UIColorFromRGB(0xF9F5E9);
    contentBackView.layer.cornerRadius = 5;
    contentBackView.layer.masksToBounds = YES;
    contentBackView.textAlignment = NSTextAlignmentCenter;
    contentBackView.textColor = UIColorFromRGB(0x333333);
    self.contentTF = contentBackView;
    [self addSubview:contentBackView];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(60, self.hd_height * 0.5, self.hd_width - 120, self.hd_height * 0.5)];
    self.contentLB.backgroundColor = UIColorFromRGB(0xF9F5E9);
    self.contentLB.textColor = UIColorFromRGB(0x333333);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.contentLB];
    self.contentLB.hidden = YES;
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width - 50, self.hd_height * 0.5  + (self.hd_height * 0.5 - 17) / 2, 10, 17)];
    goImageView.image = [UIImage imageNamed:@"arrow_icon_phone"];
    [self addSubview:goImageView];
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = contentBackView.frame;
    [self addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selectAction
{
    if (self.selectBlock) {
        self.selectBlock();
    }
}

@end
