//
//  RegisterViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountInputView.h"

@interface RegisterViewController ()<UserModule_RegistProtocol,UserModule_VerifyCodeProtocol>

@property (nonatomic, strong)UIButton * iconImageView;

@property (nonatomic, strong)AccountInputView * accountView;
@property (nonatomic, strong)AccountInputView * verifyCodeView;
@property (nonatomic, strong)AccountInputView * passwordView;
@property (nonatomic, strong)UIButton * complateBtn;


@property (nonatomic, strong)NSString * codeStr;

@property (nonatomic, strong)NSTimer * timer;
@property (nonatomic, assign)int time;
@end

@implementation RegisterViewController

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
    titleLB.text = @"注册";
    [self.view addSubview:titleLB];
    
    self.accountView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, kScreenHeight * 0.27, 390, 49)];
    self.accountView.contentTF.placeholder = @"请输入账号";
    self.accountView.iconImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, CGRectGetMaxY(self.accountView.frame)  + 12, 390, 49)];
    self.verifyCodeView.contentTF.placeholder = @"请输入验证码";
    self.verifyCodeView.iconImageView.image = [UIImage imageNamed:@"verification_code"];
    [self.view addSubview:self.verifyCodeView];
    self.verifyCodeView.getVreifyCodeBtn.hidden = NO;
    self.verifyCodeView.seperateView.hidden = NO;
    __weak typeof(self)weakSelf = self;
    self.verifyCodeView.GetVerifyCodeBlock = ^{
        NSLog(@"获取验证码");
        [weakSelf stastCountDown];
    };
    
    self.passwordView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, CGRectGetMaxY(self.verifyCodeView.frame)  + 12, 390, 49)];
    self.passwordView.contentTF.placeholder = @"请输入密码";
    self.passwordView.iconImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.passwordView];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.passwordView.hd_x, CGRectGetMaxY(self.passwordView.frame) + 20, 390, 49);
    self.complateBtn.backgroundColor = UIRGBColor(80, 164, 130);
    [self.complateBtn setTitle:@"注册" forState:UIControlStateNormal];
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
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)stastCountDown
{
    if (self.accountView.contentTF.text.length == 0 ) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [[UserManager sharedManager] getVerifyCodeWithPhoneNumber:self.accountView.contentTF.text withNotifiedObject:self];
    
    self.verifyCodeView.getVreifyCodeBtn.enabled = NO;
    self.time = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}

- (void)countDownAction
{
    if (self.time >= 0) {
        [self.verifyCodeView.getVreifyCodeBtn setTitle:[NSString stringWithFormat:@"(%d)", self.time--] forState:UIControlStateNormal];
    }else
    {
        [self.timer invalidate];
        self.timer = nil;
        [self.verifyCodeView.getVreifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)tapAction
{
    [self.accountView.contentTF resignFirstResponder];
    [self.verifyCodeView.contentTF resignFirstResponder];
    [self.passwordView.contentTF resignFirstResponder];
}

- (void)complateAction
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.passwordView.contentTF.text.length == 0 || self.verifyCodeView.contentTF.text.length == 0 || self.accountView.contentTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"账号、验证码、密码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (![[[UserManager sharedManager] getVerifyCode] isEqualToString:self.verifyCodeView.contentTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"验证码不正确，请重新输入"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [[UserManager sharedManager] registWithDic:@{@"phone":self.accountView.contentTF.text,@"password":self.passwordView.contentTF.text} withNotifiedObject:self];
    
}

- (void)didRegistFailed:(NSString *)failInfo
{
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRegistSuccessed
{
    [self backAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didVerifyCodeSuccessed
{
    
}

- (void)didVerifyCodeFailed:(NSString *)failInfo
{
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
