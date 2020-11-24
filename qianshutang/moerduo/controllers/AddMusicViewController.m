//
//  AddMusicViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AddMusicViewController.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"



@interface AddMusicViewController ()<UITableViewDelegate, UITableViewDataSource,HYSegmentedControlDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource, ActiveStudy_TextBookContentList>

@property (nonatomic, strong)UIButton * iconImageView;
@property (nonatomic, strong)NavigationView * navigationView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)NSMutableArray * textBookSelectArray;

@property (nonatomic, assign)BOOL isSearch;

@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)ToolTipView * toolView;

@property (nonatomic, strong)NSMutableArray * allTextArray;

@property (nonatomic, strong)NSMutableArray * selectAddCoursewareArray;
@property (nonatomic, strong)NSDictionary * currentSelectAddCourseware;

@end

@implementation AddMusicViewController

- (NSMutableArray *)selectAddCoursewareArray
{
    if (!_selectAddCoursewareArray) {
        _selectAddCoursewareArray = [NSMutableArray array];
    }
    return _selectAddCoursewareArray;
}

- (NSMutableArray *)allTextArray
{
    if (!_allTextArray) {
        _allTextArray = [NSMutableArray array];
    }
    return _allTextArray;
}

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
    
//    if (self.taskEditType == TaskEditType_ChangeSuitangTaskTextbook) {
//        self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_search];
//    }else
//    {
//    }
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_select];
    
    if (self.taskEditType == TaskEditType_addClassroomCourseWare || self.taskEditType == TaskEditType_addClassroomTextBook || self.taskEditType == TaskEditType_AggangrXiLieTask|| self.taskEditType == TaskEditType_ChangeSuitangTaskTextbook) {
        [self.navigationView hideSelectAllBtn];
        [self.navigationView hideComplateBtn];
    }
    if (self.taskEditType == TaskEditType_ArrangeSuitangTask) {
        [self.navigationView hideSelectAllBtn];
    }
    
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
            weakSelf.collectionDataArray = [[weakSelf.tableDataArray objectAtIndex:weakSelf.categoryselectIndepath.row] objectForKey:@"partList"];
            [weakSelf.collectionView reloadData];
        }
    };
    self.navigationView.complateBlock = ^{
        [weakSelf complateAction];
    };
    self.navigationView.SelectAllBlock = ^{
        [weakSelf selectAllAction];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.text = @"选择课文";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCoursewareAction) name:kSelectAddCoursewareNotification object:nil];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)selectCoursewareAction
{
    if (self.currentSelectAddCourseware != nil) {
        [self.selectAddCoursewareArray addObject:self.currentSelectAddCourseware];
        [self.collectionView reloadData];
    }
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    self.collectionDataArray = [NSMutableArray array];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[self.infoDic objectForKey:kitemId]} withNotifiedObject:self];
}

- (void)didRequestTextBookContentListSuccessed
{
    [SVProgressHUD dismiss];
    self.tableDataArray = [[[UserManager sharedManager] getTextbookContentArray] objectForKey:@"data"];
    
    if ([self.tableDataArray class] == [NSNull class]) {
        return;
    }
    if (self.tableDataArray.count > 0) {
        
        [self.allTextArray removeAllObjects];
        for (NSDictionary * unitInfo in self.tableDataArray) {
            NSArray * textArray = [unitInfo objectForKey:@"partList"];
            for (NSDictionary * textInfo in textArray) {
                [self.allTextArray addObject:textInfo];
            }
        }
        
        self.categoryselectIndepath = [NSIndexPath indexPathForRow:0 inSection:0];
//        self.collectionDataArray = [self.tableDataArray[0] objectForKey:@"partList"];// 有阅读记录的话，直接显示阅读记录所在单元
        
        NSMutableArray *marray = [NSMutableArray array];
        for (NSDictionary * infoDic in [self.tableDataArray[0] objectForKey:@"partList"]) {
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[self.infoDic objectForKey:kitemName] forKey:kitemName];
            [mInfo setObject:[self.infoDic objectForKey:kitemId] forKey:kitemId];
            [marray addObject:mInfo];
        }
        self.collectionDataArray = marray;
    }
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)didRequestTextBookContentListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)selectAllAction
{
    [self.textBookSelectArray removeAllObjects];
    for (NSDictionary * infoDic in self.collectionDataArray) {
        if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
            // 单视频
        }else
        {
            [self.textBookSelectArray addObject:infoDic];
            [self.collectionView reloadData];
        }
    }
}

