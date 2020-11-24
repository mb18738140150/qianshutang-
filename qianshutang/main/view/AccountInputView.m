//
//  AccountInputView.m
//  qianshutang
//
//  Created by aaa on 2018/7/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AccountInputView.h"

@implementation AccountInputView

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
    self.layer.cornerRadius = self.hd_height / 2;
    self.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_height / 2, self.hd_height / 2 - 8, 16, 16)];
    self.iconImageView.image = [UIImage imageNamed:@"account"];
    [self addSubview:self.iconImageView];
    
    self.contentTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width - self.hd_height - 40, self.hd_height)];
    self.contentTF.textColor = UIColorFromRGB(0x4e4e4e);
    self.contentTF.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.contentTF];
    
    self.typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeButton.frame = CGRectMake(self.hd_width - self.hd_height / 2 - 16, self.hd_height / 2 - 8, 16, 16);
    [self.typeButton setImage:[UIImage imageNamed:@"eyes_hide"] forState:UIControlStateNormal];
    [self.typeButton setImage:[UIImage imageNamed:@"eyes_show"] forState:UIControlStateSelected];
    [self addSubview:self.typeButton];
    [self.typeButton addTarget:self action:@selector(typeAction ) forControlEvents:UIControlEventTouchUpInside];
    self.typeButton.hidden = YES;
    
    self.getVreifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getVreifyCodeBtn.frame = CGRectMake(self.hd_width - self.hd_height / 2 - 80, self.hd_height / 2 - 15, 80, 30);
    [self.getVreifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getVreifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.getVreifyCodeBtn setTitleColor:UIColorFromRGB(0x5aae8d) forState:UIControlStateNormal];
    [self addSubview:self.getVreifyCodeBtn];
    [self.getVreifyCodeBtn addTarget:self action:@selector(typeAction ) forControlEvents:UIControlEventTouchUpInside];
    self.getVreifyCodeBtn.hidden = YES;
    [self.getVreifyCodeBtn addTarget:self action:@selector(getVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.seperateView = [[UIView alloc]initWithFrame:CGRectMake(self.getVreifyCodeBtn.hd_x - 20, self.hd_height / 2 - 10, 1, 20)];
    self.seperateView.backgroundColor = UIColorFromRGB(0x5aae8d);
    [self addSubview:self.seperateView];
    self.seperateView.hidden = YES;
    
}

- (void)typeAction
{
    self.typeButton.selected = !self.typeButton.selected;
    if (self.typeButton.selected) {
        self.contentTF.secureTextEntry = NO;
    }else
    {
        self.contentTF.secureTextEntry = YES;
    }
}

- (void)getVerifyCodeAction
{
    if (self.GetVerifyCodeBlock) {
        self.GetVerifyCodeBlock();
    }
}

@end
