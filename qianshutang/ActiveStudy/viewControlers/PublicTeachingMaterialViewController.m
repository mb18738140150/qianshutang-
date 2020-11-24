//
//  PublicTeachingMaterialViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PublicTeachingMaterialViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "TextbookDetailViewController.h"
#import "PlayVideoViewController.h"

@interface PublicTeachingMaterialViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, ActiveStudy_ReadList, ActiveStudy_SearchReadList, ActiveStudy_CollectTextBook, ActiveStudy_TextBookContentList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;
@property (nonatomic, assign)BOOL isCollect;

@property (nonatomic, assign)BOOL isSearch;

@property (nonatomic, strong)NSMutableArray * textBookSelectArray;
@property (nonatomic, strong)NSDictionary * currentInfoDic;// 当前选中收藏课本
@property (nonatomic, strong)ToolTipView * recordShotTipView;// 收藏提示

@property (nonatomic, strong)NSDictionary * currentSelectPlayTextbook;// 当前选中课本

@end

@implementation PublicTeachingMaterialViewController

- (NSMutableArray *)textBookSelectArray
{
    if (!_textBookSelectArray) {
        _textBookSelectArray = [NSMutableArray array];
    }
    return _textBookSelectArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadData];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_searchAndCollect];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.searchBlock = ^(BOOL isSearch){
        if (isSearch) {
            [weakSelf searchMember];
        }else
        {
            weakSelf.isSearch = NO;
            [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
            if (weakSelf.tableDataArray.count > 0) {
                [weakSelf reloadCollectionDataArray:[weakSelf.tableDataArray[weakSelf.categoryselectIndepath.row] objectForKey:@"itemList"]];
                [weakSelf.collectionView reloadData];
            }else
            {
                [[UserManager sharedManager] didRequestReadListWithWithDic:@{} withNotifiedObject:weakSelf];
            }
        }
    };
    self.navigationView.collectCourseBlock = ^{
        if (weakSelf.isCollect) {
            weakSelf.isCollect = NO;
        }else
        {
            weakSelf.isCollect = YES;
        }
        [weakSelf.collectionView reloadData];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.tableView.hd_width, self.tableView.hd_y, kScreenWidth * 0.8, kScreenHeight * 0.85) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TeachingMaterailCollectionViewCell class] forCellWithReuseIdentifier:kTeachingMaterailCellID];
    
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    
    self.collectionDataArray = [NSMutableArray array];
    
    self.categoryselectIndepath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestReadListWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestReadListSuccessed
{
    [SVProgressHUD dismiss];
    self.tableDataArray = [[[UserManager sharedManager] getReadArray] mutableCopy];
    if (self.tableDataArray.count > 0) {
        [self reloadCollectionDataArray:[self.tableDataArray[self.categoryselectIndepath.row] objectForKey:@"itemList"]];
    }
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)didRequestReadListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
#pragma mark - searchTextbook
- (void)searchMember
{
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_tf andTitle:@"" andPlaceHold:@"请输入课本名称" withAnimation:NO];
    __weak typeof(toolView)weakToolView = toolView;
    [self.view addSubview:toolView];
    toolView.TextBlock = ^(NSString *text) {
        if (text.length == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
        [SVProgressHUD show];
        weakSelf.isSearch = YES;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        if (weakSelf.tableDataArray.count > 0) {
            [[UserManager sharedManager] didRequestSearchReadListWithWithDic:@{kcategoryId:[self.tableDataArray[self.categoryselectIndepath.row] objectForKey:kcategoryId], kitemName:text} withNotifiedObject:weakSelf];
        }
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        weakSelf.isSearch = NO;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        [weakToolView removeFromSuperview];
    };
}

- (void)didRequestSearchReadListSuccessed
{
    [SVProgressHUD dismiss];
    NSArray * searchList = [NSArray array];
    if ([[UserManager sharedManager] getSearchReadArray].count > 0) {
        searchList = [[[UserManager sharedManager] getSearchReadArray][0] objectForKey:@"itemList"];
    }
    
    [self reloadCollectionDataArray:searchList];
    [self.collectionView reloadData];
}

