//
//  CommonQuestionDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommonQuestionDetailViewController.h"

@interface CommonQuestionDetailViewController ()
@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIScrollView * scrollView;

@end

@implementation CommonQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.iconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageView.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.iconImageView setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.iconImageView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.iconImageView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"protect_eye_bg"];
    
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
