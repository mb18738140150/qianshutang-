//
//  GraffitiView.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "GraffitiView.h"

#import "GraffitiDrawView.h"
#import "ColorSelectView.h"
#import "GraffitiBackgroundColorSelectView.h"

#define kOperationBtnWidth (kScreenHeight * 0.15 - 10)

@interface GraffitiView()

@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)UIButton * complateBtn;

@property (nonatomic, strong)GraffitiDrawView * drawer;
@property (nonatomic, strong)UIImageView * imageView;

@property (nonatomic, strong)UIButton * imageBtn;
@property (nonatomic, strong)UIButton * eraseBtn;
@property (nonatomic, strong)UIButton * revocationBtn;
@property (nonatomic, strong)UIButton * cleanBtn;
@property (nonatomic, strong)UIButton * saveBtn;

// 画笔宽度
@property (nonatomic, strong)UIButton * minWidthBtn;
@property (nonatomic, strong)UIButton * midWidthBtn;
@property (nonatomic, strong)UIButton * maxWidthBtn;

// 画笔颜色
@property (nonatomic, strong)UIView * brushCOlorView;
@property (nonatomic, strong)UIImageView * brushImageView;

@property (nonatomic, strong)UIColor * brushColor;
@property (nonatomic, strong)ColorSelectView * colorSelectView;

// 背景色
@property (nonatomic, strong)UIView * grffitiBackColorView;
@property (nonatomic, strong)UIImageView * grffitiBackImageView;

@property (nonatomic, strong)UIColor * grffitiBackColor;
@property (nonatomic, strong)GraffitiBackgroundColorSelectView * graffitiBackColorView;

@end


@implementation GraffitiView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
{
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    
    self.iconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageView.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.iconImageView setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self addSubview:self.iconImageView];
    [self.iconImageView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.complateBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addWidthBtns];
    [self addBrushColorView];
    
    if (self.image) {
        [self addoperationBtnNotImage];
    }else
    {
        [self addoperationBtn];
        [self addGraffitiBackColorSelectView];
    }
    
    
    self.brushColor = [UIColor blackColor];
    self.drawer = [[GraffitiDrawView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, kScreenHeight * 0.15 + 10, kScreenWidth * 0.8 - 10, kScreenHeight * 0.85 - 20)];
    
    if (self.image) {
        CGSize imageSize = [self getImageSizeForPreview:self.image];
        
        self.drawer.frame = CGRectMake(kScreenWidth * 0.6 - imageSize.width / 2, kScreenHeight * 0.575 - imageSize.height / 2, imageSize.width, imageSize.height);
        self.imageView = [[UIImageView alloc]initWithFrame:self.drawer.frame];
        self.imageView.image = self.image;
        [self addSubview:self.imageView];
    }
    
    _drawer.width = 8;
    _drawer.backgroundColor = [UIColor clearColor];
    self.drawer.lineColor = self.brushColor;
    self.drawer.isEraser = NO;
    [self addSubview:self.drawer];
    
    self.colorSelectView = [[ColorSelectView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.09, self.hd_centerY - kScreenHeight * 0.3, kScreenHeight * 0.4, kScreenHeight * 0.6)];
    self.colorSelectView.layer.cornerRadius = 5;
    self.colorSelectView.layer.masksToBounds = YES;
    self.colorSelectView.ColorSelectBlock = ^(UIColor *color) {
        [weakSelf refreshBrushColor:color];
    };
    [self.colorSelectView moveSlideBlock:^(CGPoint point) {
        [weakSelf setColorViewMovingRange:point];
    }];
    
    self.graffitiBackColorView = [[GraffitiBackgroundColorSelectView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.grffitiBackColorView.frame) + 20, kScreenHeight * 0.485, kScreenWidth * 0.46, kScreenHeight * 0.47) andDirectionPoint:CGPointMake(0, self.grffitiBackImageView.hd_centerY - kScreenHeight * 0.485)];
    self.graffitiBackColorView.GraffitiBackColorSelectBlock = ^(UIColor *color) {
        weakSelf.drawer.backgroundColor = color;
        [weakSelf.graffitiBackColorView dismiss];
        [weakSelf.drawer clearScreen];
    };
    
}

- (void)backAction
{
    if (self.backBlock) {
        self.backBlock();
    }
}
- (void)complateAction:(UIButton *)button
{
    if (self.SavaGraffitiBlock) {
        self.SavaGraffitiBlock([self getGraffitiImage]);
    }
}

- (void)setColorViewMovingRange:(CGPoint)point
{
    CGFloat x = self.colorSelectView.hd_x + point.x;
    CGFloat y = self.colorSelectView.hd_y + point.y;
    
    if (x < 0) {
        x = 0;
    }
    if (x > kScreenWidth - self.colorSelectView.hd_width) {
        x = kScreenWidth - self.colorSelectView.hd_width;
    }
    
    if (y < 0) {
        y = 0;
    }
    
    if (y > kScreenHeight - self.colorSelectView.hd_height) {
        y = kScreenHeight - self.colorSelectView.hd_height;
    }
    
    self.colorSelectView.hd_x = x;
    self.colorSelectView.hd_y = y;
}

