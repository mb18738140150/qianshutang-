//
//  StudyLengthViewController.m
//  qianshutang
//
//  Created by aaa on 2018/9/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StudyLengthViewController.h"
#import "StudyLengthTableViewCell.h"
#define kStudyLengthTableViewCellId @"StudyLengthTableViewCell"
#import "CommentTaskViewController.h"
#import "MyTaskViewController.h"

@interface StudyLengthViewController ()<UITableViewDelegate, UITableViewDataSource, MyStudy_MyStudyTimeLengthDetailList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UILabel * titleLB;
@end

@implementation StudyLengthViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    
    self.titleLB.text = @"今日学习情况";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    [self loadData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + 5, kScreenWidth, kScreenHeight - self.navigationView.hd_height - 5) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[StudyLengthTableViewCell class] forCellReuseIdentifier:kStudyLengthTableViewCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyStudyTimeLengthDetailListWithWithDic:@{kTime:[self.infoDic objectForKey:kTime],kmemberId:@([[UserManager sharedManager] getUserType])} withNotifiedObject:self];
}

- (void)didRequestMyStudyTimeLengthDetailListSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getMyStudyTimeLengthDetailList] mutableCopy];
    [self.tableView reloadData];
}

- (void)didRequestMyStudyTimeLengthDetailListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudyLengthTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kStudyLengthTableViewCellId forIndexPath:indexPath];
    [cell resetUIWithInfoDic:self.dataArray[indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 9, view.hd_height) andTitle:@"类型"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"内容名称"];
    [view addSubview:nameLB];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"所属课本"];
    [view addSubview:timeLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"所用时长"];
    [view addSubview:detailLB];
    
    UILabel * dateLB = [self headLB:CGRectMake(CGRectGetMaxX(detailLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"学习日期"];
    [view addSubview:dateLB];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.14;
}

- (UILabel *)headLB:(CGRect)rect andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}


@end
