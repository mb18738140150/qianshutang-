//
//  PraiseAndFlowerView.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PraiseAndFlowerView.h"
@interface PraiseAndFlowerView()

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UIButton * fifteenBtn;
@property (nonatomic, strong)UIButton * tenBtn;
@property (nonatomic, strong)UIButton * fiveBtn;

@end

@implementation PraiseAndFlowerView

-(instancetype)initWithFrame:(CGRect)frame
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
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
    [self.backView addGestureRecognizer:tap];
    //resinTv
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight * 0.61)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    CGFloat backHeight = self.tipView.hd_height;
    CGFloat backWidth = self.tipView.hd_width;
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.182)];
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backWidth * 0.35, 0.133 * tipLB.hd_height, backWidth * 0.3, tipLB.hd_height * 0.733)];
    imageView.image = [UIImage imageNamed:@"like_icon"];
    [self.tipView addSubview:imageView];
    
    UIButton * dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(backWidth * 0.87, 0, backWidth * 0.1, tipLB.hd_height);
    [dismissBtn setImage:[UIImage imageNamed:@"close_chat_btn_green"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.tipView addSubview:dismissBtn];
    
    UIView * fifteenView = [self getFlowerViewWith:CGRectMake(backWidth * 0.08, tipLB.hd_height + backHeight * 0.067, backWidth * 0.84, backHeight *  0.182) andCount:@"15朵" andContent:@"非常棒，顶一个！"];
    [self.tipView addSubview:fifteenView];
    self.fifteenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fifteenBtn.frame = fifteenView.frame;
    [self.tipView addSubview:self.fifteenBtn];
    
    UIView * tenView = [self getFlowerViewWith:CGRectMake(backWidth * 0.08, CGRectGetMaxY(fifteenView.frame) + backHeight * 0.067, backWidth * 0.84, backHeight  * 0.182) andCount:@"10朵" andContent:@"很好，加油！"];
    [self.tipView addSubview:tenView];
    self.tenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tenBtn.frame = tenView.frame;
    [self.tipView addSubview:self.tenBtn];
    
    UIView * fiveView = [self getFlowerViewWith:CGRectMake(backWidth * 0.08, CGRectGetMaxY(tenView.frame) + backHeight * 0.067, backWidth * 0.84, backHeight *  0.182) andCount:@"5朵" andContent:@"好，继续努力！"];
    [self.tipView addSubview:fiveView];
    self.fiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fiveBtn.frame = fiveView.frame;
    [self.tipView addSubview:self.fiveBtn];
    
    [self.fifteenBtn addTarget:self action:@selector(fifteenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tenBtn addTarget:self action:@selector(tenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.fiveBtn addTarget:self action:@selector(fiveAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fifteenAction
{
    if (self.praiseBlock) {
        self.praiseBlock(@"15");
    }
    [self removeFromSuperview];
}

- (void)tenAction
{
    if (self.praiseBlock) {
        self.praiseBlock(@"10");
    }
    [self removeFromSuperview];
}

- (void)fiveAction
{
    if (self.praiseBlock) {
        self.praiseBlock(@"5");
    }
    [self removeFromSuperview];
}

- (UIView *)getFlowerViewWith:(CGRect)rect andCount:(NSString *)count andContent:(NSString *)content
{
    UIView * view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    UILabel * countLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.hd_width * 0.229, view.hd_height)];
    countLB.text = count;
    countLB.textColor = kMainColor;
    countLB.textAlignment = NSTextAlignmentRight;
    [view addSubview:countLB];
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(countLB.hd_width + view.hd_width * 0.046, view.hd_height * 0.186, view.hd_height * 0.627, view.hd_height * 0.627)];
    imageview.image = [UIImage imageNamed:@"flower"];
    [view addSubview:imageview];
    
    UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + view.hd_width * 0.046, 0, view.hd_width * 0.598, view.hd_height)];
    contentLB.text = content;
    contentLB.textColor = kMainColor;
    [view addSubview:contentLB];
    
    return view;
}

- (void)dismissAction
{
    [self removeFromSuperview];
}

@end
