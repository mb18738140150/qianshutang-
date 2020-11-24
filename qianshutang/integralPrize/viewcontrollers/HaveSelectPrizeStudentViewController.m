//
//  HaveSelectPrizeStudentViewController.m
//  qianshutang
//
//  Created by aaa on 2018/10/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "HaveSelectPrizeStudentViewController.h"
#import "MyClassroomViewController.h"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "StudentInformationViewController.h"
#import "Teacher_StudentInformationViewController.h"

#define kCellID @"cellID"

@interface HaveSelectPrizeStudentViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UIButton * selectAllBtn;
@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)NSMutableArray * deleteSelectPeizeStudentArray;

@end

@implementation HaveSelectPrizeStudentViewController

- (NSMutableArray *)deleteSelectPeizeStudentArray
{
    if (!_deleteSelectPeizeStudentArray) {
        _deleteSelectPeizeStudentArray = [NSMutableArray array];
    }
    return _deleteSelectPeizeStudentArray;
}

- (NSMutableArray *)collectionDataArray
{
    if (!_collectionDataArray) {
        _collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionDataArray = [self.haveSelectStudentArray mutableCopy];
    
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_none];
    self.navigationView.DismissBlock = ^{
        
        if (weakSelf.selectPrizeStudentBlock) {
            weakSelf.selectPrizeStudentBlock(weakSelf.collectionDataArray);
        }
        
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.text = @"已选兑奖人";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView addSubview:self.titleLB];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.rightView.hd_height + 10, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectAllBtn.backgroundColor = kMainColor;
    self.selectAllBtn.layer.cornerRadius = self.selectAllBtn.hd_height / 2;
    self.selectAllBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.selectAllBtn];
    [self.selectAllBtn addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.selectAllBtn.hd_x - 16 - self.navigationView.rightView.hd_height + 10 , 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = kMainColor;
    self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID];
}

- (void)deleteAction
{
    for (NSDictionary * infoDic in self.deleteSelectPeizeStudentArray) {
        if ([self.collectionDataArray containsObject:infoDic]) {
            [self.collectionDataArray removeObject:infoDic];
        };
    }
    [self.collectionView reloadData];
}

- (void)selectAllAction
{
    [self.deleteSelectPeizeStudentArray removeAllObjects];
    for (NSDictionary * infoDic in self.collectionDataArray) {
        [self.deleteSelectPeizeStudentArray addObject:infoDic];
    }
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.collectionDataArray.count) {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
        
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(cell.hd_width * 0.05, 5, cell.hd_width * 0.8, cell.hd_height - 5)];
        backView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:backView];
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = YES;
        
        UIImageView * addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.hd_width / 4, backView.hd_width / 4, backView.hd_width / 2, backView.hd_width / 2)];
        addImageView.image = [UIImage imageNamed:@"addPeizeStudent"];
        [backView addSubview:addImageView];
        
        return cell;
    }
    
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kUserName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:@"userIconUrl"] forKey:@"imagrUrl"];
    
    cell.isTeacher = NO;
    [cell resetWithInfoDic:infoDic];
    
    for (NSDictionary * selectInfoDic in self.deleteSelectPeizeStudentArray) {
        if ([[selectInfoDic objectForKey:kUserId] isEqual:[infoDic objectForKey:kUserId]]) {
            [cell shareSelectReset];
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
    if (indexPath.row == self.collectionDataArray.count) {
        __weak typeof(self)weakSelf = self;
        MyClassroomViewController * classroomVC = [[MyClassroomViewController alloc]init];
        classroomVC.classroomType = MyClassroomType_CreatePrize_selectStudent;
        classroomVC.haveSelectStudentArray = self.collectionDataArray;
        classroomVC.selectPrizeStudentBlock = ^(NSArray *array) {
            [weakSelf resetHaveSelectArrayWith:array];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.015 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            });
        };
        [self presentViewController:classroomVC animated:NO completion:nil];
        return;
    }
    
    NSDictionary *infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    if ([self.deleteSelectPeizeStudentArray containsObject:infoDic]) {
        [self.deleteSelectPeizeStudentArray removeObject:infoDic];
    }else
    {
        [self.deleteSelectPeizeStudentArray addObject:infoDic];
    }
    
    [self.collectionView reloadData];
}

- (void)resetHaveSelectArrayWith:(NSArray *)array
{
    for (NSDictionary * infoDic in array) {
        [self.collectionDataArray addObject:infoDic];
    }
    [self.collectionView reloadData];
    if (self.selectPrizeStudentBlock) {
        self.selectPrizeStudentBlock(self.collectionDataArray);
    }
    
}

@end
