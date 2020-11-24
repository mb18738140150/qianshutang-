//
//  AddMusicCategoryViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddMusicCategoryViewController.h"
#import "NavigationView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "HYSegmentedControl.h"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "StartCollectionViewCell.h"
#define kStartCellID   @"startCellID"

#import "AddMusicViewController.h"
#import "ClassTextBookView.h"
typedef enum : NSUInteger {
    CollectionType_nomal,
    CollectionType_start,
} CollectionType;

@interface AddMusicCategoryViewController ()<UITableViewDelegate, UITableViewDataSource,HYSegmentedControlDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource, ActiveStudy_ReadList, ActiveStudy_SearchReadList,MyStudy_MyProduct,ProductShow_ProductShowList, UserData_MyCollectiontextBook>

@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)NavigationView * navigationView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSMutableArray * readArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;// 左部导航当前选中indexpath

@property (nonatomic, strong)PopListView * popListView;
@property (nonatomic, strong)NSIndexPath * popListIndexPath;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;
@property (nonatomic, assign)CollectionType collectionType;

@property (nonatomic, strong)UILabel * titleLB;
//@property (nonatomic, strong)HYSegmentedControl * classroomHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl * productHySegmentControl;

@property (nonatomic, assign)BOOL isSearch;// 是否搜索
@property (nonatomic, strong)ClassTextBookView * classroomMemberproductView;

@property (nonatomic, strong)NSMutableArray * textBookSelectArray;// 录音作品已选数组
@property (nonatomic, strong)ToolTipView * recordShotTipView;

@end

@implementation AddMusicCategoryViewController

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
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_search];
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
            if (weakSelf.readArray.count > 0) {
                [weakSelf reloadCollectionDataArray:[weakSelf.readArray[weakSelf.popListIndexPath.row] objectForKey:@"itemList"]];
            }else
            {
                [[UserManager sharedManager] didRequestReadListWithWithDic:@{} withNotifiedObject:weakSelf];
            }
        }
    };
    self.navigationView.complateBlock = ^{
        if (weakSelf.textBookSelectArray.count >0) {
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            if (weakSelf.complateBlock) {
                weakSelf.complateBlock(weakSelf.textBookSelectArray);
            }
        }
    };
    self.navigationView.SelectAllBlock = ^{
        [weakSelf.textBookSelectArray removeAllObjects];
        for (NSDictionary * infoDic in weakSelf.collectionDataArray) {
            if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
                // 单视频
            }else
            {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                [mInfo setObject:[infoDic objectForKey:kProductName] forKey:kpartName];
                [mInfo setObject:[infoDic objectForKey:kProductId] forKey:kpartId];
                [weakSelf.textBookSelectArray addObject:infoDic];
                [weakSelf.collectionView reloadData];
            }
        }
        [weakSelf.collectionView reloadData];
    };
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    
    self.productHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"我的作品",@"明星作品",@"老师的讲解"] delegate:self];
    [self.productHySegmentControl hideBottomView];
    [self.productHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.productHySegmentControl];
    self.productHySegmentControl.hidden = YES;
    self.productHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.productHySegmentControl]) {
            
            if (index == 1) {
                weakSelf.collectionType = CollectionType_start;
                [weakSelf.collectionView reloadData];
                [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(5),kselType:@(0), kClassroomId:@(0)} withNotifiedObject:weakSelf];
            }else if(index == 0)
            {
                weakSelf.collectionType = CollectionType_nomal;
                [weakSelf.collectionView reloadData];
                [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:weakSelf];
            }else
            {
                weakSelf.collectionType = CollectionType_nomal;
                [weakSelf.collectionView reloadData];
                [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(6),kselType:@(0), kClassroomId:@(0)} withNotifiedObject:weakSelf];
            }
            
        }
    };
    
    self.categoryselectIndepath = nil;
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
    [self.collectionView registerClass:[StartCollectionViewCell class] forCellWithReuseIdentifier:kStartCellID];
    
}

