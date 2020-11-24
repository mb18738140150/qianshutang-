//
//  PopListView.m
//  qianshutang
//
//  Created by aaa on 2018/7/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PopListView.h"

#define kArrowWidth 15.0
#define kCellHeight 45.0

@interface PopListView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIView * arrowView;

@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic, assign)CGPoint    point;
@property (nonatomic, assign)ArrowDirection direction;
@property (nonatomic, assign)CGFloat width;

@property (nonatomic, strong)NSIndexPath * selectIndexpath;

@end


@implementation PopListView

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArray andArrowRect:(CGRect)rect andWidth:(CGFloat)width
{
    CGPoint leftPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height / 2);
    CGPoint topPoint = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y);
    CGPoint rightPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2);
    CGPoint bottomPoint = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
    
    CGPoint arrowPoint;
    ArrowDirection arrowRection;
    
    if (rect.origin.y + rect.size.height / 2 > kScreenHeight / 2) {
        if (topPoint.y - dataArray.count * kCellHeight > 0) {
            arrowRection = ArrowDirection_bottom;
            arrowPoint = topPoint;
        }else
        {
            arrowRection = ArrowDirection_right;
            arrowPoint = leftPoint;
        }
    }else
    {
        if (kScreenHeight - bottomPoint.y - dataArray.count * kCellHeight > 0) {
            arrowRection = ArrowDirection_top;
            arrowPoint = bottomPoint;
        }else
        {
            arrowRection = ArrowDirection_right;
            arrowPoint = leftPoint;
        }
    }
    
    return [self initWithFrame:frame andDataArr:dataArray anDirection:arrowRection andArrowPoint:arrowPoint andWidth:width];
}

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArray anDirection:(ArrowDirection)arrowDirection andArrowPoint:(CGPoint)point andWidth:(CGFloat)width
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = dataArray;
        self.point = CGPointMake(point.x, point.y);
        self.width = width;
        self.direction = arrowDirection;
        [self prepareUI:arrowDirection];
    }
    return self;
}

- (void)prepareUI:(ArrowDirection)arrowDirection
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [backView addGestureRecognizer:tap];
    
    CGRect tableViewRect;
    self.arrowView = [[UIView alloc]init];
    self.arrowView.backgroundColor = kMainColor;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.hd_height, self.hd_width - 15) style:UITableViewStylePlain];
    
    switch (arrowDirection) {
        case ArrowDirection_top:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y, kArrowWidth, kArrowWidth / 2);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, kArrowWidth / 2)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            CGFloat height = self.dataArray.count * kCellHeight;
            if (kScreenHeight - self.point.y - kArrowWidth / 2 < height) {
                height = kScreenHeight - self.point.y  - kArrowWidth / 2 - 20;
            }
            
            self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y + kArrowWidth / 2, self.width, height);
            
        }
            break;
        case ArrowDirection_left:
        {
            self.arrowView.frame = CGRectMake(self.point.x , self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(0, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth / 2, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            if (self.point.y < kScreenHeight / 2) {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (kScreenHeight - self.point.y < height) {
                    height = kScreenHeight - self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight / 2, self.width, height);
            }else
            {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (self.point.y < height) {
                    height = self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
            }
            
        }
            break;
        case ArrowDirection_bottom:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth, kArrowWidth, kArrowWidth / 2);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth , 0)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            CGFloat height = self.dataArray.count * kCellHeight;
            if (self.point.y - kArrowWidth / 2 < height) {
                height = self.point.y - kArrowWidth / 2 - 20;
            }
            
            self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y - kArrowWidth / 2 - self.dataArray.count * kCellHeight, self.width, height);
            
        }
            break;
        case ArrowDirection_right:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, kArrowWidth)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            if (self.point.y < kScreenHeight / 2) {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (kScreenHeight - self.point.y < height) {
                    height = kScreenHeight - self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight / 2, self.width, height);
            }else
            {
                CGFloat height = self.dataArray.count * kCellHeight;
                if (self.point.y < height) {
                    height = self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
            }
            
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.borderColor = kMainColor.CGColor;
    self.tableView.layer.borderWidth = 2;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.arrowView];
    [self addSubview:self.tableView];
    
}

- (void)dismissAction
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - tableView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.hd_width, 44)];
    titleLB.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    titleLB.textColor = kMainColor;
    titleLB.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLB];
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44, cell.hd_width, 1)];
    seperateLine.backgroundColor = kMainColor;
    [cell.contentView addSubview:seperateLine];
    
    if (indexPath.row == self.selectIndexpath.row) {
        cell.backgroundColor = UIColorFromRGB(0xf4fffb);
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexpath = indexPath;
    [self.tableView reloadData];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[indexPath.row]];
    [dic setObject:@(indexPath.row) forKey:@"row"];
    
    if (self.SelectBlock) {
        self.SelectBlock(dic);
    }
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)refreshWithRecr:(CGRect)rect
{
    CGPoint leftPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height / 2);
    CGPoint topPoint = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y);
    CGPoint rightPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2);
    CGPoint bottomPoint = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height);
    
    CGPoint arrowPoint;
    ArrowDirection arrowRection;
    
    if (rect.origin.y + rect.size.height / 2 > kScreenHeight / 2) {
        if (topPoint.y - _dataArray.count * kCellHeight > 0) {
            arrowRection = ArrowDirection_bottom;
            arrowPoint = topPoint;
        }else
        {
            arrowRection = ArrowDirection_right;
            arrowPoint = leftPoint;
        }
    }else
    {
        if (kScreenHeight - bottomPoint.y - _dataArray.count * kCellHeight > 0) {
            arrowRection = ArrowDirection_top;
            arrowPoint = bottomPoint;
        }else
        {
            arrowRection = ArrowDirection_right;
            arrowPoint = leftPoint;
        }
    }
    self.direction = arrowRection;
    [self refreshDirectView:arrowRection];
    [self refreshWithPoint:arrowPoint];
}

