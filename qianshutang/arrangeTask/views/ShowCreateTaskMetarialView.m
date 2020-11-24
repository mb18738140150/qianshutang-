//
//  ShowCreateTaskMetarialView.m
//  qianshutang
//
//  Created by aaa on 2018/11/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ShowCreateTaskMetarialView.h"

@interface ShowCreateTaskMetarialView()

@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)NSArray * dataArray;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UIButton * lastBtn;
@property (nonatomic, strong)UIButton * nextBtn;

@property (nonatomic, assign)NSInteger currentIndex;

@end

@implementation ShowCreateTaskMetarialView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = dataArray;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.dataArray.count, kScreenHeight);
    
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary * infoDic = [self.dataArray objectAtIndex:i];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        imageView.backgroundColor = [UIColor blackColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.image = image;
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.topView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    [self addSubview:self.topView];
    UIButton * complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(kScreenWidth - 80, 0, 60, 50);
    [self.topView addSubview:complateBtn];
    [complateBtn setTitle:@"完成" forState:UIControlStateNormal];
    [complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    self.bottomView.backgroundColor = self.topView.backgroundColor;
    [self addSubview:self.bottomView];
    
    self.lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastBtn.frame = CGRectMake(kScreenWidth / 2 - 100, 12, 25, 25);
    [self.lastBtn setImage:[UIImage imageNamed:@"sanjiaoxing_last_nomal"] forState:UIControlStateNormal];
    [self.lastBtn addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(kScreenWidth / 2 + 75, 12, 25, 25);
    [self.nextBtn setImage:[UIImage imageNamed:@"sanjiaoxing_next_nomal"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:self.lastBtn];
    [self.bottomView addSubview:self.nextBtn];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissTopAndBottomView)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissAction];
    });
    
}

- (void)dismissTopAndBottomView
{
    if (self.topView.alpha == 1) {
        [self dismissAction];
    }
    else
    {
        [self showAction];
    }
}

- (void)dismissAction
{
    [UIView animateWithDuration:1 animations:^{
        self.topView.alpha = 0;
        self.topView.frame = CGRectMake(0, -25, kScreenWidth, 50);
        
        self.bottomView.alpha = 0;
        self.bottomView.frame = CGRectMake(0, kScreenHeight - 25, kScreenWidth, 50);
        
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)showAction
{
    [UIView animateWithDuration:1 animations:^{
        self.topView.alpha = 1;
        self.topView.frame = CGRectMake(0, 0, kScreenWidth, 50);
        
        self.bottomView.alpha = 1;
        self.bottomView.frame = CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50);
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)complateAction
{
    [self removeFromSuperview];
}

- (void)resetCurrentIndex:(NSInteger)index
{
    self.currentIndex = index;
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * index, 0, kScreenWidth, kScreenHeight) animated:NO];
    if (index == 0) {
        [self.lastBtn setImage:[UIImage imageNamed:@"sanjiaoxing_last_noMore"] forState:UIControlStateNormal];
    }
    if (index == self.dataArray.count - 1) {
        [self.nextBtn setImage:[UIImage imageNamed:@"sanjiaoxing_next_noMore"] forState:UIControlStateNormal];
    }
}

- (void)lastAction
{
    if (self.currentIndex <= 0) {
        return;
    }
    
    [self.lastBtn setImage:[UIImage imageNamed:@"sanjiaoxing_last_nomal"] forState:UIControlStateNormal];
    [self.nextBtn setImage:[UIImage imageNamed:@"sanjiaoxing_next_nomal"] forState:UIControlStateNormal];
    self.currentIndex--;
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * self.currentIndex, 0, kScreenWidth, kScreenHeight) animated:NO];
    if (self.currentIndex == 0) {
        [self.lastBtn setImage:[UIImage imageNamed:@"sanjiaoxing_last_noMore"] forState:UIControlStateNormal];
    }
}

- (void)nextAction
{
    if (self.currentIndex >= self.dataArray.count - 1) {
        return;
    }
    [self.lastBtn setImage:[UIImage imageNamed:@"sanjiaoxing_last_nomal"] forState:UIControlStateNormal];
    [self.nextBtn setImage:[UIImage imageNamed:@"sanjiaoxing_next_nomal"] forState:UIControlStateNormal];
    self.currentIndex++;
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * self.currentIndex, 0, kScreenWidth, kScreenHeight) animated:NO];
    if (self.currentIndex == self.dataArray.count - 1) {
        [self.nextBtn setImage:[UIImage imageNamed:@"sanjiaoxing_next_noMore"] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
