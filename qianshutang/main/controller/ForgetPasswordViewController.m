//
//  ForgetPasswordViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UserModule_ForgetPasswordProtocol>

@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)AccountInputView * nPSDViewCodeView;
@property (nonatomic, strong)AccountInputView * rePSDViewCodeView;
@property (nonatomic, strong)UIButton * complateBtn;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageView.frame = CGRectMake(10, 20, 40, 40);
    [self.iconImageView setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self.view addSubview:self.iconImageView];
    [self.iconImageView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 100, CGRectGetMaxY(self.iconImageView.frame), 200, 30)];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.textColor = UIColorFromRGB(0x2c2c2c);
    titleLB.font = [UIFont systemFontOfSize:27];
    titleLB.text = @"忘记密码";
    [self.view addSubview:titleLB];
    
    self.nPSDViewCodeView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY - 55, 390, 49)];
    self.nPSDViewCodeView.contentTF.placeholder = @"请输入密码";
    self.nPSDViewCodeView.iconImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.nPSDViewCodeView];
    
    self.rePSDViewCodeView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY + 5, 390, 49)];
    self.rePSDViewCodeView.contentTF.placeholder = @"请再次输入密码";
    self.rePSDViewCodeView.iconImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.rePSDViewCodeView];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.rePSDViewCodeView.hd_x, CGRectGetMaxY(self.rePSDViewCodeView.frame) + 20, 390, 49);
    self.complateBtn.backgroundColor = UIRGBColor(80, 164, 130);
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}


- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)tapAction
{
    [self.rePSDViewCodeView.contentTF resignFirstResponder];
    [self.nPSDViewCodeView.contentTF resignFirstResponder];
}

- (void)complateAction
{
    if (self.nPSDViewCodeView.contentTF.text.length == 0 || self.rePSDViewCodeView.contentTF.text.length == 0 ) {
        
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return ;
    }
    
    if ([self.nPSDViewCodeView.contentTF.text isEqualToString: self.rePSDViewCodeView.contentTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次新密码输入不一致"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [[UserManager sharedManager] forgetPsdWithDic:@{} withNotifiedObject:self];
}

- (void)didForgetPasswordSuccessed
{
    [[NSUserDefaults standardUserDefaults] setObject:self.nPSDViewCodeView.contentTF.text forKey:kPassword];
    if (self.ResetPsdSuccessBlock) {
        self.ResetPsdSuccessBlock(YES);
    }
}

- (void)didForgetPasswordFailed:(NSString *)failInfo
{
    [SVProgressHUD showErrorWithStatus:failInfo];
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
