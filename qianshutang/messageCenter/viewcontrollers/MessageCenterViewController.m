//
//  MessageCenterViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MessageCenterViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "MessageDetailTableViewCell.h"
#define kMessageDetailCellID @"messageDetailCell"

#import "MessageOfRequestTableViewCell.h"
#define kRequestCellID @"requestCell"

@interface MessageCenterViewController ()<UITableViewDelegate, UITableViewDataSource, Notification_TaskNotification, Notification_SchoolNotification, Notification_OtherMessageNotification>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITableView * messageTableView;
@property (nonatomic, strong)NSMutableArray * messageDataArray;
@property (nonatomic, strong)FailedView * failedView;// 暂无数据view
@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"学校通知";
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 10, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.messageTableView = [[UITableView alloc]initWithFrame:self.backView.bounds style:UITableViewStylePlain];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.messageTableView registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:kMessageDetailCellID];
    [self.messageTableView registerClass:[MessageOfRequestTableViewCell class] forCellReuseIdentifier:kRequestCellID];
    [self.backView addSubview:self.messageTableView];
    
    self.failedView = [[FailedView alloc]initWithFrame:self.backView.bounds andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self.backView addSubview:self.failedView];
    self.failedView.hidden = YES;
    
    self.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadTableData];
    }];
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    
    [self.tableDataArray addObject:@{@"title":@"学校通知"}];
    [self.tableDataArray addObject:@{@"title":@"作业提醒"}];
    [self.tableDataArray addObject:@{@"title":@"好友请求"}];
    [self.tableDataArray addObject:@{@"title":@"其他消息"}];
    
    self.messageDataArray = [NSMutableArray array];
    
    [[UserManager sharedManager] didRequestSchoolNotificationWithWithDic:@{} withNotifiedObject:self];
}

#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return self.tableDataArray.count;
    }else
    {
        return self.messageDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
        if ([indexPath isEqual:self.categoryselectIndepath]) {
            [cell selectReset];
        }
        [cell refreshTipPointHide:YES];
        for (int i = 0; i < [[[UserManager sharedManager] getIsHaveNewMessageInfoDic] count]; i++) {
            NSDictionary * messageInfo = [[[UserManager sharedManager] getIsHaveNewMessageInfoDic] objectAtIndex:i];
            NSDictionary * infoDic = self.tableDataArray[indexPath.row];
            if ([[messageInfo objectForKey:@"typeStr"] isEqualToString:[infoDic objectForKey:@"title"]]) {
                [cell refreshTipPointHide:NO];
                break;
            }
        }
        
        
        return cell;
    }else
    {
        if (self.categoryselectIndepath.row != 2) {
            MessageDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMessageDetailCellID forIndexPath:indexPath];
            [cell resetWithInfoDic:self.messageDataArray[indexPath.row]];
            return cell;
        }else
        {
            MessageOfRequestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kRequestCellID forIndexPath:indexPath];
             [cell resetWithInfoDic:self.messageDataArray[indexPath.row]];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        
        return kScreenHeight / 8;
    }else
    {
        if (self.categoryselectIndepath.row != 2) {
            return [self getContentSize:self.messageDataArray[indexPath.row]].height + 40;
        }else
        {
            return 75;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView isEqual:tableView]) {
        
        int index = 0;
        for (int i = 0; i < [[[UserManager sharedManager] getIsHaveNewMessageInfoDic] count]; i++) {
            NSDictionary * messageInfo = [[[UserManager sharedManager] getIsHaveNewMessageInfoDic] objectAtIndex:i];
            NSDictionary * infoDic = self.tableDataArray[indexPath.row];
            if ([[messageInfo objectForKey:@"typeStr"] isEqualToString:[infoDic objectForKey:@"title"]]) {
                index = i;
                break;
            }
        }
        if ([[[UserManager sharedManager] getIsHaveNewMessageInfoDic] count] > 0) {
            [[[UserManager sharedManager] getIsHaveNewMessageInfoDic] removeObjectAtIndex:index];
        }
        
        
        if ([self.categoryselectIndepath isEqual: indexPath]) {
            [self.tableView reloadData];
            return;
        }
        NSDictionary * infoDic = [self.tableDataArray objectAtIndex:indexPath.row];
        self.titleLB.text = [infoDic objectForKey:@"title"];
        self.categoryselectIndepath = indexPath;
        [self.navigationView showSearch];
        [self reloadTableData];
        [self.tableView reloadData];
    }
}

