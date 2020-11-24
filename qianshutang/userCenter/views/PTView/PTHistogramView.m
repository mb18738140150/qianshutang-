//
//  PTHistogramView.m
//  PTHistogramView
//
//  Created by 天蓝 on 2017/8/8.
//  Copyright © 2017年 PT. All rights reserved.
//

#import "PTHistogramView.h"
#import "UICountingLabel.h"
#import "UIView+Extend.h"

@interface PTHistogramView ()
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *countArray;
@property (nonatomic, strong)NSArray * colorArray;

// 柱状图间隙
@property (nonatomic, assign) CGFloat itemSpace;
// 柱状图宽
@property (nonatomic, assign) CGFloat itemW;
// 柱状图高
@property (nonatomic, assign) CGFloat itemH;
// 左侧宽度
@property (nonatomic, assign) CGFloat leftSpace;
// 上侧间隙
@property (nonatomic, assign) CGFloat topSpace;
// 下侧高度
@property (nonatomic, assign) CGFloat bottomSpace;
// 纵向分的阶段
@property (nonatomic, assign) CGFloat stageCount;
// 阶段的间隔数量
@property (nonatomic, assign) CGFloat stageSpaceCount;
// 纵向的最大值
@property (nonatomic, assign) CGFloat maxYCount;
@end


@implementation PTHistogramView

- (instancetype)initWithFrame:(CGRect)frame
                    nameArray:(NSArray <NSString *>*)nameArray
                   countArray:(NSArray <NSString *>*)countArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (nameArray.count && nameArray.count == countArray.count)
        {
            self.nameArray = nameArray;
            self.countArray = countArray;
            self.backgroundColor = [UIColor greenColor];
            
            self.leftSpace = 30;
            self.topSpace = 30;
            self.bottomSpace = 30;
            self.itemW = 14;
            self.itemH = self.height - self.bottomSpace - self.topSpace;
            self.itemSpace = (self.width - 2 * self.leftSpace)/self.nameArray.count - self.itemW;
            
            
            // 取数组中最大的值
            NSInteger max_number = [[countArray valueForKeyPath:@"@max.intValue"] integerValue];
            
            self.stageCount = 3.0;
            self.stageSpaceCount = max_number == 0 ? 1 : ceilf(max_number/self.stageCount);
            self.maxYCount = self.stageCount * self.stageSpaceCount;
            
            [self createBaseView];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}

- (void)refreshUIWithnameArray:(NSArray<NSString *> *)nameArray countArray:(NSArray<NSString *> *)countArray
{
    [self removeAllSubviews];
    if (nameArray.count && nameArray.count == countArray.count)
    {
        self.nameArray = nameArray;
        self.countArray = countArray;
        self.backgroundColor = [UIColor whiteColor];
        
        self.leftSpace = 30;
        self.topSpace = 30;
        self.bottomSpace = 50;
        self.itemW = 50;
        self.itemH = self.height - self.bottomSpace - self.topSpace;
        self.itemSpace = (self.width - 2 * self.leftSpace - 30)/self.nameArray.count - self.itemW;
        
        
        // 设置最大的值
        NSInteger max_number = 100;
        
        self.stageCount = 3.0;
        self.stageSpaceCount = max_number == 0 ? 1 : ceilf(max_number/self.stageCount);
        self.maxYCount = self.stageCount * self.stageSpaceCount;
        self.colorArray = @[kMainColor_orange,UIRGBColor(248, 210, 59),UIRGBColor(211, 221, 110),UIRGBColor(115, 185, 93),UIRGBColor(70, 192, 183)];
        [self createBaseView];
    }
}