#pragma mark = choice brushColor
- (void)brushColorAction
{
    if ([self.subviews containsObject:self.colorSelectView]) {
        [self.colorSelectView dismiss];
    }else
    {
        [self.colorSelectView showWithView:self];
    }
}

- (void)refreshBrushColor:(UIColor *)color
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.brushColor = color;
        self.brushCOlorView.backgroundColor = color;
        self.drawer.lineColor = color;
    });
}

#pragma mark - graffitiBackColor
- (void)grffitiBackColorAction
{
    if ([self.subviews containsObject:self.graffitiBackColorView]) {
        [self.graffitiBackColorView dismiss];
    }else
    {
        [self.graffitiBackColorView showWithView:self];
    }
}

- (void)changeBrushWidth:(UIButton *)button
{
    [self.eraseBtn setImage:[UIImage imageNamed:@"drawboard_rubber"] forState:UIControlStateNormal];
    self.drawer.lineColor = self.brushColor;
    self.drawer.isEraser = NO;
    if ([button isEqual:self.minWidthBtn]) {
        self.drawer.width = 3;
        self.minWidthBtn.hd_x = 0;
        self.midWidthBtn.hd_x = -18;
        self.maxWidthBtn.hd_x = -18;
    }else if ([button isEqual:self.midWidthBtn])
    {
        self.drawer.width = 8;
        self.minWidthBtn.hd_x = -18;
        self.midWidthBtn.hd_x = 0;
        self.maxWidthBtn.hd_x = -18;
    }else{
        self.drawer.width = 15;
        self.minWidthBtn.hd_x = -18;
        self.midWidthBtn.hd_x = -18;
        self.maxWidthBtn.hd_x = 0;
    }
}



#pragma mark 涂鸦板操作

- (void)getImageAction
{
    if (self.GetLibraryImageBlock) {
        self.GetLibraryImageBlock();
    }
}

- (void)resetWithImage:(UIImage *)image
{
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc]initWithImage:image];
    }else
    {
        self.imageView.image = image;
    }
    CGRect rect;
    rect.size = [self getImageSizeForPreview:image];
    rect.origin = CGPointMake(kScreenWidth * 0.6 - rect.size.width / 2, kScreenHeight * 0.15 + 10);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.drawer clearScreen];
        self.imageView.frame = rect;
        self.drawer.frame = rect;
        [self addSubview:self.imageView];
        [self insertSubview:self.imageView belowSubview:_drawer];
        self.drawer.backgroundColor = [UIColor clearColor];
    });
    
}

- (CGSize)getImageSizeForPreview:(UIImage *)image
{
    
    CGFloat maxWidth = kScreenWidth * 0.8 - 10,maxHeight = kScreenHeight * 0.85 - 20;
    
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

- (void)revocationAction
{
    [self.drawer undo];
}

- (void)eraseAction
{
    [self.eraseBtn setImage:[UIImage imageNamed:@"dowork_edit_btn_shallow"] forState:UIControlStateNormal];
    self.drawer.lineColor = [UIColor clearColor];
    self.drawer.isEraser = YES;
    self.minWidthBtn.hd_x = -18;
    self.midWidthBtn.hd_x = -18;
    self.maxWidthBtn.hd_x = -18;
}

- (void)cleanAction
{
    [self.drawer clearScreen];
}

// 保存本地相册
- (void)saveAction
{
    UIImage * image = [self getGraffitiImage];
    [self loadImageFinished:image];
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


#pragma mark prepareUI
- (void)addWidthBtns
{
    self.minWidthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minWidthBtn.frame = CGRectMake(-18, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight * 0.1, kScreenWidth * 0.085, kScreenHeight * 0.045);
    [self.minWidthBtn setImage:[UIImage imageNamed:@"pen_thin_selected"] forState:UIControlStateNormal];
    [self addSubview:self.minWidthBtn];
    
    self.midWidthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.midWidthBtn.frame = CGRectMake(0, CGRectGetMaxY(self.minWidthBtn.frame) + 10, kScreenWidth * 0.085, kScreenHeight * 0.067);
    [self.midWidthBtn setImage:[UIImage imageNamed:@"pen_middle_selected"] forState:UIControlStateNormal];
    [self addSubview:self.midWidthBtn];
    
    self.maxWidthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maxWidthBtn.frame = CGRectMake(-18, CGRectGetMaxY(self.midWidthBtn.frame) + 10, kScreenWidth * 0.085, kScreenHeight * 0.09);
    [self.maxWidthBtn setImage:[UIImage imageNamed:@"pen_rude_selected"] forState:UIControlStateNormal];
    [self addSubview:self.maxWidthBtn];
    
    [self.minWidthBtn addTarget:self action:@selector(changeBrushWidth:) forControlEvents:UIControlEventTouchUpInside];
    [self.midWidthBtn addTarget:self action:@selector(changeBrushWidth:) forControlEvents:UIControlEventTouchUpInside];
    [self.maxWidthBtn addTarget:self action:@selector(changeBrushWidth:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addBrushColorView
{
    self.brushCOlorView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.maxWidthBtn.frame) + 20, kScreenWidth * 0.072, kScreenHeight * 0.14)];
    self.brushCOlorView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.brushCOlorView];
    
    self.brushImageView = [[UIImageView alloc]initWithFrame:self.brushCOlorView.frame];
    self.brushImageView.image = [UIImage imageNamed:@"drawboard_pencolour"];
    self.brushImageView.userInteractionEnabled = YES;
    [self addSubview:self.brushImageView];
    
    UITapGestureRecognizer * brushColortap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(brushColorAction)];
    [self.brushImageView addGestureRecognizer:brushColortap];
    
}

