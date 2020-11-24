//
//  ProductShowViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/4.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductShowViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "StartCollectionViewCell.h"
#define kStartCellID   @"startCellID"

#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"
#import "ClassroomMemberProductView.h"
#import "CommentTaskViewController.h"

typedef enum : NSUInteger {
    CollectionType_nomal,
    CollectionType_start,
    CollectionType_teacher
} CollectionType;

typedef enum : NSUInteger {
    ProductCategory_mine,
    ProductCategory_schoolmate,
    ProductCategory_friend,
    ProductCategory_school,
    ProductCategory_star,
    ProductCategory_teacher,
    ProductCategory_none
} ProductCategory;

@interface ProductShowViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ProductShow_ProductShowList,ProductShow_DeleteProductShowMyProduct, MyClassroom_MyFriendProductDetail, MyClassroom_MyRecordProductDetail>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UIImageView * collectionBackView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSMutableArray * hotArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;
@property (nonatomic, strong)NSMutableArray * myProductPopArray;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, assign)CollectionType collectionType;
@property (nonatomic, strong)HYSegmentedControl * myPoductHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  friendProductHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  schoolProductHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  starProductHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  teacherProductHySegmentControl;

@property (nonatomic, strong)PopListView * myProductPopView;
@property (nonatomic, strong)PopListView * popListView;

@property (nonatomic, assign)int myProductPopRow;
@property (nonatomic, assign)int popListRow;
@property (nonatomic, assign)int classroomPopRow;

@property (nonatomic, strong)PopListView * classroomPopList;

@property (nonatomic, strong)ClassroomMemberProductView * classroomMemberproductView;
@property (nonatomic, strong)NSDictionary * currentClassroomInfoDic;
@property (nonatomic, assign)BOOL isDelete;

@property (nonatomic, assign)CommentTaskType commentTaskType;
@property (nonatomic, strong)NSDictionary * selectProductInfo;// 当前选中作品info

@property (nonatomic, strong)FailedView * failedView;// 暂无数据view

@end

@implementation ProductShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
}

- (void)loadData
{
    self.categoryselectIndepath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.tableDataArray = [NSMutableArray array];
    [self.tableDataArray addObject:@{@"title":@"我的作品"}];
    [self.tableDataArray addObject:@{@"title":@"同学作品"}];
    [self.tableDataArray addObject:@{@"title":@"朋友作品"}];
    [self.tableDataArray addObject:@{@"title":@"全校作品"}];
    [self.tableDataArray addObject:@{@"title":@"明星作品"}];
    [self.tableDataArray addObject:@{@"title":@"老师作品"}];
    
    
    self.hotArray = [NSMutableArray array];
    [self.hotArray addObject:@{@"title":@"最新作品"}];
    [self.hotArray addObject:@{@"title":@"历史最热"}];
    [self.hotArray addObject:@{@"title":@"本月最热"}];
    [self.hotArray addObject:@{@"title":@"上月最热"}];
    [self.hotArray addObject:@{@"title":@"本周最热"}];
    [self.hotArray addObject:@{@"title":@"上周最热"}];
    
    self.myProductPopArray = [NSMutableArray array];
    [self.myProductPopArray addObject:@{@"title":@"最新"}];
    [self.myProductPopArray addObject:@{@"title":@"最热"}];
    
    self.collectionDataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(1),kselType:@(1), kClassroomId:@(0)} withNotifiedObject:self];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_deleteAndLatestProduct];
    [self.navigationView showDeleteAndLatestBtn];
    self.navigationView.DismissBlock = ^{
        
        
        
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.deleteBlock = ^(BOOL isDelete){
        weakSelf.isDelete = isDelete;
        if (isDelete) {
            [weakSelf.collectionView reloadData];
            [weakSelf.navigationView refreshDeleteBtnWith:YES];
        }else
        {
            weakSelf.isDelete = NO;
            [weakSelf.collectionView reloadData];
            [weakSelf.navigationView refreshDeleteBtnWith:NO];
        }
    };
    
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        switch (weakSelf.categoryselectIndepath.row) {
            case 0:
            {
                if (isShow) {
                    [weakSelf showMyProductPopListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
                }else
                {
                    [weakSelf.myProductPopView removeFromSuperview];
                }
            }
                break;
            case 2:
            case 3:
            {
                if (isShow) {
                    [weakSelf showListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
                }else
                {
                    [weakSelf.popListView removeFromSuperview];
                }
            }
                break;
            default:
                break;
        }
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        self.myPoductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"讲解作品",@"创作作品"] delegate:self];
        
    }else
    {
        self.myPoductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    }
    [self.myPoductHySegmentControl hideBottomView];
    [self.myPoductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.myPoductHySegmentControl];
