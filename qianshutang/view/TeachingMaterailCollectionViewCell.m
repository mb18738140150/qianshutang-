//
//  TeachingMaterailCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeachingMaterailCollectionViewCell.h"

@interface TeachingMaterailCollectionViewCell()

@property (nonatomic, assign)BOOL isCouresWare;
@property (nonatomic, strong)UIButton * readBtn;
@property (nonatomic, strong)UIButton * recordBtn;

@property (nonatomic, strong)UIImageView * videoImageView;

@end

@implementation TeachingMaterailCollectionViewCell

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIRGBColor(239, 239, 239);
    self.infoDic = infoDic;
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, 5, self.hd_width * 0.8, self.hd_height - 5)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    self.backView = backView;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, backView.hd_width - 8, backView.hd_width - 8)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imagrUrl"]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    self.imageLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.iconImageView.hd_width - 20, self.iconImageView.hd_width - 20)];
    self.imageLB.text = [infoDic objectForKey:@"title"];
    self.imageLB.textColor = UIColorFromRGB(0x161DCC);
    self.imageLB.textAlignment = NSTextAlignmentCenter;
    self.imageLB.font = [UIFont boldSystemFontOfSize:17];
    self.imageLB.numberOfLines = 0;
    [self.iconImageView addSubview:self.imageLB];
    self.imageLB.hidden = YES;
    
    self.teacherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.iconImageView.hd_height * 0.044, self.iconImageView.hd_width * 0.68, self.iconImageView.hd_height * 0.304)];
    self.teacherImageView.image = [UIImage imageNamed:@"teacher_logo"];
    [self.iconImageView addSubview:self.teacherImageView];
    self.teacherImageView.hidden = YES;
    if (self.isTeacher) {
        self.teacherImageView.hidden = NO;
    }
    
    
    self.typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, backView.hd_width * 0.4, backView.hd_width * 4 / 15.0)];
    [backView addSubview:self.typeImageView];
    
    self.videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) - self.iconImageView.hd_width / 4, 4, self.iconImageView.hd_width / 4, self.iconImageView.hd_width / 4)];
    [backView addSubview:self.videoImageView];
    self.videoImageView.image = [UIImage imageNamed:@"book_frame_video"];
    self.videoImageView.hidden = YES;
    self.videoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * videoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoAction)];
    [self.videoImageView addGestureRecognizer:videoTap];
    
    self.cepingImageView = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_centerX, CGRectGetMaxY(self.iconImageView.frame) - 25, self.iconImageView.hd_width / 2, 25)];
    self.cepingImageView.text = @"可测评";
    self.cepingImageView.textAlignment = NSTextAlignmentCenter;
    self.cepingImageView.font = kMainFont;
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.cepingImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.cepingImageView.bounds;
    layer.path = bezierPath.CGPath;
    [self.cepingImageView.layer setMask:layer];
    self.cepingImageView.backgroundColor = [UIColor redColor];
    self.cepingImageView.textColor = [UIColor whiteColor];
    [backView addSubview:self.cepingImageView];
    
    self.cepingImageView.hidden = YES;
    switch ([[infoDic objectForKey:@"type"] integerValue]) {
        case MaterailType_ppt:
            self.typeImageView.image = [UIImage imageNamed:@"tag_ppt"];
            break;
        case MaterailType_nomal:
            self.typeImageView.image = [UIImage imageNamed:@""];
            break;
        case MaterailType_explain:
            self.typeImageView.image = [UIImage imageNamed:@"tag_explain"];
            break;
        case MaterailType_audio:
            self.typeImageView.image = [UIImage imageNamed:@"tag_voice"];
            break;
        case MaterailType_video:
            self.typeImageView.image = [UIImage imageNamed:@"tag_video"];
//            self.videoImageView.hidden = NO;
            break;
        case MaterailType_evaluation:
            self.cepingImageView.hidden = NO;
            break;
            
        default:
            break;
    }
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.iconImageView.frame) + 3, backView.hd_width - 16, backView.hd_height - CGRectGetMaxY(self.iconImageView.frame) - 6)];
    self.titleLB.font = kMainFont;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.titleLB.numberOfLines = 0;
    [backView addSubview:self.titleLB];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    
    self.selectNumberLB = [[UILabel alloc]initWithFrame:CGRectMake(backView.hd_x + 3 , 9, backView.hd_width / 4, backView.hd_width / 4)];
    self.selectNumberLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.selectNumberLB];
    self.selectNumberLB.layer.cornerRadius = self.selectNumberLB.hd_width / 2;
    self.selectNumberLB.layer.masksToBounds = YES;
    self.selectNumberLB.layer.borderWidth = 2;
    self.selectNumberLB.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectNumberLB.backgroundColor = kMainColor;
    self.selectNumberLB.textColor = [UIColor whiteColor];
    self.selectNumberLB.hidden = YES;
    
    self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backView.frame) - 3 - backView.hd_width / 4, 9, backView.hd_width / 4, backView.hd_width / 4)];
    self.selectImageView.image = [UIImage imageNamed:@"add_course_icon"];
    [self.contentView addSubview:self.selectImageView];
    self.selectImageView.hidden = YES;
    self.selectImageView.userInteractionEnabled = YES;
    
    
    self.nContentNumberLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backView.frame) - 3 - backView.hd_width / 5, 9, backView.hd_width / 5, backView.hd_width / 5)];
    self.nContentNumberLB.textAlignment = NSTextAlignmentCenter;
    self.nContentNumberLB.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.nContentNumberLB];
    
    self.nContentNumberLB.layer.cornerRadius = self.nContentNumberLB.hd_width / 2;
    self.nContentNumberLB.layer.masksToBounds = YES;
    self.nContentNumberLB.textColor = [UIColor whiteColor];
    self.nContentNumberLB.hidden = YES;
    
    if (self.isCouresWare) {
        
        self.titleLB.frame = CGRectMake(8, CGRectGetMaxY(self.iconImageView.frame) + 3, backView.hd_width - 16, 38);
        
        self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.readBtn.frame = CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 3, (self.backView.hd_width - 2) / 2, 50);
        [self.readBtn setTitle:@"阅读" forState:UIControlStateNormal];
        [self.readBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.readBtn.backgroundColor = kMainColor;
        [self.readBtn setBackgroundImage:[UIImage imageNamed:@"material_bg_left"] forState:UIControlStateNormal];
        UIBezierPath * leftPath = [UIBezierPath bezierPathWithRoundedRect:self.readBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * leftLayer = [[CAShapeLayer alloc]init];
        leftLayer.path = leftPath.CGPath;
        [self.readBtn.layer setMask:leftLayer];
        
        self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.recordBtn.frame = CGRectMake(self.backView.hd_width / 2 + 1, CGRectGetMaxY(self.titleLB.frame) + 3, (self.backView.hd_width - 2) / 2, 50);
        [self.recordBtn setTitle:@"录音" forState:UIControlStateNormal];
        if (self.isTeacherExplain) {
            [self.recordBtn setTitle:@"讲解" forState:UIControlStateNormal];
        }
        [self.recordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.recordBtn.backgroundColor = kMainColor;
        [self.recordBtn setBackgroundImage:[UIImage imageNamed:@"material_bg"] forState:UIControlStateNormal];
        UIBezierPath * rightPath = [UIBezierPath bezierPathWithRoundedRect:self.readBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * rightLayer = [[CAShapeLayer alloc]init];
        rightLayer.path = rightPath.CGPath;
        [self.recordBtn.layer setMask:rightLayer];
        
        [self.backView addSubview:self.readBtn];
        [self.backView addSubview:self.recordBtn];
        [self.recordBtn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.readBtn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[infoDic objectForKey:kMP4Src] class] == [NSNull class] || [infoDic objectForKey:kMP4Src] == nil || [[infoDic objectForKey:kMP4Src] isEqualToString:@""]) {
            self.videoImageView.hidden = YES;
        }else{
            self.videoImageView.hidden = NO;
        }
        
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case MaterailType_text:
            {
                self.typeImageView.image = [UIImage imageNamed:@"tag_text"];
                if ([[infoDic objectForKey:@"mp4Src"] class]  != [NSNull class]) {
                    if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
                        // only video
                        self.readBtn.hidden = YES;
                        self.recordBtn.hidden = YES;
                    }
                }
            }
                break;
            case MaterailType_ppt:
            case MaterailType_audio:
            case MaterailType_video:
                self.recordBtn.hidden = YES;
                self.readBtn.hidden = YES;
                break;
                
            default:
                break;
        }
    }
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

