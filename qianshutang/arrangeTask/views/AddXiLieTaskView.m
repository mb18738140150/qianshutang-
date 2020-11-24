//
//  AddXiLieTaskView.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddXiLieTaskView.h"

@interface AddXiLieTaskView()

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;


@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;




@property (nonatomic, strong)UIButton * repeatBtn;

@end


@implementation AddXiLieTaskView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
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
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction )];
    [backView addGestureRecognizer:tap];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.933)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.119)];
    tipLB.text = self.title;
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.109);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.109);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    
    self.textBookView = [[SelectTextBookView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.043, tipLB.hd_height + self.tipView.hd_height * 0.045, self.tipView.hd_width * 0.914, self.tipView.hd_height * 0.123)];
    self.textBookView.numberLB.text = @"1";
    self.textBookView.titleLB.text = @"选择课本";
    self.textBookView.contentTF.placeholder = @"点击此处选择课本";
    
    self.startTextView = [[SelectTextBookView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.043, CGRectGetMaxY(self.textBookView.frame) + self.tipView.hd_height * 0.026, self.tipView.hd_width * 0.914, self.tipView.hd_height * 0.123)];
    self.startTextView.numberLB.text = @"2";
    self.startTextView.titleLB.text = @"选择起始课文";
    self.startTextView.contentTF.placeholder = @"点击此处选择起始课文";
    
    self.endTextView = [[SelectTextBookView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.043, CGRectGetMaxY(self.startTextView.frame) + self.tipView.hd_height * 0.026, self.tipView.hd_width * 0.914, self.tipView.hd_height * 0.123)];
    self.endTextView.numberLB.text = @"3";
    self.endTextView.titleLB.text = @"选择截止课文";
    self.endTextView.contentTF.placeholder = @"点击此处选择截止课文";
    
    [self.tipView addSubview:self.textBookView];
    [self.tipView addSubview:self.startTextView];
    [self.tipView addSubview:self.endTextView];
    
    __weak typeof(self)weakSelf = self;
    self.textBookView.selectBlock = ^{
        if (weakSelf.textBookBlock) {
            weakSelf.textBookBlock();
        }
    };
    self.startTextView.selectBlock = ^{
        if (weakSelf.starttextBlock) {
            weakSelf.starttextBlock();
        }
    };
    self.endTextView.selectBlock = ^{
        if (weakSelf.endTextBlock) {
            weakSelf.endTextBlock();
        }
    };
    
    UILabel * readTextCountLB= [[UILabel alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.044, CGRectGetMaxY(self.endTextView.frame) + self.tipView.hd_height * 0.036, self.tipView.hd_width * 0.348 + 10, self.tipView.hd_height *0.039)];
    readTextCountLB.text = @"每天阅读课文数：";
    readTextCountLB.textColor = UIColorFromRGB(0x555555);
    [self.tipView addSubview:readTextCountLB];
    
    self.readTextCount = [[UITextField alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.044, CGRectGetMaxY(readTextCountLB.frame) + self.tipView.hd_height * 0.036, self.tipView.hd_width * 0.348, self.tipView.hd_height *0.1)];
    self.readTextCount.textAlignment = NSTextAlignmentCenter;
    self.readTextCount.textColor = UIColorFromRGB(0xFF6C33);
    self.readTextCount.layer.cornerRadius = 5;
    self.readTextCount.layer.masksToBounds = YES;
    self.readTextCount.layer.borderColor = UIColorFromRGB(0xd3d3d3).CGColor;
    self.readTextCount.layer.borderWidth = 1;
    self.readTextCount.text = @"1";
    [self.tipView addSubview:self.readTextCount];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.337, self.readTextCount.hd_y + self.readTextCount.hd_height * 0.35, self.readTextCount.hd_width * 0.058, self.readTextCount.hd_height * 0.3)];
    goImageView.image = [UIImage imageNamed:@"arrow_icon_phone"];
    [self.tipView addSubview:goImageView];
    
    UIButton * readTextCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readTextCountBtn.frame = self.readTextCount.frame;
    [self.tipView addSubview:readTextCountBtn];
    
    
    CGFloat width = [@"重复天数：" boundingRectWithSize:CGSizeMake(MAXFLOAT, self.tipView.hd_height *0.039) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
    UILabel * repeatCountLB= [[UILabel alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.62, CGRectGetMaxY(self.endTextView.frame) + self.tipView.hd_height * 0.036, width, self.tipView.hd_height *0.039)];
    repeatCountLB.text = @"重复天数：";
    repeatCountLB.textColor = UIColorFromRGB(0x555555);
    [self.tipView addSubview:repeatCountLB];
    // icon_material_help
    UIButton * repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    repeatBtn.frame = CGRectMake(CGRectGetMaxX(repeatCountLB.frame) + 5, repeatCountLB.hd_y - 3, repeatCountLB.hd_height + 6, repeatCountLB.hd_height + 6);
    [repeatBtn setImage:[UIImage imageNamed:@"icon_material_help"] forState:UIControlStateNormal];
    [self.tipView addSubview:repeatBtn];
    [repeatBtn addTarget:self action:@selector(repeatAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.repeatCount = [[UITextField alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.611, CGRectGetMaxY(readTextCountLB.frame) + self.tipView.hd_height * 0.036, self.tipView.hd_width * 0.348, self.tipView.hd_height *0.1)];
    self.repeatCount.textAlignment = NSTextAlignmentCenter;
    self.repeatCount.textColor = UIColorFromRGB(0xFF6C33);
    self.repeatCount.layer.cornerRadius = 5;
    self.repeatCount.layer.masksToBounds = YES;
    self.repeatCount.layer.borderColor = UIColorFromRGB(0xd3d3d3).CGColor;
    self.repeatCount.layer.borderWidth = 1;
    self.repeatCount.text = @"1";
    [self.tipView addSubview:self.repeatCount];
    
    UIImageView * repeatgoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipView.hd_width * 0.904, self.readTextCount.hd_y + self.readTextCount.hd_height * 0.35, self.readTextCount.hd_width * 0.058, self.repeatCount.hd_height * 0.3)];
    repeatgoImageView.image = [UIImage imageNamed:@"arrow_icon_phone"];
    [self.tipView addSubview:repeatgoImageView];
    
    UIButton * repeatCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    repeatCountBtn.frame = self.repeatCount.frame;
    [self.tipView addSubview:repeatCountBtn];

    
    [readTextCountBtn addTarget:self action:@selector(readTextCountAction) forControlEvents:UIControlEventTouchUpInside];
    [repeatCountBtn addTarget:self action:@selector(repeatountAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cintinueAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)readTextCountAction
{
    if (self.readTextCountBlock) {
        self.readTextCountBlock(@"read");
    }
}

- (void)repeatountAction
{
    if (self.repeatCountBlock) {
        self.repeatCountBlock(@"repeat");
    }
}


- (void)repeatAction
{
    if (self.repeatBlock) {
        self.repeatBlock();
    }
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)cintinueAction
{
    if (self.continueBlock) {
        self.continueBlock(@{});
    }
}

- (void)tapAction
{
    [self.repeatCount resignFirstResponder];
    [self.readTextCount resignFirstResponder];
}

- (void)resetTextBookWith:(NSString *)title
{
    self.textBookView.contentTF.text = title;
}

- (void)resetStartBookWith:(NSString *)title
{
    self.startTextView.contentTF.text = title;
}

- (void)resetEndBookWith:(NSString *)title
{
    self.endTextView.contentTF.text = title;
}

@end