- (void)complateAction
{
    if (self.textBookSelectArray.count >0) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.complateBlock) {
            self.complateBlock(self.textBookSelectArray);
        }
    }
}

#pragma mark - search
- (void)searchMember
{
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_searchText andTitle:@"" andPlaceHold:@"请输入课文名称" withAnimation:NO];
    __weak typeof(toolView)weakToolView = toolView;
    self.toolView = toolView;
    [self.view addSubview:toolView];
    toolView.TextBlock = ^(NSString *text) {
        if (text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入内容"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        NSMutableArray * array = [NSMutableArray array];
        for (NSDictionary * infoDic in [[weakSelf.tableDataArray objectAtIndex:weakSelf.categoryselectIndepath.row] objectForKey:@"partList"]) {
            NSString * str = [infoDic objectForKey:kpartName];
            if ([str containsString:text]) {
                [array addObject:infoDic];
            }
        }
        weakSelf.collectionDataArray = array;
        weakSelf.isSearch = YES;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        [weakSelf.collectionView reloadData];
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        weakSelf.collectionDataArray = [[weakSelf.tableDataArray objectAtIndex:weakSelf.categoryselectIndepath.row] objectForKey:@"partList"];
        [weakSelf.collectionView reloadData];
        [weakToolView removeFromSuperview];
    };
    
    
}


#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    NSDictionary * infodic = self.tableDataArray[indexPath.row];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.tableDataArray[indexPath.row]];
    [mInfo setObject:[infodic objectForKey:kUnitName] forKey:@"title"];
    
    [cell resetWithInfoDic:mInfo];
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
    self.categoryselectIndepath = indexPath;
