//
//  ShowBigImageView.h
//  qianshutang
//
//  Created by aaa on 2018/8/6.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowBigImageView : UIView

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, assign)int currentCount;

@property (nonatomic, copy)void (^dismissBlock)();

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSMutableArray *)array;
- (void)refreshUI:(CGRect)rect;

@end
