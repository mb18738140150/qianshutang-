//
//  SlideBlockView.m
//  tiku
//
//  Created by aaa on 2017/5/3.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "SlideBlockView.h"
#import "UIView+HDExtension.h"
#import "UIMacro.h"

@implementation SlideBlockView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.backImageView.image = [UIImage imageNamed:@"mo"];
    
    [self addSubview:self.backImageView];
    self.backImageView.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.beginPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    
    if (self.moveBlock) {
        self.moveBlock(currentPoint);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    
    if (self.moveBlock) {
        self.moveBlock(currentPoint);
    }
    
}

- (void)moveSlideBlock:(MoveConversationViewBlock)block
{
    self.moveBlock = [block copy];
}

@end