- (void)refreshDirectView:(ArrowDirection)arrowDirection
{
    switch (arrowDirection) {
        case ArrowDirection_top:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y, kArrowWidth, kArrowWidth / 2);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, kArrowWidth / 2)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            CGFloat height = self.dataArray.count * kCellHeight;
            if (kScreenHeight - self.point.y - kArrowWidth / 2 < height) {
                height = kScreenHeight - self.point.y  - kArrowWidth / 2 - 20;
            }
            
            self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y + kArrowWidth / 2, self.width, height);
            
        }
            break;
        case ArrowDirection_left:
        {
            self.arrowView.frame = CGRectMake(self.point.x , self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(0, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth / 2, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            if (self.point.y < kScreenHeight / 2) {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (kScreenHeight - self.point.y < height) {
                    height = kScreenHeight - self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight / 2, self.width, height);
            }else
            {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (self.point.y < height) {
                    height = self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
            }
            
        }
            break;
        case ArrowDirection_bottom:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth, kArrowWidth, kArrowWidth / 2);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            [bezierPath addLineToPoint:CGPointMake(kArrowWidth , 0)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            CGFloat height = self.dataArray.count * kCellHeight;
            if (self.point.y - kArrowWidth / 2 < height) {
                height = self.point.y - kArrowWidth / 2 - 20;
            }
            
            self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y - kArrowWidth / 2 - self.dataArray.count * kCellHeight, self.width, height);
            
        }
            break;
        case ArrowDirection_right:
        {
            self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(kArrowWidth / 2, kArrowWidth / 2)];
            [bezierPath addLineToPoint:CGPointMake(0, kArrowWidth)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            [bezierPath closePath];
            CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
            shapLayer.frame = self.arrowView.bounds;
            shapLayer.path = bezierPath.CGPath;
            [self.arrowView.layer setMask:shapLayer];
            
            if (self.point.y < kScreenHeight / 2) {
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (kScreenHeight - self.point.y < height) {
                    height = kScreenHeight - self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight / 2, self.width, height);
            }else
            {
                CGFloat height = self.dataArray.count * kCellHeight;
                if (self.point.y < height) {
                    height = self.point.y;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)refreshWithPoint:(CGPoint )point
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.point = point;
        switch (self.direction) {
            case ArrowDirection_top:
            {
                self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y, kArrowWidth, kArrowWidth / 2);
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (kScreenHeight - self.point.y - kArrowWidth / 2 < height) {
                    height = kScreenHeight - self.point.y  - kArrowWidth / 2 - 20;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y + kArrowWidth / 2, self.width, height);
                
            }
                break;
            case ArrowDirection_left:
            {
                self.arrowView.frame = CGRectMake(self.point.x , self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
                
                if (self.point.y < kScreenHeight / 2) {
                    
                    CGFloat height = self.dataArray.count * kCellHeight;
                    if (kScreenHeight - self.point.y < height) {
                        height = kScreenHeight - self.point.y;
                    }
                    
                    self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight / 2, self.width, height);
                }else
                {
                    
                    CGFloat height = self.dataArray.count * kCellHeight;
                    if (self.point.y < height) {
                        height = self.point.y;
                    }
                    
                    self.tableView.frame = CGRectMake(self.point.x + kArrowWidth / 2, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
                }
                
            }
                break;
            case ArrowDirection_bottom:
            {
                self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth / 2, kArrowWidth, kArrowWidth / 2);
                
                
                CGFloat height = self.dataArray.count * kCellHeight;
                if (self.point.y - kArrowWidth / 2 < height) {
                    height = self.point.y - kArrowWidth / 2 - 20;
                }
                
                self.tableView.frame = CGRectMake(self.point.x - self.width / 2, self.point.y - kArrowWidth / 2 - self.dataArray.count * kCellHeight, self.width, height);
                
            }
                break;
            case ArrowDirection_right:
            {
                self.arrowView.frame = CGRectMake(self.point.x - kArrowWidth / 2, self.point.y - kArrowWidth / 2, kArrowWidth / 2, kArrowWidth);
                
                
                if (self.point.y < kScreenHeight / 2) {
                    
                    CGFloat height = self.dataArray.count * kCellHeight;
                    if (kScreenHeight - self.point.y < height) {
                        height = kScreenHeight - self.point.y;
                    }
                    
                    self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight / 2, self.width, height);
                }else
                {
                    CGFloat height = self.dataArray.count * kCellHeight;
                    if (self.point.y < height) {
                        height = self.point.y;
                    }
                    
                    self.tableView.frame = CGRectMake(self.point.x - kArrowWidth / 2 - self.width, self.point.y - kCellHeight * (self.dataArray.count - 0.5), self.width, height);
                }
                
            }
                break;
                
            default:
                break;
        }
        
        
        [self.tableView scrollToRowAtIndexPath:self.selectIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}


- (void)refresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView scrollToRowAtIndexPath:self.selectIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}

@end
