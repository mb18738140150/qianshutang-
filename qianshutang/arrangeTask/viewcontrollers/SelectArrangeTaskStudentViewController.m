//
//  SelectArrangeTaskStudentViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SelectArrangeTaskStudentViewController.h"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "ArrangeTaskView.h"

@interface SelectArrangeTaskStudentViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MyClassroom_classMember>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)NSMutableArray * selectArray;

@property (nonatomic, strong)UIButton *complateBtn;

@end

@implementation SelectArrangeTaskStudentViewController

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

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
    self.titleLB.text = @"选择学员";
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
    
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(kScreenWidth  - 16 - self.navigationView.hd_height + 10, 5, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
    [self.complateBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kUserName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:@"userIconUrl"] forKey:@"imagrUrl"];
    
    [cell resetWithInfoDic:infoDic];
    BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
    if (isHaveInfo) {
        [cell haveCollect];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDIc = self.collectionDataArray[indexPath.item];
    
    BOOL isHaveInfo = [self isHaveInfoDic:infoDIc];
    if (isHaveInfo) {
        [self.selectArray removeObject:infoDIc];
    }else
    {
        [self.selectArray addObject:infoDIc];
    }
    
    [collectionView reloadData];
}

- (BOOL)isHaveInfoDic:(NSDictionary *)infoDIc
{
    BOOL isHaveInfo = NO;
    for (NSDictionary * selectInfo in self.selectArray) {
        if ([[infoDIc objectForKey:kUserId]isEqual:[selectInfo objectForKey:kUserId]]) {
            isHaveInfo = YES;
        }
    }
    if (isHaveInfo) {
        return YES;
    }else
    {
        return NO;
    }
}
- (void)complateAction
{
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.taskInfoDic];
    
    if (self.isXilie) {
        ArrangeTaskView * arrangeTaskView = [[ArrangeTaskView alloc]initXilieWithFrame:self.view.bounds andTitle:@"布置作业给学员" andInfoDic:infoDic andIsStudent:YES];
        [self.view addSubview:arrangeTaskView];
        __weak typeof(arrangeTaskView)weakView = arrangeTaskView;
        arrangeTaskView.DismissBlock = ^{
            [weakView removeFromSuperview];
        };
        arrangeTaskView.ContinueBlock = ^(NSDictionary * infoDic) {
            [weakView removeFromSuperview];
        };
    }else
    {
        ArrangeTaskView * arrangeTaskView = [[ArrangeTaskView alloc]initWithFrame:self.view.bounds andTitle:@"布置作业给学员" andInfoDic:infoDic andIsStudent:YES];
        [self.view addSubview:arrangeTaskView];
        __weak typeof(arrangeTaskView)weakView = arrangeTaskView;
        arrangeTaskView.DismissBlock = ^{
            [weakView removeFromSuperview];
        };
        arrangeTaskView.ContinueBlock = ^(NSDictionary * infoDic) {
            [weakView removeFromSuperview];
        };
    }
    
}

- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberWithWithDic:@{kClassroomId:[self.taskInfoDic objectForKey:kClassroomId], kUserName:@""} withNotifiedObject:self];
}
- (void)didRequestclassMemberSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.collectionDataArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyClassmemberList]) {
        if ([[infoDic objectForKey:@"isTeacher"] intValue] == 1) {
            
        }else
        {
            [self.collectionDataArray addObject:infoDic];
        }
    }
    
    [self.collectionView reloadData];
}

- (void)didRequestclassMemberFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
