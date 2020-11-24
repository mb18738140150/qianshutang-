//
//  CommonQuestionViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommonQuestionViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "CommonQuestionDetailViewController.h"

@interface CommonQuestionViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UserData_MyQuestionlist, UserData_SetaHaveReadQuestion>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@end

@implementation CommonQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestSetaHaveReadQuestionWithWithDic:@{kHeadQuestionId:[weakSelf.infoDic objectForKey:kHeadQuestionId]} withNotifiedObject:weakSelf];
    };
    
    [self.view addSubview:self.navigationView];
    [self.navigationView refreshWith:userCenterItemType_haveRead];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.text = @"常见问题";
    self.titleLB.font = [UIFont systemFontOfSize:22];
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

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    
    [self.tableDataArray addObject:@{@"title":@"常见问题"}];
    [SVProgressHUD show];
    self.collectionDataArray = [NSMutableArray array];
    [[UserManager sharedManager] didRequestMyQuestionListWithWithDic:@{kHeadQuestionId:[self.infoDic objectForKey:kHeadQuestionId]} withNotifiedObject:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    [cell resetWithInfoDic:infoDic];
    if ([[infoDic objectForKey:@"isRead"] intValue] == 0) {
        [cell showContentNumberWith:-1];
    }else
    {
        [cell showContentNumberWith:0];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.backView.hd_width / 4  - 0.5, self.backView.hd_width / 4  + 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommonQuestionDetailViewController * vc = [[CommonQuestionDetailViewController alloc]init];
    NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    [infoDic setValue:@(1) forKey:@"isRead"];
    [self.collectionView reloadData];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyQuestionlistSuccessed
{
    [SVProgressHUD dismiss];
    
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyQuestionArray]) {
        NSMutableDictionary * mDic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mDic setObject:[infoDic objectForKey:kQuestionName] forKey:@"title"];
        [self.collectionDataArray addObject:mDic];
    }
    [self.collectionView reloadData];
}

- (void)didRequestMyQuestionlistFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSetaHaveReadQuestionSuccessed
{
    [[UserManager sharedManager] didRequestMyQuestionListWithWithDic:@{kHeadQuestionId:[self.infoDic objectForKey:kHeadQuestionId]} withNotifiedObject:self];
}

- (void)didRequestSetaHaveReadQuestionFailed:(NSString *)failedInfo
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
