//
//  ClassroomAttendanceListViewController.m
//  qianshutang
//
//  Created by aaa on 2018/10/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomAttendanceListViewController.h"
#import "XilieTaskYulanSelectDayView.h"
#import "ClassroomAttendanceListView.h"
#import "ClassroomAttendanceListTableViewCell.h"
#define kClassroomAttendanceListTableViewCellId @"ClassroomAttendanceListTableViewCellId"

@interface ClassroomAttendanceListViewController ()<Teacher_classroomAttendanceList, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)XilieTaskYulanSelectDayView * selectDayView;
@property (nonatomic, strong)NSArray * allTaskArray;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)ClassroomAttendanceListView * classroomAttendanceListView;

@property (nonatomic, strong)NSMutableArray * pageSectionArray;
@property (nonatomic, strong)NSMutableDictionary * titleInfoDic;

@property (nonatomic, assign)int currentPage;

@end

@implementation ClassroomAttendanceListViewController
- (NSMutableArray *)pageSectionArray
{
    if (!_pageSectionArray) {
        _pageSectionArray = [NSMutableArray array];
    }
    return _pageSectionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self loadData];
    self.allTaskArray = [[UserManager sharedManager] getTeacher_classroomAttendanceArray];
    [self loadsectionData:0];
    [self addNavigationView];
    [self prepareUI];
    
}

- (void)addNavigationView
{
    self.view.backgroundColor = UIRGBColor(239, 239, 239);
    __weak typeof(self)weakSelf = self;
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.selectDayView = [[XilieTaskYulanSelectDayView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - ((self.navigationView.hd_height + 5) * 7 + 80) / 2, 0, (self.navigationView.hd_height + 5) * 7 + 80, self.navigationView.hd_height)];
    NSDictionary * infoDic = [self.allTaskArray firstObject];
    NSArray * array = [infoDic objectForKey:@"unitList"];
    
    int totalPage = 0;
    if (array.count % 9) {
        totalPage = array.count / 9 + 1;
    }else{
        totalPage = array.count / 9;
    }
    
    [self.selectDayView resetTaskCount:totalPage];
    self.selectDayView.SelectDayBlock = ^(int day) {
        [weakSelf loadsectionData:day];
        [weakSelf.classroomAttendanceListView refreshUIWith:weakSelf.titleInfoDic andDataArray:weakSelf.pageSectionArray andPage:day];
        [weakSelf.tableView reloadData];
    };
    [self.view addSubview:self.selectDayView];
}

- (void)prepareUI
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(8, self.navigationView.hd_height + 8, kScreenWidth - 16, kScreenHeight - 8 - self.navigationView.hd_height)];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:self.backView];
    
    self.classroomAttendanceListView = [[ClassroomAttendanceListView alloc]initWithFrame:CGRectMake(0, 0, self.backView.hd_width, 50)];
    [self.backView addSubview:self.classroomAttendanceListView];
    [self.classroomAttendanceListView refreshUIWith:self.titleInfoDic andDataArray:self.pageSectionArray andPage:0];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.classroomAttendanceListView.hd_height, self.backView.hd_width, self.backView.hd_height - self.classroomAttendanceListView.hd_height) style:UITableViewStylePlain];
    [self.tableView registerClass:[ClassroomAttendanceListTableViewCell class] forCellReuseIdentifier:kClassroomAttendanceListTableViewCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.backView addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTaskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomAttendanceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kClassroomAttendanceListTableViewCellId forIndexPath:indexPath];
    NSDictionary * infoDic = [self.allTaskArray objectAtIndex:indexPath.row];
    [cell resetWithInfo:infoDic andPage:self.currentPage];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)loadsectionData:(int)page
{
    self.currentPage = page;
    
    if ((page + 1) * 9 <= self.pageSectionArray.count) {
        return;
    }
    
//    [self.pageSectionArray removeAllObjects];
    for (int i = page * 9; i < (page + 1) * 9; i++) {
        NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
        [infoDic setObject:@100 forKey:@"state"];
        [infoDic setObject:[NSString stringWithFormat:@"第%d节", i + 1] forKey:kUnitName];
        [self.pageSectionArray addObject:infoDic];
    }
    self.titleInfoDic = [NSMutableDictionary dictionary];
    [self.titleInfoDic setObject:@"学员" forKey:kUserName];
    [self.titleInfoDic setObject:self.pageSectionArray forKey:@"unitList"];
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_classroomAttendanceListWithDic:@{kchapterId:[self.infoDic objectForKey:kchapterId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_classroomAttendanceListSuccessed
{
    [SVProgressHUD dismiss];
    self.allTaskArray = [[UserManager sharedManager] getTeacher_classroomAttendanceArray];
    [self.tableView reloadData];
}

- (void)didRequestTeacher_classroomAttendanceListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
