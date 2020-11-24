//
//  GenderSelectView.m
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "GenderSelectView.h"

@interface GenderSelectView()

@property (nonatomic, strong)NSString * title;
@property (nonatomic, assign)BOOL animation;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UIButton * nanBtn;
@property (nonatomic, strong)UIButton * nvBtn;



@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSString * gender;

@end

@implementation GenderSelectView

- (instancetype)initWithFrame:(CGRect)frame andGender:(NSString *)gender
{
    if (self = [super initWithFrame:frame]) {
        
        if (gender) {
            self.gender = gender;
        }else
        {
            self.gender = @"男";
        }
        
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
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.47)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height / 5)];
    tipLB.text = @"设置";
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_height / 5, self.tipView.hd_height / 15 * 11, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_height / 5 - self.tipView.hd_height * 0.45, self.tipView.hd_height / 15 * 11, self.tipView.hd_height * 0.45, self.tipView.hd_height / 6);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    
    self.nanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nanBtn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame) - self.tipView.hd_height * 0.32, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.16, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.nanBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.nanBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    self.nanBtn.selected = YES;
    [self.tipView addSubview:self.nanBtn];
    
    UILabel * nanLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nanBtn.frame) + 5, self.nanBtn.hd_y, 50, self.nanBtn.hd_height)];
    nanLB.text = @"男";
    nanLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:nanLB];
    
    self.nvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nvBtn.frame = CGRectMake(CGRectGetMinX(self.sureBtn.frame)  + 5, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.16, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.nvBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.nvBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.nvBtn];
    UILabel * nvLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nvBtn.frame) + 5, self.nanBtn.hd_y, 50, self.nanBtn.hd_height)];
    nvLB.text = @"女";
    nvLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:nvLB];
    
    
    if ([self.gender isEqualToString:@"男"]) {
        self.nanBtn.selected = YES;
        self.nvBtn.selected = NO;
    }else
    {
        self.nanBtn.selected = NO;
        self.nvBtn.selected = YES;
        self.gender = @"女";
    }
    
    [self.nanBtn addTarget:self action:@selector(infiniteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nvBtn addTarget:self action:@selector(coustomAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)infiniteAction
{
    self.nanBtn.selected = YES;
    self.nvBtn.selected = NO;
    self.gender = @"男";
}
- (void)coustomAction
{
    self.nanBtn.selected = NO;
    self.nvBtn.selected = YES;
    self.gender = @"女";
}


- (void)sureAction
{
    if (self.genderSelectBlock) {
        self.genderSelectBlock(self.gender);
    }
}

- (void)cancelAction
{
    if (self.DismissBlock) {
        self.DismissBlock();
    }
}


@end
