//
//  RecordAnimationView.h
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordAnimationView : UIView

@property (nonatomic, assign)BOOL clickStart;

@property (nonatomic, assign)BOOL isAnimationing;

@property (nonatomic, copy)void(^cancelRecoardBlock)();
@property (nonatomic, copy)void(^ComplateRecoardBlock)(int time);

@property (nonatomic, assign)BOOL isRecoardComplate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)show;
- (void)dismiss;

- (void)startAnimation;
- (void)stopAnimation;

@end
