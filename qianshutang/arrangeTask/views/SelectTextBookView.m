//
//  SelectTextBookView.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SelectTextBookView.h"

@implementation SelectTextBookView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.numberLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width * 0.02, self.hd_height * 0.355, self.hd_height * 0.29, self.hd_height * 0.29)];
    self.numberLB.layer.cornerRadius = self.numberLB.hd_height / 2;
    self.numberLB.layer.masksToBounds = YES;
    self.numberLB.layer.borderColor = UIColorFromRGB(0x555555).CGColor;
    self.numberLB.layer.borderWidth = 1;
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.textColor = UIColorFromRGB(0x555555);
    self.numberLB.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.numberLB];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width * 0.02 + CGRectGetMaxX(self.numberLB.frame), 0, self.hd_width * 0.303, self.hd_height)];
    self.titleLB.textColor = UIColorFromRGB(0x555555);
    [self addSubview:self.titleLB];
    
    UITextField * contentBackView = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame), self.hd_height * 0.08, self.hd_width * 0.607, self.hd_height * 0.84)];
    contentBackView.backgroundColor = [UIColor whiteColor];
    contentBackView.layer.cornerRadius = 5;
    contentBackView.layer.masksToBounds = YES;
    contentBackView.textAlignment = NSTextAlignmentCenter;
    contentBackView.textColor = UIColorFromRGB(0xFF6C33);
    self.contentTF = contentBackView;
    [self addSubview:contentBackView];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * 0.93, self.hd_height * 0.35, self.hd_width * 0.025, self.hd_height * 0.3)];
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

- (void)hideNumberLB
{
    self.numberLB.hidden = YES;
}

@end
