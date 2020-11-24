//
//  ExplainView.m
//  qianshutang
//
//  Created by aaa on 2018/9/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ExplainView.h"

@interface ExplainView()

@property (nonatomic, strong)UIView * tipView;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UIView * backView;

@end

@implementation ExplainView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.5)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.tipView.hd_width - 20, self.tipView.hd_height * 0.5)];
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    self.contentLB.numberOfLines = 0;
    self.contentLB.text = @"1.在APP中学习完任意一篇课文（磨耳朵、录音或阅读），系统会自动完成今日学习打卡；\n2.学习打卡数据统计起始时间为2018/1/1";
    [self.tipView addSubview:self.contentLB];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(15, self.tipView.hd_height - 65, self.tipView.hd_width - 30, 50);
    self.closeBtn.backgroundColor = kMainColor;
    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tipView addSubview:self.closeBtn];
    self.closeBtn.layer.cornerRadius = self.closeBtn.hd_height / 2;
    self.closeBtn.layer.masksToBounds = YES;
    [self.closeBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissAction
{
    [self removeFromSuperview];
}

@end
