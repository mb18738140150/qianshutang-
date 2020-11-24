//
//  TodayTaskCollectionViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TodayTaskCollectionViewCell.h"

@interface TodayTaskCollectionViewCell()
@property (nonatomic, strong)UILabel * timeTipLB;
@end

@implementation TodayTaskCollectionViewCell

- (void)resetWithInfoDic:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.backgroundColor = UIRGBColor(239, 239, 239);
    self.infoDic = infoDic;
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width * 0.05, self.hd_height * 0.07, self.hd_width * 0.8, self.hd_height * 0.93)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    self.backView = backView;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.hd_width * 0.026, backView.hd_height * 0.024, backView.hd_width * 0.95, backView.hd_height * 0.57)];
    self.iconImageView.image = [UIImage imageNamed:@"recording_bg"];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [backView addSubview:self.iconImageView];
    
    
    self.typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconImageView.hd_x, self.iconImageView.hd_y + 5, backView.hd_width * 0.36, backView.hd_width * 0.32)];
    self.typeImageView.image = [UIImage imageNamed:@"off_the_stocks"];
    self.typeImageView.hidden = YES;
    [backView addSubview:self.typeImageView];
    
    self.cepingImageView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.iconImageView.hd_height * 0.8 , self.iconImageView.hd_width, self.iconImageView.hd_height * 0.2)];
    self.cepingImageView.text = @"7天内完成";
    self.cepingImageView.textAlignment = NSTextAlignmentCenter;
    self.cepingImageView.font = kMainFont;
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.cepingImageView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.cepingImageView.bounds;
    layer.path = bezierPath.CGPath;
    [self.cepingImageView.layer setMask:layer];
    self.cepingImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.cepingImageView.textColor = [UIColor whiteColor];
    [self.iconImageView addSubview:self.cepingImageView];
    
    UILabel * timeTipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_width - 14, self.cepingImageView.hd_y, 14, 14)];
    timeTipLB.backgroundColor = [UIColor redColor];
    timeTipLB.layer.cornerRadius = timeTipLB.hd_height / 2;
    timeTipLB.layer.masksToBounds = YES;
    self.timeTipLB = timeTipLB;
    timeTipLB.hidden = YES;
    [self.iconImageView addSubview:timeTipLB];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), backView.hd_width , backView.hd_height * 0.28)];
    self.titleLB.font = kMainFont;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.titleLB.numberOfLines = 0;
    [backView addSubview:self.titleLB];
    self.titleLB.text = [infoDic objectForKey:@"title"];
    
    self.complateLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_x, CGRectGetMaxY(self.titleLB.frame), backView.hd_width / 2, backView.hd_height * 0.07)];
    self.complateLB.font = kMainFont;
    self.complateLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.complateLB.numberOfLines = 0;
    [backView addSubview:self.complateLB];
    
    
    self.complateLB.attributedText = [self getComplate:@"已完成:0次"];
    
    self.leaveLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.hd_centerX, CGRectGetMaxY(self.titleLB.frame), backView.hd_width / 2 - 5, backView.hd_height * 0.07)];
    self.leaveLB.font = kMainFont;
    self.leaveLB.textAlignment = NSTextAlignmentRight;
    self.leaveLB.textColor = UIColorFromRGB(0x5e5e5e);
    self.leaveLB.numberOfLines = 0;
    [backView addSubview:self.leaveLB];
    self.leaveLB.attributedText = [self getLeave:@"剩余:0次"];
    
    self.pageLB = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.hd_centerX - self.backView.hd_width * 0.2, 0, self.backView.hd_width * 0.4, self.hd_height * 0.07)];
    self.pageLB.layer.cornerRadius = self.pageLB.hd_height / 2;
    self.pageLB.layer.masksToBounds = YES;
    self.pageLB.font = [UIFont systemFontOfSize:13];
    self.pageLB.textColor = UIColorFromRGB(0x555555);
    self.pageLB.textAlignment = NSTextAlignmentCenter;
    self.pageLB.backgroundColor = [UIColor whiteColor];
    self.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentpage, self.totalPage];
    [self.contentView addSubview:self.pageLB];
    
    if (self.taskShowType != TaskShowType_nomal) {
        self.cepingImageView.hidden = YES;
        self.timeTipLB.hidden = YES;
    }
    
    if (!self.isRead) {
        self.complateLB.hidden = YES;
        self.leaveLB.hidden = YES;
    }
    if (self.taskShowType == TaskShowType_teacher_edit_suitang) {
        self.complateLB.hidden = YES;
        self.leaveLB.hidden = YES;
        self.cepingImageView.hidden = YES;
        self.timeTipLB.hidden = YES;
        self.typeImageView.hidden = YES;
        
        self.iconImageView.frame = CGRectMake(backView.hd_width * 0.026, backView.hd_height * 0.024, backView.hd_width * 0.95, backView.hd_height * 0.47);
        self.titleLB.frame = CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), backView.hd_width , backView.hd_height * 0.28);
        
        self.repeatLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + self.backView.hd_height * 0.251, self.backView.hd_width * 0.42, self.backView.hd_height * 0.06)];
        self.repeatLB.text = @"重复次数:";
        self.repeatLB.textColor = UIColorFromRGB(0x555555);
        self.repeatLB.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:self.repeatLB];
        
        self.repeatTF = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.repeatLB.frame) + self.backView.hd_height * 0.064, self.backView.hd_height * 0.242 + CGRectGetMaxY(self.iconImageView.frame), self.backView.hd_width * 0.194, self.backView.hd_height * 0.079)];
        self.repeatTF.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        self.repeatTF.layer.borderWidth = 1;
        self.repeatTF.textColor = kMainColor;
        self.repeatTF.userInteractionEnabled = YES;
        self.repeatTF.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:self.repeatTF];
        self.repeatTF.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"repeatNum"]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cganheCounrAction)];
        [self.repeatTF addGestureRecognizer:tap];
        
        self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.changeBtn.frame = CGRectMake(self.backView.hd_width * 0.041, self.backView.hd_height * 0.85, self.backView.hd_width * 0.324, self.backView.hd_height * 0.124);
        self.changeBtn.backgroundColor = kMainColor;
        self.changeBtn.layer.cornerRadius = 5;
        self.changeBtn.layer.masksToBounds = YES;
        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backView addSubview:self.changeBtn];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(self.backView.hd_width * 0.64, self.backView.hd_height * 0.85, self.backView.hd_width * 0.324, self.backView.hd_height * 0.124);
        self.deleteBtn.backgroundColor = kMainColor;
        self.deleteBtn.layer.cornerRadius = 5;
        self.deleteBtn.layer.masksToBounds = YES;
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backView addSubview:self.deleteBtn];
        
        [self.changeBtn addTarget:self action:@selector(changeAction ) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        case 2:
        case 3:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kpartImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            
            self.titleLB.text = [infoDic objectForKey:kpartName];
        }
            break;
        case 4:
        case 5:
        {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:kmadeImg]] placeholderImage:[UIImage imageNamed:@"recording_bg"]];
            self.titleLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
        default:
            break;
    }
    if ([[infoDic objectForKey:kdoState] isEqualToString:@"已完成"] || [[infoDic objectForKey:kdoState] isEqualToString:@"已点评"] || [[infoDic objectForKey:kdoState] isEqualToString:@"已检查"]) {
        self.typeImageView.hidden = NO;
    }else if ([[infoDic objectForKey:kdoState] isEqualToString:@"未完成"])
    {
        self.timeTipLB.hidden = NO;
    }
    self.cepingImageView.text = [NSString stringWithFormat:@"%@天内完成", [infoDic objectForKey:kcompleteDay]];
    self.complateLB.attributedText = [self getComplate:[NSString stringWithFormat:@"已完成:%@次", [infoDic objectForKey:kpartCompleateNum]]];
    self.leaveLB.attributedText = [self getLeave:[NSString stringWithFormat:@"剩余:%@次", [infoDic objectForKey:kpartRemainNum]]];
    self.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentpage, self.totalPage];
    
    
}

- (void)cganheCounrAction
{
    if (self.changeRepeatCountBlock) {
        self.changeRepeatCountBlock(self.infoDic);
    }
}

- (void)changeAction
{
    if (self.changeBlock) {
        self.changeBlock(self.infoDic);
    }
}

- (void)deleteAction
{
    if (self.deleteBlock) {
        self.deleteBlock(self.infoDic);
    }
}

- (NSMutableAttributedString *)getComplate:(NSString * )str
{
    NSMutableAttributedString * cStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor};
    [cStr setAttributes:attribute range:NSMakeRange(4, str.length - 4)];
    return cStr;
}

- (NSMutableAttributedString *)getLeave:(NSString * )str
{
    NSMutableAttributedString * cStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor};
    [cStr setAttributes:attribute range:NSMakeRange(3, str.length - 3)];
    return cStr;
}

@end
