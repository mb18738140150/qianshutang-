//
//  CheckAndCommentViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/23.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CheckAndCommentViewController.h"
#import "UserCenterTableView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "CheckAndCommentTaskView.h"

@interface CheckAndCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)CheckAndCommentTaskView * userTableview;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UIButton * moreBtn;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * teacherLB;

@end

@implementation CheckAndCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    NSString * name = [self.infoDic objectForKey:@"taskName"];
    CGSize nameSize = [name boundingRectWithSize:CGSizeMake(leftView.hd_width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLB.frame) + 10, leftView.hd_width - 20, 18)];
    self.taskNameLB.textColor = [UIColor whiteColor];
    self.taskNameLB.text = [self.infoDic objectForKey:@"taskName"];
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
    self.timeLB.attributedText = [self getTimeStr:[NSString stringWithFormat:@"布置时间:\n%@", [self.infoDic objectForKey:@"time"]]];
    [leftView addSubview:self.timeLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.timeLB.frame), leftView.hd_width - 20, 50)];
    self.teacherLB.font = [UIFont systemFontOfSize:18];
    self.teacherLB.textColor = UIColorFromRGB(0x222222);
    self.teacherLB.numberOfLines = 0;
    self.teacherLB.attributedText = [self getTeacherStr:[NSString stringWithFormat:@"布置人:\n%@", [self.infoDic objectForKey:@"teacher"]]];
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
    
    self.userTableview = [[CheckAndCommentTaskView alloc]initWithFrame:self.backView.bounds];
    self.userTableview.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.backView addSubview:self.userTableview];
    
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableDataArray addObject:@{@"title":@"一键督促"}];
    [self.tableDataArray addObject:@{@"title":@"一键检查"}];
}

- (void)moreAction
{
#warning ********
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
           
            break;
        case 1:
            
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
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