- (void)createBaseView
{
    [self createGrayCircleWihtFrame:CGRectMake(self.leftSpace - 2.5, 22.5, 10, 10)];
    [self createGrayLineWihtFrame:CGRectMake(self.leftSpace, 30, 5, self.height - self.bottomSpace  - 30 + 2)];
    [self createGrayLineWihtFrame:CGRectMake(self.leftSpace, self.height - self.bottomSpace + 2, self.width - self.leftSpace - 30, 5)];
    [self createGrayCircleWihtFrame:CGRectMake(self.width - 30 - 2.5, self.height - self.bottomSpace + 2 - 2.5, 10, 10)];
    
    UILabel * totalLB = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 30 - 100, 22.5, 100, 15)];
    totalLB.font = [UIFont systemFontOfSize:12];
    totalLB.text = [NSString stringWithFormat:@"总计:%@%%", [[[UserManager sharedManager] getTeacherStudentHistoryTaskInfo] objectForKey:@"allComplete"]];//@"总计:10%"
    totalLB.textAlignment = NSTextAlignmentRight;
    totalLB.textColor = UIColorFromRGB(0x333333);
    [self addSubview:totalLB];
    
    UILabel * complateTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.leftSpace + 15, 22.5, 100, 15)];
    complateTitleLB.font = [UIFont systemFontOfSize:12];
    complateTitleLB.text = @"作业完成度";
    complateTitleLB.textColor = UIColorFromRGB(0x333333);
    [self addSubview:complateTitleLB];
    
    for (int i = 0; i < self.nameArray.count; i++)
    {
        UILabel *label = [self createLabelWithFrame:CGRectMake(0, 0, 40, self.bottomSpace) text:self.nameArray[i]];
        label.center = CGPointMake(self.leftSpace + (i+1) * (self.itemSpace + self.itemW) - self.itemW/2.0, self.height - self.bottomSpace/2.0);
        label.textColor = [self.colorArray objectAtIndex:i];
        [self addSubview:label];
    }
    
    for (int i = 0; i <= self.stageCount; i++)
    {
        UILabel *label = [self createLabelWithFrame:CGRectMake(0, 0, self.leftSpace, 10) text:[NSString stringWithFormat:@"%.f",(self.stageCount - i)*self.stageSpaceCount]];
        label.center = CGPointMake(self.leftSpace/2.0, self.topSpace + i * (self.itemH/self.stageCount));
//        [self addSubview:label];
    }
    [self setNeedsDisplay];
}

- (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor colorWithRed:0.35f green:0.35f blue:0.37f alpha:1.00f];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)createGrayCircleWihtFrame:(CGRect)frame
{
//    UIBezierPath * bezier = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5];
//    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
//    layer.frame = frame;
//    layer.path = bezier.CGPath;
//    layer.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f].CGColor;
//    [self.layer addSublayer:layer];
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    label.layer.cornerRadius = frame.size.width / 2;
    label.layer.masksToBounds = YES;
    [self addSubview:label];
    
}

- (void)createGrayLineWihtFrame:(CGRect)frame
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f].CGColor;
    [self.layer addSublayer:layer];
}

- (void)drawRect:(CGRect)rect
{   
    for (int i = 0; i < self.countArray.count; i++)
    {
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIColor * color = [self.colorArray objectAtIndex:i];
        layer.strokeColor = color.CGColor;
        layer.lineWidth = self.itemW;
        
        
        // 贝塞尔二次曲线
        CGFloat centerX = self.leftSpace + (i+1) * (self.itemSpace + self.itemW) - self.itemW/2.0;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(centerX, self.height - self.bottomSpace)];
        [path addLineToPoint:CGPointMake(centerX, self.topSpace)];
        layer.path = path.CGPath;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 1;
        animation.repeatCount = 1;
        animation.fromValue = @(0);
        animation.toValue = @([self.countArray[i] floatValue]/self.maxYCount);
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [layer addAnimation:animation forKey:nil];
        
        [self.layer addSublayer:layer];
        
        UICountingLabel *label = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 30, 16)];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithRed:0.35f green:0.35f blue:0.37f alpha:1.00f];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(centerX, self.height - self.bottomSpace - label.height/2.0);
        
        label.format = @"%zd";
        label.method = UILabelCountingMethodLinear;
        [label countFromZeroTo:[self.countArray[i] integerValue] withDuration:animation.duration];
        [self addSubview:label];
        
        
        [UIView animateWithDuration:animation.duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             label.centerY = self.topSpace + self.itemH * (1-[animation.toValue floatValue]) - label.height/2.0;
                         } completion:nil];
    }
}

@end