- (void)requestRecordProduct
{
    int index = self.productHySegmentControl.selectIndex;
    if (index == 1) {
        [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(5),kselType:@(0), kClassroomId:@(0)} withNotifiedObject:self];
    }else if(index == 0)
    {
        [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(6),kselType:@(0), kClassroomId:@(0)} withNotifiedObject:self];
    }
}



- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    [self.tableDataArray addObject:@{@"title":@"阅读区"}];
    [self.tableDataArray addObject:@{@"title":@"班级教材"}];
    [self.tableDataArray addObject:@{@"title":@"收藏内容"}];
    if (self.taskEditType == TaskEditType_nomal) {
        [self.tableDataArray addObject:@{@"title":@"录音作品"}];
    }
    self.readArray = [NSMutableArray array];
    self.collectionDataArray = [NSMutableArray array];
    
    // 获取阅读区数据
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestReadListWithWithDic:@{} withNotifiedObject:self];
    
    return;
}

#pragma Mark - readList
- (void)didRequestReadListSuccessed
{
    [SVProgressHUD dismiss];
    
    for (NSDictionary * infoDic in [[UserManager sharedManager] getReadArray]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:kcategoryName] forKey:@"title"];
        [self.readArray addObject:mInfo];
    }
    
    self.titleLB.text = [self.readArray[0] objectForKey:kcategoryName];
    if (self.tableDataArray.count > 0) {
        self.popListIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self reloadCollectionDataArray:[self.readArray[0] objectForKey:@"itemList"]];
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
    [self.collectionView reloadData];
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
            [[UserManager sharedManager] didRequestSearchReadListWithWithDic:@{kcategoryId:[self.readArray[self.popListIndexPath.row] objectForKey:kcategoryId], kitemName:text} withNotifiedObject:weakSelf];
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
    if (indexPath.row == 0) {
        cell.ishaveCategory = YES;
    }
    [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
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
    if (self.categoryselectIndepath.row == indexPath.row) {
        if (indexPath.row != 0) {
            return;
        }
    }
    self.collectionType = CollectionType_nomal;
    self.categoryselectIndepath = indexPath;
    
    [self.navigationView showSearch];
    
    if (indexPath.row == 0) {
        self.titleLB.hidden = NO;
        self.productHySegmentControl.hidden = YES;
        if (self.popListView == nil) {
            MainLeftTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            CGRect cellRect = [cell.titleLB convertRect:cell.titleLB.bounds toView:self.view];
            CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width, cellRect.size.height / 2 + cellRect.origin.y);
            
            self.popListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.readArray anDirection:ArrowDirection_left andArrowPoint:startPoint andWidth:165];
            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
            [delegate.window addSubview:self.popListView];
            
            __weak typeof(self.popListView)weakListView = self.popListView;
            __weak typeof(self)weakSelf = self;
            self.popListView.dismissBlock = ^{
                [weakListView removeFromSuperview];
                weakSelf.categoryselectIndepath = nil;
                [weakSelf.tableView reloadData];
            };
            self.popListView.SelectBlock = ^(NSDictionary *infoDic) {
                weakSelf.collectionType = CollectionType_nomal;
                weakSelf.titleLB.text = [infoDic objectForKey:@"title"];
                weakSelf.popListIndexPath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"]intValue] inSection:0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf reloadCollectionDataArray:[[weakSelf.readArray objectAtIndex:[[infoDic objectForKey:@"row"] intValue]] objectForKey:@"itemList"]];
                });
                ;
            };
            
        }else
        {
            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
            [delegate.window addSubview:self.popListView];
            [self.popListView refresh];
        }
    }else if (indexPath.row == 1)
    {
        self.titleLB.hidden = NO;
        self.productHySegmentControl.hidden = YES;
        
        NSMutableArray * dataArray = [NSMutableArray array];
        for (NSDictionary * infoDic in [[UserManager sharedManager] getmyClassroom]) {
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:kClassroomName] forKey:@"title"];
            [mInfo setObject:[infoDic objectForKey:kClassroomIcon] forKey:@"imagrUrl"];
            [dataArray addObject:mInfo];
        }
        self.collectionDataArray = dataArray;
        [self.collectionView reloadData];
        self.titleLB.text = @"选择班级";
    }else if(indexPath.row == 2)
    {
        self.titleLB.hidden = YES;
        self.productHySegmentControl.hidden = YES;
        self.titleLB.text = @"选择内容";
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:self];
    }else if (indexPath.row == 3)
    {
        [self.navigationView showSelectAllAndComplate];
        
        self.titleLB.hidden = YES;
        self.productHySegmentControl.hidden = NO;
        if (self.productHySegmentControl.selectIndex == 1) {
            self.collectionType = CollectionType_start;
        }
        [self requestRecordProduct];
    }
    
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
    if (self.collectionType == CollectionType_nomal) {
        TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
        
        if (self.categoryselectIndepath.row != 3) {
            [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
        }else
        {
            NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
            [cell resetWithInfoDic:infoDic];
            
            BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
            if (isHaveInfo) {
                [cell selectReset];
            }
            
            int number = [self numberInfoDic:infoDic];
            if (number > 0) {
                [cell selectNumberReset];
                cell.selectNumberLB.text = [NSString stringWithFormat:@"%d", number];
            }
        }
        
        return cell;
    }else
    {
        StartCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStartCellID forIndexPath:indexPath];
        
        NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
        [cell resetWithInfoDic:infoDic];
        int number = [self numberInfoDic:infoDic];
        if (number > 0) {
            [cell selectNumberReset];
            cell.selectNumberLB.text = [NSString stringWithFormat:@"%d", number];
        }
        
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionType == CollectionType_nomal) {
        return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 15);
    }
    
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (self.categoryselectIndepath.row != 1) {
        
        if (self.taskEditType == TaskEditType_AggangrXiLieTask) {
            if (self.xilietaskBlock) {
                self.xilietaskBlock(self.collectionDataArray[indexPath.row]);
            }
            [self dismissViewControllerAnimated:NO completion:nil];
            return;
        }
        if (self.taskEditType == TaskEditType_addClassroomTextBook) {
            
            weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"分享课本" withAnimation:YES];
            [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"是否分享课本《%@》到班级%@?", [self.collectionDataArray[indexPath.row] objectForKey:@"title"],[self.infoDic objectForKey:kClassroomName]]];
            [weakSelf.view addSubview:weakSelf.recordShotTipView];
            weakSelf.recordShotTipView.DismissBlock = ^{
                [weakSelf.recordShotTipView removeFromSuperview];
            };
            weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
                
                if (self.addClassroomTextbookBlock) {
                    self.addClassroomTextbookBlock(self.collectionDataArray[indexPath.row]);
                }
                [self dismissViewControllerAnimated:NO completion:nil];
                
                [weakSelf.recordShotTipView removeFromSuperview];
                weakSelf.recordShotTipView = nil;
            };
            
            return;
        }
        if (self.taskEditType == TaskEditType_addClassroomCourseWare) {
            
            NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
            
            switch ([[infoDic objectForKey:@"itemType"] intValue]) {
                case 2:
                case 3:
                case 4:
                {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                    [mInfo setObject:[mInfo objectForKey:kitemId] forKey:kbookId];
                    [mInfo setObject:[infoDic objectForKey:@"itemType"] forKey:@"coursewareType"];
                    if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare)
                    {
                        NSString * typeStr = @"";
                        if ([[infoDic objectForKey:@"itemType"] intValue] == 2) {
                            typeStr = @"PPT";
                        }else if ([[infoDic objectForKey:@"itemType"] intValue] == 3)
                        {
                            typeStr = @"音频";
                        }else
                        {
                            typeStr = @"视频";
                        }
                        
                        weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"分享课本" withAnimation:YES];
                        [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"是否分享%@%@到班级%@?",typeStr, [infoDic objectForKey:@"title"],[weakSelf.infoDic objectForKey:kClassroomName]]];
                        [weakSelf.view addSubview:weakSelf.recordShotTipView];
                        weakSelf.recordShotTipView.DismissBlock = ^{
                            [weakSelf.recordShotTipView removeFromSuperview];
                        };
                        weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
                            
                            if (weakSelf.addClassroomCourseWareBlock) {
                                weakSelf.addClassroomCourseWareBlock(mInfo);
                            }
                            [weakSelf dismissViewControllerAnimated:NO completion:nil];
                            
                            [weakSelf.recordShotTipView removeFromSuperview];
                            weakSelf.recordShotTipView = nil;
                        };
                        
                        return;
                    }
                    [weakSelf choseCourseWareText:mInfo];
                }
                    break;
                case 5:
                {
                    // 课文
                    [weakSelf qaaa:infoDic];
                }
                    break;
                case 1:
                {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                    
                    [weakSelf choseCourseWareText:mInfo];
                }
                    break;
                default:
                    break;
            }
            
            return;
        }

        if (self.categoryselectIndepath.row == 3) {
            NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
            if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
                // 单视频
                [SVProgressHUD showInfoWithStatus:@"该课文不包含音频，不能添加到播放列表"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
            
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:kProductName] forKey:kpartName];
            [mInfo setObject:[infoDic objectForKey:kProductId] forKey:kpartId];
            if (isHaveInfo) {
                [self.textBookSelectArray removeObject:mInfo];
            }else
            {
                [self.textBookSelectArray addObject:mInfo];
            }
            
            [collectionView reloadData];
            return;
        }
        
        AddMusicViewController * addmusicVC = [[AddMusicViewController alloc]init];
        addmusicVC.arrangeTaskType = self.arrangeTaskType;
        addmusicVC.taskEditType = self.taskEditType;
        
        addmusicVC.infoDic = self.collectionDataArray[indexPath.row];
        __weak typeof(self)weakSelf = self;
        // 更改课文
        addmusicVC.changeSuitangTaskTextbookBlock = ^(NSDictionary *infoDic) {
            if (weakSelf.changeSuitangTaskTextbookBlock) {
                weakSelf.changeSuitangTaskTextbookBlock(infoDic);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            });
        };
        // 选择课文
        addmusicVC.complateBlock = ^(NSArray *array) {
            
            if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare) {
                if (weakSelf.addClassroomCourseWareBlock) {
                    NSMutableDictionary * minfo = [[ NSMutableDictionary alloc]initWithDictionary:[array firstObject]];
                    [minfo setObject:[minfo objectForKey:kitemId] forKey:kbookId];
                    [minfo setObject:[minfo objectForKey:kpartId] forKey:kitemId];
                    [minfo setObject:@5 forKey:@"coursewareType"];

                    weakSelf.addClassroomCourseWareBlock(minfo);
                }
                return ;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            });
            if (weakSelf.complateBlock) {
                weakSelf.complateBlock(array);
            }
        };
        
        [self presentViewController:addmusicVC animated:NO completion:nil];
    }else
    {
        NSDictionary * infoDIc = self.collectionDataArray[indexPath.item];
        
        [self addClassroomSelectView:infoDIc];
    }
}


