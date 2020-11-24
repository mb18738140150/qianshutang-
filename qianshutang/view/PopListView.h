//
//  PopListView.h
//  qianshutang
//
//  Created by aaa on 2018/7/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ArrowDirection_top,
    ArrowDirection_left,
    ArrowDirection_bottom,
    ArrowDirection_right
} ArrowDirection;

@interface PopListView : UIView

@property (nonatomic, copy)void(^dismissBlock)();

@property (nonatomic, copy)void(^SelectBlock)(NSDictionary * infoDic);

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArray andArrowRect:(CGRect)rect andWidth:(CGFloat)width;

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArray anDirection:(ArrowDirection)arrowDirection andArrowPoint:(CGPoint)point andWidth:(CGFloat)width;

- (void)refreshWithPoint:(CGPoint)point;

- (void)refreshWithRecr:(CGRect)rect;

- (void)refresh;

@end
