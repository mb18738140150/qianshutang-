//
//  AccountInputView.h
//  qianshutang
//
//  Created by aaa on 2018/7/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountInputView : UIView

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UITextField * contentTF;
@property (nonatomic, strong)UIButton * typeButton;

@property (nonatomic, strong)UIButton * getVreifyCodeBtn;
@property (nonatomic, strong)UIView * seperateView;

@property (nonatomic, copy)void (^GetVerifyCodeBlock)();

@end
