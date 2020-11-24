//
//  SelectTextBookView.h
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTextBookView : UIView

@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UITextField * contentTF;
@property (nonatomic, strong)UIButton * operationBtn;

- (void)hideNumberLB;

@property (nonatomic, copy)void(^selectBlock)();

@end
