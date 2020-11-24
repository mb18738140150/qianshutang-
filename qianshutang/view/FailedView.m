//
//  FailedView.m
//  qianshutang
//
//  Created by aaa on 2018/9/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "FailedView.h"

@implementation FailedView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)image andContent:(NSString *)content andDetail:(NSMutableAttributedString *)detail;
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUIWithImage:image andContent:content andDetail:detail];
    }
    return self;
}

- (void)prepareUIWithImage:(UIImage *)image andContent:(NSString *)content andDetail:(NSMutableAttributedString *)detail
{
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((width - height * 0.368 * 0.924) / 2, height * 0.213, height * 0.368 * 0.924, height * 0.368)];
    self.imageView.image = image;
    [self addSubview:self.imageView];
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + height * 0.045, width, height * 0.045)];
    self.contentLB.text = content;
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    self.contentLB.textColor = UIColorFromRGB(0x4D4D4D);
    [self addSubview:self.contentLB];
    
    self.detailLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLB.frame) + height * 0.045, width, height * 0.045)];
    self.detailLB.attributedText = detail;
    self.detailLB.textAlignment = NSTextAlignmentCenter;
    self.detailLB.textColor = UIColorFromRGB(0xC9C9C9);
    [self addSubview:self.detailLB];
    
}

- (void)refreshWithImage:(UIImage*)image andContent:(NSString *)content andDetail:(NSMutableAttributedString *)detail
{
    self.imageView.image = image;
    
    self.contentLB.text = content;
    
    self.detailLB.attributedText = detail;
}

@end
