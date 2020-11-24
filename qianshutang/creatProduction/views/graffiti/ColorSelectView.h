//
//  ColorSelectView.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MoveColorSelectViewBlock)(CGPoint point);

@interface ColorSelectView : UIView

@property (nonatomic, strong)UIView * colorView;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UIImageView * colorImageView;
@property (nonatomic, copy)MoveColorSelectViewBlock moveBlock;
@property (nonatomic, strong)UIColor * selectColor;

@property (nonatomic, strong)void(^ColorSelectBlock)(UIColor *color);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)moveSlideBlock:(MoveColorSelectViewBlock)block;

- (void)showWithView:(UIView *)superView;
- (void)dismiss;

@end