//    self.collectionDataArray = [self.tableDataArray[indexPath.row] objectForKey:@"partList"];
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * infoDic in [self.tableDataArray[indexPath.row] objectForKey:@"partList"]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[self.infoDic objectForKey:kitemName] forKey:kitemName];
        [mInfo setObject:[self.infoDic objectForKey:kitemId] forKey:kitemId];
        [marray addObject:mInfo];
    }
    self.collectionDataArray = marray;
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
    
    NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
    NSMutableDictionary * minfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [minfo setObject:[infoDic objectForKey:kpartName] forKey:@"title"];
    [minfo setObject:[infoDic objectForKey:@"partImageUrl"] forKey:@"imagrUrl"];
    
    [cell resetWithInfoDic:minfo];
    BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
    if (isHaveInfo) {
        [cell selectReset];
    }
    
    if (self.taskEditType == TaskEditType_addClassroomCourseWare) {
        BOOL isHaveInfo = NO;
        for (NSDictionary * selectInfo in self.selectAddCoursewareArray) {
            if ([[infoDic objectForKey:kpartId]isEqual:[selectInfo objectForKey:kpartId]]) {
                isHaveInfo = YES;
            }
        }
        if (isHaveInfo) {
            [cell shareSelectReset];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * typeStr = @"";
    switch (self.arrangeTaskType) {
        case ArrangeTaskTypedetail_read:
            typeStr = @"阅读作业";
            break;
        case ArrangeTaskTypedetail_moerduo:
            typeStr = @"磨耳朵作业";
            break;
        case ArrangeTaskTypedetail_record:
            typeStr = @"录音作业";
            break;
            
        default:
            typeStr = @"播放列表";
            break;
    }
    
    NSDictionary * mp4infoDic = self.collectionDataArray[indexPath.item];
    if ([[mp4infoDic objectForKey:@"mp4Src"] length] > 0 && [[mp4infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
        // 单视频
        
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"该课文不包含音频，不能添加到%@", typeStr]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        return;
    }
//    if (self.taskEditType != TaskEditType_addClassroomCourseWare) {
//    }
    if (self.taskEditType == TaskEditType_addClassroomCourseWare) {
#pragma mark - addcourseWare
        self.currentSelectAddCourseware = self.collectionDataArray[indexPath.item];
        if (self.complateBlock) {
            self.complateBlock(@[self.collectionDataArray[indexPath.item]]);
        }
        return;
    }
    
    
    if (self.taskEditType == TaskEditType_AggangrXiLieTask) {
        NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
        
        if (self.isEnd) {
            // 选择截止课文
            if (self.startTextInfo != nil) {
                // 有起始课文
                // 选择结束课文时，结束课文需在起始课文以后，且两篇课文中间不能有纯视频课文
#pragma mark - change end text
                
                int start = 0;
                int end = 0;
                
                for (int i = 0; i < self.allTextArray.count; i++) {
                    NSDictionary * textInfo = self.allTextArray[i];
                    if ([[textInfo objectForKey:kpartId] isEqual:[self.startTextInfo objectForKey:kpartId]]) {
                        start = i;
                    }
                    if ([[textInfo objectForKey:kpartId] isEqual:[infoDic objectForKey:kpartId]]) {
                        end = i;
                    }
                }
                
                if (end < start) {
                    [SVProgressHUD showInfoWithStatus:@"截止课文必须在起始课文之后"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    return;
                }
                
                NSMutableArray * videoArray = [NSMutableArray array];
                NSMutableArray *selectArrfay = [NSMutableArray array];
                for (int i = start; i <= end; i++) {
                    NSDictionary * textInfo = self.allTextArray[i];
                    if ([[textInfo objectForKey:@"mp4Src"] length] > 0 && [[textInfo objectForKey:@"haveImgMp3"] intValue] == 0) {
                        [videoArray addObject:textInfo];
                    }else
                    {
                        [selectArrfay addObject:textInfo];
                    }
                }
                if (videoArray.count == 0) {
                    if (self.xilietaskBlock) {
                        self.xilietaskBlock(self.collectionDataArray[indexPath.row]);
                    }
                    if (self.complateBlock) {
                        self.complateBlock(selectArrfay);
                    }
                    [self dismissViewControllerAnimated:NO completion:nil];
                }else
                {
                    NSString * tipStr = [NSString stringWithFormat:@"所选课文中以下课文不包含音频，不能添加到%@：", typeStr];
                    for (int j = 0; j < videoArray.count; j++) {
                        NSDictionary * videoInfo = [videoArray objectAtIndex:j];
                        if (j == 0) {
                            tipStr = [tipStr stringByAppendingString:[NSString stringWithFormat:@"    %@", [videoInfo objectForKey:kpartName]]];
                        }else
                        {
                            tipStr = [tipStr stringByAppendingString:[NSString stringWithFormat:@"\n    %@", [videoInfo objectForKey:kpartName]]];
                        }
                    }
                    
                    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_callroll andTitle:@"提示" withAnimation:NO];
                    [toolView resetContentLbTetx:tipStr];
                    [self.view addSubview:toolView];
                    __weak typeof(toolView)weakView = toolView  ;
                    toolView.ContinueBlock = ^(NSString *str) {
                        [weakView removeFromSuperview];
                    };
                    
                    return;
                }
                
                return;
            }
            
            
            if (self.xilietaskBlock) {
                self.xilietaskBlock(self.collectionDataArray[indexPath.row]);
            }
            return;
        }
        if (self.isStart) {
            // 选择起始课文
            if (self.endTextInfo != nil) {
                // 有截止课文
                // 选择起始课文时，起始课文需在截止课文之前，且两篇课文中间不能有纯视频课文
#pragma mark - change end text
                
                int start = 0;
                int end = 0;
                
                for (int i = 0; i < self.allTextArray.count; i++) {
                    NSDictionary * textInfo = self.allTextArray[i];
                    if ([[textInfo objectForKey:kpartId] isEqual:[self.endTextInfo objectForKey:kpartId]]) {
                        end = i;
                    }
                    if ([[textInfo objectForKey:kpartId] isEqual:[infoDic objectForKey:kpartId]]) {
                        start = i;
                    }
                }
                
                if (end < start) {
                    [SVProgressHUD showInfoWithStatus:@"起始课文必须在截止课文之前"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    return;
                }
                
                NSMutableArray * videoArray = [NSMutableArray array];
                NSMutableArray *selectArrfay = [NSMutableArray array];
                for (int i = start; i <= end; i++) {
                    NSDictionary * textInfo = self.allTextArray[i];
                    if ([[textInfo objectForKey:@"mp4Src"] length] > 0 && [[textInfo objectForKey:@"haveImgMp3"] intValue] == 0) {
                        [videoArray addObject:textInfo];
                    }else
                    {
                        [selectArrfay addObject:textInfo];
                    }
                }
                if (videoArray.count == 0) {
                    if (self.xilietaskBlock) {
                        self.xilietaskBlock(self.collectionDataArray[indexPath.row]);
                    }
                    if (self.complateBlock) {
                        self.complateBlock(selectArrfay);
                    }
                    [self dismissViewControllerAnimated:NO completion:nil];
                }else
                {
                    NSString * tipStr = [NSString stringWithFormat:@"所选课文中以下课文不包含音频，不能添加到%@：", typeStr];
                    for (int j = 0; j < videoArray.count; j++) {
                        NSDictionary * videoInfo = [videoArray objectAtIndex:j];
                        if (j == 0) {
                            tipStr = [tipStr stringByAppendingString:[NSString stringWithFormat:@"    %@", [videoInfo objectForKey:kpartName]]];
                        }else
                        {
                            tipStr = [tipStr stringByAppendingString:[NSString stringWithFormat:@"\n    %@", [videoInfo objectForKey:kpartName]]];
                        }
                    }
                    
                    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_callroll andTitle:@"提示" withAnimation:NO];
                    [toolView resetContentLbTetx:tipStr];
                    [self.view addSubview:toolView];
                    __weak typeof(toolView)weakView = toolView  ;
                    toolView.ContinueBlock = ^(NSString *str) {
                        [weakView removeFromSuperview];
                    };
                    
                }
                
                return;
            }
            
            if (self.xilietaskBlock) {
                self.xilietaskBlock(self.collectionDataArray[indexPath.row]);
            }
        }
        
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    
    if (self.taskEditType == TaskEditType_ChangeSuitangTaskTextbook) {
        
        ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"选择课文" withAnimation:YES ];
        [toolView resetContentLbTetx:[NSString stringWithFormat:@"选择“%@”作为该项作业的课文？", [[self.collectionDataArray objectAtIndex:indexPath.row] objectForKey:kpartName]]];
        [self.view addSubview:toolView];
        self.toolView = toolView;
        __weak typeof(self)weakSelf = self;
        toolView.DismissBlock = ^{
            [weakSelf.toolView removeFromSuperview];
        };
        toolView.ContinueBlock = ^(NSString *str) {
            
            if (self.changeSuitangTaskTextbookBlock) {
                self.changeSuitangTaskTextbookBlock([self.collectionDataArray objectAtIndex:indexPath.row]);
            }
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            [weakSelf.toolView removeFromSuperview];
        };
        
        return;
    }
    
    NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
    
    BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
    if (isHaveInfo) {
        [self.textBookSelectArray removeObject:infoDic];
    }else
    {
        [self.textBookSelectArray addObject:infoDic];
    }
    
    [collectionView reloadData];
}

- (BOOL)isHaveInfoDic:(NSDictionary *)infoDIc
{
    BOOL isHaveInfo = NO;
    for (NSDictionary * selectInfo in self.textBookSelectArray) {
        if ([[infoDIc objectForKey:kpartId]isEqual:[selectInfo objectForKey:kpartId]]) {
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

@end
