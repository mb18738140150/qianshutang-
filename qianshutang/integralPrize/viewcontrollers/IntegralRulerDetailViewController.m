//
//  IntegralRulerDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "IntegralRulerDetailViewController.h"

@interface IntegralRulerDetailViewController ()
@property (nonatomic, strong)UIButton * iconImageView;

@property (nonatomic, strong)UIScrollView * scrollView;
@end

@implementation IntegralRulerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    UIImage * image = [UIImage imageNamed:@"integral_rules"];
    CGSize imageSize = [self getImagesize:image];
    
    self.iconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageView.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.iconImageView setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.iconImageView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.iconImageView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, imageSize.height)];
    imageView.image = image;
    [self.scrollView addSubview:imageView];
    
    self.scrollView.contentSize = CGSizeMake(imageView.hd_width, imageView.hd_height);
}

- (CGSize)getImagesize:(UIImage *)image
{
    CGFloat height = kScreenWidth / image.size.width * image.size.height;
    
    return CGSizeMake(kScreenWidth, height);
}

- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