- (void)addGraffitiBackColorSelectView
{
    self.grffitiBackColorView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.brushCOlorView.frame) + 20, kScreenWidth * 0.072, kScreenHeight * 0.14)];
    self.grffitiBackColorView.backgroundColor = [UIColor redColor];
    [self addSubview:self.grffitiBackColorView];
    
    self.grffitiBackImageView = [[UIImageView alloc]initWithFrame:self.grffitiBackColorView.frame];
    self.grffitiBackImageView.image = [UIImage imageNamed:@"drawboard_bgcolour"];
    self.grffitiBackImageView.userInteractionEnabled = YES;
    [self addSubview:self.grffitiBackImageView];
    
    UITapGestureRecognizer * grffitiBackColortap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(grffitiBackColorAction)];
    [self.grffitiBackImageView addGestureRecognizer:grffitiBackColortap];
}

- (void)addoperationBtnNotImage
{
    self.revocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.revocationBtn.frame = CGRectMake(kScreenWidth / 2 - kOperationBtnWidth * 2 - 45, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.revocationBtn setImage:[UIImage imageNamed:@"drawboard_repeal"] forState:UIControlStateNormal];
    [self addSubview:self.revocationBtn];
    
    self.eraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eraseBtn.frame = CGRectMake(kScreenWidth / 2 - kOperationBtnWidth  - 15, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.eraseBtn setImage:[UIImage imageNamed:@"drawboard_rubber"] forState:UIControlStateNormal];
    [self addSubview:self.eraseBtn];
    
    self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cleanBtn.frame = CGRectMake(kScreenWidth / 2 + 15, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.cleanBtn setImage:[UIImage imageNamed:@"drawboard_clear"] forState:UIControlStateNormal];
    [self addSubview:self.cleanBtn];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(kScreenWidth / 2 + kOperationBtnWidth  + 45, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.saveBtn setImage:[UIImage imageNamed:@"drawboard_save"] forState:UIControlStateNormal];
    [self addSubview:self.saveBtn];
    
    [self.revocationBtn addTarget:self action:@selector(revocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.eraseBtn addTarget:self action:@selector(eraseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addoperationBtn
{
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBtn.frame = CGRectMake(kScreenWidth / 2 - kOperationBtnWidth * 2.5 - 60, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.imageBtn setImage:[UIImage imageNamed:@"drawboard_pic"] forState:UIControlStateNormal];
    [self addSubview:self.imageBtn];
    
    self.revocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.revocationBtn.frame = CGRectMake(kScreenWidth / 2 - kOperationBtnWidth * 1.5 - 30, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.revocationBtn setImage:[UIImage imageNamed:@"drawboard_repeal"] forState:UIControlStateNormal];
    [self addSubview:self.revocationBtn];
    
    self.eraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eraseBtn.frame = CGRectMake(kScreenWidth / 2 - kOperationBtnWidth * 0.5, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.eraseBtn setImage:[UIImage imageNamed:@"drawboard_rubber"] forState:UIControlStateNormal];
    [self addSubview:self.eraseBtn];
    
    self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cleanBtn.frame = CGRectMake(kScreenWidth / 2 + 30 + kOperationBtnWidth * 0.5, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.cleanBtn setImage:[UIImage imageNamed:@"drawboard_clear"] forState:UIControlStateNormal];
    [self addSubview:self.cleanBtn];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(kScreenWidth / 2 + kOperationBtnWidth * 1.5  + 60, 5, kOperationBtnWidth, kOperationBtnWidth);
    [self.saveBtn setImage:[UIImage imageNamed:@"drawboard_save"] forState:UIControlStateNormal];
    [self addSubview:self.saveBtn];
    
    [self.imageBtn addTarget:self action:@selector(getImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.revocationBtn addTarget:self action:@selector(revocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.eraseBtn addTarget:self action:@selector(eraseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 获取涂鸦板截图
- (UIImage *)getGraffitiImage
{
    self.colorSelectView.hidden = YES;
    self.graffitiBackColorView.hidden = YES;
    
    if (self.image) {
        CGRect rect = self.imageView.frame;
        self.imageView.frame = CGRectMake(0, 0, self.imageView.hd_width, self.imageView.hd_height);
        self.drawer.frame = self.imageView.frame;
        UIGraphicsBeginImageContext(_drawer.bounds.size);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.imageView.frame = rect;
        self.drawer.frame = rect;
        return viewImage;
        
    }else
    {
        CGRect scope = self.drawer.frame;
        CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:self].CGImage, scope);
        UIGraphicsBeginImageContext(scope.size);
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
    
}
- (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
