//
//  TextCommentView.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TextCommentView.h"

@interface TextCommentView()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UILabel * systemScoreLB;
@property (nonatomic, strong)UITextField * teacherScoreTF;
@property (nonatomic, assign)int teacherScore;

@property (nonatomic, strong)UIButton * commentModulBtn;
@property (nonatomic, strong)UIButton * storeToModulBtn;
@property (nonatomic, strong)MKPPlaceholderTextView * commentTv;
@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)NSMutableArray * btnArray;
@property (nonatomic, strong)NSArray * numberArray;

@end

@implementation TextCommentView

- (void)limitClick
{
    self.commentTv.editable = NO;
    self.commentModulBtn.enabled = NO;
    self.storeToModulBtn.enabled = NO;
    self.teacherScoreTF.enabled = NO;
    [self.sureBtn removeTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    for (UIButton * starBtn in self.btnArray) {
        [starBtn removeTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)tapAction{
    [self.teacherScoreTF resignFirstResponder];
    [self.commentTv resignFirstResponder];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
    [self.backView addGestureRecognizer:tap];
    //resinTv
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.722, kScreenHeight * 0.974)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.114)];
    tipLB.text = @"文字点评";
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    CGFloat backWidth = self.tipView.hd_width;
    CGFloat backHeight = self.tipView.hd_height;
    
    self.systemScoreLB = [[UILabel alloc]initWithFrame:CGRectMake(backWidth * 0.066, tipLB.hd_height + backHeight * 0.06, backWidth * 0.22, backHeight * 0.04)];
    self.systemScoreLB.text = @"系统评分:-分";
    self.systemScoreLB.textColor = UIColorFromRGB(0x505050);
    [self.tipView addSubview:self.systemScoreLB];
    
    UILabel * teacherScoreLB = [[UILabel alloc]initWithFrame:CGRectMake(backWidth * 0.645 - 100, self.systemScoreLB.hd_y, 100, self.systemScoreLB.hd_height)];
    teacherScoreLB.textColor = UIColorFromRGB(0x505050);
    teacherScoreLB.text = @"老师评分:";
    teacherScoreLB.textAlignment = NSTextAlignmentRight;
    [self.tipView addSubview:teacherScoreLB];
    
    self.teacherScoreTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teacherScoreLB.frame) + backWidth * 0.021, tipLB.hd_height + backHeight * 0.049, backWidth * 0.108, backHeight * 0.064)];
    self.teacherScoreTF.layer.cornerRadius = 2;
    self.teacherScoreTF.layer.masksToBounds = YES;
    self.teacherScoreTF.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.teacherScoreTF.layer.borderWidth = 1;
    self.teacherScoreTF.textAlignment = NSTextAlignmentCenter;
    self.teacherScoreTF.textColor = UIColorFromRGB(0x808080);
    self.teacherScoreTF.delegate = self;
    [self.tipView addSubview:self.teacherScoreTF];
    self.teacherScoreTF.text = @"-";
    
    UILabel * scoreLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.teacherScoreTF.frame) + backWidth * 0.021, teacherScoreLB.hd_y, 50, teacherScoreLB.hd_height)];
    scoreLB.textColor = UIColorFromRGB(0x505050);
    scoreLB.text = @"分";
    [self.tipView addSubview:scoreLB];
    
    for (int i = 0; i < 5; i++) {
        UIButton * starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBtn.frame = CGRectMake(backWidth * 0.08 + backWidth * 0.086 * i, CGRectGetMaxY(self.systemScoreLB.frame) + backHeight * 0.055, backHeight * 0.076, backHeight * 0.076);
        [starBtn setImage:[UIImage imageNamed:@"rank_n"] forState:UIControlStateNormal];
        [starBtn setImage:[UIImage imageNamed:@"rank_p"] forState:UIControlStateSelected];
        starBtn.selected = NO;
        starBtn.tag = 1000 + i;
        [self.btnArray addObject:starBtn];
        [self.tipView addSubview:starBtn];
        [starBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.commentModulBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentModulBtn.frame = CGRectMake(backWidth * 0.522, tipLB.hd_height + backHeight * 0.152, backWidth * 0.187, backHeight * 0.085);
    self.commentModulBtn.backgroundColor = kMainColor;
    self.commentModulBtn.layer.cornerRadius = self.commentModulBtn.hd_height / 2;
    self.commentModulBtn.layer.masksToBounds = YES;
    [self.commentModulBtn setTitle:@"评语模板" forState:UIControlStateNormal];
    [self.commentModulBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tipView addSubview:self.commentModulBtn];
    
    self.storeToModulBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeToModulBtn.frame = CGRectMake(backWidth * 0.034 + CGRectGetMaxX(self.commentModulBtn.frame), tipLB.hd_height + backHeight * 0.152, backWidth * 0.187, backHeight * 0.085);
    self.storeToModulBtn.backgroundColor = kMainColor;
    self.storeToModulBtn.layer.cornerRadius = self.commentModulBtn.hd_height / 2;
    self.storeToModulBtn.layer.masksToBounds = YES;
    [self.storeToModulBtn setTitle:@"存储为模板" forState:UIControlStateNormal];
    [self.storeToModulBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tipView addSubview:self.storeToModulBtn];
    
    [self.commentModulBtn addTarget:self action:@selector(comentModulAction) forControlEvents:UIControlEventTouchUpInside];
    [self.storeToModulBtn addTarget:self action:@selector(storeToModulAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(backWidth * 0.066, tipLB.hd_height + backHeight * 0.266, backWidth * 0.868, backHeight * 0.426)];
    self.commentTv.placeholder = @"暂无文字点评";
    self.commentTv.delegate = self;
    self.commentTv.layer.cornerRadius = 2;
    self.commentTv.layer.masksToBounds = YES;
    self.commentTv.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.commentTv.layer.borderWidth = 1;
    self.commentTv.textColor = UIColorFromRGB(0x333333);
    self.commentTv.font = [UIFont systemFontOfSize:17];
    [self.tipView addSubview:self.commentTv];
    
    if (self.commentTv.text.length == 0) {
        self.storeToModulBtn.enabled = NO;
        self.storeToModulBtn.backgroundColor = UIColorFromRGB(0xeeeeee);
    }
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.tipView.hd_width * 0.138, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.206, self.tipView.hd_height * 0.108);
    self.cancelBtn.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.138 - self.tipView.hd_width * 0.206, self.tipView.hd_height * 0.85, self.tipView.hd_width * 0.206, self.tipView.hd_height * 0.108);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureBtnAction ) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * tipViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tipViewtTapAction)];
    [self.tipView addGestureRecognizer:tipViewTap];
    
    // ❶❷❸❹❺❻❼❽❾❿
    // ➊➋➌➍➎➏➐➑➒➓
    
    // ❶❷❸❹❺❻❼❽❾
    self.numberArray = @[@"➊",@"➋",@"➌",@"➍",@"➎",@"➏",@"➐",@"➑",@"➒",@"➓",@"❶",@"❷",@"❸",@"❹",@"❺",@"❻",@"❼",@"❽",@"❾"];
    
}

