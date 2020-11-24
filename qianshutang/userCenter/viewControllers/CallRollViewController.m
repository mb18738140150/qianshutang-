//
//  CallRollViewController.m
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/5.
//  Copyright © 2018 mcb. All rights reserved.
//

#import "CallRollViewController.h"
#import "CallRollTableViewCell.h"
#define kCallRollCellID @"CallRollTableViewCellId"

@interface CallRollViewController ()<Teacher_sectionAttendance, UITableViewDelegate, UITableViewDataSource, Teacher_classroomSign, Teacher_sectionCallRoll>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * dataArray;

@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UILabel *totalLB;
@property (nonatomic, strong)UILabel *attendanceLB;
@property (nonatomic, strong)UILabel *leaveLB;
@property (nonatomic, strong)UILabel *absenteeismLB;
@property (nonatomic, strong)UIButton *classroomCallRollBtn;

@property (nonatomic, strong)NSDictionary * sectionInfo;

@end

@implementation CallRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
        self.navigationView.DismissBlock = ^{
        
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 200, 0, 400, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [NSString stringWithFormat:@"%@-点名页", [self.infoDic objectForKey:@"beginendTime"]];
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.88, kScreenWidth, kScreenHeight * 0.12)];
    self.bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:self.bottomView];
    
    self.totalLB = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth * 0.148, self.bottomView.hd_height)];
    self.totalLB.textColor = UIColorFromRGB(0x555555);
    self.totalLB.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.totalLB];
    
    self.attendanceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.totalLB.frame), 0, kScreenWidth * 0.124, self.bottomView.hd_height)];
    self.attendanceLB.textColor = UIColorFromRGB(0x555555);
    self.attendanceLB.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.attendanceLB];
    
    self.leaveLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.attendanceLB.frame), 0, kScreenWidth * 0.124, self.bottomView.hd_height)];
    self.leaveLB.textColor = UIColorFromRGB(0x555555);
    self.leaveLB.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.leaveLB];
    
    self.absenteeismLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leaveLB.frame), 0, kScreenWidth * 0.124, self.bottomView.hd_height)];
    self.absenteeismLB.textColor = UIColorFromRGB(0x555555);
    self.absenteeismLB.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.absenteeismLB];
    
    self.classroomCallRollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classroomCallRollBtn.frame = CGRectMake(kScreenWidth * 0.83, 5, kScreenWidth * 0.155, self.bottomView.hd_height - 10);
    [self.bottomView addSubview:self.classroomCallRollBtn];
    [self.classroomCallRollBtn setTitle:@"全班签到" forState:UIControlStateNormal];
    [self.classroomCallRollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.classroomCallRollBtn.backgroundColor = kMainColor;
    self.classroomCallRollBtn.layer.cornerRadius = 5;
    self.classroomCallRollBtn.layer.masksToBounds = YES;
    [self.classroomCallRollBtn addTarget:self action:@selector(classroomCallRollAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(8, self.navigationView.hd_height + 8, kScreenWidth - 16, kScreenHeight * 0.73 - 7) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CallRollTableViewCell class] forCellReuseIdentifier:kCallRollCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_sectionAttendanceWithWithDic:@{kunitId:[self.infoDic objectForKey:kunitId]} withNotifiedObject:self];
}

