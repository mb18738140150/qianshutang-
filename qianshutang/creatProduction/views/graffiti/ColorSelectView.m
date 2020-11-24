//
//  ColorSelectView.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ColorSelectView.h"
#import "ColorSelectAssistView.h"
#import "SlideBlockView.h"

@interface ColorSelectView()

@property (nonatomic, strong)ColorSelectAssistView *assistView;
@property (nonatomic, strong)SlideBlockView * sliderView;
@property (nonatomic, assign)CGPoint startPoint;

@end

@implementation ColorSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    
    __weak typeof(self)weakSelf = self;
    self.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.colorView = [[UIView alloc]initWithFrame:CGRectMake( self.hd_width / 4, 5, self.hd_width / 2, 15)];
    self.colorView.layer.cornerRadius = 2;
    self.colorView.layer.masksToBounds = YES;
    self.colorView.backgroundColor = [UIColor redColor];
    [self addSubview:self.colorView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(self.hd_width - 20, 5, 15, 15);
    [self.closeBtn setImage:[UIImage imageNamed:@"skyblue_editpage_close"] forState:UIControlStateNormal];
    [self addSubview:self.closeBtn];
    [self.closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.colorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.colorView.frame) + 20, self.hd_width - 30, self.hd_width - 30)];
    self.colorImageView.image = [UIImage imageNamed:@"colorboard"];
    self.colorImageView.layer.cornerRadius = self.colorImageView.hd_width / 2;
    self.colorImageView.layer.masksToBounds = YES;
    self.colorImageView.clipsToBounds = YES;
    self.colorImageView.userInteractionEnabled = YES;
    [self addSubview:self.colorImageView];
    
    self.sliderView = [[SlideBlockView alloc]initWithFrame:CGRectMake(0, 0, self.colorImageView.hd_width / 5, self.colorImageView.hd_width / 5)];
    self.sliderView.boundRect = self.colorImageView.bounds;
    self.sliderView.hd_centerX = self.colorImageView.hd_width / 2;
    self.sliderView.hd_centerY = self.colorImageView.hd_width / 2;
    self.sliderView.backImageView.image = [UIImage imageNamed:@"colorboard_selected"];
    [self.colorImageView addSubview:self.sliderView];
    [self.sliderView moveSlideBlock:^(CGPoint point) {
        
        // 获取滑块触摸点相对于色盘的位置
        CGPoint imagePoint = [weakSelf.sliderView convertPoint:point toView:weakSelf.colorImageView];
        if (CGRectContainsPoint(self.colorImageView.bounds, imagePoint)) {
            [weakSelf setMovingRange:imagePoint];
        }else
        {
            return ;
        }
        
    }];
    
    
    CGFloat assistViewHeight = self.hd_height - CGRectGetMaxY(self.colorImageView.frame) - 30;
    CGFloat assistViewWidth = (self.hd_height - CGRectGetMaxY(self.colorImageView.frame) - 30) * 3;
    self.assistView = [[ColorSelectAssistView alloc]initWithFrame:CGRectMake(self.hd_width / 2 - assistViewWidth / 2, CGRectGetMaxY(self.colorImageView.frame) + 18, assistViewWidth, assistViewHeight)];
    self.assistView.ColorSelectAssistBlock = ^(UIColor *selectColor) {
        weakSelf.selectColor = selectColor;
        weakSelf.colorView.backgroundColor = selectColor;
        if (weakSelf.ColorSelectBlock) {
            weakSelf.ColorSelectBlock(weakSelf.selectColor);
        }
    };
    [self addSubview:self.assistView];
}

#pragma mark - 点击 拖动 选择颜色
- (void)setMovingRange:(CGPoint)point
{
    // 设置移动边界
    CGFloat centerX = self.colorImageView.hd_width / 2;
    
    if (point.x < centerX / 5) {
        point.x = centerX / 5;
    }
    if (point.x > centerX + centerX * 0.8) {
        point.x = centerX + centerX * 0.8;
    }
    if (point.y < centerX / 5) {
        point.y = centerX / 5;
    }
    if (point.y > centerX + centerX * 0.8) {
        point.y = centerX + centerX * 0.8;
    }
    
    CGFloat  width = fabsf(centerX - point.x);
    CGFloat  height = fabsf(centerX - point.y);
    
    // 判断直角三角形斜边长
    if (hypot(width, height) > centerX * 0.8) {
        if (width > height) {
            width = sqrt(fabsf(pow(centerX * 0.8, 2) - pow(height, 2)));
            
            if (point.x > centerX) {
                point.x = centerX + width;
            }else
            {
                point.x = centerX - width;
            }
        }else
        {
            height = sqrt(fabsf(pow(centerX * 0.8, 2) - pow(width, 2)));
            if (point.y > centerX) {
                point.y = centerX + height;
            }else
            {
                point.y = centerX - height;
            }
        }
    }
    NSLog(@"sliderPoint %.2f *** %.2f", point.x, point.y);
    self.sliderView.center = point;
    
    
    // 获取当前点的颜色值
    UIColor *selectColor = [self.colorImageView getCurrentPointColor:point andRect:self.colorImageView.bounds];
    self.selectColor = selectColor;
    self.colorView.backgroundColor = selectColor;
    if (self.ColorSelectBlock) {
        self.ColorSelectBlock(self.selectColor);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint beginPoint = [[touches anyObject] locationInView:self];
    self.startPoint = beginPoint;
    if (CGRectContainsPoint(self.colorImageView.frame, beginPoint)) {
        CGPoint imagePoint = [self convertPoint:beginPoint toView:self.colorImageView];
        [self setMovingRange:imagePoint];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    
    
    if (CGRectContainsPoint(self.colorImageView.frame, self.startPoint) && CGRectContainsPoint(self.colorImageView.frame, currentPoint)) {
        CGPoint imagePoint = [self convertPoint:currentPoint toView:self.colorImageView];
         [self setMovingRange:imagePoint];
    }else if(!CGRectContainsPoint(self.colorImageView.frame, self.startPoint))
    {
        CGPoint offSetPoint = CGPointMake(currentPoint.x - _startPoint.x, currentPoint.y - _startPoint.y);
        if (self.moveBlock) {
            self.moveBlock(offSetPoint);
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.colorImageView.frame, currentPoint) && CGRectContainsPoint(self.colorImageView.frame, self.startPoint)) {
        CGPoint imagePoint = [self convertPoint:currentPoint toView:self.colorImageView];
         [self setMovingRange:imagePoint];
    }else if(!CGRectContainsPoint(self.colorImageView.frame, self.startPoint))
    {
        CGPoint offSetPoint = CGPointMake(currentPoint.x - _startPoint.x, currentPoint.y - _startPoint.y);
        if (self.moveBlock) {
            self.moveBlock(offSetPoint);
        }
    }
}

#pragma 出现动画
- (void)showWithView:(UIView *)superView
{
    [superView addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss
{
    
    self.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)moveSlideBlock:(MoveColorSelectViewBlock)block
{
    self.moveBlock = [block copy];
}


@end
