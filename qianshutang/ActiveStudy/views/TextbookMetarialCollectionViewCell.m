//
//  TextbookMetarialCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TextbookMetarialCollectionViewCell.h"

@interface TextbookMetarialCollectionViewCell()

@property (nonatomic, assign)BOOL isCouresWare;
@property (nonatomic, strong)UIButton * readBtn;
@property (nonatomic, strong)UIButton * recordBtn;

@property (nonatomic, strong)UIImageView * videoImageView;

@property (nonatomic, strong)UIImageView * haveReadImegeView;
@property (nonatomic, strong)UIImageView * haveRecordImageView;

@property (nonatomic, strong)UIImageView * lastImageView;

@property (nonatomic, strong)UIView * circleView;

@end

@implementation TextbookMetarialCollectionViewCell

- (void)searchReset
{
    UIBezierPath * bezierpath = [UIBezierPath bezierPath];
    
    [bezierpath moveToPoint:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_height / 2, self.pageLB.hd_height + self.pageLB.hd_y)];
    [bezierpath addArcWithCenter:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_height / 2, self.pageLB.hd_y + self.pageLB.hd_height / 2) radius:self.pageLB.hd_height / 2 startAngle:M_PI / 2 endAngle:M_PI * 1.5 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_width - self.pageLB.hd_height / 2, self.pageLB.hd_y)];
    [bezierpath addArcWithCenter:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_width - self.pageLB.hd_height / 2, self.pageLB.hd_y + self.pageLB.hd_height / 2) radius:self.pageLB.hd_height / 2 startAngle:M_PI * 1.5 endAngle:M_PI / 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, self.pageLB.hd_height + self.pageLB.hd_y)];
    
    [bezierpath addArcWithCenter:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, self.backView.hd_y + 5) radius:5 startAngle:M_PI * 1.5 endAngle:M_PI * 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame), CGRectGetMaxY(self.backView.frame) - 5)];
    
    [bezierpath addArcWithCenter:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, CGRectGetMaxY(self.backView.frame) - 5) radius:5 startAngle:0 endAngle:M_PI / 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.backView.hd_x + 5, CGRectGetMaxY(self.backView.frame))];
    
    [bezierpath addArcWithCenter:CGPointMake(self.backView.hd_x + 5, CGRectGetMaxY(self.backView.frame) - 5) radius:5 startAngle:M_PI / 2 endAngle:M_PI clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.backView.hd_x, self.backView.hd_y + 5)];
    
    [bezierpath addArcWithCenter:CGPointMake(self.backView.hd_x + 5, self.backView.hd_y + 5) radius:5 startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
    [bezierpath closePath];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.path = bezierpath.CGPath;
    layer.lineWidth = 2;
    [layer setStrokeColor:kMainColor.CGColor];
    
    [self.circleView.layer addSublayer:layer];
}
- (void)reSearchReset
{
    UIBezierPath * bezierpath = [UIBezierPath bezierPath];
    
    [bezierpath moveToPoint:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_height / 2, self.pageLB.hd_height + self.pageLB.hd_y)];
    [bezierpath addArcWithCenter:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_height / 2, self.pageLB.hd_y + self.pageLB.hd_height / 2) radius:self.pageLB.hd_height / 2 startAngle:M_PI / 2 endAngle:M_PI * 1.5 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_width - self.pageLB.hd_height / 2, self.pageLB.hd_y)];
    [bezierpath addArcWithCenter:CGPointMake(self.pageLB.hd_x + self.pageLB.hd_width - self.pageLB.hd_height / 2, self.pageLB.hd_y + self.pageLB.hd_height / 2) radius:self.pageLB.hd_height / 2 startAngle:M_PI * 1.5 endAngle:M_PI / 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, self.pageLB.hd_height + self.pageLB.hd_y)];
    
    [bezierpath addArcWithCenter:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, self.backView.hd_y + 5) radius:5 startAngle:M_PI * 1.5 endAngle:M_PI * 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(CGRectGetMaxX(self.backView.frame), CGRectGetMaxY(self.backView.frame) - 5)];
    
    [bezierpath addArcWithCenter:CGPointMake(CGRectGetMaxX(self.backView.frame) - 5, CGRectGetMaxY(self.backView.frame) - 5) radius:5 startAngle:0 endAngle:M_PI / 2 clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.backView.hd_x + 5, CGRectGetMaxY(self.backView.frame))];
    
    [bezierpath addArcWithCenter:CGPointMake(self.backView.hd_x + 5, CGRectGetMaxY(self.backView.frame) - 5) radius:5 startAngle:M_PI / 2 endAngle:M_PI clockwise:YES];
    [bezierpath addLineToPoint:CGPointMake(self.backView.hd_x, self.backView.hd_y + 5)];
    
    [bezierpath addArcWithCenter:CGPointMake(self.backView.hd_x + 5, self.backView.hd_y + 5) radius:5 startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
    [bezierpath closePath];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.path = bezierpath.CGPath;
    layer.lineWidth = 2;
    [layer setStrokeColor:UIRGBColor(239, 239, 239).CGColor];
    
    [self.circleView.layer addSublayer:layer];
}
- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIRGBColor(239, 239, 239);
    self.infoDic = infoDic;
    
    self.circleView = [[UIView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:self.circleView];
    self.circleView.backgroundColor = UIRGBColor(239, 239, 239);
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, self.hd_height * 0.076 + 2, self.hd_width * 0.8, self.hd_height * 0.924 - 4)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    self.backView = backView;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.hd_width * 0.075, backView.hd_height * 0.06, backView.hd_width * 0.85, backView.hd_height * 0.56)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"partImageUrl"]] placeholderImage:[UIImage imageNamed:@"recording_bg"]] ;
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    
    self.lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconImageView.hd_x + self.iconImageView.hd_width * 0.3, self.iconImageView.hd_y + self.iconImageView.hd_height * 0.3, self.iconImageView.hd_width * 0.4, self.iconImageView.hd_width * 0.4)];
    self.lastImageView.image = [UIImage imageNamed:@"icon_continue"];
    self.lastImageView.hidden = YES;
    [backView addSubview:self.lastImageView];
    if (self.isLastReadRecord) {
        self.lastImageView.hidden = NO;
    }
    
    self.videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) - self.iconImageView.hd_width / 4, 4, self.iconImageView.hd_width / 4, self.iconImageView.hd_width / 4)];
    [backView addSubview:self.videoImageView];
    self.videoImageView.image = [UIImage imageNamed:@"book_frame_video"];
    self.videoImageView.hidden = YES;
    self.videoImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * videoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoAction)];
    [self.videoImageView addGestureRecognizer:videoTap];

    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), backView.hd_width , backView.hd_height * 0.2)];
    self.titleLB.font = kMainFont;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.titleLB.numberOfLines = 0;
    [backView addSubview:self.titleLB];
    self.titleLB.text = [infoDic objectForKey:kpartName];
    
    self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.readBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLB.frame), (self.backView.hd_width - 2) / 2, backView.hd_height * 0.18);
    [self.readBtn setTitle:@"阅读" forState:UIControlStateNormal];
    [self.readBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.readBtn.backgroundColor = kMainColor;
    [self.readBtn setBackgroundImage:[UIImage imageNamed:@"material_bg_left"] forState:UIControlStateNormal];
    UIBezierPath * leftPath = [UIBezierPath bezierPathWithRoundedRect:self.readBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * leftLayer = [[CAShapeLayer alloc]init];
    leftLayer.path = leftPath.CGPath;
    [self.readBtn.layer setMask:leftLayer];
    [self.backView addSubview:self.readBtn];
    
    self.haveReadImegeView = [[UIImageView alloc]initWithFrame:CGRectMake(self.readBtn.hd_x + self.readBtn.hd_width * 0.7, self.readBtn.hd_y + self.readBtn.hd_height * 0.67, self.readBtn.hd_width * 0.3, self.readBtn.hd_height * 0.33)];
    self.haveReadImegeView.image = [UIImage imageNamed:@"white_checkmark"];
    [self.backView addSubview:self.haveReadImegeView];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake(self.backView.hd_width / 2 + 1, CGRectGetMaxY(self.titleLB.frame), (self.backView.hd_width - 2) / 2, backView.hd_height * 0.18);
    [self.recordBtn setTitle:@"录音" forState:UIControlStateNormal];
    [self.recordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.recordBtn.backgroundColor = kMainColor;
    [self.recordBtn setBackgroundImage:[UIImage imageNamed:@"material_bg"] forState:UIControlStateNormal];
    UIBezierPath * rightPath = [UIBezierPath bezierPathWithRoundedRect:self.readBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * rightLayer = [[CAShapeLayer alloc]init];
    rightLayer.path = rightPath.CGPath;
    [self.recordBtn.layer setMask:rightLayer];
    [self.backView addSubview:self.recordBtn];
    
    self.haveRecordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.recordBtn.hd_x + self.recordBtn.hd_width * 0.7, self.recordBtn.hd_y + self.recordBtn.hd_height * 0.67, self.recordBtn.hd_width * 0.3, self.recordBtn.hd_height * 0.33)];
    self.haveRecordImageView.image = [UIImage imageNamed:@"white_checkmark"];
    [self.backView addSubview:self.haveRecordImageView];
    
    self.haveReadImegeView.hidden = YES;
    self.haveRecordImageView.hidden = YES;
    
    [self.recordBtn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.readBtn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
        // only video
        self.readBtn.hidden = YES;
        self.recordBtn.hidden = YES;
        self.videoImageView.hidden = NO;
    }else if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 1)
    {
        // video and audio
        self.videoImageView.hidden = NO;
    }
    
    if ([[infoDic objectForKey:@"isRead"] intValue] == 1) {
        self.haveReadImegeView.hidden = NO;
    }
    if ([[infoDic objectForKey:@"isRecord"] intValue] == 1) {
        self.haveRecordImageView.hidden = NO;
    }
    
    self.pageLB = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.hd_centerX - self.backView.hd_width * 0.2, 2, self.backView.hd_width * 0.4, self.hd_height * 0.076)];
    self.pageLB.layer.cornerRadius = self.pageLB.hd_height / 2;
    self.pageLB.layer.masksToBounds = YES;
    self.pageLB.font = [UIFont systemFontOfSize:13];
    self.pageLB.textColor = UIColorFromRGB(0x555555);
    self.pageLB.textAlignment = NSTextAlignmentCenter;
    self.pageLB.backgroundColor = [UIColor whiteColor];
    self.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentpage, self.totalPage];
    [self.contentView addSubview:self.pageLB];
    
}

- (void)resetCCoursewareWithInfoDic:(NSDictionary *)infoDic
{
    self.isCouresWare = YES;
    [self resetWithInfoDic:infoDic];
}

- (void)recordAction:(UIButton *)button
{
    if ([button isEqual:self.readBtn]) {
        if (self.readTextBlock) {
            self.readTextBlock(self.infoDic);
        }
    }else
    {
        if (self.recordTextBlock) {
            self.recordTextBlock(self.infoDic);
        }
    }
}

- (void)videoAction
{
    if (self.videoBlock) {
        self.videoBlock(self.infoDic);
    }
}

@end
