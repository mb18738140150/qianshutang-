//
//  GraffitiBackgroundColorSelectView.h
//  qianshutang
//
//  Created by aaa on 2018/7/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraffitiBackgroundColorSelectView : UIView

@property (nonatomic, strong)void(^GraffitiBackColorSelectBlock)(UIColor *color);

- (instancetype)initWithFrame:(CGRect)frame andDirectionPoint:(CGPoint)point;

- (void)showWithView:(UIView *)superView;
- (void)dismiss;

@end