- (void)selectReset
{
    self.selectImageView.hidden = NO;
    self.selectImageView.image = [UIImage imageNamed:@"add_course_icon"];
}

- (void)deleteReset
{
    self.selectImageView.hidden = NO;
    self.selectImageView.image = [UIImage imageNamed:@"icon_off"];
}

- (void)shareNoSelectReset
{
    self.selectImageView.hidden = NO;
    self.selectImageView.image = [UIImage imageNamed:@"选中"];
}
- (void)shareSelectReset
{
    self.selectImageView.hidden = NO;
    self.selectImageView.image = [UIImage imageNamed:@"icon_send"];
}

- (void)dleteAction
{
    if (self.deleteBlock) {
        self.deleteBlock(self.infoDic);
    }
}

- (void)haveCollect
{
    self.selectImageView.hidden = NO;
    self.selectImageView.image = [UIImage imageNamed:@"icon_send"];
}

- (void)selectNumberReset
{
    self.selectNumberLB.hidden = YES;
}

- (void)showContentNumberWith:(int)number
{
    self.imageLB.hidden = NO;
    if (number >0) {
        self.nContentNumberLB.hidden = NO;
        self.nContentNumberLB.text = [NSString stringWithFormat:@"%d", number];
    }else if (number == 0)
    {
        self.nContentNumberLB.hidden = YES;
    }else
    {
        self.nContentNumberLB.hidden = NO;
        self.nContentNumberLB.frame = CGRectMake(CGRectGetMaxX(self.backView.frame) - 3 - self.backView.hd_width / 10, 9, self.backView.hd_width / 10, self.backView.hd_width / 10);
        self.nContentNumberLB.layer.cornerRadius = self.nContentNumberLB.hd_width / 2;
        self.nContentNumberLB.layer.masksToBounds = YES;
    }
    
}
#pragma mark - 观看视频
- (void)videoAction
{
    if (self.videoBlock) {
        self.videoBlock(self.infoDic);
    }
}
@end