//    self.myPoductHySegmentControl.hidden = YES;
    self.myPoductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.myPoductHySegmentControl]) {
            weakSelf.collectionType = CollectionType_nomal;
            [weakSelf refreshWithSegment:index];
        }
    };
    
    self.friendProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    [self.friendProductHySegmentControl hideBottomView];
    [self.friendProductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.friendProductHySegmentControl];
    self.friendProductHySegmentControl.hidden = YES;
    self.friendProductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.friendProductHySegmentControl]) {
            weakSelf.collectionType = CollectionType_start;
            [weakSelf refreshWithSegment:index];
        }
    };
    
    self.schoolProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    [self.schoolProductHySegmentControl hideBottomView];
    [self.schoolProductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.schoolProductHySegmentControl];
    self.schoolProductHySegmentControl.hidden = YES;
    self.schoolProductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.schoolProductHySegmentControl]) {
            weakSelf.collectionType = CollectionType_start;
            [weakSelf refreshWithSegment:index];
        }
    };
    self.starProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    [self.starProductHySegmentControl hideBottomView];
    [self.starProductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.starProductHySegmentControl];
    self.starProductHySegmentControl.hidden = YES;
    self.starProductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.starProductHySegmentControl]) {
            weakSelf.collectionType = CollectionType_start;
            [weakSelf refreshWithSegment:index];
        }
    };
    self.teacherProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"讲解作品",@"创作作品"] delegate:self];
    [self.teacherProductHySegmentControl hideBottomView];
    [self.teacherProductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.teacherProductHySegmentControl];
    self.teacherProductHySegmentControl.hidden = YES;
    self.teacherProductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.teacherProductHySegmentControl]) {
            weakSelf.collectionType = CollectionType_teacher;
            [weakSelf refreshWithSegment:index];
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
    [self.collectionView registerClass:[CreatProductionCollectionViewCell class] forCellWithReuseIdentifier:kCreatProductionCellID];
    
    self.collectionBackView = [[UIImageView alloc]initWithFrame:self.collectionView.frame];
    [self.view addSubview:self.collectionBackView];
    
    self.failedView = [[FailedView alloc]initWithFrame:self.collectionView.frame andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self.view addSubview:self.failedView];
    self.failedView.hidden = YES;
    
}

- (void)showMyProductPopListVIew:(CGRect)rect
{
    if (self.popListView == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.myProductPopView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.myProductPopArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.12];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.myProductPopView];
        
        __weak typeof(self.myProductPopView)weakListView = self.myProductPopView;
        __weak typeof(self)weakSelf = self;
        self.myProductPopView.dismissBlock = ^{
            [weakSelf.navigationView refreshLatestView];
            [weakListView removeFromSuperview];
            [weakSelf.tableView reloadData];
        };
        self.myProductPopView.SelectBlock = ^(NSDictionary *infoDic) {
            weakSelf.collectionType = CollectionType_nomal;
            [weakSelf.navigationView refreshTitleWith:[infoDic objectForKey:@"title"]];
            weakSelf.myProductPopRow = [[infoDic objectForKey:@"row"] intValue];
            [weakSelf reloadData];
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.myProductPopView];
        [self.myProductPopView refresh];
    }
}

