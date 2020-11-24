//
//  ColorSelectAssistView.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ColorSelectAssistView.h"

@implementation ColorSelectAssistView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    CGFloat btnWidth = (self.hd_width - 7) / 6;
    CGFloat btnHeight = (self.hd_height - 3) / 2;
    
    self.backgroundColor = UIRGBColor(202, 202, 202);
    
    for (int i = 0; i < 12; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = 1;
        int scale = i;
        if (i > 5) {
            y = btnHeight + 2;
            scale = i - 6;
        }
        
        button.frame = CGRectMake(1 + (btnWidth + 1) * scale, y, btnWidth, btnHeight);
        button.tag = i + 1000;
        CGFloat colorValue = 255 - (button.tag - 1000) * 21.25;
        UIColor * selectColor = UIRGBColor(colorValue, colorValue, colorValue);
        button.backgroundColor = selectColor;
        [self addSubview:button];
        [button addTarget:self action:@selector(colorSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)colorSelectAction:(UIButton *)button
{
    CGFloat colorValue = 255 - (button.tag - 1000) * 21.25;
    UIColor * selectColor = UIRGBColor(colorValue, colorValue, colorValue);
    if (self.ColorSelectAssistBlock) {
        self.ColorSelectAssistBlock(selectColor);
    }
}

@end