- (void)qaaa:(NSDictionary *)infoDic;
{
    AddMusicViewController * addmusicVC = [[AddMusicViewController alloc]init];
    addmusicVC.arrangeTaskType = self.arrangeTaskType;
    addmusicVC.taskEditType = self.taskEditType;
    
    addmusicVC.infoDic = infoDic;
    __weak typeof(self)weakSelf = self;
    // 更改课文
    addmusicVC.changeSuitangTaskTextbookBlock = ^(NSDictionary *infoDic) {
        if (weakSelf.changeSuitangTaskTextbookBlock) {
            weakSelf.changeSuitangTaskTextbookBlock(infoDic);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        });
    };
    // 选择课文
    addmusicVC.complateBlock = ^(NSArray *array) {
        
        if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare) {
            if (weakSelf.addClassroomCourseWareBlock) {
                NSMutableDictionary * minfo = [[ NSMutableDictionary alloc]initWithDictionary:[array firstObject]];
                [minfo setObject:[minfo objectForKey:kitemId] forKey:kbookId];
                [minfo setObject:[minfo objectForKey:kpartId] forKey:kitemId];
                [minfo setObject:@5 forKey:@"coursewareType"];
                
                weakSelf.addClassroomCourseWareBlock(minfo);
            }
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        });
        if (weakSelf.complateBlock) {
            weakSelf.complateBlock(array);
        }
    };
    
    [self presentViewController:addmusicVC animated:NO completion:nil];
}