- (void)showListVIew:(CGRect)rect
{
    if (self.popListView == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.popListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.hotArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.17];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.popListView];
        
        __weak typeof(self.popListView)weakListView = self.popListView;
        __weak typeof(self)weakSelf = self;
        self.popListView.dismissBlock = ^{
            [weakSelf.navigationView refreshLatestView];
            [weakListView removeFromSuperview];
            [weakSelf.tableView reloadData];
        };
        self.popListView.SelectBlock = ^(NSDictionary *infoDic) {
            weakSelf.collectionType = CollectionType_nomal;
            [weakSelf.navigationView refreshTitleWith:[infoDic objectForKey:@"title"]];
            weakSelf.popListRow = [[infoDic objectForKey:@"row"] intValue];
            [weakSelf reloadData];
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.popListView];
        [self.popListView refresh];
    }
}

#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    
    [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
    if (indexPath.row == self.categoryselectIndepath.row) {
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
        return;
    }
    self.collectionType = CollectionType_nomal;
    self.categoryselectIndepath = indexPath;
    [self.classroomMemberproductView removeFromSuperview];
    [self.navigationView showSearch];
    
    if (indexPath.row != 0) {
        self.isDelete = NO;
        [self.navigationView refreshDeleteBtnWith:NO];
    }
    
    if (indexPath.row == 0) {
        self.titleLB.hidden = YES;
        [self showSegmentWith:ProductCategory_mine];
        
    }else if (indexPath.row == 1)
    {
        self.titleLB.hidden = NO;
        [self showSegmentWith:ProductCategory_none];
        self.titleLB.text = @"选择班级";
    }else if(indexPath.row == 2)
    {
        self.collectionType = CollectionType_start;
        self.titleLB.hidden = YES;
        [self showSegmentWith:ProductCategory_friend];
        
    }else if (indexPath.row == 3)
    {
        [self.navigationView showSelectAllAndComplate];
        self.collectionType = CollectionType_start;
        self.titleLB.hidden = YES;
        [self showSegmentWith:ProductCategory_school];
    }else if (indexPath.row == 4)
    {
        [self.navigationView showSelectAllAndComplate];
        self.collectionType = CollectionType_start;
        self.titleLB.hidden = YES;
        [self showSegmentWith:ProductCategory_star];
    }else if (indexPath.row == 5)
    {
        [self.navigationView showSelectAllAndComplate];
        self.collectionType = CollectionType_teacher;
        self.titleLB.hidden = YES;
        [self showSegmentWith:ProductCategory_teacher];
    }
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)showSegmentWith:(ProductCategory)productCategory
{
    self.myPoductHySegmentControl.hidden = YES;
    self.friendProductHySegmentControl.hidden = YES;
    self.schoolProductHySegmentControl.hidden = YES;
    self.starProductHySegmentControl.hidden = YES;
    self.teacherProductHySegmentControl.hidden = YES;
    [self.navigationView hideLatestBtn];
    [self.navigationView hideDeleteBtn];
    switch (productCategory) {
        case ProductCategory_mine:
            self.myPoductHySegmentControl.hidden = NO;
            [self.navigationView showDeleteAndLatestBtn];
            break;
        case ProductCategory_friend:
            self.friendProductHySegmentControl.hidden = NO;
            [self.navigationView showLatestBtn];
            break;
        case ProductCategory_school:
            self.schoolProductHySegmentControl.hidden = NO;
            [self.navigationView showLatestBtn];
            break;
        case ProductCategory_star:
            self.starProductHySegmentControl.hidden = NO;
            break;
        case ProductCategory_teacher:
            self.teacherProductHySegmentControl.hidden = NO;
            break;
        case ProductCategory_none:
            
            break;
            
        default:
            break;
    }
    
    [self reloadData];
}