- (void)resetUIWith:(NSDictionary *)infoDic
{
    [self resetCommentContent:[infoDic objectForKey:@"textReview"]];
    self.teacherScoreTF.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"reviewScore"]];
    if (self.teacherScoreTF.text.intValue == 0) {
        self.teacherScoreTF.text = @"-";
    }
    
    [self refreshStarBtnState];
}

#pragma mark - textFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"self.teacherScoreTF.text = %@ ****** string = %@", self.teacherScoreTF.text, string);
    if (string.intValue > 0) {
        if (self.teacherScoreTF.text.intValue > 0) {
            NSString * nString = [self.teacherScoreTF.text stringByAppendingString:string];
            if (nString.intValue <= 100) {
                return YES;
            }else
            {
                return NO;
            }
        }
    }
    
    for (NSString * numberString in self.numberArray) {
        if ([string isEqualToString:numberString]) {
            NSLog(@"string = %@ **** number = %@",string, numberString);
            return YES;
        }
    }
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (string.intValue == 0) {
        if ([string isEqualToString:@"0"]) {
            if (self.teacherScoreTF.text.intValue > 0) {
                NSString * nString = [self.teacherScoreTF.text stringByAppendingString:string];
                if (nString.intValue <= 100) {
                    return YES;
                }else
                {
                    return NO;
                }
            }
            return YES;
        }
        return NO;
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.teacherScoreTF.text isEqualToString:@"-"]) {
        self.teacherScoreTF.text = @"";
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.teacherScoreTF.text.intValue == 0) {
        self.teacherScoreTF.text = @"-";
    }
    [self refreshStarBtnState];
}


- (void)tipViewtTapAction
{
    [self.teacherScoreTF resignFirstResponder];
    [self.commentTv resignFirstResponder];
}

- (void)comentModulAction
{
    if (self.commentModulBlock) {
        self.commentModulBlock(@{});
    }
}

- (void)storeToModulAction
{
    if (self.storeCommentModulBlock) {
        self.storeCommentModulBlock(@{@"content":self.commentTv.text});
    }
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)sureBtnAction
{
    if ([self.teacherScoreTF.text isEqualToString:@"-"]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请给该作品评级"];
//        [SVProgressHUD showInfoWithStatus:@"请给该作品评级"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.commentTv.text.length <= 0) {
        self.commentTv.text = @"";
    }
    
    if (self.updataCommentBlock) {
        self.updataCommentBlock(@{@"comment":self.commentTv.text,@"score":@(self.teacherScoreTF.text.intValue)});
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.storeToModulBtn.enabled = NO;
        self.storeToModulBtn.backgroundColor = UIColorFromRGB(0xeeeeee);
    }else
    {
        self.storeToModulBtn.enabled = YES;
        self.storeToModulBtn.backgroundColor = kMainColor;
    }
}

- (void)starAction:(UIButton*)button
{
    for (UIButton * btn in self.btnArray) {
        btn.selected = NO;
    }
    for (int i = 0; i <= button.tag - 1000; i++) {
        UIButton * btn = [self.btnArray objectAtIndex:i];
        btn.selected = YES;
    }
    self.teacherScore = ((int)button.tag - 1000 + 1) * 20;
    self.teacherScoreTF.text = [NSString stringWithFormat:@"%d", self.teacherScore];
}

- (void)refreshStarBtnState
{
    int score = self.teacherScoreTF.text.intValue;
    int starNum = score / 20;
    if (score != 0 && score % 20 == 0) {
        starNum--;
    }
    
    if ([self.teacherScoreTF.text isEqualToString:@"-"]) {
        return;
    }
    
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton * btn = [self.btnArray objectAtIndex:i];
        btn.selected = NO;
    }
    for (int i = 0; i <= starNum; i++) {
        UIButton * btn = [self.btnArray objectAtIndex:i];
        btn.selected = YES;
    }
}

- (void)resetCommentContent:(NSString *)comment
{
    self.commentTv.text = comment;
    if (self.commentTv.text.length == 0) {
        self.storeToModulBtn.enabled = NO;
        self.storeToModulBtn.backgroundColor = UIColorFromRGB(0xeeeeee);
    }else
    {
        self.storeToModulBtn.enabled = YES;
        self.storeToModulBtn.backgroundColor = kMainColor;
    }
}

@end
