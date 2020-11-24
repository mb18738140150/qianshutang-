//
//  CreatePrizeSelectView.h
//  qianshutang
//
//  Created by aaa on 2018/10/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePrizeSelectView : UIView

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UITextField * contentTF;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UIButton * operationBtn;

@property (nonatomic, copy)void(^selectBlock)();

@end