#pragma mark - collectionView delegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.categoryselectIndepath.row == 1) {
        TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
        [infoDic setObject:[infoDic objectForKey:kClassroomName] forKey:@"title"];
        [infoDic setObject:[infoDic objectForKey:kClassroomIcon] forKey:@"imagrUrl"];
        [cell resetWithInfoDic:infoDic];
        return cell;
    }
    
    
    if (self.collectionType == CollectionType_teacher) {
        TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
        
        if (self.categoryselectIndepath.row != 3) {
            [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
        }else
        {
            NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
            [cell resetWithInfoDic:infoDic];
            
            cell.selectNumberLB.text = [NSString stringWithFormat:@"%d", indexPath.item];
        }
        
        return cell;
    }else if(self.collectionType == CollectionType_nomal)
    {
        CreatProductionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCreatProductionCellID forIndexPath:indexPath];
        
        NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
        ProductionModel * model = [[ProductionModel alloc]init];
        model.image = [UIImage imageNamed:@""];
        model.name = [infoDic objectForKey:@"name"];
        
        [cell resetWithInfoDic:infoDic];
        
        if (self.isDelete) {
            [cell resetDeleteView];
        }
        
        cell.delateBlock = ^(NSDictionary *infoDic) {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestDeleteProductShowMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
        };
        cell.shareBlock = ^(NSDictionary *infoDic) {
            NSLog(@"share %@", [infoDic objectForKey:kProductName]);
        };
        
        return cell;
    }else
    {
        StartCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStartCellID forIndexPath:indexPath];
        
        NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
        [cell resetWithInfoDic:infoDic];
        
        cell.selectNumberLB.text = [NSString stringWithFormat:@"%d", indexPath.row];
        
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionType == CollectionType_nomal) {
        return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 30);
    }else if (self.collectionType == CollectionType_teacher )
    {
        return CGSizeMake(kScreenWidth * 0.2 - 0.5, kScreenWidth * 0.2 + 15);
    }
    
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.categoryselectIndepath.row == 1) {
        [SVProgressHUD show];
        self.currentClassroomInfoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
        [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(2),kselType:@(1), kClassroomId:[self.collectionDataArray[indexPath.row] objectForKey:kClassroomId]} withNotifiedObject:self];
        return;
    }
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        NSDictionary * infoDic = self.collectionDataArray[indexPath.row];

        switch (self.categoryselectIndepath.row) {
            case 0:
            {
                self.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
                if (self.isDelete) {
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestDeleteProductShowMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                }else
                {
                    self.commentTaskType = CommentTaskType_studentLookSelf;
                    [self getProductInfoWith:infoDic andtype:self.myPoductHySegmentControl.selectIndex];
                }
            }
                break;
            case 2:
            {
                self.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
            }
                break;
            case 3:
            {
                NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
                
                if ([[infoDic objectForKey:@"productType"] isEqualToString:@"teacher"]) {
                    self.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
                }else
                {
                    self.commentTaskType = CommentTaskType_teacherLookStudent;
                }
                [self getProductInfoWith:infoDic andtype:self.schoolProductHySegmentControl.selectIndex];
                
            }
                break;
            case 4:
            {
                self.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
                [self getProductInfoWith:infoDic andtype:self.starProductHySegmentControl.selectIndex];

            }
                break;
            case 5:
            {
                self.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
                [self getProductInfoWith:infoDic andtype:self.teacherProductHySegmentControl.selectIndex];

            }
                break;
                
            default:
                break;
        }
    }else
    {
        NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
        self.selectProductInfo = infoDic;
        
        switch (self.categoryselectIndepath.row) {
            case 0:
            {
                if (self.isDelete) {
                    [[UserManager sharedManager] didRequestDeleteProductShowMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
                }else
                {
                    self.commentTaskType = CommentTaskType_studentLookSelf;
                    [self getProductInfoWith:infoDic andtype:self.myPoductHySegmentControl.selectIndex];
                }
                
            }
                break;
            case 2:
            {
                self.commentTaskType = CommentTaskType_studentLookStudent;
                [self getProductInfoWith:infoDic andtype:self.friendProductHySegmentControl.selectIndex];
            }
                break;
            case 3:
            {
                if ([[infoDic objectForKey:@"productType"] isEqualToString:@"teacher"]) {
                    self.commentTaskType = CommentTaskType_studentLookTeacherProduct;
                }else
                {
                    self.commentTaskType = CommentTaskType_studentLookStudent;
                }
                [self getProductInfoWith:infoDic andtype:self.schoolProductHySegmentControl.selectIndex];
            }
                break;
            case 4:
            {
                self.commentTaskType = CommentTaskType_studentLookStarProduct;
                [self getProductInfoWith:infoDic andtype:self.starProductHySegmentControl.selectIndex];
            }
                break;
            case 5:
            {
                self.commentTaskType = CommentTaskType_studentLookTeacherProduct;
                [self getProductInfoWith:infoDic andtype:self.teacherProductHySegmentControl.selectIndex];
            }
                break;
                
            default:
                break;
        }
        
    }
    
}

