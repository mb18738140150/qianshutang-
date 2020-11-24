//
//  StartCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StartCollectionViewCell.h"

@implementation StartCollectionViewCell


- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIRGBColor(239, 239, 239);
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, 5, self.hd_width * 0.8, self.hd_height - 5)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, backView.hd_width - 8, backView.hd_width - 8)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"productIconUrl"]]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    self.typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, backView.hd_width * 0.4, backView.hd_width * 4 / 15.0)];
    [backView addSubview:self.typeImageView];
    
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
        case MaterailType_video:
            self.typeImageView.image = [UIImage imageNamed:@"tag_video"];
            break;
        case MaterailType_evaluation:
            self.cepingImageView.hidden = NO;
            break;
            
        default:
            break;
    }
    
    self.startImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.iconImageView.frame) + 5, 20, 20)];
    self.startImageView.image = [UIImage imageNamed:@"flower"];
    [backView addSubview:self.startImageView];
    
    self.startCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.startImageView.frame) + 10, self.startImageView.hd_y, 100, 20)];
    self.startCountLB.textColor = UIColorFromRGB(0xFD834E);
    self.startCountLB.font = kMainFont;
    [backView addSubview:self.startCountLB];
    self.startCountLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"flowerCount"]];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.startImageView.frame) , backView.hd_width - 10, 20)];
    self.nameLB.textColor = UIColorFromRGB(0x5e5e5e);
    [backView addSubview:self.nameLB];
    self.nameLB.font = kMainFont;
    self.nameLB.text = [infoDic objectForKey:@"memberName"];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.nameLB.frame), backView.hd_width - 16, backView.hd_height - CGRectGetMaxY(self.nameLB.frame))];
    self.titleLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.titleLB.numberOfLines = 0;
    self.titleLB.font = kMainFont;
    [backView addSubview:self.titleLB];
    self.titleLB.text = [infoDic objectForKey:kProductName];
    
    self.selectNumberLB = [[UILabel alloc]initWithFrame:CGRectMake(backView.hd_x + 3 , 9, backView.hd_width / 4, backView.hd_width / 4)];
    self.selectNumberLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.selectNumberLB];
    self.selectNumberLB.layer.cornerRadius = self.selectNumberLB.hd_width / 2;
    self.selectNumberLB.layer.masksToBounds = YES;
    self.selectNumberLB.layer.borderWidth = 1;
    self.selectNumberLB.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectNumberLB.backgroundColor = kMainColor;
    self.selectNumberLB.textColor = [UIColor whiteColor];
    self.selectNumberLB.hidden = YES;
    
    self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backView.frame) - 3 - backView.hd_width / 4, 9, backView.hd_width / 4, backView.hd_width / 4)];
    self.selectImageView.image = [UIImage imageNamed:@"add_course_icon"];
    [self.contentView addSubview:self.selectImageView];
    self.selectImageView.hidden = YES;
    
}

- (void)selectReset
{
    self.selectImageView.hidden = NO;
}

- (void)selectNumberReset
{
    self.selectNumberLB.hidden = NO;
}

@end
