//
//  MyTaskListDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyTaskListDetailViewController.h"
#import "UserCenterTableView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "CommentTaskViewController.h"
#import "MyTaskViewController.h"

@interface MyTaskListDetailViewController ()<UITableViewDelegate, UITableViewDataSource, MyStudy_MyEveryDayTaskDetailList, MyClassroom_classMemberComplateTaskInfo,MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

@property (nonatomic, strong)NSDictionary * selectProductInfo;
@property (nonatomic, assign)TaskType tasktype;

@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UIButton * moreBtn;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * teacherLB;

@end

@implementation MyTaskListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"我的作业详情";
    [self.navigationView.rightView addSubview:self.titleLB];
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    UILabel * nameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, leftView.hd_width - 20, 20)];
    nameLB.text = @"作业名称:";
    nameLB.textColor = UIColorFromRGB(0x222222);
    nameLB.font = [UIFont systemFontOfSize:18];
    [leftView addSubview:nameLB];
    
    NSString * name = [self.infoDic objectForKey:kWorkLogName];
    CGSize nameSize = [name boundingRectWithSize:CGSizeMake(leftView.hd_width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLB.frame) + 10, leftView.hd_width - 20, 18)];
    self.taskNameLB.textColor = [UIColor whiteColor];
    self.taskNameLB.text = name;
    self.taskNameLB.userInteractionEnabled = YES;
    [leftView addSubview:self.taskNameLB];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.frame = CGRectMake(10, CGRectGetMaxY(self.taskNameLB.frame) + 3, 50, 20);
    [self.moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftView addSubview:self.moreBtn];
    [self.moreBtn addTarget:self action:@selector(moreAction ) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeLB = [[UILabel alloc]init];
    
    if (nameSize.height < 30) {
        self.moreBtn.hidden = YES;
        self.timeLB.frame = CGRectMake(10, CGRectGetMaxY(self.taskNameLB.frame) + 5, leftView.hd_width - 20, 50);
    }else
    {
        UITapGestureRecognizer * moreTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAction)];
        [self.taskNameLB addGestureRecognizer:moreTap];
        
        self.timeLB.frame = CGRectMake(10, CGRectGetMaxY(self.moreBtn.frame) + 5, leftView.hd_width - 20, 50);
    }
    self.timeLB.font = [UIFont systemFontOfSize:18];
    self.timeLB.textColor = UIColorFromRGB(0x222222);
    self.timeLB.numberOfLines = 0;
    self.timeLB.attributedText = [self getTimeStr:[NSString stringWithFormat:@"布置时间:\n%@", [self.infoDic objectForKey:@"arrangeTime"]]];
    [leftView addSubview:self.timeLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.timeLB.frame), leftView.hd_width - 20, 50)];
    self.teacherLB.font = [UIFont systemFontOfSize:18];
    self.teacherLB.textColor = UIColorFromRGB(0x222222);
    self.teacherLB.numberOfLines = 0;
    self.teacherLB.attributedText = [self getTeacherStr:[NSString stringWithFormat:@"布置人:\n%@", [self.infoDic objectForKey:@"arrangeTeacher"]]];
    [leftView addSubview:self.teacherLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.75 - 10, kScreenWidth * 0.2, kScreenHeight * 0.25 + 10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 8, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.userTableview = [[UserCenterTableView alloc]initWithFrame:self.backView.bounds];
    self.userTableview.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.backView addSubview:self.userTableview];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_MytaskComplateDetail];
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        
    };
    
    self.userTableview.headRefreshBlock = ^{
        if (weakSelf.selectIndexPath.row == 0) {
            [[UserManager sharedManager] didRequestMyEveryDayTaskDetailListWithWithDic:@{kWorkLogId:[weakSelf.infoDic objectForKey:kWorkLogId]} withNotifiedObject:weakSelf];
        }else
        {
            [[UserManager sharedManager] didRequestClassMemberComplateTaskInfoWithWithDic:@{kWorkLogId:[weakSelf.infoDic objectForKey:kWorkLogId]} withNotifiedObject:weakSelf];
        }
    };
    
    self.userTableview.checkTaskBlock = ^(NSDictionary *infoDic, DoTaskType type) {
        weakSelf.selectProductInfo = infoDic;
        switch (type) {
            case DoTaskType_nomal:
            {
            }
                break;
            case DoTaskType_do:
            {
                MyTaskViewController * vc = [[MyTaskViewController alloc]init];
                vc.infoDic = infoDic;
                vc.bottomCollectionViewArray = [weakSelf getTaskList:[[UserManager sharedManager] getMyEveryDayTaskDetailList]];
                [weakSelf presentViewController:vc animated:NO completion:nil];
            }
                break;
            case DoTaskType_check:
            {
                
                if ([[infoDic objectForKey:kProductId] intValue] == 0) {
                    return ;
                }
                
                switch ([[infoDic objectForKey:@"type"] intValue]) {
                    case 3:
                    {
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
                    }
                        break;
                    case 4:
                    {
                        weakSelf.tasktype = TaskType_create;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
                    }
                        break;
                    case 5:
                    {
                        weakSelf.tasktype = TaskType_video;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
                
            default:
                break;
        }
        
        
    };
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableDataArray addObject:@{@"title":@"我的作业"}];
    [self.tableDataArray addObject:@{@"title":@"全班情况"}];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyEveryDayTaskDetailListWithWithDic:@{kWorkLogId:[self.infoDic objectForKey:kWorkLogId]} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestClassMemberComplateTaskInfoWithWithDic:@{kWorkLogId:[self.infoDic objectForKey:kWorkLogId]} withNotifiedObject:self];
}


- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.productType = ProductType_record;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestMyFriendProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.taskType = self.tasktype;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)moreAction
{
    
}

- (NSMutableAttributedString *)getTimeStr:(NSString *)string
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSDictionary * infoDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(0xffffff)};
    [mStr setAttributes:infoDic range:NSMakeRange(5, string.length - 5)];
    return mStr;
}

- (NSMutableAttributedString *)getTeacherStr:(NSString *)string
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSDictionary * infoDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(0xffffff)};
    [mStr setAttributes:infoDic range:NSMakeRange(4, string.length - 4)];
    return mStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
        if ([self.selectIndexPath isEqual:indexPath]) {
            [cell selectReset];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    switch (indexPath.row) {
        case 0:
            self.titleLB.text = @"我的作业详情";
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_MytaskComplateDetail];
            break;
        case 1:
            self.titleLB.text = @"全班作业完成情况";
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_classMemberTaskComplateDetail];
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - myTaskDetail delegate
- (void)didRequestMyEveryDayTaskDetailListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_MytaskComplateDetail];
}

- (void)didRequestMyEveryDayTaskDetailListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestclassMemberComplateTaskInfoSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_classMemberTaskComplateDetail];
}

- (void)didRequestclassMemberComplateTaskInfoFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (NSArray *)getTaskList:(NSArray *)dataArray1
{
    NSMutableArray * moArray = [NSMutableArray array];
    NSMutableArray * readArray = [NSMutableArray array];
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    NSMutableArray * videoArray = [NSMutableArray array];
    
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary * infoDic in dataArray1) {
        switch ([[infoDic objectForKey:@"type"] intValue]) {
            case 1:
            {
                [moArray addObject:infoDic];
            }
                break;
            case 2:
            {
                [readArray addObject:infoDic];
            }
                break;
            case 3:
            {
                [recordArray addObject:infoDic];
            }
                break;
            case 4:
            {
                [createArray addObject:infoDic];
            }
                break;
            case 5:
            {
                [videoArray addObject:infoDic];
            }
                break;
                
            default:
                break;
        }
    }
    
    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
    [moDic setObject:@(1) forKey:@"type"];
    [moDic setObject:moArray forKey:@"data"];
    
    [readDic setObject:@"阅读" forKey:@"typeStr"];
    [readDic setObject:@(2) forKey:@"type"];
    [readDic setObject:readArray forKey:@"data"];
    
    [recordDic setObject:@"录音" forKey:@"typeStr"];
    [recordDic setObject:@(3) forKey:@"type"];
    [recordDic setObject:recordArray forKey:@"data"];
    
    [createDic setObject:@"创作" forKey:@"typeStr"];
    [createDic setObject:@(4) forKey:@"type"];
    [createDic setObject:createArray forKey:@"data"];
    
    [videoDic setObject:@"视频" forKey:@"typeStr"];
    [videoDic setObject:@(5) forKey:@"type"];
    [videoDic setObject:videoArray forKey:@"data"];
    
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (moArray.count > 0) {
        [dataArray addObject:moDic];
    }
    if (readArray.count > 0) {
        [dataArray addObject:readDic];
    }
    if (recordArray.count > 0) {
        [dataArray addObject:recordDic];
    }
    if (createArray.count > 0) {
        [dataArray addObject:createDic];
    }
    if (videoArray.count > 0) {
        [dataArray addObject:videoDic];
    }
    
    
    return dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
