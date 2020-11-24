//
//  TextPositionView.m
//  qianshutang
//
//  Created by aaa on 2018/8/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TextPositionView.h"
#import "ProductPatternSelectView.h"

@interface TextPositionView()

@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)UIImageView *backImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, assign)CGPoint startPoint;
@property (nonatomic, assign)CGRect startRect;
@property (nonatomic, strong)NSArray * colorArray;

@end

@implementation TextPositionView

- (instancetype)initWithFrame:(CGRect)frame  andText:(NSString *)text andColor:(NSString *)colorStr andImage:(UIImage *)image
{
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.text = text;
        NSArray * colorArray = @[@{kcolorStr:kBlack,@"color":UIColorFromRGB(0x555555)},@{kcolorStr:kWhite,@"color":UIColorFromRGB(0xffffff)},@{kcolorStr:kRed,@"color":UIColorFromRGB(0xFF1D11)},@{kcolorStr:kYellow,@"color":UIColorFromRGB(0xF9F704)},@{kcolorStr:kGreen,@"color":UIColorFromRGB(0x20DA1D)},@{kcolorStr:kBlue,@"color":UIColorFromRGB(0x1B9BFF)},@{kcolorStr:kPurple,@"color":UIColorFromRGB(0x9204F8)},@{kcolorStr:kPink,@"color":UIColorFromRGB(0xFC00FF)}];
        self.colorArray = colorArray;
        for (NSDictionary * infoDic in colorArray) {
            if ([colorStr isEqualToString:[infoDic objectForKey:kcolorStr]]) {
                self.color = [infoDic objectForKey:@"color"];
                self.colorStr = colorStr;
            }
        }
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(25, 25, 50, 25);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.cancelBtn];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(kScreenWidth - 75, 25, 50, 25);
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.complateBtn];
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.complateBtn addTarget:self action:@selector(complateAction ) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGRect rect = CGRectMake(kScreenWidth * 0.09, kScreenHeight * 0.09, kScreenWidth * 0.82, kScreenHeight * 0.82);
    if (self.image) {
        CGSize imageSize = [self getImageRect:self.image];
        rect = CGRectMake(kScreenWidth / 2 - imageSize.width / 2, kScreenHeight / 2 - imageSize.height / 2, imageSize.width, imageSize.height);
    }
    
    self.backImageView = [[UIImageView alloc]initWithFrame:rect];
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.image = self.image;
    [self addSubview:self.backImageView];
    self.backImageView.userInteractionEnabled = YES;
    
    UIView * backBtn = [[UIView alloc]initWithFrame:self.backImageView.bounds];
    backBtn.backgroundColor = [UIColor clearColor];
    [self.backImageView addSubview:backBtn];
    
    UITapGestureRecognizer * LBtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancenLBSelectState)];
    [backBtn addGestureRecognizer:LBtap];
    
    
    CGSize widthSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGSize heightSize = CGSizeZero;
    
    if (widthSize.width > self.backImageView.hd_width) {
        heightSize = [self.text boundingRectWithSize:CGSizeMake(self.backImageView.hd_width - 4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    }else
    {
        heightSize = widthSize;
    }
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, heightSize.width, heightSize.height + 10)];
    self.titleLB.text = self.text;
    self.titleLB.textColor = self.color;
    self.titleLB.numberOfLines = 10000;
    self.titleLB.userInteractionEnabled = YES;
    [self.backImageView addSubview:self.titleLB];
    
    UITapGestureRecognizer * labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapAction)];
    [self.titleLB addGestureRecognizer:labelTap];
    self.startRect = self.titleLB.frame;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.image) {
        return;
    }
    self.startPoint = [self convertPoint:[[touches anyObject] locationInView:self] toView:self.backImageView];
    
    if (CGRectContainsPoint(self.titleLB.frame, self.startPoint))
    {
        self.titleLB.layer.borderColor = [UIColor orangeColor].CGColor;
        self.titleLB.layer.borderWidth = 2;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    
    CGPoint imagePoint = [self convertPoint:currentPoint toView:self.backImageView];
    
    CGPoint offSet = CGPointMake(imagePoint.x - self.startPoint.x, imagePoint.y - self.startPoint.y);
    
    if (CGRectContainsPoint(self.startRect, self.startPoint)) {
//        if (self.titleLB.hd_x + offSet.x > 2 && self.titleLB.hd_x + self.titleLB.hd_width + offSet.x < self.backImageView.hd_width - 4) {
//            self.titleLB.hd_centerX =  imagePoint.x;
//        }
//        if (self.titleLB.hd_y + offSet.y > 2 && self.titleLB.hd_y + self.titleLB.hd_height + offSet.y < self.backImageView.hd_height - 4) {
//            self.titleLB.hd_centerY =  imagePoint.y;
//        }
        
        
        self.titleLB.center = imagePoint;
        
        if (self.titleLB.hd_x <= 0) {
            self.titleLB.hd_x = 0;
        }
        if (self.titleLB.hd_x + self.titleLB.hd_width  >= self.backImageView.hd_width - 4) {
            self.titleLB.hd_x = self.backImageView.hd_width - 4 - self.titleLB.hd_width;
        }
        if (self.titleLB.hd_y  <= 0) {
            self.titleLB.hd_y = 0;
        }
        if (self.titleLB.hd_y + self.titleLB.hd_height  >= self.backImageView.hd_height - 4) {
            self.titleLB.hd_y = self.backImageView.hd_height - 4 - self.titleLB.hd_height;
        }
        
    }else
    {
        NSLog(@"*%.2f **** %.2f    ^^^^ %.2f, %.2f", self.startPoint.x, self.startPoint.y, self.titleLB.hd_x, self.titleLB.hd_y);
        NSLog(@"not in ");
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.startRect = self.titleLB.frame;
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)complateAction
{
    self.titleLB.layer.borderColor = [UIColor clearColor].CGColor;
    self.titleLB.layer.borderWidth = 2;
    if (self.textPositionBlock) {
        self.textPositionBlock(CGPointMake(self.titleLB.hd_x, self.titleLB.hd_y), @{@"title":self.titleLB.text,kcolorStr:self.colorStr}, [self getGraffitiImage]);
    }
    if (self.textPositionRectBlock) {
        self.textPositionRectBlock(self.titleLB.frame,self.backImageView.frame, @{@"title":self.titleLB.text,kcolorStr:self.colorStr}, [self shotWithView:self.titleLB]);
    }
}

- (void)labelTapAction
{
    self.titleLB.layer.borderColor = [UIColor orangeColor].CGColor;
    self.titleLB.layer.borderWidth = 2;
    
    __weak typeof(self)weakSelf = self;
    ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.bounds withText:self.text];
    [view resetTextColor:self.colorStr];
    __weak typeof(view)weakView = view;
    view.textBlock = ^(NSDictionary *infoDic) {
        weakSelf.text = [infoDic objectForKey:@"title"];
        weakSelf.colorStr = [infoDic objectForKey:kcolorStr];
        
        for (NSDictionary * infoDic in weakSelf.colorArray) {
            if ([weakSelf.colorStr isEqualToString:[infoDic objectForKey:kcolorStr]]) {
                weakSelf.color = [infoDic objectForKey:@"color"];
            }
        }
        
        [weakSelf refreshLabel];
        
        [weakView dismiss];
    };
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
}