- (void)getProductInfoWith:(NSDictionary *)infoDic andtype:(int)type
{
    if (type == 1) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
    }else
    {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
    }
}

#pragma mark - 查看作品详情
// 录音作品
- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    [infoDic setObject:@0 forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    vc.model.userWorkId = 0;
    vc.commentTaskType = self.commentTaskType;
    vc.isFromProductShow = YES;
    vc.productType = ProductType_record;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

// 创作作品
- (void)didRequestMyFriendProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:@0 forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = 0;
    vc.commentTaskType = self.commentTaskType;
    vc.isFromProductShow = YES;
    vc.productType = ProductType_create;
        
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestDeleteProductShowMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestDeleteProductShowMyProductSuccessed
{
    [self reloadData];
}

- (void)addClassroomSelectView
{
    __weak typeof(self)weakSelf = self;
    if (self.classroomMemberproductView == nil) {
        self.classroomMemberproductView = [[ClassroomMemberProductView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight)];
    }
    [self.classroomMemberproductView reloadData];
    self.classroomMemberproductView.latestProductBlock = ^(BOOL isShow, CGRect rect) {
        if (isShow) {
            [weakSelf showclassroomListVIew:[weakSelf.classroomMemberproductView convertRect:rect toView:weakSelf.view]];
        }else
        {
            [weakSelf.classroomPopList removeFromSuperview];
        }
    };
//    self.classroomMemberproductView.selectProductBlock = ^(NSDictionary *infoDic) {
//        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
//        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
//            weakSelf.commentTaskType = CommentTaskType_teacherLookStudent;
//        }else
//        {
//            weakSelf.commentTaskType = CommentTaskType_studentLookStudent;
//        }
//        [weakSelf getProductInfoWith:infoDic andtype:weakSelf.myPoductHySegmentControl.selectIndex];
////        [weakSelf presentViewController:vc animated:NO completion:nil];
//    };
    
    self.classroomMemberproductView.selectProductAndSegmentBlock = ^(NSDictionary *infoDic, int selectIndex) {
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            weakSelf.commentTaskType = CommentTaskType_teacherLookStudent;
        }else
        {
            weakSelf.commentTaskType = CommentTaskType_studentLookStudent;
        }
        [weakSelf getProductInfoWith:infoDic andtype:selectIndex];
    };
    
    [self.view addSubview:self.classroomMemberproductView];
    
}

