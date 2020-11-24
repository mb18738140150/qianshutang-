//
//  GraffitiBackgroundColorSelectView.m
//  qianshutang
//
//  Created by aaa on 2018/7/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "GraffitiBackgroundColorSelectView.h"

@interface GraffitiBackgroundColorSelectView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIView * directionView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation GraffitiBackgroundColorSelectView

- (instancetype)initWithFrame:(CGRect)frame andDirectionPoint:(CGPoint)point
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI:point];
    }
    return self;
}

- (void)prepareUI:(CGPoint)point
{
    self.directionView = [[UIView alloc]initWithFrame:CGRectMake(0, point.y - 20, 14, 20)];
    self.directionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.directionView];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 2;
    [bezierPath moveToPoint:CGPointMake(self.directionView.hd_width, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, self.directionView.hd_height / 2)];
    [bezierPath addLineToPoint:CGPointMake(self.directionView.hd_width, self.directionView.hd_height)];
    
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.directionView.bounds;
    shapLayer.strokeColor = UIRGBColor(246, 72, 82).CGColor;
    shapLayer.fillColor = UIRGBColor(248, 108, 113).CGColor;
    shapLayer.path = bezierPath.CGPath;
    shapLayer.lineWidth = 2;
    
    [self.directionView.layer addSublayer:shapLayer];
    
    self.dataArray = @[UIColorFromRGB(0xffffff), UIRGBColor(254, 249, 218), UIRGBColor(194, 228, 223), UIRGBColor(253, 214, 201),UIRGBColor(253, 234, 152), UIRGBColor(255, 161, 153),UIRGBColor(232, 203, 235), UIRGBColor(94, 208, 213), UIRGBColor(148, 207, 111), UIRGBColor(254, 100, 69), UIRGBColor(208, 178, 125), UIRGBColor(128, 192, 248)];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((self.hd_width - 12) / 4, self.hd_height / 3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 0, self.hd_width - 12, self.hd_height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"celID"];
    self.collectionView.layer.cornerRadius = 5;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.borderColor = UIRGBColor(246, 72, 82).CGColor;
    self.collectionView.layer.borderWidth = 2;
    [self addSubview:self.collectionView];
    
    [self insertSubview:self.directionView aboveSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celID" forIndexPath:indexPath];
    
    cell.backgroundColor = UIRGBColor(248, 108, 113);
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.hd_height - 10, cell.hd_height - 10)];
    backView.hd_centerX = cell.hd_width / 2;
    backView.hd_centerY = cell.hd_height / 2;
    backView.layer.cornerRadius = backView.hd_height / 2;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:backView];
    
    UIView * colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.hd_height - 20, cell.hd_height - 20)];
    colorView.hd_centerX = cell.hd_width / 2;
    colorView.hd_centerY = cell.hd_height / 2;
    colorView.layer.cornerRadius = colorView.hd_height / 2;
//    colorView.layer.masksToBounds = YES;
    colorView.backgroundColor = [self.dataArray objectAtIndex:indexPath.item];
    [cell addSubview:colorView];
    
    colorView.layer.shadowColor = UIRGBColor(72, 72, 72).CGColor;
    colorView.layer.shadowOffset = CGSizeMake(0, 2);
    colorView.layer.shadowOpacity = 0.5;
    colorView.layer.shadowRadius = 5;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.GraffitiBackColorSelectBlock) {
        self.GraffitiBackColorSelectBlock(self.dataArray[indexPath.item]);
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


@end