- (void)refreshLabel
{
    CGSize widthSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGSize heightSize = CGSizeZero;
    
    if (widthSize.width > self.backImageView.hd_width) {
        heightSize = [self.text boundingRectWithSize:CGSizeMake(self.backImageView.hd_width - 4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    }else
    {
        heightSize = widthSize;
    }
    
    if (self.titleLB.hd_x + heightSize.width >= self.backImageView.hd_width - 4) {
        self.titleLB.frame = CGRectMake(0, self.titleLB.hd_y, heightSize.width, heightSize.height + 10);
    }
    if (self.titleLB.hd_y + heightSize.height >= self.backImageView.hd_height - 4) {
        self.titleLB.frame = CGRectMake(self.titleLB.hd_x, self.backImageView.hd_height - heightSize.height - 10, heightSize.width, heightSize.height);
    }
    
    self.titleLB.frame = CGRectMake(self.titleLB.hd_x, self.titleLB.hd_y, heightSize.width, heightSize.height + 10);
    
    self.titleLB.text = self.text;
    self.titleLB.textColor = self.color;
}

- (void)cancenLBSelectState
{
    self.titleLB.layer.borderColor = [UIColor clearColor].CGColor;
    self.titleLB.layer.borderWidth = 2;
}

- (CGSize)getImageRect:(UIImage *)image
{
    
    CGFloat maxWidth = kScreenWidth * 0.82,maxHeight = kScreenHeight * 0.82;
    
    CGSize size = image.size;
    
    if (size.width > maxWidth) {
        size.height *= (maxWidth / size.width);
        size.width = maxWidth;
    }
    
    if (size.height > maxHeight) {
        size.width *= (maxHeight / size.height);
        size.height = maxHeight;
    }
    
    return size;
}

- (UIImage *)getGraffitiImage
{
    CGRect scope = CGRectMake(self.backImageView.frame.origin.x + 1, self.backImageView.frame.origin.y + 1, self.backImageView.frame.size.width - 2, self.backImageView.frame.size.height - 2);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:self].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
//    UIGraphicsBeginImageContextWithOptions(scope.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);// 下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    return image;
    
}
- (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
