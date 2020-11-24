//
//  ProductDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/3.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "PageControlLB.h"
#import "CreateProductionViewController.h"
#import "ShowBigImageView.h"

@interface ProductDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)NavigationView * navigationView;

@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * iconImage;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * flowerLB;
@property (nonatomic, strong)UIImageView * flowerImageView;
@property (nonatomic, strong)UIButton * modifyBtn;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)PageControlLB * pageControlLB;
@property (nonatomic, assign)int currentCount;
@property (nonatomic, strong)NSMutableArray * imaegArray;
@property (nonatomic, strong)ShowBigImageView * showBigImageView;

@end

@implementation ProductDetailViewController

- (NSMutableArray *)imaegArray
{
    if (!_imaegArray) {
        _imaegArray = [NSMutableArray array];
    }
    return _imaegArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    __weak typeof(self)weakSelf = self;
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndPlay];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.shareBlock = ^(BOOL isShare) {
        ;
    };
    self.navigationView.playBlock = ^{
        ;
    };
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = self.model.name;
    [self.navigationView.rightView addSubview:self.titleLB];
    
    [self addLeftView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 13, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 20)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.backView.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.pagingEnabled = YES;
    [self.backView addSubview:self.scrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageAction)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.pageControlLB = [[PageControlLB alloc]initWithFrame:CGRectMake(self.backView.hd_width * 0.89, self.backView.hd_height * 0.895, self.backView.hd_width * 0.086, self.backView.hd_height * 0.07)];
    [self.backView addSubview:self.pageControlLB];
    
    [self refreshScroll];
    
}
- (void)backAction
{
    if (self.backBlock) {
        self.backBlock(self.model);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)refreshScroll
{
    [self.scrollView removeAllSubviews];
    [self.imaegArray removeAllObjects];
    switch (self.model.modelType) {
        case ProductModelType_text:
        {
            for (int i = 0; i < self.model.textProductArray.count; i++) {
                TextProductModel * model = [self.model.textProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                imageView.image = model.textImage;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                [self.scrollView addSubview:imageView];
                [self.imaegArray addObject:imageView];
            }
            self.scrollView.contentSize = CGSizeMake(self.model.textProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.textProductArray.count];
        }
            break;
        case ProductModelType_music:
            {
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.image = self.model.image;
                imageView.userInteractionEnabled = YES;
                [self.scrollView addSubview:imageView];
                [self.imaegArray addObject:imageView];
            }
            break;
        case ProductModelType_photo:
        {
            for (int i = 0; i < self.model.imageProductArray.count; i++) {
                ImageProductModel * model = [self.model.imageProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                imageView.image = model.fanleImage;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                [self.scrollView addSubview:imageView];
                [self.imaegArray addObject:imageView];
            }
            self.scrollView.contentSize = CGSizeMake(self.model.imageProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
        }
            break;
        case ProductModelType_video:
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = self.model.image;
            [self.scrollView addSubview:imageView];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)showBigImageAction
{
    if (self.model.modelType != ProductModelType_video) {
        if (!self.showBigImageView) {
            self.showBigImageView = [[ShowBigImageView alloc]initWithFrame:self.view.frame andArray:self.imaegArray];
        }
        [self.view addSubview:self.showBigImageView];
        CGFloat duration = 1.0;
        
        self.showBigImageView.currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(0.8);
            scaleAnimation.toValue = @(1);
            scaleAnimation.duration = duration;
            
            CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            alphaAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.backView.hd_centerX, self.backView.hd_centerY)];
            // 终止位置
            alphaAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.hd_centerX, self.view.hd_centerY)];
            alphaAnimation.duration = duration;
            
            CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = duration;
            animationGroup.autoreverses = NO;
            [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation,alphaAnimation, nil]];
            
            [self.showBigImageView.layer addAnimation:animationGroup forKey:@"animationGroup"];
        });
        
        
        
        
        __weak typeof(self)weakSelf = self;
        self.showBigImageView.dismissBlock = ^{
            CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(1.0);
            scaleAnimation.toValue = @(0.8);
            scaleAnimation.duration = duration;
            
            CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            alphaAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.view.hd_centerX, weakSelf.view.hd_centerY)];
            // 终止位置
            alphaAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.backView.hd_centerX, weakSelf.backView.hd_centerY)];
            alphaAnimation.duration = duration;
            
            CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = duration;
            animationGroup.autoreverses = NO;
            [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation,alphaAnimation, nil]];
            
            [weakSelf.showBigImageView.layer addAnimation:animationGroup forKey:@"animationGroup"];
            [weakSelf performSelector:@selector(dismissBigImageView) withObject:nil afterDelay:duration - 0.05];
        };
        
    }
}

- (void)dismissBigImageView
{
    [self.showBigImageView removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width ;
    switch (self.model.modelType) {
        case ProductModelType_text:
        {
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.textProductArray.count];
        }
            break;
        case ProductModelType_photo:
        {
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
        }
            break;
            
        default:
            break;
    }
}

- (void)addLeftView
{
    UIView * leftBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftBackView.backgroundColor = kMainColor;
    [self.view addSubview:leftBackView];
    
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(leftBackView.hd_width * 18, 15, leftBackView.hd_width * 0.64, leftBackView.hd_width * 0.64)];
    self.iconImage.image = [UIImage imageNamed:@"head_portrait"];
    [leftBackView addSubview:self.iconImage];
    self.iconImage.layer.cornerRadius = 5;
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImage.layer.borderWidth = 5;
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImage.frame) + 5, leftBackView.hd_width, 20)];
    self.nameLB.textColor = [UIColor whiteColor];
    self.nameLB.text = @"teacherqst";
    self.nameLB.textAlignment = NSTextAlignmentCenter;
    [leftBackView addSubview:self.nameLB];
    
    NSString * flowerStr = @"红花： 9";
    CGSize flowerLBSize = [flowerStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 5, flowerLBSize.width, 20)];
    self.flowerLB.textColor = [UIColor whiteColor];
    self.flowerLB.text = flowerStr;
    self.flowerLB.textAlignment = NSTextAlignmentCenter;
    [leftBackView addSubview:self.flowerLB];
    
    self.flowerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerLB.frame) + 5, self.flowerLB.hd_y, 20, 20)];
    self.flowerImageView.image = [UIImage imageNamed:@"flower"];
    [leftBackView addSubview:self.flowerImageView];
    
    self.modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.modifyBtn.frame = CGRectMake(5, leftBackView.hd_height - kScreenHeight * 0.2, leftBackView.hd_width - 10, kScreenHeight * 0.13);
    self.modifyBtn.layer.cornerRadius = 5;
    self.modifyBtn.layer.masksToBounds = YES;
    self.modifyBtn.backgroundColor = UIColorFromRGB(0x8BC6AF);
    [self.modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
    [self.modifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.modifyBtn addTarget:self action:@selector(modifyProduct) forControlEvents:UIControlEventTouchUpInside];
    [leftBackView addSubview:self.modifyBtn];
}

- (void)modifyProduct
{
    __weak typeof(self)weakSelf = self;
    CreateProductionViewController * vc = [[CreateProductionViewController alloc]init];
    vc.model = self.model;
    vc.SavaProductBlock = ^(ProductionModel *model) {
        weakSelf.model = model;
        [weakSelf refreshScroll];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
