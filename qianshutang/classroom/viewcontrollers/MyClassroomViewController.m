//
//  MyClassroomViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyClassroomViewController.h"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "ClassroomDetailViewController.h"
#import "ClassroomMetarialViewController.h"
#import "SelectArrangeTaskStudentViewController.h"
#import "ArrangeTaskView.h"
#import "TeacherClassroomDetailViewController.h"
#import "CreatePrizeSelectStudentViewController.h"

@interface MyClassroomViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, Teacher_arrangeTask,UserModule_MyClassroomProtocol>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@end

@implementation MyClassroomViewController

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
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"我的班级";
    if (self.classroomType == MyClassroomType_Metarial) {
        self.titleLB.text = @"选择班级";
    }
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 5 - 0.5, kScreenWidth / 5 - 0.5 + 15);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColorFromRGBValue(240, 240, 240, 1);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[TeachingMaterailCollectionViewCell class] forCellWithReuseIdentifier:kTeachingMaterailCellID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kClassroomName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:kClassroomIcon] forKey:@"imagrUrl"];
    [cell resetWithInfoDic:infoDic];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.classroomType == MyClassroomType_Metarial) {
        ClassroomMetarialViewController * vc = [[ClassroomMetarialViewController alloc]init];
        vc.infoDic = self.collectionDataArray[indexPath.row];
        [self presentViewController:vc animated:NO completion:nil];
        return;
    }else if (self.classroomType == MyClassroomType_CreatePrize_selectStudent) {
        CreatePrizeSelectStudentViewController * vc = [[CreatePrizeSelectStudentViewController alloc]init];
        vc.haveSelectStudentArray = self.haveSelectStudentArray;
        vc.infoDic = self.collectionDataArray[indexPath.row];
        __weak typeof(self)weakSelf = self;
        vc.selectPrizeStudentBlock = ^(NSArray *array) {
            if (weakSelf.selectPrizeStudentBlock) {
                weakSelf.selectPrizeStudentBlock(array);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            });
        };
        
        [self presentViewController:vc animated:NO completion:nil];
        return;
    }
    else if (self.classroomType == MyClassroomType_arrangeTaskToStudent_Suitang || self.classroomType == MyClassroomType_arrangeTaskToStudent_Xilie)
    {
        SelectArrangeTaskStudentViewController * vc = [[SelectArrangeTaskStudentViewController alloc]init];
        NSMutableDictionary * classroomInfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.taskInfoDic];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomName]  forKey:@"classroomName"];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomId] forKey:kClassroomId];
        vc.taskInfoDic = classroomInfoDic;
        
        if (self.classroomType == MyClassroomType_arrangeTaskToStudent_Suitang) {
            vc.isXilie = NO;
        }else
        {
            vc.isXilie = YES;
        }
        
        [self presentViewController:vc animated:NO completion:nil];
        return;
    }else if(self.classroomType == MyClassroomType_arrangeTaskToClassroom_suitang)
    {
        NSMutableDictionary * classroomInfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.taskInfoDic];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomName]  forKey:@"classroomName"];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomId] forKey:kClassroomId];
        ArrangeTaskView * arrangeTaskView = [[ArrangeTaskView alloc]initWithFrame:self.view.bounds andTitle:@"布置作业到班级" andInfoDic:classroomInfoDic];
        [self.view addSubview:arrangeTaskView];
        __weak typeof(self)weakSelf = self;
        __weak typeof(arrangeTaskView)weakView = arrangeTaskView;
        
        arrangeTaskView.DismissBlock = ^{
            [weakView removeFromSuperview];;
        };
        arrangeTaskView.ContinueBlock = ^(NSDictionary * infoDic) {
            
            NSMutableDictionary *mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:[weakSelf.taskInfoDic objectForKey:kworkTempId] forKey:kworkTempId];
            [mInfo setObject:[classroomInfoDic objectForKey:kClassroomId] forKey:kClassroomId];
            [mInfo setObject:[infoDic objectForKey:@"name"] forKey:@"title"];
            [mInfo setObject:[infoDic objectForKey:@"startTime"] forKey:kbeginTime];
            [mInfo setObject:[infoDic objectForKey:@"endTime"] forKey:kendTime];
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_arrangeTaskWithWithDic:mInfo withNotifiedObject:weakSelf];
            [weakView removeFromSuperview];
        };
        return;
    }else if (self.classroomType == MyClassroomType_arrangeTaskToClassroom_Xilie)
    {
        NSMutableDictionary * classroomInfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.taskInfoDic];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomName]  forKey:@"classroomName"];
        [classroomInfoDic setObject:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomId] forKey:kClassroomId];
        ArrangeTaskView * arrangeTaskView = [[ArrangeTaskView alloc]initXilieWithFrame:self.view.bounds andTitle:@"布置作业到班级" andInfoDic:classroomInfoDic andIsStudent:NO];
        [arrangeTaskView resetOriginContinuTime:5];
        [self.view addSubview:arrangeTaskView];
        __weak typeof(self)weakSelf = self;
        __weak typeof(arrangeTaskView)weakView = arrangeTaskView;
        
        arrangeTaskView.DismissBlock = ^{
            [weakView removeFromSuperview];;
        };
        arrangeTaskView.ContinueBlock = ^(NSDictionary * infoDic) {
            
            NSMutableDictionary *mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:[weakSelf.taskInfoDic objectForKey:kworkTempId] forKey:kworkTempId];
            [mInfo setObject:[classroomInfoDic objectForKey:kClassroomId] forKey:kClassroomId];
            [mInfo setObject:[infoDic objectForKey:@"name"] forKey:@"title"];
            [mInfo setObject:[infoDic objectForKey:@"startTime"] forKey:kbeginTime];
            [mInfo setObject:[infoDic objectForKey:@"endTime"] forKey:kendTime];
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_arrangeTaskWithWithDic:mInfo withNotifiedObject:weakSelf];
            [weakView removeFromSuperview];
        };
        return;
    }
    
    NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        TeacherClassroomDetailViewController * vc = [[TeacherClassroomDetailViewController alloc]init];
        vc.infoDic = infoDic;
        [self presentViewController:vc  animated:NO completion:nil];
    }else
    {
        ClassroomDetailViewController * vc = [[ClassroomDetailViewController alloc]init];
        vc.infoDic = infoDic;
        [self presentViewController:vc  animated:NO completion:nil];
    }
}

- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    self.collectionDataArray = [[[UserManager sharedManager] getmyClassroom] mutableCopy];
    
    if (self.collectionDataArray.count == 0) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestMyClassroomInfoWithNotifiedObject:self];
    }
    
    return;
}

- (void)didRequestMyClassroomSuccessed
{
    [SVProgressHUD dismiss];
    self.collectionDataArray = [[[UserManager sharedManager] getmyClassroom] mutableCopy];
    [self.collectionView reloadData];
}

- (void)didRequestMyClassroomFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_arrangeTaskSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"布置作业成功，请在\"已布置作业\"页面查看"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_arrangeTaskFailed:(NSString *)failedInfo
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
