//
//  ColorSelectAssistView.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSelectAssistView : UIView

@property (nonatomic, copy)void(^ColorSelectAssistBlock)(UIColor * selectColor);
- (instancetype)initWithFrame:(CGRect)frame;

@end
