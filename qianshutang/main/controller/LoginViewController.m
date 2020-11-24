//
//  LoginViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountInputView.h"
#import "VerifyCodeViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UserModule_LoginProtocol,UserModule_BindJPushProtocol>

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)AccountInputView * accountView;
@property (nonatomic, strong)AccountInputView * passwordView;
@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)UIButton * registBtn;
@property (nonatomic, strong)UIButton * forgrtPsdBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 20)];
    self.iconImageView.image = [UIImage imageNamed:@"class_logo"];
    [self.view addSubview:self.iconImageView];
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 100, CGRectGetMaxY(self.iconImageView.frame), 200, 30)];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.textColor = UIColorFromRGB(0x2c2c2c);
    titleLB.font = [UIFont systemFontOfSize:27];
    titleLB.text = @"用户登录";
    [self.view addSubview:titleLB];
    
    self.accountView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY - 55, 390, 49)];
    self.accountView.contentTF.placeholder = @"请输入账号";
    self.accountView.iconImageView.image = [UIImage imageNamed:@"account"];
    [self.view addSubview:self.accountView];
    
    self.passwordView = [[AccountInputView alloc]initWithFrame:CGRectMake(self.view.hd_width / 2 - 195, self.view.hd_centerY + 5, 390, 49)];
    self.passwordView.contentTF.placeholder = @"请输入密码";
    self.passwordView.iconImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.passwordView];
    self.passwordView.typeButton.hidden = NO;
    self.passwordView.contentTF.secureTextEntry = YES;
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.passwordView.hd_x, CGRectGetMaxY(self.passwordView.frame) + 20, 390, 49);
    self.complateBtn.backgroundColor = UIRGBColor(80, 164, 130);
    [self.complateBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn.frame = CGRectMake(self.passwordView.hd_x, CGRectGetMaxY(self.complateBtn.frame) + 20, 70, 15);
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString * registStr = [[NSMutableAttributedString alloc]initWithString:@"新用户注册"];
    [registStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [registStr length])];
    [registStr addAttribute:NSForegroundColorAttributeName value:UIRGBColor(80, 164, 130) range:NSMakeRange(0, [registStr length])];
    [self.registBtn setAttributedTitle:registStr forState:UIControlStateNormal];
    [self.registBtn setTitleColor:UIRGBColor(80, 164, 130) forState:UIControlStateNormal];
    
    self.forgrtPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgrtPsdBtn.frame = CGRectMake(CGRectGetMaxX(self.complateBtn.frame) - 55, CGRectGetMaxY(self.complateBtn.frame) + 20, 55, 15);
    self.forgrtPsdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString * forgetPsdStr = [[NSMutableAttributedString alloc]initWithString:@"忘记密码"];
    [forgetPsdStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [forgetPsdStr length])];
    [forgetPsdStr addAttribute:NSForegroundColorAttributeName value:UIRGBColor(80, 164, 130) range:NSMakeRange(0, [forgetPsdStr length])];
    [self.forgrtPsdBtn setAttributedTitle:forgetPsdStr forState:UIControlStateNormal];
    
    
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.forgrtPsdBtn];
    [self.registBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgrtPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction
{
    [self.accountView.contentTF resignFirstResponder];
    [self.passwordView.contentTF resignFirstResponder];
}

- (void)registAction
{
    NSLog(@"新用户注册");
    RegisterViewController * vc = [[RegisterViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)forgetPsdAction
{
    NSLog(@"忘记密码");
    VerifyCodeViewController * verifyVC = [[VerifyCodeViewController alloc]init];
    [self presentViewController:verifyVC animated:NO completion:nil];
}

- (void)complateAction
{
    NSLog(@"%@", self.accountView.contentTF.text);
    NSLog(@"%@", self.passwordView.contentTF.text);
    
    if (self.accountView.contentTF.text.length == 0 || self.passwordView.contentTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"账号密码均不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    
    [SVProgressHUD show];
    [[UserManager sharedManager]loginWithUserName:self.accountView.contentTF.text andPassword:self.passwordView.contentTF.text withNotifiedObject:self];
}

- (void)didUserLoginSuccessed
{
//    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
    
    [[NSUserDefaults standardUserDefaults] setObject:self.accountView.contentTF.text forKey:kAccount];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordView.contentTF.text forKey:kPassword];
    
    NSString * registrationID = [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
    if ([registrationID class] == [NSNull class] || registrationID == nil || [registrationID isEqualToString:@""]) {
    }else
    {
        [[UserManager sharedManager] didRequestBindJPushWithCID:registrationID withNotifiedObject:self];
    }
    
    [SVProgressHUD dismiss];
    if (self.loginSuccessBlock) {
        self.loginSuccessBlock(YES);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didUserLoginFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestBindJPushSuccessed
{
    
}

- (void)didRequestBindJPushFailed:(NSString *)failedInfo
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
