//
//  PrizeDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PrizeDetailViewController.h"

@interface PrizeDetailViewController ()<Integral_ConvertPrize>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * totalIntegralLB;
@property (nonatomic, strong)UILabel * needIntegral;
@property (nonatomic, strong)UILabel * prizeNameLB;
@property (nonatomic, strong)UITextView * prizeDetailTV;
@property (nonatomic, strong)UIButton * convertBtn;

@end

@implementation PrizeDetailViewController

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
    self.titleLB.text = @"兑换奖品";
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
    
    UILabel * totalLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.055, 80, kScreenHeight * 0.038)];
    totalLB.text = @"可兑积分:";
    totalLB.textColor = UIColorFromRGB(0x222222);
    totalLB.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:totalLB];
    
    UIImageView * integralImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalLB.frame) + kScreenHeight * 0.053, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.044, kScreenHeight * 0.05, kScreenHeight * 0.05)];
    integralImageView.image = [UIImage imageNamed:@"integral"];
    [self.view addSubview:integralImageView];
    
    self.totalIntegralLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(integralImageView.frame), integralImageView.hd_y, 200, integralImageView.hd_height)];
    self.totalIntegralLB.text = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"canUserIntegral"]];
    self.totalIntegralLB.textColor = UIColorFromRGB(0xFD8753);
    [self.view addSubview:self.totalIntegralLB];
    
    UILabel * needIntegralLB = [[UILabel alloc]initWithFrame:CGRectMake(totalLB.hd_x, CGRectGetMaxY(totalLB.frame) + kScreenHeight * 0.038, totalLB.hd_width, totalLB.hd_height)];
    needIntegralLB.text = @"所需积分:";
    needIntegralLB.textColor = UIColorFromRGB(0x222222);
    needIntegralLB.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:needIntegralLB];
    
    self.needIntegral = [[UILabel alloc]initWithFrame:CGRectMake(integralImageView.hd_x, CGRectGetMaxY(integralImageView.frame) + kScreenHeight * 0.018, kScreenWidth * 0.076, kScreenHeight * 0.061)];
    self.needIntegral.layer.cornerRadius = 2;
    self.needIntegral.layer.masksToBounds = YES;
    self.needIntegral.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.needIntegral.layer.borderWidth = 1;
    self.needIntegral.backgroundColor = [UIColor whiteColor];
    self.needIntegral.textColor = UIColorFromRGB(0xFD8753);
    self.needIntegral.textAlignment = NSTextAlignmentCenter;
    self.needIntegral.text = [NSString stringWithFormat:@"%@",[self.infoDic objectForKey:kPrizeIntegral]];
    [self.view addSubview:self.needIntegral];
    
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
    if (self.prizeDetailTV.text.length == 0) {
        self.prizeDetailTV.text = @"暂无描述";
    }
    self.prizeDetailTV.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.prizeDetailTV];
    
    self.convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.convertBtn.frame = CGRectMake(kScreenWidth * 0.82, kScreenHeight * 0.878, kScreenWidth * 0.154, kScreenHeight * 0.094);
    self.convertBtn.layer.cornerRadius = 5;
    self.convertBtn.layer.masksToBounds = YES;
    self.convertBtn.backgroundColor = kMainColor;
    [self.convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.convertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.convertBtn];
    [self.convertBtn addTarget:self action:@selector(convertPrize) forControlEvents:UIControlEventTouchUpInside];
}

- (void)convertPrize
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestConvertPrizeWith:@{kPrizeId:[self.infoDic objectForKey:kPrizeId]} withNotifiedObject:self];
}

- (void)didRequestConvertPrizeSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"兑换成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (self.convertBlock) {
            self.convertBlock(YES);
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)didRequestConvertPrizeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
