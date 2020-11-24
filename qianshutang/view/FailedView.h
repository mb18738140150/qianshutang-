//
//  FailedView.h
//  qianshutang
//
//  Created by aaa on 2018/9/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailedView : UIView

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * detailLB;


- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)image andContent:(NSString *)content andDetail:(NSMutableAttributedString *)detail;

- (void)refreshWithImage:(UIImage*)image andContent:(NSString *)content andDetail:(NSMutableAttributedString *)detail;

@end
