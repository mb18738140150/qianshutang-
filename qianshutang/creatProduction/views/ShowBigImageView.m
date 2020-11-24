//
//  ShowBigImageView.m
//  qianshutang
//
//  Created by aaa on 2018/8/6.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ShowBigImageView.h"
#import "PageControlLB.h"

@interface ShowBigImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)PageControlLB * pageLB;

@end

@implementation ShowBigImageView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSMutableArray *)array
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = array;
        [self prepareUI:array];
    }
    return self;
}

- (void)prepareUI:(NSArray *)array
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < array.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width * i, 0, self.hd_width, self.hd_height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImageView * sourceImage = array[i];
        imageView.image = sourceImage.image;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.hd_width * self.dataArray.count, self.hd_height);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.pageLB = [[PageControlLB alloc]initWithFrame:CGRectMake(self.hd_width * 0.89, self.hd_height * 0.895, self.hd_width * 0.086, self.hd_height * 0.07)];
    [self addSubview:self.pageLB];
    
}

- (void)setCurrentCount:(int)currentCount
{
    _currentCount = currentCount;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.scrollView scrollRectToVisible:CGRectMake(self.hd_width * currentCount, 0, self.hd_width, self.hd_height) animated:NO];
        self.pageLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.dataArray.count];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentCount = self.scrollView.contentOffset.x / self.hd_width ;
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.hd_width * currentCount, 0, self.hd_width, self.hd_height) animated:NO];
    self.pageLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.dataArray.count];
}

- (void)dismissAction
{
    if (self.dismissBlock) {
        self.dismissBlock();
    };
}

- (void)refreshUI:(CGRect)rect
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.frame = rect;
        self.scrollView.frame = CGRectMake(0, 0, self.hd_width, self.hd_height);
        for (int i = 0; i < self.dataArray.count; i++) {
            UIImageView * imageView = [self.dataArray objectAtIndex:i];
            imageView.frame = CGRectMake(self.hd_width * i, 0, self.hd_width, self.hd_height);
        }
        self.scrollView.contentSize = CGSizeMake(self.hd_width * self.dataArray.count, self.hd_height);
        self.pageLB.frame = CGRectMake(self.hd_width * 0.89, self.hd_height * 0.895, self.hd_width * 0.086, self.hd_height * 0.07);
    });
    
}
@end
