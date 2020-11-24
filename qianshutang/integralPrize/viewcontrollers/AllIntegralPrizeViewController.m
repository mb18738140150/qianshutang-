//
//  AllIntegralPrizeViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AllIntegralPrizeViewController.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "PrizeCollectionViewCell.h"
#define kPrizeCollectionCellID @"PrizeCollectionViewCell"
#import "TeacherPrizeDetailViewController.h"

@interface AllIntegralPrizeViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,Integral_PrizeList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, assign)BOOL isHaveConversion;

@end

@implementation AllIntegralPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     __weak typeof(self)weakSelf = self;
    
    [self loadData];
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"上架奖品";
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.backgroundColor = kMainColor;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 8, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.backView.hd_width / 3 - 0.5, kScreenHeight * 0.5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.backView.bounds collectionViewLayout:layout];
    [self.backView addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[PrizeCollectionViewCell class] forCellWithReuseIdentifier:kPrizeCollectionCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    [cell resetWithInfoDic:self.dataArray[indexPath.row]];
    if ([self.selectIndexPath isEqual:indexPath]) {
        [cell selectReset];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    if (indexPath.row == 0) {
        self.titleLB.text = @"上架奖品";
        [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@1} withNotifiedObject:self];
    }else
    {
        self.titleLB.text = @"未上架奖品";
        [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@0} withNotifiedObject:self];
    }
    [self.tableview reloadData];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PrizeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrizeCollectionCellID forIndexPath:indexPath];
    cell.isHaveConversion = YES;
    [cell refreshWith:self.collectionDataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    
    if (self.selectIndexPath.row == 0) {
        if (self.selectPrizeBlock) {
            self.selectPrizeBlock(infoDic);
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
  
    [self.dataArray addObject:@{@"title":@"上架奖品"}];
    [self.dataArray addObject:@{@"title":@"未上架奖品"}];
    
    self.collectionDataArray = [NSMutableArray array];
    [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@1} withNotifiedObject:self];
}

- (void)didRequestPrizeListSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.collectionDataArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getPrizeList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:@"prizeIntegral"] forKey:@"integral"];
        [mInfo setObject:[infoDic objectForKey:kPrizeName] forKey:@"title"];
        [self.collectionDataArray addObject:mInfo];
    }
    
    [self.collectionView reloadData];
}

- (void)didRequestPrizeListFailed:(NSString *)failedInfo
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
