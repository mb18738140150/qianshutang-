//
//  ProtectEyeView.m
//  qianshutang
//
//  Created by aaa on 2018/8/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProtectEyeView.h"

@interface ProtectEyeView()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * tipView;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * explainLB;
@property (nonatomic, strong)UILabel * resultTipLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * resultLB;
@property (nonatomic, strong)UIImageView * resultImg;

@property (nonatomic, strong)NSMutableArray * resultContentArray;

@end

@implementation ProtectEyeView

- (NSMutableArray *)resultContentArray
{
    if (!_resultContentArray) {
        _resultContentArray = [NSMutableArray array];
    }
    return _resultContentArray;
}

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
    
    self.tipView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.625, kScreenHeight * 0.87)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    self.tipView.image = [UIImage imageNamed:@"protect_eye_bg"];
    [self addSubview:self.tipView];
    self.tipView.userInteractionEnabled = YES;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.tipView.hd_height * 0.066, self.tipView.hd_width, self.tipView.hd_height * 0.067)];
    self.titleLB.text = @"温馨提示";
    self.titleLB.textColor = UIColorFromRGB(0xFD8753);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.font = [UIFont systemFontOfSize:self.tipView.hd_height * 0.067 - 3];
    [self.tipView addSubview:self.titleLB];
    
    self.explainLB = [[UILabel alloc]initWithFrame:CGRectMake(self.tipView.hd_width / 2 - 120, CGRectGetMaxY(self.titleLB.frame) + self.tipView.hd_height * 0.06, 240, self.tipView.hd_height * 0.1)];
    self.explainLB.textAlignment = NSTextAlignmentCenter;
    self.explainLB.textColor = UIColorFromRGB(0xFD8753);
    self.explainLB.font = [UIFont systemFontOfSize:16];
    self.explainLB.numberOfLines = 0;
    self.explainLB.text = @"为确保您是家长\n请先回答下方问题";
    self.explainLB.adjustsFontSizeToFitWidth = YES;
    [self.tipView addSubview:self.explainLB];
    
    self.resultTipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.66, self.tipView.hd_height * 0.386, self.tipView.hd_height * 0.15, self.tipView.hd_height * 0.048)];
    self.resultTipLB.text = @"答错了";
    self.resultTipLB.textColor = UIColorFromRGB(0xffffff);
    [self.tipView addSubview:self.resultTipLB];
    self.resultTipLB.hidden = YES;
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.tipView.hd_height * 0.48, self.tipView.hd_width * 0.53, self.tipView.hd_height * 0.1 )];
    self.contentLB.textColor = UIColorFromRGB(0xffffff);
    self.contentLB.textAlignment = NSTextAlignmentRight;
    self.contentLB.font = [UIFont systemFontOfSize:self.contentLB.hd_height - 5];
    self.contentLB.text = @"108 / 9 =";
    [self.tipView addSubview:self.contentLB];
    
    self.resultLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentLB.frame) + self.tipView.hd_width * 0.05, self.tipView.hd_height * 0.455, self.tipView.hd_height * 0.36, self.tipView.hd_height * 0.154)];
    self.resultLB.textAlignment = NSTextAlignmentCenter;
    self.resultLB.textColor = UIColorFromRGB(0xffffff);
    self.resultLB.layer.cornerRadius = self.resultLB.hd_height / 2;
    self.resultLB.layer.masksToBounds = YES;
    self.resultLB.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    self.resultLB.layer.borderWidth = 3;
    self.resultLB.backgroundColor = UIColorFromRGB(0xFFA200);
    self.resultLB.font = [UIFont systemFontOfSize:self.contentLB.hd_height - 5];
    self.resultLB.text = @"?";
    [self.tipView addSubview:self.resultLB];
    
//    self.resultImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 39)];
//    self.resultImg.center = self.resultLB.center;
//    self.resultImg.image = [UIImage imageNamed:@""];
    
    NSArray * array = @[@1,@1,@7,@2];
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.tipView.hd_height * 0.169 + self.tipView.hd_width * 0.193 * i, self.tipView.hd_height * 0.645, self.tipView.hd_height * 0.186, self.tipView.hd_height * 0.186);
        btn.layer.cornerRadius = btn.hd_width / 2;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        btn.layer.borderWidth = 3;
        btn.backgroundColor = UIColorFromRGB(0xFFA200);
        btn.titleLabel.font = [UIFont systemFontOfSize:self.contentLB.hd_height - 5];
        [btn setTitle:[NSString stringWithFormat:@"%@", array[i]] forState:UIControlStateNormal];
        [self.tipView addSubview:btn];
        [self.resultContentArray addObject:btn];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)clickAction:(UIButton *)button
{
    self.resultTipLB.hidden = YES;
    if ([self.resultLB.text isEqualToString:@"?"]) {
        self.resultLB.text = [NSString stringWithFormat:@"%@", button.titleLabel.text];
    }else
    {
        self.resultLB.text = [self.resultLB.text stringByAppendingString:[NSString stringWithFormat:@"%@", button.titleLabel.text]];
        
        if (self.resultLB.text.intValue == 12) {
            if (self.changeProtectTimeBlock) {
                self.changeProtectTimeBlock(@"");
            }
            [self removeFromSuperview];
        }else
        {
            self.resultTipLB.hidden = NO;
            self.resultLB.text = @"?";
        }
    }
    
}

@end
