//
//  StarPrizeView.m
//  qianshutang
//
//  Created by aaa on 2018/9/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StarPrizeView.h"

@interface StarPrizeView()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)CADisplayLink * displayLink;

@property (nonatomic, strong)UIView * tipView;
@property (nonatomic, strong)UIImageView * bigImageView;
@property (nonatomic, strong)UILabel * contentLB;

@property (nonatomic, strong)UIButton * circleBtn;
@property (nonatomic, strong)UIButton * recordBtn;
@property (nonatomic, strong)UIButton * reReadBtn;

@property (nonatomic, strong)UIButton * backBtn;

@end

@implementation StarPrizeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andIsRecord:(BOOL)isRecord
{
    if (self = [super initWithFrame:frame]) {
        
        if (isRecord) {
            [self prepareRecordUI];
        }else
        {
            [self prepareUI];
        }
        
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
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(1, 1, self.tipView.hd_height / 9 * 2.5,  self.tipView.hd_height / 9);
    [self.backBtn setImage:[UIImage imageNamed:@"popup_left_return_btn_circle"] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kMainColor_orange forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tipView addSubview:self.backBtn];
    
    self.bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.22, self.tipView.hd_height * 0.048, self.tipView.hd_width * 0.56, self.tipView.hd_height * 0.466)];
    self.bigImageView.image = [UIImage imageNamed:@"popup_graph_star"];
    [self.tipView addSubview:self.bigImageView];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bigImageView.frame) + self.tipView.hd_height * 0.077, self.tipView.hd_width, self.tipView.hd_height * 0.05)];
    self.contentLB.textColor = UIColorFromRGB(0x222222);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:self.contentLB];
    self.contentLB.text = @"本次录音获得20星星";
    
    self.circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleBtn.frame = CGRectMake((self.tipView.hd_width - self.tipView.hd_height * 0.6) / 4, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.2);
    [self.circleBtn setImage:[UIImage imageNamed:@"repeat_record"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.circleBtn];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake((self.tipView.hd_width - self.tipView.hd_height * 0.6) / 2 +  self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.2);
    [self.recordBtn setImage:[UIImage imageNamed:@"popup_record"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.recordBtn];
    
    self.reReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reReadBtn.frame = CGRectMake((self.tipView.hd_width - self.tipView.hd_height * 0.6) / 4 * 3 + self.tipView.hd_height * 0.4, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.2);
    [self.reReadBtn setImage:[UIImage imageNamed:@"read_again_btn"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.reReadBtn];
    
    
    [self.circleBtn addTarget:self action:@selector(circleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBtn addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.reReadBtn addTarget:self action:@selector(reReadAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.backView removeAllSubviews];
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

- (void)prepareRecordUI
{
    
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
    
    
    self.bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.22, self.tipView.hd_height * 0.048, self.tipView.hd_width * 0.56, self.tipView.hd_height * 0.466)];
    self.bigImageView.image = [UIImage imageNamed:@"popup_graph_star"];
    [self.tipView addSubview:self.bigImageView];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bigImageView.frame) + self.tipView.hd_height * 0.077, self.tipView.hd_width, self.tipView.hd_height * 0.05)];
    self.contentLB.textColor = UIColorFromRGB(0x222222);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:self.contentLB];
    self.contentLB.text = @"";
    
    self.circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleBtn.frame = CGRectMake((self.tipView.hd_width - self.tipView.hd_height * 0.6) / 4, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.2);
    [self.circleBtn setImage:[UIImage imageNamed:@"popup_return_btn"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.circleBtn];
    
    
    self.reReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reReadBtn.frame = CGRectMake((self.tipView.hd_width - self.tipView.hd_height * 0.6) / 4 * 3 + self.tipView.hd_height * 0.4, self.tipView.hd_height * 0.75, self.tipView.hd_height * 0.2, self.tipView.hd_height * 0.2);
    [self.reReadBtn setImage:[UIImage imageNamed:@"popup_share_btn"] forState:UIControlStateNormal];
    [self.tipView addSubview:self.reReadBtn];
    
    
    [self.circleBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.reReadBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.backView removeAllSubviews];
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

- (void)resetContent:(NSMutableAttributedString *)content
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.contentLB.attributedText = content;
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)handleAction:(CADisplayLink *)displayLink{
    
    UIImage *image = [UIImage imageNamed:@"star"];
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

- (void)hideRecoedBtn
{
    self.recordBtn.hidden = YES;
}

#pragma mark - operation
- (void)backAction
{
    if (self.backBlock) {
        self.backBlock(YES);
    }
    [self removeFromSuperview];
    
}

- (void)circleAction
{
    if (self.circleBlock) {
        self.circleBlock(YES);
    }
    [self removeFromSuperview];
}

- (void)recordAction
{
    if (self.recordBlock) {
        self.recordBlock(YES);
    }
    [self removeFromSuperview];
}
- (void)reReadAction
{
    if (self.reReadBlock) {
        self.reReadBlock(YES);
    }
    [self removeFromSuperview];
}

- (void)shareAction
{
    if (self.shareBlock) {
        self.shareBlock(YES);
    }
}

@end
