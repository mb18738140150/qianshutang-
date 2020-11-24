//
//  BindPhoneNumberViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BindPhoneNumberViewController.h"

@interface BindPhoneNumberViewController ()<UserModule_VerifyCodeProtocol, UserInfo_BindPhoneNumber>

@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)AccountInputView * accountView;
@property (nonatomic, strong)AccountInputView * verifyCodeView;
@property (nonatomic, strong)UIButton * complateBtn;

@property (nonatomic, strong)NSString * verifyCode;

@property (nonatomic, strong)NSTimer * timer;
@property (nonatomic, assign)int time;

@end

@implementation BindPhoneNumberViewController

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
    titleLB.text = @"绑定手机号";
    [self.view addSubview:titleLB];
    
    self.accountView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY - 55, 390, 49)];
    self.accountView.contentTF.placeholder = @"请输入手机号";
    self.accountView.iconImageView.image = [UIImage imageNamed:@"tel"];
    [self.view addSubview:self.accountView];
    
    self.verifyCodeView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY + 5, 390, 49)];
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
    
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.verifyCodeView.hd_x, CGRectGetMaxY(self.verifyCodeView.frame) + 20, 390, 49);
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
    self.time--;
    if (self.time >= 0) {
        [self.verifyCodeView.getVreifyCodeBtn setTitle:[NSString stringWithFormat:@"(%d)", self.time] forState:UIControlStateNormal];
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
}


- (void)complateAction
{
    
    if (self.verifyCodeView.contentTF.text.length == 0 || self.accountView.contentTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"账号与验证码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
    [infoDic setObject:self.accountView.contentTF.text forKey:@"phone"];
    [infoDic setObject:self.verifyCodeView.contentTF.text forKey:@"code"];
    [infoDic setObject:self.verifyCode forKey:@"md5Code"];
    
    [[UserManager sharedManager] getBindPhoneNumber:infoDic withNotifiedObject:self];
}

- (void)didVerifyCodeSuccessed
{
    self.verifyCode = [[UserManager sharedManager] getVerifyCode];
}

- (void)didVerifyCodeFailed:(NSString *)failInfo
{
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestBindPhoneNumberSuccessed
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (self.BindPhoneNumberBlock) {
            self.BindPhoneNumberBlock(self.accountView.contentTF.text);
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)didRequestBindPhoneNumberFailed:(NSString *)failedInfo
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
