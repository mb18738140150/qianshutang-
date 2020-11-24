//
//  TeacherPrizeDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherPrizeDetailViewController.h"

@interface TeacherPrizeDetailViewController ()

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * totalIntegralLB;
@property (nonatomic, strong)UILabel * needIntegral;
@property (nonatomic, strong)UILabel * storeCountLB;

@property (nonatomic, strong)UILabel * prizeNameLB;
@property (nonatomic, strong)UITextView * prizeDetailTV;
@property (nonatomic, strong)UIButton * convertBtn;

@end

@implementation TeacherPrizeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"奖品详情";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    [self addSubViews];
    
}

- (void)addSubViews
{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, 2)];
    topView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:topView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.008, kScreenHeight * 0.25, kScreenWidth * 0.49, kScreenHeight * 0.5)];
    self.iconImageView.backgroundColor = UIColorFromRGB(0xF4F5F9);
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"imageUrl"]]] placeholderImage:[UIImage imageNamed:@"recording_cover"]];
    [self.view addSubview:self.iconImageView];
    
    /*
     UILabel * totalLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.055, 80, kScreenHeight * 0.038)];
     totalLB.text = @"可兑积分:";
     totalLB.textColor = UIColorFromRGB(0x222222);
     totalLB.font = [UIFont systemFontOfSize:18];
     [self.view addSubview:totalLB];
     
     UIImageView * integralImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalLB.frame) + kScreenHeight * 0.053, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.044, kScreenHeight * 0.05, kScreenHeight * 0.05)];
     integralImageView.image = [UIImage imageNamed:@"integral"];
     [self.view addSubview:integralImageView];
     
     self.totalIntegralLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(integralImageView.frame), integralImageView.hd_y, 100, integralImageView.hd_height)];
     self.totalIntegralLB.text = @"100";
     self.totalIntegralLB.textColor = UIColorFromRGB(0xFD8753);
     [self.view addSubview:self.totalIntegralLB];
     
     */
    
    
    UILabel * needIntegralLB = [[UILabel alloc]initWithFrame:CGRectMake(10,  CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.055, 80, kScreenHeight * 0.038)];
    needIntegralLB.text = @"所需积分:";//prizeIntegral
    needIntegralLB.textColor = UIColorFromRGB(0x222222);
    needIntegralLB.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:needIntegralLB];
    
    self.needIntegral = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(needIntegralLB.frame) + kScreenHeight * 0.053, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.044, kScreenWidth * 0.076, kScreenHeight * 0.061)];
    self.needIntegral.layer.cornerRadius = 2;
    self.needIntegral.layer.masksToBounds = YES;
    self.needIntegral.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.needIntegral.layer.borderWidth = 1;
    self.needIntegral.backgroundColor = [UIColor whiteColor];
    self.needIntegral.textColor = UIColorFromRGB(0xFD8753);
    self.needIntegral.textAlignment = NSTextAlignmentCenter;
    self.needIntegral.text = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"prizeIntegral"]];
    [self.view addSubview:self.needIntegral];
    
    UILabel * needIntegralTipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needIntegral.frame) + 5, needIntegralLB.hd_y, 200, needIntegralLB.hd_height)];
    needIntegralTipLB.textColor = UIColorFromRGB(0x222222);
    needIntegralTipLB.font = kMainFont;
    needIntegralTipLB.text = @"(参考值50-100)";
    [self.view addSubview:needIntegralTipLB];
    
    /*
     CGRectMake(totalLB.hd_x, CGRectGetMaxY(totalLB.frame) + kScreenHeight * 0.038, totalLB.hd_width, totalLB.hd_height)
     CGRectMake(integralImageView.hd_x, CGRectGetMaxY(integralImageView.frame) + kScreenHeight * 0.018, kScreenWidth * 0.076, kScreenHeight * 0.061)
     
     */
    
    UILabel * storeCountLB = [[UILabel alloc]initWithFrame:CGRectMake(10,  CGRectGetMaxY(needIntegralLB.frame) + kScreenHeight * 0.038, 80, kScreenHeight * 0.038)];
    storeCountLB.text = @"库存数量:";//remainNum
    storeCountLB.textColor = UIColorFromRGB(0x222222);
    storeCountLB.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:storeCountLB];
    
    self.storeCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(storeCountLB.frame) + kScreenHeight * 0.053, CGRectGetMaxY(self.needIntegral.frame) + kScreenHeight * 0.018, kScreenWidth * 0.076, kScreenHeight * 0.061)];
    self.storeCountLB.layer.cornerRadius = 2;
    self.storeCountLB.layer.masksToBounds = YES;
    self.storeCountLB.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.storeCountLB.layer.borderWidth = 1;
    self.storeCountLB.backgroundColor = [UIColor whiteColor];
    self.storeCountLB.textColor = UIColorFromRGB(0xFD8753);
    self.storeCountLB.textAlignment = NSTextAlignmentCenter;
    self.storeCountLB.text = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"remainNum"]];
    [self.view addSubview:self.storeCountLB];
    
    UILabel * storeCountTipLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.needIntegral.frame) + 5, storeCountLB.hd_y, 200, needIntegralLB.hd_height)];
    storeCountTipLB.textColor = UIColorFromRGB(0x222222);
    storeCountTipLB.font = kMainFont;
    NSDictionary * storeAttribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
    NSMutableAttributedString * storeMStr = [[NSMutableAttributedString alloc]initWithString:@"(数值-1为库存无限制)"];
    [storeMStr setAttributes:storeAttribute range:NSMakeRange(3, 2)];
    storeCountTipLB.attributedText = storeMStr;
    [self.view addSubview:storeCountTipLB];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(needIntegralLB.hd_x, CGRectGetMaxY(storeCountLB.frame) + kScreenHeight * 0.02, 400, storeCountLB.hd_height)];
    tipLB.font = kMainFont;
    tipLB.textColor = UIColorFromRGB(0x222222);
    NSDictionary * tipAttribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
    NSMutableAttributedString * tipMStr = [[NSMutableAttributedString alloc]initWithString:@"(注:学员通过星星、红花每天最多可获得13积分)"];
    [tipMStr addAttributes:tipAttribute range:NSMakeRange(1, 2)];
    [tipMStr addAttributes:tipAttribute range:NSMakeRange(19, 2)];
    tipLB.attributedText = tipMStr;
    [self.view addSubview:tipLB];
    
    
    UILabel * prizeNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + kScreenWidth * 0.02, self.navigationView.hd_height + kScreenHeight * 0.061, 120, kScreenHeight * 0.039)];
    prizeNameLB.text = @"奖品名称:";
    prizeNameLB.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:prizeNameLB];
    
    self.prizeNameLB = [[UILabel alloc]initWithFrame:CGRectMake(prizeNameLB.hd_x, CGRectGetMaxY(prizeNameLB.frame) + kScreenHeight * 0.018, kScreenWidth * 0.458, kScreenHeight * 0.076)];
    self.prizeNameLB.layer.cornerRadius = 2;
    self.prizeNameLB.layer.masksToBounds = YES;
    self.prizeNameLB.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.prizeNameLB.layer.borderWidth = 1;
    self.prizeNameLB.backgroundColor = [UIColor whiteColor];
    self.prizeNameLB.textColor = UIColorFromRGB(0x555555);
    self.prizeNameLB.text = [self.infoDic objectForKey:kPrizeName];
    [self.view addSubview:self.prizeNameLB];
    
    UILabel * prizeDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + kScreenWidth * 0.02, CGRectGetMaxY(self.prizeNameLB.frame) + kScreenHeight * 0.018, 120, kScreenHeight * 0.039)];
    prizeDetailLB.text = @"奖品简介:";
    prizeDetailLB.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:prizeDetailLB];
    
    self.prizeDetailTV = [[UITextView alloc]initWithFrame:CGRectMake(prizeDetailLB.hd_x, CGRectGetMaxY(prizeDetailLB.frame) + kScreenHeight * 0.018, kScreenWidth * 0.458, kScreenHeight * 0.337)];
    self.prizeDetailTV.layer.cornerRadius = 2;
    self.prizeDetailTV.layer.masksToBounds = YES;
    self.prizeDetailTV.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.prizeDetailTV.layer.borderWidth = 1;
    self.prizeDetailTV.backgroundColor = [UIColor whiteColor];
    self.prizeDetailTV.textColor = UIColorFromRGB(0x555555);
    self.prizeDetailTV.text = [self.infoDic objectForKey:kPrizeIntro];
    self.prizeDetailTV.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.prizeDetailTV];
    
    self.convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.convertBtn.frame = CGRectMake(kScreenWidth * 0.82, kScreenHeight * 0.878, kScreenWidth * 0.154, kScreenHeight * 0.094);
    self.convertBtn.layer.cornerRadius = 5;
    self.convertBtn.layer.masksToBounds = YES;
    self.convertBtn.backgroundColor = kMainColor;
    [self.convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.convertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:self.convertBtn];
    
}

@end