- (void)classroomCallRollAction
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_classroomSignWithWithDic:@{kunitId:[self.infoDic objectForKey:kunitId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_classroomSignSuccessed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"签到成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

- (void)didRequestTeacher_classroomSignFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

- (void)didRequestTeacher_sectionAttendanceSuccessed
{
    [SVProgressHUD dismiss];
    self.sectionInfo = [[UserManager sharedManager] getTeacherSectionAttendanceRecordInfo];
    [self refreshDataUI];
}

- (void)didRequestTeacher_sectionAttendanceFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}


- (void)didRequestTeacher_sectionCallRollSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_sectionAttendanceWithWithDic:@{kunitId:[self.infoDic objectForKey:kunitId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_sectionCallRollFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

- (void)refreshDataUI
{
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor_orange};
    NSString * totalStr = [NSString stringWithFormat:@"总人数：%@", [self.sectionInfo objectForKey:@"userNum"]];
    NSMutableAttributedString * mToyalStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总人数：%@", [self.sectionInfo objectForKey:@"userNum"]]];
    [mToyalStr setAttributes:attribute range:NSMakeRange(4, totalStr.length - 4)];
    self.totalLB.attributedText = mToyalStr;

    
    NSString * attendanceStr = [NSString stringWithFormat:@"出勤：%@", [self.sectionInfo objectForKey:@"chuNum"]];
    NSMutableAttributedString * mAttendanceStr = [[NSMutableAttributedString alloc]initWithString:attendanceStr];
    [mAttendanceStr setAttributes:attribute range:NSMakeRange(3, attendanceStr.length - 3)];
    self.attendanceLB.attributedText = mAttendanceStr;

    
    NSString * leaveStr = [NSString stringWithFormat:@"请假：%@", [self.sectionInfo objectForKey:@"jiaNum"]];
    NSMutableAttributedString * mLeaveStr = [[NSMutableAttributedString alloc]initWithString:leaveStr];
    [mLeaveStr setAttributes:attribute range:NSMakeRange(3, leaveStr.length - 3)];
    self.leaveLB.attributedText = mLeaveStr;

    
    NSString * absenteeismStr = [NSString stringWithFormat:@"旷课：%@", [self.sectionInfo objectForKey:@"kuangNum"]];
    NSMutableAttributedString * mAbsenteeismStr = [[NSMutableAttributedString alloc]initWithString:absenteeismStr];
    [mAbsenteeismStr setAttributes:attribute range:NSMakeRange(3, absenteeismStr.length - 3)];
    self.absenteeismLB.attributedText = mAbsenteeismStr;

    self.dataArray = [self.sectionInfo objectForKey:@"data"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    CallRollTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCallRollCellID forIndexPath:indexPath];
    [cell refreshWith:self.dataArray[indexPath.row]];
    cell.callRollBlock = ^(NSDictionary *infoDic) {
        NSLog(@"%@", infoDic);
        [weakSelf showCallRollView:infoDic];
        
    };
    return cell;
}

- (void)showCallRollView:(NSDictionary *)infoDic
{
    ToolTipView * toolTipView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_ModifyAttendance andTitle:@"修改出勤状态" withAnimation:NO];
    [toolTipView resetAttendanceView:infoDic];
    [self.view addSubview:toolTipView];
    __weak typeof(toolTipView)weakView = toolTipView  ;
    toolTipView.ContinueBlock = ^(NSString *str) {
        NSArray * stateArray = [str componentsSeparatedByString:@"-???"];
        NSString * intro = @"";
        if (stateArray.count >2) {
            intro = [stateArray objectAtIndex:2];
        }
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_sectionCallRollWithWithDic:@{kLogId:[infoDic objectForKey:kLogId],kState:@([stateArray[0] intValue]),kCost:@([stateArray[1] intValue]),@"intro":intro} withNotifiedObject:self];
        
        [weakView removeFromSuperview];
    };
    toolTipView.DismissBlock = ^{
        ;[weakView removeFromSuperview];
    };
}


 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
    NSString * str = [NSString stringWithFormat:@"状态：%@\n\n操作人：%@\n\n备注信息：(无)", [infoDic objectForKey:@"state"], [self.infoDic objectForKey:kTeacherName]];
    
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_callroll andTitle:@"备注信息" withAnimation:NO];
    [toolView resetContentLbTetx:str];
    [self.view addSubview:toolView];
    __weak typeof(toolView)weakView = toolView  ;
    toolView.ContinueBlock = ^(NSString *str) {
        [weakView removeFromSuperview];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.146;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"学员"];
    [view addSubview:titleLB];
    
    UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"出勤状态"];
    [view addSubview:nameLB];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(nameLB.hd_centerX + 37, nameLB.hd_centerY - 8, 16, 16)];
    imageView.image = [UIImage imageNamed:@"icon_material_help"];
    [view addSubview:imageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(explainAction)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"课耗"];
    [view addSubview:timeLB];
    
    UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"操作"];
    [view addSubview:detailLB];    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [view addSubview:bottomView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)explainAction
{
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_callroll andTitle:@"提示" withAnimation:NO];
    [self.view addSubview:toolView];
    __weak typeof(toolView)weakView = toolView  ;
    toolView.ContinueBlock = ^(NSString *str) {
        [weakView removeFromSuperview];
    };
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
