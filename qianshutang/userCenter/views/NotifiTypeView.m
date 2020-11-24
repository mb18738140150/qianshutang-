//
//  NotifiTypeView.m
//  qianshutang
//
//  Created by aaa on 2018/8/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NotifiTypeView.h"

@interface NotifiTypeView()
@property (nonatomic, strong)NSString * title;
@property (nonatomic, assign)BOOL animation;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UIButton * openBtn;
@property (nonatomic, strong)UIButton * closeBtn;

@property (nonatomic, strong)UILabel * contentLB;

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSString * notifiType;

@end


@implementation NotifiTypeView

- (instancetype)initWithFrame:(CGRect)frame andType:(NSString *)type
{
    if (self = [super initWithFrame:frame]) {
        
        if (type) {
            self.notifiType = type;
        }else
        {
            self.notifiType = @"开启";
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
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.6)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.185)];
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
    
    
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openBtn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame) - self.tipView.hd_height * 0.32, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.1, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.openBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.openBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    self.openBtn.selected = YES;
    [self.tipView addSubview:self.openBtn];
    
    UILabel * nanLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.openBtn.frame) + 5, self.openBtn.hd_y, 50, self.openBtn.hd_height)];
    nanLB.text = @"开启";
    nanLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:nanLB];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(CGRectGetMinX(self.sureBtn.frame)  + 5, CGRectGetMaxY(tipLB.frame) + self.tipView.hd_height * 0.1, self.tipView.hd_height * 0.12, self.tipView.hd_height * 0.12);
    [self.closeBtn setImage:[UIImage imageNamed:@"listen_timing"] forState:UIControlStateNormal];
    [self.closeBtn setImage:[UIImage imageNamed:@"listen_timing_selected"] forState:UIControlStateSelected];
    [self.tipView addSubview:self.closeBtn];
    UILabel * nvLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.closeBtn.frame) + 5, self.closeBtn.hd_y, 50, self.closeBtn.hd_height)];
    nvLB.text = @"关闭";
    nvLB.textColor = UIColorFromRGB(0x515151);
    [self.tipView addSubview:nvLB];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.openBtn.frame) + self.tipView.hd_height * 0.1, self.tipView.hd_width, 45)];
    self.contentLB.text = @"聊天交流信息将通过App消息发送提醒";
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.numberOfLines = 0;
    [self.tipView addSubview:self.contentLB];
    
    if ([self.notifiType isEqualToString:@"开启"]) {
        self.openBtn.selected = YES;
        self.closeBtn.selected = NO;
    }else
    {
        self.openBtn.selected = NO;
        self.closeBtn.selected = YES;
        self.notifiType = @"关闭";
    }
    
    [self.openBtn addTarget:self action:@selector(infiniteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn addTarget:self action:@selector(coustomAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)infiniteAction
{
    self.openBtn.selected = YES;
    self.closeBtn.selected = NO;
    self.notifiType = @"开启";
    self.contentLB.text = @"聊天交流信息不发送App消息提醒，仅保留程序内小红点提示";
}
- (void)coustomAction
{
    self.openBtn.selected = NO;
    self.closeBtn.selected = YES;
    self.notifiType = @"关闭";
    self.contentLB.text = @"聊天交流信息将通过App消息发送提醒";
}


- (void)sureAction
{
    if (self.NotifySelectBlock) {
        self.NotifySelectBlock(self.notifiType);
    }
}

- (void)cancelAction
{
    if (self.DismissBlock) {
        self.DismissBlock();
    }
}



@end
