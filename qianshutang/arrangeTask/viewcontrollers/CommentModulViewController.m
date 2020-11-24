//
//  CommentModulViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentModulViewController.h"
#import "CommentModulTableViewCell.h"
#define kCommentModulCellID @"CommentModulTableViewCell"


@interface CommentModulViewController ()<UITableViewDelegate, UITableViewDataSource,Teacher_CommentModul, Teacher_deleteCommentModul>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * deleteBtn;

@property (nonatomic, assign)BOOL isDelete;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)NSDictionary * selectInfo;
@end

@implementation CommentModulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
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
       self.titleLB.text = @"评语模板";
       
       self.titleLB.font = [UIFont systemFontOfSize:22];
       [self.navigationView.rightView addSubview:self.titleLB];
       
       self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       self.deleteBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.hd_height + 10, 5, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
       [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
       [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       self.deleteBtn.backgroundColor = kMainColor;
       self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
       self.deleteBtn.layer.masksToBounds = YES;
       [self.navigationView.rightView addSubview:self.deleteBtn];
       [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
       
       self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(7, 7 + self.navigationView.hd_height, kScreenWidth - 14, kScreenHeight - self.navigationView.hd_height - 9) style:UITableViewStylePlain];
       self.tableView.delegate = self;
       self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [self.tableView registerClass:[CommentModulTableViewCell class] forCellReuseIdentifier:kCommentModulCellID] ;
    [self.view addSubview:self.tableView];
    
}

- (void)backAction
{
    if (self.selectCommentModulBlock) {
        self.selectCommentModulBlock(self.selectInfo);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    CommentModulTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommentModulCellID forIndexPath:indexPath];
    cell.isDelete = self.isDelete;
    [cell reSetWithInfo:self.dataArray[indexPath.row]];
    cell.deleteCommentModulBlock = ^(NSDictionary *infoDic) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_deleteCommentModulWithDic:@{@"id":[infoDic objectForKey:@"id"]} withNotifiedObject:self];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.138;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
    if (self.isDelete) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_deleteCommentModulWithDic:@{@"id":[infoDic objectForKey:@"id"]} withNotifiedObject:self];
    }else
    {
        self.selectInfo = self.dataArray[indexPath.row];
        [self backAction];
    }
}

- (void)deleteAction
{
    self.deleteBtn.selected = !self.deleteBtn.selected;
    if (self.deleteBtn.selected) {
        self.isDelete = YES;
        [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else
    {
        self.isDelete = NO;
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_CommentModulListWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestTeacher_CommentModulSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getTeacher_CommentModulArray] mutableCopy];
    [self.tableView reloadData];
}

- (void)didRequestTeacher_CommentModulFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteCommentModulSuccessed
{
    [self loadData];
}

- (void)didRequestTeacher_deleteCommentModulFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
