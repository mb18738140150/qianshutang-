//
//  CreatePrizeSelectStudentViewController.m
//  qianshutang
//
//  Created by aaa on 2018/10/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreatePrizeSelectStudentViewController.h"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "StudentInformationViewController.h"
#import "Teacher_StudentInformationViewController.h"
@interface CreatePrizeSelectStudentViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyClassroom_classMember>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)NSMutableArray * selectPeizeStudentArray;

@end

@implementation CreatePrizeSelectStudentViewController

- (NSMutableArray *)selectPeizeStudentArray
{
    if (!_selectPeizeStudentArray) {
        _selectPeizeStudentArray = [NSMutableArray array];
    }
    return _selectPeizeStudentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.text = @"班级成员";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView addSubview:self.titleLB];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.rightView.hd_height + 10, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    self.complateBtn.enabled = NO;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height , kScreenWidth, kScreenHeight* 0.85)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIRGBColor(240, 240, 240);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.backView.bounds collectionViewLayout:layout];
    [self.backView addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TeachingMaterailCollectionViewCell class] forCellWithReuseIdentifier:kTeachingMaterailCellID];
    
}

- (void)complateAction
{
    if (self.selectPrizeStudentBlock) {
        self.selectPrizeStudentBlock(self.selectPeizeStudentArray);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)refreshComplateBtnState
{
    if (self.selectPeizeStudentArray.count > 0) {
        self.complateBtn.enabled = YES;
    }
    else
    {
        self.complateBtn.enabled = NO;
    }
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
    
    cell.isTeacher = NO;
    [cell resetWithInfoDic:infoDic];
    
    for (NSDictionary * haveInfoDic in self.haveSelectStudentArray) {
        if ([[haveInfoDic objectForKey:kUserId] isEqual:[infoDic objectForKey:kUserId]]) {
            [cell selectReset];
        }
    }
    
    for (NSDictionary * selectInfoDic in self.selectPeizeStudentArray) {
        if ([[selectInfoDic objectForKey:kUserId] isEqual:[infoDic objectForKey:kUserId]]) {
            [cell selectReset];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.backView.hd_width / 5 - 0.5, self.backView.hd_width / 5  + 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    [self.selectPeizeStudentArray addObject:infoDic];
    if (self.selectPrizeStudentBlock) {
        self.selectPrizeStudentBlock(self.selectPeizeStudentArray);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    return;
    
    for (NSDictionary * haveInfoDic in self.haveSelectStudentArray) {
        if ([[haveInfoDic objectForKey:kUserId] isEqual:[infoDic objectForKey:kUserId]]) {
            return;
        }
    }
    
    if ([self.selectPeizeStudentArray containsObject:infoDic]) {
        [self.selectPeizeStudentArray removeObject:infoDic];
    }else
    {
        [self.selectPeizeStudentArray addObject:infoDic];
    }
    
    [self.collectionView reloadData];
    [self refreshComplateBtnState];
}


- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId], kUserName:@""} withNotifiedObject:self];
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


@end