- (void)reloadCollectionDataArray:(NSArray *)dataArray
{
    if ([dataArray class] == [NSNull class]) {
        return;
    }
    
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in dataArray) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:@"itemType"] forKey:@"type"];
        [mInfo setObject:[infoDic objectForKey:@"itemName"] forKey:@"title"];
        [mInfo setObject:[infoDic objectForKey:@"itemImageUrl"] forKey:@"imagrUrl"];
        [array addObject:mInfo];
    }
    self.collectionDataArray = array;
}

- (void)didRequestSearchReadListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.tableDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kcategoryName] forKey:@"title"];
    [cell resetWithInfoDic:infoDic];
    if ([indexPath isEqual:self.categoryselectIndepath]) {
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
    if ([self.categoryselectIndepath isEqual:indexPath]) {
        
        return;
    }
    
    if (self.isSearch) {
        self.isSearch = NO;
        [self.navigationView refreshSearchBtnWith:self.isSearch];
    }
    
    self.isCollect = NO;
    [self.textBookSelectArray removeAllObjects];
    self.categoryselectIndepath = indexPath;
    [self.navigationView showSearch];
    
    [self reloadCollectionDataArray:[self.tableDataArray[indexPath.row] objectForKey:@"itemList"]];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
    [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
    if (self.isCollect) {
        BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
        if (isHaveInfo) {
            [cell haveCollect];
        }else
        {
            [cell selectReset];
        }
    }
    
    cell.videoBlock = ^(NSDictionary *infoDic) {
        PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
        playVC.infoDic = infoDic;
        [weakSelf presentViewController:playVC animated:NO completion:nil];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDIc = self.collectionDataArray[indexPath.item];
    
    if (self.isCollect) {
        self.currentInfoDic = infoDIc;
        BOOL isHaveInfo = [self isHaveInfoDic:infoDIc];
        if (isHaveInfo) {
            
            [SVProgressHUD showInfoWithStatus:@"已收藏"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else
        {
            __weak typeof(self)weakSelf = self;
            self.recordShotTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"收藏课本" withAnimation:YES];
            [self.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"将%@加入我的收藏?", [infoDIc objectForKey:kitemName]]];
            [self.view addSubview:self.recordShotTipView];
            self.recordShotTipView.DismissBlock = ^{
                [weakSelf.recordShotTipView removeFromSuperview];
            };
            self.recordShotTipView.ContinueBlock = ^(NSString *str) {
                [weakSelf.recordShotTipView removeFromSuperview];
                weakSelf.recordShotTipView = nil;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestCollectTextBookWithWithDic:@{kitemId:[infoDIc objectForKey:kitemId], kitemType:[infoDIc objectForKey:kitemType]} withNotifiedObject:weakSelf];
            };
            
        }
        [collectionView reloadData];
        
        return;
    }
    self.currentSelectPlayTextbook = infoDIc;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDIc objectForKey:kitemId]} withNotifiedObject:self];
}

- (void)didRequestTextBookContentListSuccessed
{
    [SVProgressHUD dismiss];
    TextbookDetailViewController * vc = [[TextbookDetailViewController alloc]init];
    
    vc.infoDic = self.currentSelectPlayTextbook;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTextBookContentListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (BOOL)isHaveInfoDic:(NSDictionary *)infoDIc
{
    BOOL isHaveInfo = NO;
    for (NSDictionary * selectInfo in self.textBookSelectArray) {
        if ([[infoDIc objectForKey:kitemId]isEqual:[selectInfo objectForKey:kitemId]]) {
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

- (void)didRequestCollectTextBookSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    [self.textBookSelectArray addObject:self.currentInfoDic];
    [self.collectionView reloadData];
}

- (void)didRequestCollectTextBookFailed:(NSString *)failedInfo
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
