//
//  AddressView.m
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddressView.h"


@interface AddressView()<UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong)NSString * title;
@property (nonatomic, assign)BOOL animation;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UITextField * nameTF;
@property (nonatomic, strong)UITextField * phoneTF;
@property (nonatomic, strong)MKPPlaceholderTextView * addressTextView;


@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)NSDictionary * dataInfo;

@end

@implementation AddressView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    return self;
}

- (NSDictionary *)infoDic
{
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionary];
    }
    return _infoDic;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinAction)];
    [backView addGestureRecognizer:tap];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.82)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    CGFloat TipViewWidth = self.tipView.hd_width;
    CGFloat tipViewHeight = self.tipView.hd_height;
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, TipViewWidth * 0.11)];
    tipLB.text = @"我的收货地址";
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(TipViewWidth * 0.26, CGRectGetMaxY(tipLB.frame) + tipViewHeight * 0.054, TipViewWidth * 0.69, tipViewHeight * 0.115)];
    self.nameTF.placeholder = @"请输入收货人姓名";
    self.nameTF.textColor = UIColorFromRGB(0x505050);
    self.nameTF.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.nameTF.layer.cornerRadius = 2;
    self.nameTF.layer.masksToBounds = YES;
    [self.tipView addSubview:self.nameTF];
    
    UILabel * nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.nameTF.hd_y, TipViewWidth * 0.26 - 20, self.nameTF.hd_height)];
    nameLB.textColor = UIColorFromRGB(0x272727);
    nameLB.text = @"收货人:";
    nameLB.textAlignment = NSTextAlignmentRight;
    [self.tipView addSubview:nameLB];
    
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(TipViewWidth * 0.26, CGRectGetMaxY(self.nameTF.frame) + 10, TipViewWidth * 0.69, tipViewHeight * 0.115)];
    self.phoneTF.placeholder = @"请输入有效的联系电话";
    self.phoneTF.textColor = UIColorFromRGB(0x505050);
    self.phoneTF.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.phoneTF.layer.cornerRadius = 2;
    self.phoneTF.layer.masksToBounds = YES;
    [self.tipView addSubview:self.phoneTF];
    UILabel * phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.phoneTF.hd_y, TipViewWidth * 0.26 - 20, self.nameTF.hd_height)];
    phoneLB.textColor = UIColorFromRGB(0x272727);
    phoneLB.text = @"联系电话:";
    phoneLB.textAlignment = NSTextAlignmentRight;
    [self.tipView addSubview:phoneLB];
    
    
    MKPPlaceholderTextView * textView = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(TipViewWidth * 0.26, CGRectGetMaxY(self.phoneTF.frame) + 10, TipViewWidth * 0.69, tipViewHeight * 0.29)];
    textView.font = [UIFont systemFontOfSize: 17];
    textView.placeholder = @"请输入详细的收货地址,街道,楼牌号等";
    textView.delegate = self;
    textView.layer.cornerRadius = 3;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    textView.textColor = UIColorFromRGB(0x505050);
    self.addressTextView = textView;
    [self.tipView addSubview:self.addressTextView];
    
    UILabel * addressLB = [[UILabel alloc]initWithFrame:CGRectMake(0, self.addressTextView.hd_y, TipViewWidth * 0.26 - 20, self.nameTF.hd_height)];
    addressLB.textColor = UIColorFromRGB(0x272727);
    addressLB.text = @"收货地址:";
    addressLB.textAlignment = NSTextAlignmentRight;
    [self.tipView addSubview:addressLB];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_height / 5, tipViewHeight * 0.06 + CGRectGetMaxY(self.addressTextView.frame), self.tipView.hd_height * 0.32, TipViewWidth * 0.1);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_height / 5 - self.tipView.hd_height * 0.32, tipViewHeight * 0.06 + CGRectGetMaxY(self.addressTextView.frame), self.tipView.hd_height * 0.32, TipViewWidth * 0.1);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.nameTF isEqual:textField]) {
        [self.infoDic setValue:textField.text forKey:kreceiveName];
    }else
    {
        [self.infoDic setValue:textField.text forKey:kreceivePhoneNumber];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.infoDic setValue:textView.text forKey:kreceiveAddress];
}

- (void)sureAction
{
    if (self.dataInfo != nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无发货信息，暂无法发货" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return ;
    }
    
    if (self.nameTF.text.length == 0 || self.phoneTF.text.length == 0 || self.addressTextView.text.length == 0 ) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return ;
    }
    [self.infoDic setValue:self.nameTF.text forKey:kreceiveName];
    [self.infoDic setValue:self.phoneTF.text forKey:kreceivePhoneNumber];
    [self.infoDic setValue:self.addressTextView.text forKey:kreceiveAddress];
    NSLog(@"%@", self.infoDic);
    
    if (self.AddressSelectBlock) {
        self.AddressSelectBlock(self.infoDic);
    }
    [self removeFromSuperview];
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)resinAction
{
    [self.nameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.addressTextView resignFirstResponder];
}

- (void)refreshWithAddressInfo:(NSDictionary *)infoDic
{
    self.dataInfo = infoDic;
    self.nameTF.text = [infoDic objectForKey:kreceiveName];
    self.phoneTF.text = [infoDic objectForKey:kreceivePhoneNumber];
    self.addressTextView.text = [infoDic objectForKey:kreceiveAddress];
}

- (void)resignAllTf
{
    self.nameTF.enabled = NO;
    self.phoneTF.enabled = NO;
    self.addressTextView.editable = NO;
}

@end
