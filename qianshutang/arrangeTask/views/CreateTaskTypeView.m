//
//  CreateTaskTypeView.m
//  qianshutang
//
//  Created by aaa on 2018/8/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreateTaskTypeView.h"

@interface CreateTaskTypeView()

@property (nonatomic, strong)UIButton * moerduoBtn;
@property (nonatomic, strong)UIButton * readBtn;
@property (nonatomic, strong)UIButton * recordBtn;
@property (nonatomic, strong)UIButton * createBtn;
@property (nonatomic, strong)UIButton * videoBtn;

@property (nonatomic, strong)UIView * backView;

@end


@implementation CreateTaskTypeView

- (instancetype)initWithFrame:(CGRect)frame andisXiLie:(BOOL)isXiLie
{
    if (self = [super initWithFrame:frame]) {
        self.isXiLie = isXiLie;
        [self prepareUI];
    }
    return self;
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
    [self addSubview:backView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
    [backView addGestureRecognizer:tap];
    
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.46, kScreenHeight * 0.52)];
    if (self.isXiLie) {
        self.backView.frame = CGRectMake(0, 0, kScreenWidth * 0.46, kScreenHeight * 0.296);
    }
    self.backView.center = self.center;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    
    CGFloat backViewWidth = self.backView.hd_width;
    CGFloat backVIewHeight = self.backView.hd_height;
    
    self.moerduoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moerduoBtn.frame = CGRectMake(backViewWidth * 0.12, backVIewHeight * 0.1, backViewWidth * 0.161, backVIewHeight * 0.364);
    [self.moerduoBtn setImage:[UIImage imageNamed:@"work_icon_ear"] forState:UIControlStateNormal];
    [self.backView addSubview:self.moerduoBtn];
    
    self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.readBtn.frame = CGRectMake(backViewWidth * 0.13 + CGRectGetMaxX(self.moerduoBtn.frame), backVIewHeight * 0.1, backViewWidth * 0.161, backVIewHeight * 0.364);
    [self.readBtn setImage:[UIImage imageNamed:@"work_icon_read"] forState:UIControlStateNormal];
    [self.backView addSubview:self.readBtn];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake(backViewWidth * 0.13 + CGRectGetMaxX(self.readBtn.frame), backVIewHeight * 0.1, backViewWidth * 0.161, backVIewHeight * 0.364);
    [self.recordBtn setImage:[UIImage imageNamed:@"work_icon_record"] forState:UIControlStateNormal];
    [self.backView addSubview:self.recordBtn];
    
    self.createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.createBtn.frame = CGRectMake(backViewWidth * 0.273, backVIewHeight * 0.52, backViewWidth * 0.161, backVIewHeight * 0.364);
    [self.createBtn setImage:[UIImage imageNamed:@"work_icon_creation"] forState:UIControlStateNormal];
    
    self.videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.videoBtn.frame = CGRectMake(backViewWidth * 0.13 + CGRectGetMaxX(self.createBtn.frame), backVIewHeight * 0.52, backViewWidth * 0.161, backVIewHeight * 0.364);
    [self.videoBtn setImage:[UIImage imageNamed:@"work_icon_video"] forState:UIControlStateNormal];
    [self.backView addSubview:self.createBtn];
    [self.backView addSubview:self.videoBtn];
    
    if (self.isXiLie) {
        self.createBtn.hidden = YES;
        self.videoBtn.hidden = YES;
        
        self.moerduoBtn.frame = CGRectMake(backViewWidth * 0.12, backVIewHeight * 0.1, backViewWidth * 0.161, backViewWidth * 0.23);
        self.readBtn.frame = CGRectMake(backViewWidth * 0.13 + CGRectGetMaxX(self.moerduoBtn.frame), backVIewHeight * 0.1, backViewWidth * 0.161, backViewWidth * 0.23);
        self.recordBtn.frame = CGRectMake(backViewWidth * 0.13 + CGRectGetMaxX(self.readBtn.frame), backVIewHeight * 0.1, backViewWidth * 0.161, backViewWidth * 0.23);
    }
    
    [self.moerduoBtn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.readBtn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBtn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.createBtn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)createAction:(UIButton *)button
{
    CreateTaskType type = CreateTaskType_read;
    
    if ([button isEqual:self.moerduoBtn]) {
        type = CreateTaskType_moerduo;
    }else if ([button isEqual:self.readBtn])
    {
        type = CreateTaskType_read;
    }else if ([button isEqual:self.recordBtn])
    {
        type = CreateTaskType_record;
    }
    else if ([button isEqual:self.createBtn])
    {
        type = CreateTaskType_create;
    }
    else if ([button isEqual:self.videoBtn])
    {
        type = CreateTaskType_video;
    }
    
    if (self.createTaskBlock) {
        self.createTaskBlock(type);
    }
    
}

- (void)dismissAction
{
    [self removeFromSuperview];
}

@end