- (void)showclassroomListVIew:(CGRect)rect
{
    if (self.classroomPopList == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.classroomPopList = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.hotArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.17];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.classroomPopList];
        
        __weak typeof(self.classroomPopList)weakListView = self.classroomPopList;
        __weak typeof(self)weakSelf = self;
        self.classroomPopList.dismissBlock = ^{
            [weakSelf.classroomMemberproductView refreshLatestView];
            [weakListView removeFromSuperview];
            [weakSelf.tableView reloadData];
        };
        self.classroomPopList.SelectBlock = ^(NSDictionary *infoDic) {
            weakSelf.collectionType = CollectionType_nomal;
            [weakSelf.classroomMemberproductView refreshTitleWith: [infoDic objectForKey:@"title"]];
            weakSelf.classroomPopRow = [[infoDic objectForKey:@"row"] intValue];
            
            [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(2),kselType:@([[infoDic objectForKey:@"row"] intValue] + 1), kClassroomId:[weakSelf.currentClassroomInfoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
            
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.classroomPopList];
        [self.classroomPopList refresh];
    }
}

- (void)reloadData
{
    int memberType = 0;
    int selType = 0;
    self.failedView.hidden = YES;
    switch (self.categoryselectIndepath.row) {
        case 0:
        {
            memberType = 1;
            selType = self.myProductPopRow + 1;
        }
            break;
        case 1:
        {
            self.collectionDataArray = [[[UserManager sharedManager] getmyClassroom] mutableCopy];
            return;
        }
            break;
        case 2:
        {
            memberType = 3;
            selType = self.popListRow + 1;
        }
            break;
        case 3:
        {
            memberType = 4;
            selType = self.popListRow + 1;
        }
            break;
        case 4:
        {
            memberType = 5;
        }
            break;
        case 5:
        {
            memberType = 6;
        }
            break;
            
        default:
            break;
    }
    [[UserManager sharedManager] didRequestProductShowListWithWithDic:@{kmemberType:@(memberType),kselType:@(selType), kClassroomId:@(0)} withNotifiedObject:self];
    
}

- (void)didRequestProductShowListSuccessed
{
    [SVProgressHUD dismiss];
    
    switch (self.categoryselectIndepath.row) {
        case 0:
        {
            if (self.myPoductHySegmentControl.selectIndex == 0) {
                [self refreshWithSegment:0];
            }else
            {
                [self refreshWithSegment:1];
            }
        }
            break;
        case 1:
        {
            [self addClassroomSelectView];
        }
            break;
        case 2:
        {
            if (self.friendProductHySegmentControl.selectIndex == 0) {
                [self refreshWithSegment:0];
            }else
            {
                [self refreshWithSegment:1];
            }
        }
            break;
        case 3:
        {
            if (self.schoolProductHySegmentControl.selectIndex == 0) {
                [self refreshWithSegment:0];
            }else
            {
                [self refreshWithSegment:1];
            }
        }
            break;
        case 4:
        {
            if (self.starProductHySegmentControl.selectIndex == 0) {
                [self refreshWithSegment:0];
            }else
            {
                [self refreshWithSegment:1];
            }
        }
            break;
        case 5:
        {
            if (self.teacherProductHySegmentControl.selectIndex == 0) {
                [self refreshWithSegment:0];
            }else
            {
                [self refreshWithSegment:1];
            }
        }
            break;
            
        default:
            break;
    }

}

- (void)didRequestProductShowListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)refreshWithSegment:(NSInteger)selIndex
{
    if (selIndex == 0) {
        self.collectionDataArray = [[[UserManager sharedManager] getProductShowRecordArray] mutableCopy];
    }else
    {
        self.collectionDataArray = [[[UserManager sharedManager] getProductShowCreateArray] mutableCopy];
    }
    [self.collectionView reloadData];
    [self addnoDataView];
}


- (void)addnoDataView
{
    if (self.collectionDataArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
    }
    
    UIImage * image = [UIImage imageNamed:@""];
    NSString * content = @"";
    NSMutableAttributedString * detail ;
    image = [UIImage imageNamed:@"default_works_icon"];
    content = @"还没有作品";
    detail = [[NSMutableAttributedString alloc]initWithString:@""];

    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