- (void)reloadTableData
{
    [SVProgressHUD show];
    self.failedView.hidden = YES;
    if (self.categoryselectIndepath.row == 0) {
        [[UserManager sharedManager] didRequestSchoolNotificationWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 2)
    {
        [SVProgressHUD dismiss];
        [self addnoDataView];
    }else if (self.categoryselectIndepath.row == 1)
    {
        [[UserManager sharedManager] didRequestTaskNotificationWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 3)
    {
        [[UserManager sharedManager] didRequestOtherMessageNotificationWithWithDic:@{} withNotifiedObject:nil];
    }
}

#pragma mark - httprequest delegate
- (void)didRequestSchoolNotificationSuccessed
{
    [SVProgressHUD dismiss];
    [self.messageTableView.mj_header endRefreshing];
    self.messageDataArray = [[[UserManager sharedManager] getSchoolNotificationList] mutableCopy];
    [self.messageTableView reloadData];
    [self addnoDataView];
}
- (void)didRequestSchoolNotificationFailed:(NSString *)failedInfo
{
    [self.messageTableView.mj_header endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    self.messageDataArray = [[[UserManager sharedManager] getSchoolNotificationList] mutableCopy];
    [self.messageTableView reloadData];
}

- (void)didRequestTaskNotificationFailed:(NSString *)failedInfo
{
    [self.messageTableView.mj_header endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    self.messageDataArray = [[[UserManager sharedManager] getTaskNotificationList] mutableCopy];
    [self.messageTableView reloadData];
}

- (void)didRequestTaskNotificationSuccessed
{
    [SVProgressHUD dismiss];
    [self.messageTableView.mj_header endRefreshing];
    self.messageDataArray = [[[UserManager sharedManager] getTaskNotificationList] mutableCopy];
    [self.messageTableView reloadData];
    [self addnoDataView];
}

- (void)didRequestOtherMessageNotificationFailed:(NSString *)failedInfo
{
    [self.messageTableView.mj_header endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    self.messageDataArray = [[[UserManager sharedManager] getOtherMessageNotificationList] mutableCopy];
    [self.messageTableView reloadData];
}

- (void)didRequestOtherMessageNotificationSuccessed
{
    [self.messageTableView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    self.messageDataArray = [[[UserManager sharedManager] getOtherMessageNotificationList] mutableCopy];
    [self.messageTableView reloadData];
    [self addnoDataView];
}

- (CGSize)getContentSize:(NSDictionary *)infoDic
{
    CGSize contentSize = [[infoDic objectForKey:@"content"] boundingRectWithSize:CGSizeMake(self.messageTableView.hd_width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    return contentSize;
}

- (void)addnoDataView
{
    if (self.messageDataArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
    }
    
    UIImage * image = [UIImage imageNamed:@""];
    NSString * content = @"";
    NSMutableAttributedString * detail ;
    detail = [[NSMutableAttributedString alloc]initWithString:@""];
    
    switch (self.categoryselectIndepath.row) {
        case 0:
            {
                image = [UIImage imageNamed:@"default_notice_icon"];
                content = @"还没有学校通知";
            }
            break;
        case 1:
        {
            image = [UIImage imageNamed:@"default_homework_icon"];
            content = @"还没有作业提醒";
        }
            break;
        case 2:
        {
            self.failedView.hidden = NO;
            image = [UIImage imageNamed:@"default_friends_icon"];
            content = @"还没有好友请求信息";
        }
            break;
        case 3:
        {
            image = [UIImage imageNamed:@"default_news_icon"];
            content = @"还没有其他消息";
        }
            break;
            
        default:
            break;
    }
    
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
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