#pragma mark - classroom textbook & courseware
- (void)addClassroomSelectView:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    if (self.classroomMemberproductView == nil) {
        self.classroomMemberproductView = [[ClassTextBookView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight) andInfoDic:infoDic];
    }
    self.classroomMemberproductView.taskEditType = self.taskEditType;
    [self.classroomMemberproductView reloadData:infoDic];
    
    self.classroomMemberproductView.selectProductBlock = ^(NSDictionary *infoDic, BOOL isTextbook) {
        if (isTextbook) {
            NSLog(@"Textbook infoDic = %@", infoDic);
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:kTextBookId] forKey:kitemId];
            [mInfo setObject:[infoDic objectForKey:kTextBookName] forKey:kitemName];
            if (weakSelf.taskEditType == TaskEditType_AggangrXiLieTask) {
                weakSelf.xilietaskBlock(mInfo);
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
                return ;
            }
            if (weakSelf.taskEditType == TaskEditType_addClassroomTextBook) {
                
                weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"分享课本" withAnimation:YES];
                [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"是否分享课本《%@》到班级%@?", [infoDic objectForKey:@"title"],[weakSelf.infoDic objectForKey:kClassroomName]]];
                [weakSelf.view addSubview:weakSelf.recordShotTipView];
                weakSelf.recordShotTipView.DismissBlock = ^{
                    [weakSelf.recordShotTipView removeFromSuperview];
                };
                weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
                    
                    if (weakSelf.addClassroomTextbookBlock) {
                        weakSelf.addClassroomTextbookBlock(mInfo);
                    }
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                    
                    [weakSelf.recordShotTipView removeFromSuperview];
                    weakSelf.recordShotTipView = nil;
                };
                
                return;
            }
            [weakSelf choseCourseWareText:mInfo];
        }else
        {
            NSLog(@"courseware infoDic = %@", infoDic);
            switch ([[infoDic objectForKey:@"coursewareType"] intValue]) {
                case 2:
                case 3:
                case 4:
                    {
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                        [mInfo setObject:[infoDic objectForKey:kbookId] forKey:kitemId];
                        [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kitemName];
                        
                        if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare)
                        {
                            NSString * typeStr = @"";
                            if ([[infoDic objectForKey:@"coursewareType"] intValue] == 2) {
                                typeStr = @"PPT";
                            }else if ([[infoDic objectForKey:@"coursewareType"] intValue] == 3)
                            {
                                typeStr = @"音频";
                            }else
                            {
                                typeStr = @"视频";
                            }
                            
                            weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"分享课本" withAnimation:YES];
                            [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"是否分享%@%@到班级%@?",typeStr, [infoDic objectForKey:@"title"],[weakSelf.infoDic objectForKey:kClassroomName]]];
                            [weakSelf.view addSubview:weakSelf.recordShotTipView];
                            weakSelf.recordShotTipView.DismissBlock = ^{
                                [weakSelf.recordShotTipView removeFromSuperview];
                            };
                            weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
                                
                                if (weakSelf.addClassroomCourseWareBlock) {
                                    weakSelf.addClassroomCourseWareBlock(mInfo);
                                }
                                [weakSelf dismissViewControllerAnimated:NO completion:nil];
                                
                                [weakSelf.recordShotTipView removeFromSuperview];
                                weakSelf.recordShotTipView = nil;
                            };
                            
                            return;
                        }
                        [weakSelf choseCourseWareText:mInfo];
                    }
                    break;
                case 5:
                {
                    // 课文直接选中
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf dismissViewControllerAnimated:NO completion:nil];
                    });
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                    if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare) {
                        [mInfo setObject:[infoDic objectForKey:@"coursewareId"] forKey:kitemId];
                        if (weakSelf.addClassroomCourseWareBlock) {
                            weakSelf.addClassroomCourseWareBlock(mInfo);
                        }
                        return;
                    }
                    [mInfo setObject:[infoDic objectForKey:kbookId] forKey:kitemId];
                    [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kitemName];
                    [mInfo setObject:[infoDic objectForKey:@"coursewareId"] forKey:kpartId];
                    [mInfo setObject:[infoDic objectForKey:@"coursewareUrl"] forKey:kpartImg];
                    [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kpartName];

                    if (weakSelf.complateBlock) {
                        weakSelf.complateBlock(@[mInfo]);
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
    };
    
    [self.view addSubview:self.classroomMemberproductView];
     
}

