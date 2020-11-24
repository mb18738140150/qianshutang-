//
//  ProductPatternSelectView.m
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductPatternSelectView.h"
#import "GrafitiViewController.h"
#import "MKPPlaceholderTextView.h"

@interface ProductPatternSelectView()<UITextViewDelegate>

@property (nonatomic, strong)UIButton * recoardBtn;
@property (nonatomic, strong)UIButton * tfBtn;

@property (nonatomic, strong)UIButton * filmBtn;
@property (nonatomic, strong)UIButton * videoBtn;

@property (nonatomic, strong)UIButton * photoBtn;
@property (nonatomic, strong)UIButton * photographBtn;
@property (nonatomic, strong)UIButton * graffitiBtn;
@property (nonatomic, strong)UIButton * materailBtn;

@property (nonatomic, strong)MKPPlaceholderTextView * textView;
@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)NSMutableArray * btnArray;
@property (nonatomic, strong)UIButton * selectBtn;

@property (nonatomic, strong)NSArray * colorArray;

@property (nonatomic, assign)BOOL isPhoto;

@end

@implementation ProductPatternSelectView

- (instancetype)initWithFrame:(CGRect)frame andVideoPhoto:(BOOL)isVideoPhoto
{
    if (self = [super initWithFrame:frame]) {
        if (isVideoPhoto) {
            [self prepareVideoPhotoProductSelectView];
        }else
        {
            [self preparePhotoProductSelectView];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andVideo:(BOOL)isVideo
{
    if (self = [super initWithFrame:frame]) {
        
        [self prepareVideoProductSelectView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withPhoto:(BOOL)isPhoto
{
    if (self = [super initWithFrame:frame]) {
        self.isPhoto = isPhoto;
        if (isPhoto) {
            [self preparePhotoProductSelectView];
        }else
        {
            [self prepareUI];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withPhoto:(BOOL)isPhoto andDoTask:(BOOL)isDoTask
{
    if (self = [super initWithFrame:frame]) {
        self.isPhoto = isPhoto;
        if (isPhoto) {
            [self preparePhotoProductSelectView_DoTask];
        }else
        {
            [self prepareUI_DoTask];
        }
    }
    return self;
}

- (void)prepareUI_DoTask
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13)];
    tiplabel.backgroundColor = kMainColor;
    tiplabel.text = @"选择创作作品模式";
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    // 音频模式
    UILabel * recoardLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    recoardLB.text = @"音频模式:";
    recoardLB.textColor = UIColorFromRGB(0x333333);
    recoardLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:recoardLB];
    
    self.recoardBtn = [self getOperationBtnWith:@"录音"];
    self.recoardBtn.frame = CGRectMake(CGRectGetMaxX(recoardLB.frame) + 20, recoardLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.recoardBtn];
    
    // 写作模式
    UILabel * writeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(recoardLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    writeLB.text = @"写作模式:";
    writeLB.textColor = UIColorFromRGB(0x333333);
    writeLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:writeLB];
    
    self.tfBtn = [self getOperationBtnWith:@"写作"];
    self.tfBtn.frame = CGRectMake(CGRectGetMaxX(writeLB.frame) + 20, writeLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.tfBtn];
    
    // 视频模式
    UILabel * videoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(writeLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    videoLB.text = @"视频模式:";
    videoLB.textColor = UIColorFromRGB(0x333333);
    videoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:videoLB];
    
    self.filmBtn = [self getOperationBtnWith:@"拍摄"];
    self.filmBtn.frame = CGRectMake(CGRectGetMaxX(videoLB.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.filmBtn];
    
    self.videoBtn = [self getOperationBtnWith:@"视频"];
    self.videoBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.videoBtn];
    
    // 绘本模式
    UILabel * photoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(videoLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    photoLB.text = @"绘本模式:";
    photoLB.textColor = UIColorFromRGB(0x333333);
    photoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:photoLB];
    
    self.photoBtn = [self getOperationBtnWith:@"图片"];
    self.photoBtn.frame = CGRectMake(CGRectGetMaxX(photoLB.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.photoBtn];
    
    self.photographBtn = [self getOperationBtnWith:@"拍照"];
    self.photographBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.photographBtn];
    
    self.graffitiBtn = [self getOperationBtnWith:@"画板"];
    self.graffitiBtn.frame = CGRectMake(CGRectGetMaxX(self.photographBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.graffitiBtn];
    
    self.materailBtn = [self getOperationBtnWith:@"作业素材"];
    self.materailBtn.frame = CGRectMake(CGRectGetMaxX(self.graffitiBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.materailBtn];
    
    operationView.frame = CGRectMake(operationView.hd_x, operationView.hd_y, kScreenWidth * 0.56 + 100, kScreenHeight * 0.88);
    operationView.center = backView.center;
    tiplabel.hd_width = operationView.hd_width;
    
    [self.recoardBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tfBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filmBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.graffitiBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.materailBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)preparePhotoProductSelectView_DoTask
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88 * 0.4)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13 * 2.5)];
    tiplabel.backgroundColor = kMainColor;
    if (self.isPhoto) {
        tiplabel.text = @"选择创作作品模式";
    }else
    {
        tiplabel.text = @"选择描述类型";
    }
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    // 绘本模式
    UILabel * photoLB = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.08 * 2.5, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5)];
    photoLB.text = @"绘本模式:";
    photoLB.textColor = UIColorFromRGB(0x333333);
    photoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:photoLB];
    
    self.photoBtn = [self getOperationBtnWith:@"图片"];
    self.photoBtn.frame = CGRectMake(CGRectGetMaxX(photoLB.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.photoBtn];
    
    self.photographBtn = [self getOperationBtnWith:@"拍照"];
    self.photographBtn.frame = CGRectMake(CGRectGetMaxX(self.photoBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.photographBtn];
    
    self.graffitiBtn = [self getOperationBtnWith:@"画板"];
    self.graffitiBtn.frame = CGRectMake(CGRectGetMaxX(self.photographBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.graffitiBtn];
    
    self.materailBtn = [self getOperationBtnWith:@"作业素材"];
    self.materailBtn.frame = CGRectMake(CGRectGetMaxX(self.graffitiBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.materailBtn];
    
    operationView.frame = CGRectMake(operationView.hd_x, operationView.hd_y, kScreenWidth * 0.56 + 100, operationView.hd_height);
    operationView.center = backView.center;
    tiplabel.hd_width = operationView.hd_width;
    
    [self.photoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.graffitiBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.materailBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13)];
    tiplabel.backgroundColor = kMainColor;
    tiplabel.text = @"选择创作作品模式";
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    // 音频模式
    UILabel * recoardLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    recoardLB.text = @"音频模式:";
    recoardLB.textColor = UIColorFromRGB(0x333333);
    recoardLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:recoardLB];
    
    self.recoardBtn = [self getOperationBtnWith:@"录音"];
    self.recoardBtn.frame = CGRectMake(CGRectGetMaxX(recoardLB.frame) + 20, recoardLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.recoardBtn];
    
    // 写作模式
    UILabel * writeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(recoardLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    writeLB.text = @"写作模式:";
    writeLB.textColor = UIColorFromRGB(0x333333);
    writeLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:writeLB];
    
    self.tfBtn = [self getOperationBtnWith:@"写作"];
    self.tfBtn.frame = CGRectMake(CGRectGetMaxX(writeLB.frame) + 20, writeLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.tfBtn];
    
    // 视频模式
    UILabel * videoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(writeLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    videoLB.text = @"视频模式:";
    videoLB.textColor = UIColorFromRGB(0x333333);
    videoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:videoLB];
    
    self.filmBtn = [self getOperationBtnWith:@"拍摄"];
    self.filmBtn.frame = CGRectMake(CGRectGetMaxX(videoLB.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.filmBtn];
    
    self.videoBtn = [self getOperationBtnWith:@"视频"];
    self.videoBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.videoBtn];
    
    // 绘本模式
    UILabel * photoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(videoLB.frame) + operationView.hd_height * 0.08, operationView.hd_width * 0.2, operationView.hd_height * 0.12)];
    photoLB.text = @"绘本模式:";
    photoLB.textColor = UIColorFromRGB(0x333333);
    photoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:photoLB];
    
    self.photoBtn = [self getOperationBtnWith:@"图片"];
    self.photoBtn.frame = CGRectMake(CGRectGetMaxX(photoLB.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.photoBtn];
    
    self.photographBtn = [self getOperationBtnWith:@"拍照"];
    self.photographBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.photographBtn];
    
    self.graffitiBtn = [self getOperationBtnWith:@"画板"];
    self.graffitiBtn.frame = CGRectMake(CGRectGetMaxX(self.photographBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12);
    [operationView addSubview:self.graffitiBtn];
    
    
    [self.recoardBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tfBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filmBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.graffitiBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareVideoPhotoProductSelectView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.537)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.207)];
    tiplabel.backgroundColor = kMainColor;
    tiplabel.text = @"选择描述类型";
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    // 视频模式
    UILabel * videoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.127, operationView.hd_width * 0.2, operationView.hd_height * 0.193)];
    videoLB.text = @"视频模式:";
    videoLB.textColor = UIColorFromRGB(0x333333);
    videoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:videoLB];
    
    self.filmBtn = [self getOperationBtnWith:@"拍摄"];
    self.filmBtn.frame = CGRectMake(CGRectGetMaxX(videoLB.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.193);
    [operationView addSubview:self.filmBtn];
    
    self.videoBtn = [self getOperationBtnWith:@"视频"];
    self.videoBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.193);
    [operationView addSubview:self.videoBtn];
    
    // 绘本模式
    UILabel * photoLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(videoLB.frame) + operationView.hd_height * 0.127, operationView.hd_width * 0.2, operationView.hd_height * 0.193)];
    photoLB.text = @"绘本模式:";
    photoLB.textColor = UIColorFromRGB(0x333333);
    photoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:photoLB];
    
    self.photoBtn = [self getOperationBtnWith:@"图片"];
    self.photoBtn.frame = CGRectMake(CGRectGetMaxX(photoLB.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.193);
    [operationView addSubview:self.photoBtn];
    
    self.photographBtn = [self getOperationBtnWith:@"拍照"];
    self.photographBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.193);
    [operationView addSubview:self.photographBtn];
    
    self.graffitiBtn = [self getOperationBtnWith:@"画板"];
    self.graffitiBtn.frame = CGRectMake(CGRectGetMaxX(self.photographBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.193);
    [operationView addSubview:self.graffitiBtn];
    
    
    [self.recoardBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tfBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filmBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.graffitiBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)preparePhotoProductSelectView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88 * 0.4)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13 * 2.5)];
    tiplabel.backgroundColor = kMainColor;
    if (self.isPhoto) {
        tiplabel.text = @"选择创作作品模式";
    }else
    {
        tiplabel.text = @"选择描述类型";
    }
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    // 绘本模式
    UILabel * photoLB = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.08 * 2.5, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5)];
    photoLB.text = @"绘本模式:";
    photoLB.textColor = UIColorFromRGB(0x333333);
    photoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:photoLB];
    
    self.photoBtn = [self getOperationBtnWith:@"图片"];
    self.photoBtn.frame = CGRectMake(CGRectGetMaxX(photoLB.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.photoBtn];
    
    self.photographBtn = [self getOperationBtnWith:@"拍照"];
    self.photographBtn.frame = CGRectMake(CGRectGetMaxX(self.photoBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.photographBtn];
    
    self.graffitiBtn = [self getOperationBtnWith:@"画板"];
    self.graffitiBtn.frame = CGRectMake(CGRectGetMaxX(self.photographBtn.frame) + 20, photoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.graffitiBtn];
    
    
    [self.photoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.graffitiBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareVideoProductSelectView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88 * 0.4)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13 * 2.5)];
    tiplabel.backgroundColor = kMainColor;
    if (self.isPhoto) {
        tiplabel.text = @"选择创作作品模式";
    }else
    {
        tiplabel.text = @"选择描述类型";
    }
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    
    UILabel * videoLB = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.08 * 2.5, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5)];
    videoLB.text = @"视频模式:";
    videoLB.textColor = UIColorFromRGB(0x333333);
    videoLB.textAlignment = NSTextAlignmentRight;
    [operationView addSubview:videoLB];
    
    self.filmBtn = [self getOperationBtnWith:@"拍摄"];
    self.filmBtn.frame = CGRectMake(CGRectGetMaxX(videoLB.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.filmBtn];
    
    self.videoBtn = [self getOperationBtnWith:@"视频"];
    self.videoBtn.frame = CGRectMake(CGRectGetMaxX(self.filmBtn.frame) + 20, videoLB.hd_y, operationView.hd_width * 0.2, operationView.hd_height * 0.12 * 2.5);
    [operationView addSubview:self.videoBtn];
    
    [self.filmBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)operationAction:(UIButton *)button
{
    ProDuctPatternType type = ProDuctPatternType_recoard;
    if ([button isEqual:self.recoardBtn]) {
        type = ProDuctPatternType_recoard;
    }else if ([button isEqual:self.tfBtn])
    {
        type = ProDuctPatternType_text;
    }else if ([button isEqual:self.filmBtn])
    {
        type = ProDuctPatternType_film;
    }else if ([button isEqual:self.videoBtn])
    {
        type = ProDuctPatternType_video;
    }else if ([button isEqual:self.photoBtn])
    {
        type = ProDuctPatternType_photo;
    }else if ([button isEqual:self.photographBtn])
    {
        type = ProDuctPatternType_photograph;
    }else if ([button isEqual:self.graffitiBtn])
    {
        type = ProDuctPatternType_graffiti;
    }else if ([button isEqual:self.materailBtn])
    {
        type = ProDuctPatternType_Metarial;
    }
    if (self.ProductPatternSelectBlock) {
        self.ProductPatternSelectBlock(type);
    }
    
}

- (UIButton * )getOperationBtnWith:(NSString * )title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x6CB79A) forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = UIColorFromRGB(0xd5ffef).CGColor;
    button.layer.borderWidth = 1;
    button.backgroundColor = UIColorFromRGB(0xF4FFFB);
    return button;
}

