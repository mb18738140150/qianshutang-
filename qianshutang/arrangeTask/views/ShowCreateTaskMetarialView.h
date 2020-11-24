//
//  ShowCreateTaskMetarialView.h
//  qianshutang
//
//  Created by aaa on 2018/11/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCreateTaskMetarialView : UIView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray;

- (void)resetCurrentIndex:(NSInteger)index;

@end