- (void)choseCourseWareText:(NSDictionary *)infoDic
{
    AddMusicViewController * addmusicVC = [[AddMusicViewController alloc]init];
    addmusicVC.arrangeTaskType = self.arrangeTaskType;
    addmusicVC.taskEditType = self.taskEditType;
    addmusicVC.infoDic = infoDic;
    __weak typeof(self)weakSelf = self;
    addmusicVC.complateBlock = ^(NSArray *array) {
        if (weakSelf.taskEditType == TaskEditType_addClassroomCourseWare) {
            if (weakSelf.addClassroomCourseWareBlock) {
                NSMutableDictionary * minfo = [[ NSMutableDictionary alloc]initWithDictionary:[array firstObject]];
                [minfo setObject:[minfo objectForKey:kitemId] forKey:kbookId];
                [minfo setObject:[minfo objectForKey:kpartId] forKey:kitemId];
                [minfo setObject:@5 forKey:@"coursewareType"];
                weakSelf.addClassroomCourseWareBlock(minfo);
            }
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        });
        if (weakSelf.complateBlock) {
            weakSelf.complateBlock(array);
        }
    };
    
    [self presentViewController:addmusicVC animated:NO completion:nil];
}

- (BOOL)isHaveInfoDic:(NSDictionary *)infoDIc
{
    BOOL isHaveInfo = NO;
    for (NSDictionary * selectInfo in self.textBookSelectArray) {
        if ([[infoDIc objectForKey:kProductId] isEqual:[selectInfo objectForKey:kProductId]]) {
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

- (int)numberInfoDic:(NSDictionary *)infoDIc
{
    for (int i = 0; i < self.textBookSelectArray.count; i++) {
        NSDictionary * selectInfo = [self.textBookSelectArray objectAtIndex:i];
        if ([[infoDIc objectForKey:kProductId]isEqual:[selectInfo objectForKey:kProductId]]) {
            return i + 1;
        }
    }
    return 0;
}


#pragma mark - request
- (void)didRequestMyProductSuccessed
{
    [SVProgressHUD dismiss];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyRecordProductInfoDic]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:kProductName] forKey:@"title"];
        [mInfo setObject:[infoDic objectForKey:kProductIconUrl] forKey:@"imagrUrl"];
        [mInfo setObject:[infoDic objectForKey:kProductId] forKey:kpartId];
        [dataArray addObject:mInfo];
    }
    
    self.collectionDataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)didRequestMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestProductShowListSuccessed
{
    [SVProgressHUD dismiss];
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getProductShowRecordArray]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:kProductName] forKey:@"title"];
        [mInfo setObject:[infoDic objectForKey:kProductIconUrl] forKey:@"imagrUrl"];
        [mInfo setObject:[infoDic objectForKey:kProductId] forKey:kpartId];
        
        [dataArray addObject:mInfo];
    }
    
    self.collectionDataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)didRequestProductShowListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyCollectionTextbookArray]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:kitemName] forKey:@"title"];
        [mInfo setObject:[infoDic objectForKey:kitemImageUrl] forKey:@"imagrUrl"];
        [dataArray addObject:mInfo];
    }
    
    self.collectionDataArray = dataArray;
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
