//
//  FlowerView.m
//  qianshutang
//
//  Created by aaa on 2018/9/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "FlowerView.h"

@interface FlowerView()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)CADisplayLink * displayLink;

@property (nonatomic, strong)UIView * tipView;
@property (nonatomic, strong)UIImageView * bigImageView;
@property (nonatomic, strong)UIImageView * flowerCountView;

@property (nonatomic, strong)UIButton * sureBtn;
@end

@implementation FlowerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareUI{
    
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight , kScreenHeight * 0.76)];
    self.tipView.hd_centerX = self.hd_centerX;
    self.tipView.hd_centerY = self.hd_centerY;
    self.tipView.layer.cornerRadius = 10;
    self.tipView.layer.masksToBounds = YES;
    self.tipView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tipView];
    self.tipView.hidden = YES;
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.76)];
    topView.backgroundColor = UIColorFromRGB(0xFFCE54);
    [self.tipView addSubview:topView];
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRoundedRect:topView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * shaplayer = [[CAShapeLayer alloc]init];
    shaplayer.frame = topView.bounds;
    shaplayer.path = bezier.CGPath;
    shaplayer.backgroundColor = UIColorFromRGB(0xFFCE54).CGColor;
    shaplayer.fillColor = UIColorFromRGB(0xFFCE54).CGColor;
    shaplayer.strokeColor = UIColorFromRGB(0xFFCE54).CGColor;;
    [topView.layer addSublayer:shaplayer];
    
    self.bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.12, 0, self.tipView.hd_width * 0.74, self.tipView.hd_height * 0.54)];
    self.bigImageView.image = [UIImage imageNamed:@"flower_show"];
    [self.tipView addSubview:self.bigImageView];
    
    self.flowerCountView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.3, self.bigImageView.hd_height + 10, self.tipView.hd_width * 0.4, self.tipView.hd_height * 0.16)];
    self.flowerCountView.image = [UIImage imageNamed:@"flower_add"];
    [self.tipView addSubview:self.flowerCountView];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width * 0.36, self.tipView.hd_height * 0.80, self.tipView.hd_width * 0.28,  self.tipView.hd_height * 0.16);
    self.sureBtn.backgroundColor = kMainColor;
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tipView addSubview:self.sureBtn];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.displayLink invalidate];
        self.displayLink = nil;
        self.tipView.hidden = NO;
    });
    
    //方法每秒钟调用60次
    /*
     CADisplayLink用来重绘，绘图
     NSTimer用于计时，重复调用
     
     */
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAction:)];
    //
    //    self.displayLink.frameInterval = 0.5;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)backAction
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)handleAction:(CADisplayLink *)displayLink{
    
    UIImage *image = [UIImage imageNamed:@"flower"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat scale = arc4random_uniform(4) / 2.0;
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    CGSize winSize = self.bounds.size;
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = - imageView.frame.size.height;
    imageView.center = CGPointMake(x, y);
    
    [self.backView addSubview:imageView];
    [UIView animateWithDuration:arc4random_uniform(10) animations:^{
        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = imageView.frame.size.height * 0.5 + winSize.height;
        
        imageView.center = CGPointMake(toX, toY);
        imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(M_PI * 2));
        
        imageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
    //    NSLog(@"%ld",self.displayLink.frameInterval);
    //    NSLog(@"%lf",self.displayLink.duration);
    //
}


@end
