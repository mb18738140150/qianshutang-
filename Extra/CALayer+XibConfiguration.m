//
//  CALayer+XibConfiguration.m
//  tiku
//
//  Created by aaa on 2017/5/25.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

- (void)setBorderUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
