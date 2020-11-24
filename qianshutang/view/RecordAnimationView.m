//
//  RecordAnimationView.m
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "RecordAnimationView.h"
#import "RecordTool.h"

@interface RecordAnimationView()

@property (nonatomic, strong)UIView * contentView;

@property (nonatomic, strong)UIImageView * macroImageView;
@property (nonatomic, strong)UIView * minView;
@property (nonatomic, strong)UIView * midView;
@property (nonatomic, strong)UIView * maxView;
@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * complateBtn;

@property (nonatomic, strong)RecordTool * recoardTool;

@end

@implementation RecordAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.recoardTool = [RecordTool sharedInstance];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UIView * contentView = [[UIView alloc]initWithFrame:self.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    self.contentView = contentView;
    [self addSubview:self.contentView];
    
    self.macroImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.macroImageView.center = self.center;
    self.macroImageView.layer.cornerRadius = self.macroImageView.hd_height / 2;
    self.layer.masksToBounds = YES;
    self.macroImageView.image = [UIImage imageNamed:@"micro_btn"];
    [self.contentView addSubview:self.macroImageView];
    self.macroImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * animationTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animationAction)];
    [self.macroImageView addGestureRecognizer:animationTap];
    
    self.minView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
    self.minView.backgroundColor = [UIColor colorWithRed:248/255.0 green:161/255.0 blue:145/255.0 alpha:0.3];
    self.minView.center = self.center;
    self.minView.layer.cornerRadius = self.minView.hd_height / 2;
    self.minView.layer.masksToBounds = YES;
    [self.contentView insertSubview:self.minView belowSubview:self.macroImageView];
    
    self.midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.midView.backgroundColor = [UIColor colorWithRed:248/255.0 green:161/255.0 blue:145/255.0 alpha:0.3];
    self.midView.center = self.center;
    self.midView.layer.cornerRadius = self.midView.hd_height / 2;
    self.midView.layer.masksToBounds = YES;
    [self.contentView insertSubview:self.midView belowSubview:self.minView];
    
    self.maxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.maxView.backgroundColor = [UIColor colorWithRed:248/255.0 green:161/255.0 blue:145/255.0 alpha:0.3];
    self.maxView.center = self.center;
    self.maxView.layer.cornerRadius = self.maxView.hd_height / 2;
    self.maxView.layer.masksToBounds = YES;
    [self.contentView insertSubview:self.maxView belowSubview:self.midView];
    
    self.minView.hidden = YES;
    self.midView.hidden = YES;
    self.maxView.hidden = YES;
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.midView.frame), kScreenWidth, 20)];
    self.tipLB.textAlignment = NSTextAlignmentCenter;
    self.tipLB.textColor = UIColorFromRGB(0x5b5b5b);
    self.tipLB.text = @"点击 开始录音";
    [self.contentView addSubview:self.tipLB];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kScreenWidth / 2 - 80, self.tipLB.hd_y, 65, 25);
    cancelBtn.layer.cornerRadius = cancelBtn.hd_height / 2;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.backgroundColor = UIRGBColor(233, 88, 53);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:cancelBtn];
    
    UIButton * complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(kScreenWidth / 2 + 15, self.tipLB.hd_y, 65, 25);
    complateBtn.layer.cornerRadius = cancelBtn.hd_height / 2;
    complateBtn.layer.masksToBounds = YES;
    complateBtn.backgroundColor = UIRGBColor(233, 88, 53);
    [complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:complateBtn];
    
    self.cancelBtn = cancelBtn;
    self.complateBtn = complateBtn;
    cancelBtn.hidden = YES;
    complateBtn.hidden = YES;
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelAction
{
    if (self.cancelRecoardBlock) {
        self.cancelRecoardBlock();
    }
}

- (void)complateAction
{
    if (self.ComplateRecoardBlock) {
        self.ComplateRecoardBlock([self.recoardTool timelenght]);
    }
}


- (void)animationAction
{
    if (self.isRecoardComplate) {
        if ([[BTVoicePlayer share] isPlaying]) {
            [self stopPlay];
        }else
        {
            [self plaAudio];
        }
    }else
    {
        if (self.isAnimationing) {
            [self stopAnimation];
            
        }else
        {
            [self startAnimation];
            
        }
    }
}

- (void)show
{
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
    self.contentView.center = CGPointMake(self.hd_centerX, self.hd_centerY);
    CAKeyframeAnimation * rectAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rectAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, kScreenHeight)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY - 10)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY + 7)],[NSValue valueWithCGPoint:CGPointMake(self.hd_centerX, self.hd_centerY)]];
    
    CGFloat time1 = (self.hd_height + 10) / (self.hd_height + 10 + 18 + 8);
    CGFloat time2 = (18) / (self.hd_height + 10 + 18 + 8);
    
    rectAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:time1], [NSNumber numberWithFloat:time2], [NSNumber numberWithFloat:1]];
    
    rectAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    rectAnimation.repeatCount = 1;
    rectAnimation.calculationMode = kCAAnimationLinear;
    rectAnimation.autoreverses = NO;
    rectAnimation.duration = 0.35;
    [self.macroImageView.layer addAnimation:rectAnimation forKey:@"rectInAnimation"];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.center = CGPointMake(self.hd_centerX, kScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)stopPlay
{
    [[BTVoicePlayer share] stop];
    self.macroImageView.image = [UIImage imageNamed:@"play_btn_p"];
}

- (void)plaAudio
{
    [[BTVoicePlayer share]play:self.recoardTool.savePath];
    self.macroImageView.image = [UIImage imageNamed:@"play_suspend_btn"];
}

- (void)startAnimation
{
    [self.recoardTool startRecordVoice];
    CGFloat duration = 2;
    self.minView.hidden = NO;
    self.midView.hidden = NO;
    self.maxView.hidden = NO;
    self.isAnimationing = YES;
    self.tipLB.text = @"点击 结束录音";
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1.0);
    scaleAnimation.toValue = @(1.3);
    scaleAnimation.duration = duration;
    
    CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(1.0);
    alphaAnimation.toValue = @(0);
    alphaAnimation.duration = duration;
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = 100000;
    [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation,alphaAnimation, nil]];
    
    [self.minView.layer addAnimation:animationGroup forKey:@"animationGroup"];
    [self.midView.layer addAnimation:animationGroup forKey:@"animationGroup"];
    [self.maxView.layer addAnimation:animationGroup forKey:@"animationGroup"];
    
}
- (void)stopAnimation
{
    [self.recoardTool stopRecordVoice];
    self.isRecoardComplate = YES;
    self.minView.hidden = YES;
    self.midView.hidden = YES;
    self.maxView.hidden = YES;
    self.isAnimationing = NO;
    [self.minView.layer removeAnimationForKey:@"animationGroup"];
    [self.midView.layer removeAnimationForKey:@"animationGroup"];
    [self.maxView.layer removeAnimationForKey:@"animationGroup"];
    
    self.cancelBtn.hidden = NO;
    self.complateBtn.hidden = NO;
    self.macroImageView.image = [UIImage imageNamed:@"play_btn_p"];
}


@end
