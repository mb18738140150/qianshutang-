//
//  UIImageView+Color.h
//  qianshutang
//
//  Created by aaa on 2018/7/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Color)

- (UIColor *)getCurrentPointColor:(CGPoint )point;

- (UIColor *)getCurrentPointColor:(CGPoint )point andRect:(CGRect)rect;

@end