-(instancetype)initWithFrame:(CGRect)frame withText:(NSString *)text
{
    if (self = [super initWithFrame:frame]) {
       
        [self prepareTextUI:text];
    }
    return self;
}

- (void)prepareTextUI:(NSString *)text
{
    self.backgroundColor = [UIColor clearColor];
    self.btnArray = [NSMutableArray array];
    
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignAction)];
    [backView addGestureRecognizer:tap];
    
    UIView * operationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.56, kScreenHeight * 0.88)];
    operationView.center = backView.center;
    operationView.backgroundColor = [UIColor whiteColor];
    operationView.layer.cornerRadius = 8;
    operationView.layer.masksToBounds = YES;
    operationView.clipsToBounds = YES;
    [self addSubview:operationView];
    
    UILabel * tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, operationView.hd_width, operationView.hd_height * 0.13)];
    tiplabel.backgroundColor = kMainColor;
    tiplabel.text = @"文字描述";
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont systemFontOfSize:20];
    tiplabel.textColor = [UIColor whiteColor];
    [operationView addSubview:tiplabel];
    
    NSArray * colorArray = @[@{kcolorStr:kBlack,@"color":UIColorFromRGB(0x555555)},@{kcolorStr:kWhite,@"color":UIColorFromRGB(0xffffff)},@{kcolorStr:kRed,@"color":UIColorFromRGB(0xFF1D11)},@{kcolorStr:kYellow,@"color":UIColorFromRGB(0xF9F704)},@{kcolorStr:kGreen,@"color":UIColorFromRGB(0x20DA1D)},@{kcolorStr:kBlue,@"color":UIColorFromRGB(0x1B9BFF)},@{kcolorStr:kPurple,@"color":UIColorFromRGB(0x9204F8)},@{kcolorStr:kPink,@"color":UIColorFromRGB(0xFC00FF)}];
    self.colorArray = colorArray;
    for (int i = 0; i < colorArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(operationView.hd_width * 0.07 + operationView.hd_width * 0.116 * i, CGRectGetMaxY(tiplabel.frame) + operationView.hd_width * 0.037, operationView.hd_width * 0.053, operationView.hd_width * 0.053);
        button.backgroundColor = [colorArray[i] objectForKey:@"color"];
        button.layer.cornerRadius = button.hd_height / 2;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = UIColorFromRGB(0xcbcbcb).CGColor;
        button.layer.borderWidth = 1.5;
        [operationView addSubview:button];
        [self.btnArray addObject:button];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(textColorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    MKPPlaceholderTextView *textView = [[MKPPlaceholderTextView alloc]init];
    textView.frame = CGRectMake(operationView.hd_width * 0.07, CGRectGetMaxY(tiplabel.frame) + operationView.hd_height * 0.15, operationView.hd_width * 0.86, operationView.hd_height * 0.47);
    textView.placeholder = @"请输入描述";
    textView.text = text;
    textView.delegate = self;
    textView.layer.cornerRadius = 3;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = UIColorFromRGB(0xebebeb).CGColor;
    textView.layer.borderWidth = 1;
    textView.textColor = UIColorFromRGB(0x333333);
    self.textView = textView;
    [operationView addSubview:self.textView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(operationView.hd_width * 0.12, operationView.hd_height * 0.83, operationView.hd_width * 0.26, operationView.hd_height * 0.12);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [operationView addSubview:self.cancelBtn];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(operationView.hd_width * 0.62, operationView.hd_height * 0.83, operationView.hd_width * 0.26, operationView.hd_height * 0.12);
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = 5;
    self.complateBtn.layer.masksToBounds = YES;
    [operationView addSubview:self.complateBtn];
    
    [self.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.complateBtn addTarget:self action:@selector(textComplaetAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textColorAction:(UIButton *)button
{
    if ([self.selectBtn isEqual:button]) {
        return;
    }
    
    CGRect selectRect = CGRectMake(self.selectBtn.hd_centerX - button.hd_width / 2, self.selectBtn.hd_centerY - button.hd_width / 2, button.hd_width, button.hd_height);
    CGRect rect = CGRectMake(button.hd_x - 4, button.hd_y - 4, button.hd_width + 8, button.hd_height + 8);
    self.selectBtn.frame = selectRect;
    self.selectBtn.layer.cornerRadius = selectRect.size.width / 2;
    self.selectBtn.layer.masksToBounds = YES;
    button.frame = rect;
    button.layer.cornerRadius = rect.size.width / 2;
    button.layer.masksToBounds = YES;
    
    self.selectBtn = button;
    self.textView.textColor = button.backgroundColor;
}

- (void)resetTextColor:(NSString *)colorStr
{
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton * button = self.btnArray[i];
        NSDictionary * colorDic = self.colorArray[i];
        if ([[colorDic objectForKey:kcolorStr] isEqual:colorStr]) {
            [self textColorAction:button];
            return;
        }
    }
}

- (void)textComplaetAction
{
    if (self.textView.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"描述不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.textBlock) {
        self.textBlock(@{@"title":self.textView.text,kcolorStr:[[self.colorArray objectAtIndex:self.selectBtn.tag - 1000] objectForKey:kcolorStr]});
    }
}

- (void)resignAction
{
    [self.textView resignFirstResponder];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
