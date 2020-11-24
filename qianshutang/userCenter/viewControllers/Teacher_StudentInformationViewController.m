//
//  Teacher_StudentInformationViewController.m
//  qianshutang
//
//  Created by aaa on 2018/10/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Teacher_StudentInformationViewController.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "CommentTaskViewController.h"
#import "UserCenterTableView.h"
#import "StudentProductTableViewCell.h"
#define kStudentProductCellID @"studentproductCell"
#import "TaskListViewController.h"
#import "MyTaskAttendanceRecordViewController.h"
#import "TeacherCourseListViewController.h"
#import "StudyLengthViewController.h"
#import "PrizeCollectionViewCell.h"
#define kPrizeCollectionCellID @"PrizeCollectionViewCell"
#import "ExplainView.h"
#import "Teacher_studentProductTableViewCell.h"
#define kTeacher_studentProductTableViewCellId @"Teacher_studentProductTableViewCell"
#import "TaskEveryDayListTableViewCell.h"
#define kTaskEveryDayListTableViewCellID @"TaskEveryDayListTableViewCellID"
#import "TeakEveryDayDetailViewController.h"
#import "PTHistogramView.h"

@interface Teacher_StudentInformationViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, MyClassroom_classMemberInformation,MyStudy_MyProduct, MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail,MyStudy_MyCourseCost,MyStudy_BuyCourseRecord,MyStudy_MyCourseList,MyStudy_MyStudyTimeLengthList,MyStudy_MyAchievementList,MyStudy_PunchCardList, Integral_MyIntegralRecord, Integral_ConvertPrizeRecord, Integral_ComplateConvertPrize,MyStudy_MyEveryDayTask,Teacher_studentHistoryTask,Teacher_editStudent_remark>
@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * basicArray;
@property (nonatomic, strong)NSMutableArray * recordArray;
@property (nonatomic, strong)NSMutableArray * createArray;

//@property (nonatomic, strong)HYSegmentedControl * productSegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  achievementHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  myCourseHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl * integralHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl * productHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl * taskSegmentControl;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITableView * leftTableView;
@property (nonatomic, strong)NSMutableArray * leftDataArr;
@property (nonatomic, strong)NSIndexPath * leftIndexPath;

@property (nonatomic, strong)NSDictionary * selectProductInfo;

@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UITableView * taskTableView;// 作业
@property (nonatomic, strong)NSArray * taskArray;
@property (nonatomic, strong)UIButton * detailBtn;
@property (nonatomic, strong) PTHistogramView *ptView;

@property (nonatomic, strong)PopListView * awardPopListView;// taskType
@property (nonatomic, strong)NSIndexPath * awardPopToatalProductIndexpath;
@property (nonatomic, strong)NSIndexPath * awardPopTaskIndexpath;
@property (nonatomic, strong)NSIndexPath * awardPopHaveShowProductIndexpath;
@property (nonatomic, strong)NSMutableArray * awardListArray;
@property (nonatomic, strong)UITableView * productTableView;// 作品
@property (nonatomic, strong)NSIndexPath * productIndexpath;
@property (nonatomic, strong)NSArray * taskProductArray;

@property (nonatomic, strong)ToolTipView * changeRemarkTipView;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * studentNameLB;
@property (nonatomic, strong)UIImageView * genderImageView;
@property (nonatomic, strong)UILabel * ageLB;
@property (nonatomic, strong)UILabel * starLB;
@property (nonatomic, strong)UILabel * flowerLB;
@property (nonatomic, strong)UILabel * goldLB;
@property (nonatomic, strong)UIButton * comunicateBtn;
@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic, strong)FailedView * failedView;// 暂无数据view
@end

@implementation Teacher_StudentInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.explainBlock = ^{
        ExplainView * explainView = [[ExplainView alloc]initWithFrame:weakSelf.view.bounds];
        [weakSelf.view addSubview:explainView];
    };
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        if (isShow) {
            [weakSelf showListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
        }else
        {
            [weakSelf.awardPopListView removeFromSuperview];
        }
    };
    
    [self.view addSubview:self.navigationView];
    
    NSLog(@"%@", self.infoDic);
    
    [self prepareUI];
    [self loadData];
}
- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.leftTableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.leftTableView.backgroundColor = kMainColor;
    
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.frame = CGRectMake(kScreenWidth * 0.8 - kScreenHeight * 0.15 - 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.detailBtn.backgroundColor = kMainColor;
    self.detailBtn.layer.cornerRadius = self.detailBtn.hd_height / 2;
    self.detailBtn.layer.masksToBounds = YES;
    self.detailBtn.hidden = YES;
    [self.navigationView.rightView addSubview:self.detailBtn];
    [self.detailBtn addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTopView];
    
    self.achievementHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"学习打卡",@"学习时长",@"成就"] delegate:self];
    [self.achievementHySegmentControl hideBottomView];
    [self.achievementHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.achievementHySegmentControl];
    self.achievementHySegmentControl.hidden = YES;
    self.achievementHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.achievementHySegmentControl]) {
            
            [weakSelf reloadData];
        }
    };
    
    self.myCourseHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"我的课程",@"课耗记录",@"购课记录"] delegate:self];
    [self.myCourseHySegmentControl hideBottomView];
    [self.myCourseHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.myCourseHySegmentControl];
    self.myCourseHySegmentControl.hidden = YES;
    self.myCourseHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.myCourseHySegmentControl]) {
            
            [weakSelf reloadData];
        }
    };
    
    self.integralHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"积分记录",@"兑奖记录",@"已兑奖品"] delegate:self];
    [self.integralHySegmentControl hideBottomView];
    [self.integralHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.integralHySegmentControl];
    self.integralHySegmentControl.hidden = YES;
    self.integralHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.integralHySegmentControl]) {
            [weakSelf reloadData];
        }
    };
    
    self.productHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"全部作品",@"作业",@"已分享作品"] delegate:self];
    [self.productHySegmentControl hideBottomView];
    [self.productHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.productHySegmentControl];
    self.productHySegmentControl.hidden = YES;
    self.productHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.productHySegmentControl]) {
            [weakSelf reloadData];
        }
    };
    
    self.taskSegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"今日作业",@"历史作业"] delegate:self];
    [self.taskSegmentControl hideBottomView];
    [self.taskSegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.taskSegmentControl];
    self.taskSegmentControl.hidden = YES;
    self.taskSegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.taskSegmentControl]) {
            [weakSelf reloadData];
        }
    };
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 5, self.topView.hd_height + 15, kScreenWidth * 0.8 - 10, kScreenHeight - self.topView.hd_height)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.ptView = [[PTHistogramView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.8 - 10, kScreenHeight - self.navigationView.hd_height - 10)];
    
    [self.backView addSubview:self.ptView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(self.backView.hd_width / 3 - 0.5, kScreenHeight * 0.5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.backView.bounds collectionViewLayout:layout];
    [self.backView addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[PrizeCollectionViewCell class] forCellWithReuseIdentifier:kPrizeCollectionCellID];
    self.collectionView.hidden = YES;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.backView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.tableView registerClass:[StudentProductTableViewCell class] forCellReuseIdentifier:kStudentProductCellID];
    [self.backView addSubview:self.tableView];
    
    self.productTableView = [[UITableView alloc]initWithFrame:self.backView.bounds style:UITableViewStylePlain];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.productTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.productTableView registerClass:[Teacher_studentProductTableViewCell class] forCellReuseIdentifier:kTeacher_studentProductTableViewCellId];
    [self.backView addSubview:self.productTableView];
    
    self.taskTableView = [[UITableView alloc]initWithFrame:self.backView.bounds style:UITableViewStylePlain];
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
    self.taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.taskTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.taskTableView registerClass:[TaskEveryDayListTableViewCell class] forCellReuseIdentifier:kTaskEveryDayListTableViewCellID];
    [self.backView addSubview:self.taskTableView];
    
    self.userTableview = [[UserCenterTableView alloc]initWithFrame:self.backView.bounds];
    [self.backView addSubview:self.userTableview];
    self.userTableview.hidden = YES;
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        switch (type) {
            case UserCenterTableViewType_MyTask:
            {
                TaskListViewController * taskVC = [[TaskListViewController alloc]init];
                taskVC.infoDic = infoDic;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:taskVC animated:NO completion:nil];
                });
            }
                break;
            case UserCenterTableViewType_myCourse:
            {
                if (weakSelf.myCourseHySegmentControl.selectIndex == 0) {
                    MyTaskAttendanceRecordViewController * myTaskattVC = [[MyTaskAttendanceRecordViewController alloc]init];
                    myTaskattVC.myCourseInfo = infoDic;
                    myTaskattVC.isTeacher = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:myTaskattVC animated:NO completion:nil];
                    });
                }
            }
                break;
            
            case UserCenterTableViewType_teacherCourse:
            {
                TeacherCourseListViewController * stuVC = [[TeacherCourseListViewController alloc]init];
                stuVC.infoDic = infoDic;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:stuVC animated:NO completion:nil];
                });
            }
                break;
                
            default:
                break;
        }
    };
    self.userTableview.headRefreshBlock = ^{
        [weakSelf reloadData];
    };
    self.userTableview.shichangBlock = ^(NSDictionary *infoDic) {
        StudyLengthViewController *vc =  [[StudyLengthViewController alloc]init];
        vc.infoDic = infoDic;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:vc animated:NO completion:nil];
        });
    };
    self.failedView = [[FailedView alloc]initWithFrame:self.backView.bounds andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self.backView addSubview:self.failedView];
    self.failedView.hidden = YES;
}
- (void)loadData
{
    self.leftIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.leftDataArr = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"学员信息"},@{@"title":@"学习情况"},@{@"title":@"学员作业"},@{@"title":@"学员作品"},@{@"title":@"课程信息"},@{@"title":@"积分奖品"}]];
    
    self.dataArray = [NSMutableArray array];
    self.basicArray = [NSMutableArray array];
    self.recordArray = [NSMutableArray array];
    self.createArray = [NSMutableArray array];
    
    self.awardPopToatalProductIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.awardPopTaskIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.awardPopHaveShowProductIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.awardListArray = [NSMutableArray array];
    [self.awardListArray addObject:@{@"title":@"录音"}];
    [self.awardListArray addObject:@{@"title":@"创作"}];
    
    [self studentTableviewcellSelect:[NSIndexPath indexPathForRow:0 inSection:0] andTableView:nil];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberInformationWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"],@"isShare":@0} withNotifiedObject:self];
}

- (void)reloadData
{
    //    [SVProgressHUD show];
    if (self.categoryselectIndepath.row == 4)
    {
        if (self.myCourseHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestMyCourseCostWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else if(self.myCourseHySegmentControl.selectIndex == 2)
        {
            [[UserManager sharedManager] didRequestBuyCourseRecordWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else
        {
            [[UserManager sharedManager] didRequestMyCourseListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId],kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }
    }else if (self.categoryselectIndepath.row == 1)
    {
        if (self.achievementHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestMyStudyTimeLengthListWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else if(self.achievementHySegmentControl.selectIndex == 2)
        {
            [[UserManager sharedManager] didRequestMyAchievementListWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
            
        }else
        {
            [[UserManager sharedManager] didRequestPunchCardListWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }
    }else if (self.categoryselectIndepath.row == 5)
    {
        if (self.integralHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestConvertPrizeRecordWith:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else if(self.integralHySegmentControl.selectIndex == 2)
        {
             [[UserManager sharedManager] didRequestComplateConvertPrizeWith:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else
        {
            [[UserManager sharedManager] didRequestMyIntegralRecordWith:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }
    }else if (self.categoryselectIndepath.row == 3)
    {
        if (self.productHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"],@"isShare":@0} withNotifiedObject:self];
        }else if(self.productHySegmentControl.selectIndex == 2)
        {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"],@"isShare":@1} withNotifiedObject:self];
        }else
        {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"],@"isShare":@0} withNotifiedObject:self];
        }
    }else if (self.categoryselectIndepath.row == 2)
    {
        if (self.taskSegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestTeacher_studentHistoryTaskWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
        }else
        {
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
            [[UserManager sharedManager] didRequestMyEveryDayTaskWithWithDic:@{@"dayTime":timeStr,kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
            
        }
    }
}

- (void)refreshUsertableView
{
    NSIndexPath * indexPath = self.categoryselectIndepath;
    if (indexPath.row == 4)
    {
        if (self.myCourseHySegmentControl.selectIndex == 1) {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_courseCost];
        }else if(self.myCourseHySegmentControl.selectIndex == 2)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_buyCourseRecoard];
        }else
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_myCourse];
        }
    }else if (indexPath.row == 1)
    {
        if (self.achievementHySegmentControl.selectIndex == 1) {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_shichang];
        }else if(self.achievementHySegmentControl.selectIndex == 2)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_achievement];
        }else
        {
            [self.navigationView refreshWith:userCenterItemType_explainAndShare];
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_calendr];
        }
    }
    else if (indexPath.row == 5)
    {
        if (self.integralHySegmentControl.selectIndex == 1) {
            self.userTableview.hidden = NO;
            self.collectionView.hidden = YES;
            [self.navigationView refreshWith:userCenterItemType_none];
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_prizeRecord];
        }else if(self.integralHySegmentControl.selectIndex == 2)
        {
            self.userTableview.hidden = YES;
            self.collectionView.hidden = NO;
            [self.navigationView refreshWith:userCenterItemType_none];
            self.collectionDataArray = [[[UserManager sharedManager] getComplateConvertPrizeList] mutableCopy];
            [self.collectionView reloadData];
        }else
        {
            self.collectionView.hidden = YES;
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_integralRecord];
        }
    }else if (indexPath.row == 3)
    {
        if (self.productHySegmentControl.selectIndex == 1) {
            if (self.awardPopTaskIndexpath.row == 0) {
                self.taskProductArray = [[UserManager sharedManager] getMyTaskRecordProductInfoDic];
            }else
            {
                self.taskProductArray = [[UserManager sharedManager] getMyTaskCreatProductInfoDic];
            }
            [self.navigationView refreshLatestViewWith:[[self.awardListArray objectAtIndex:self.awardPopTaskIndexpath.row] objectForKey:@"title"]];
        }else if(self.productHySegmentControl.selectIndex == 2)
        {
            if (self.awardPopTaskIndexpath.row == 0) {
                self.taskProductArray = [[UserManager sharedManager] getMyTaskRecordProduct_shareInfoDic];
            }else
            {
                self.taskProductArray = [[UserManager sharedManager] getMyCreatProduct_shareInfoDic];
            }
            [self.navigationView refreshLatestViewWith:[[self.awardListArray objectAtIndex:self.awardPopHaveShowProductIndexpath.row] objectForKey:@"title"]];
        }else
        {
            if (self.awardPopToatalProductIndexpath.row == 0) {
                self.taskProductArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
            }else
            {
                self.taskProductArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
            }
            [self.navigationView refreshLatestViewWith:[[self.awardListArray objectAtIndex:self.awardPopToatalProductIndexpath.row] objectForKey:@"title"]];
        }
        
        [self addnoDataView];
        [self.productTableView reloadData];
    }
    else if (indexPath.row == 2)
    {
        if (self.taskSegmentControl.selectIndex == 1) {
            self.taskTableView.hidden = YES;
            self.detailBtn.hidden = NO;
            self.ptView.hidden = NO;
        }else
        {
            self.detailBtn.hidden = YES;
            self.ptView.hidden = YES;
            self.taskTableView.hidden = NO;
            self.taskArray = [[UserManager sharedManager] getMyEveryDayTaskListNoClassify];
        }
//        [self addnoDataView];
        [self.taskTableView reloadData];
    }
}

- (void)studentTableviewcellSelect:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView
{
    self.topView.hidden = YES;
    self.tableView.hidden = YES;
    self.userTableview.hidden = YES;
    self.myCourseHySegmentControl.hidden = YES;
    self.achievementHySegmentControl.hidden = YES;
    self.integralHySegmentControl.hidden = YES;
    self.productHySegmentControl.hidden = YES;
    self.taskSegmentControl.hidden = YES;
    self.taskTableView.hidden = YES;
    self.productTableView.hidden = YES;
    self.failedView.hidden = YES;
    self.detailBtn.hidden = YES;
    self.ptView.hidden = YES;
    self.backView.frame = CGRectMake(kScreenWidth * 0.2 + 5, CGRectGetMaxY(self.navigationView.frame) + 5, kScreenWidth * 0.8 - 10, kScreenHeight * 0.85 - 10);
    [self.navigationView refreshWith:userCenterItemType_none];
    
    switch (indexPath.row) {
       case 0:
            self.tableView.hidden = NO;
            self.topView.hidden = NO;
            self.backView.frame = CGRectMake(kScreenWidth * 0.2 + 5, CGRectGetMaxY(self.topView.frame) + 15, kScreenWidth * 0.8 - 10, kScreenHeight  - self.topView.hd_height - 20);
            self.dataArray = self.basicArray;
            break;
        case 4:
        {
            [self.navigationView refreshWith:userCenterItemType_none];
            self.myCourseHySegmentControl.hidden = NO;
            self.userTableview.hidden = NO;
            if (self.myCourseHySegmentControl.selectIndex == 1) {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_courseCost];
            }else if(self.myCourseHySegmentControl.selectIndex == 2)
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_buyCourseRecoard];
            }else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_myCourse];
            }
        }
            break;
        case 1:
        {
            [self.navigationView refreshWith:userCenterItemType_explainAndShare];
            self.achievementHySegmentControl.hidden = NO;
            self.userTableview.hidden = NO;
            if (self.achievementHySegmentControl.selectIndex == 1) {
                [self.navigationView refreshWith:userCenterItemType_none];
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_shichang];
            }else if(self.achievementHySegmentControl.selectIndex == 2)
            {
                [self.navigationView refreshWith:userCenterItemType_none];
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_achievement];
            }else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_calendr];
            }
        }
            break;
        case 5:
        {
            self.integralHySegmentControl.hidden = NO;
            
            if (self.achievementHySegmentControl.selectIndex == 1) {
                self.userTableview.hidden = NO;
                self.collectionView.hidden = YES;
                [self.navigationView refreshWith:userCenterItemType_none];
            }else if(self.achievementHySegmentControl.selectIndex == 2)
            {
                self.userTableview.hidden = YES;
                self.collectionView.hidden = NO;
                [self.navigationView refreshWith:userCenterItemType_none];
                
            }else
            {
                self.collectionView.hidden = YES;
                self.userTableview.hidden = NO;
            }
        }
            break;
        case 3:
        {
            [self.navigationView refreshWith:userCenterItemType_latest];
            [self.navigationView refreshLatestViewWith:@"录音"];
            
            self.productHySegmentControl.hidden = NO;
            self.productTableView.hidden = NO;
            if (self.productHySegmentControl.selectIndex == 1) {
                
            }else if(self.productHySegmentControl.selectIndex == 2)
            {
                
            }else
            {
                
            }
        }
            break;
        case 2:
        {
            self.taskSegmentControl.hidden = NO;
            if (self.taskSegmentControl.selectIndex == 1) {
                self.detailBtn.hidden = NO;
                self.ptView.hidden = NO;
            }else
            {
                self.taskTableView.hidden = NO;
            }
        }
            break;
        
        default:
            break;
    }
    [self reloadData];
    [self.tableView reloadData];
}

- (void)refreshUIWith:(NSDictionary * )infoDic
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"chat_image_normal"]];
    self.studentNameLB.text = [infoDic objectForKey:kUserNickName];
    if ([[infoDic objectForKey:kgender] isEqualToString:@"男"]) {
        self.genderImageView.image = [UIImage imageNamed:@"sex_icon_boy"];
    }else
    {
        self.genderImageView.image = [UIImage imageNamed:@"sex_icon_girl"];
    }
    self.starLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"starCount"]];
    self.flowerLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"flowerCount"]];
    self.goldLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"prizeCount"]];
    
    if ([infoDic objectForKey:@"birthday"] && [[infoDic objectForKey:@"birthday"] length] > 0) {
        self.ageLB.text = [NSString stringWithFormat:@"%ld岁", [self getAgeWith:[infoDic objectForKey:@"birthday"]]];
    }else
    {
        self.ageLB.text = @"1岁";
    }
    
}

#pragma mark - taskType
- (void)showListVIew:(CGRect)rect
{
    if (self.awardPopListView == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.awardPopListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.awardListArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.12];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.awardPopListView];
        
        __weak typeof(self.awardPopListView)weakListView = self.awardPopListView;
        __weak typeof(self)weakSelf = self;
        self.awardPopListView.dismissBlock = ^{
            [weakSelf.navigationView refreshLatestView];
            [weakListView removeFromSuperview];
        };
        self.awardPopListView.SelectBlock = ^(NSDictionary *infoDic) {
            
            if (weakSelf.productHySegmentControl.selectIndex == 1) {
                weakSelf.awardPopTaskIndexpath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"] intValue] inSection:0];
            }else if(weakSelf.productHySegmentControl.selectIndex == 2)
            {
                weakSelf.awardPopHaveShowProductIndexpath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"] intValue] inSection:0];
            }else
            {
                weakSelf.awardPopToatalProductIndexpath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"] intValue] inSection:0];
            }
            
            [weakSelf.navigationView refreshLatestViewWith:[infoDic objectForKey:@"title"]];
            [weakSelf refreshUsertableView];
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.awardPopListView];
        [self.awardPopListView refresh];
    }
}

- (NSInteger)getAgeWith:(NSString *)birthdayStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate * birthDate = [formatter dateFromString:birthdayStr];
    
    NSCalendar * calendaar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents * cmp1 = [calendaar components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
    
    return cmp1.year;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.leftTableView isEqual:tableView]) {
        return self.leftDataArr.count;
    }else if ([self.productTableView isEqual:tableView])
    {
        return self.taskProductArray.count;
    }
    else if ([self.taskTableView isEqual:tableView])
    {
        return self.taskArray.count;
    }
    else
    {
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.leftTableView isEqual:tableView]) {
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.leftDataArr[indexPath.row]];
        if ([indexPath isEqual:self.leftIndexPath]) {
            [cell selectReset];
        }
        return cell;
    }else if ([self.productTableView isEqual:tableView])
    {
        Teacher_studentProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTeacher_studentProductTableViewCellId forIndexPath:indexPath];
        NSDictionary * infodic = [self.taskProductArray objectAtIndex:indexPath.row];
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infodic];
        if (self.productHySegmentControl.selectIndex != 2) {
            [mInfo setObject:[infodic objectForKey:@"productTime"] forKey:@"content"];
        }else
        {
            [mInfo setObject:[infodic objectForKey:@"shareTypeStr"] forKey:@"content"];
        }
        
        [cell refreshWith:mInfo];
        return cell;
    }
    else if ([self.taskTableView isEqual:tableView])
    {
        __weak typeof(self)weakSelf = self;
        TaskEveryDayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTaskEveryDayListTableViewCellID forIndexPath:indexPath];
        cell.isToday = YES;
        cell.isTeacher = YES;
        [cell refreshWith:self.taskArray[indexPath.row]];
        
        return cell;
    }
    else
    {
        if (self.leftIndexPath.row == 0) {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
            [cell.contentView removeAllSubviews];
            
            NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
            UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(cell.hd_height / 2, 0, cell.hd_width / 2 - cell.hd_height / 2, cell.hd_height)];
            titleLB.text = [infoDic objectForKey:@"title"];
            titleLB.textColor = UIColorFromRGB(0x4e4e4e);
            [cell.contentView addSubview:titleLB];
            
            
            UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(cell.hd_width / 2, 0, cell.hd_width / 2 - cell.hd_height * 0.8, cell.hd_height)];
            contentLB.textAlignment = NSTextAlignmentRight;
            contentLB.text = [infoDic objectForKey:@"content"];
            contentLB.textColor = UIColorFromRGB(0x4e4e4e);
            [cell.contentView addSubview:contentLB];
            if (indexPath.row == 7) {
                contentLB.textColor = kCommonMainOringeColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.hd_height - 2, cell.hd_width, 2)];
            bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
            [cell.contentView addSubview:bottomView];
            return cell;
        }else
        {
            StudentProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kStudentProductCellID forIndexPath:indexPath];
            
            [cell resetWithInfoDic:self.dataArray[indexPath.row]];
            
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableView]) {
        self.categoryselectIndepath = indexPath;
        
        self.leftIndexPath = indexPath;
        [self studentTableviewcellSelect:indexPath andTableView:tableView];
        [self.leftTableView reloadData];
        
    }else if ([tableView isEqual:self.productTableView])
    {
        NSLog(@"查看作品");
        NSDictionary * infoDic = [self.taskProductArray objectAtIndex:indexPath.row];
        self.selectProductInfo = infoDic;
        if (self.productHySegmentControl.selectIndex == 0) {
            if (self.awardPopToatalProductIndexpath.row == 0) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }
        }else if (self.productHySegmentControl.selectIndex == 1)
        {
            if (self.awardPopTaskIndexpath.row == 0) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }
        }else
        {
            if (self.awardPopHaveShowProductIndexpath.row == 0) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }
        }
    }else if ([tableView isEqual:self.tableView])
    {
        NSLog(@"info");
        if (indexPath.row == 7) {
            NSLog(@"edit remark");
            NSDictionary * infoDic = [[UserManager sharedManager] getMemberInformation];
            [self changeNameAction:infoDic];
        }
    }
    else
    {
        NSDictionary * infoDic = [self.taskArray objectAtIndex:indexPath.row];
        self.selectProductInfo = infoDic;
    }
}

#pragma mark - 修改备注
- (void)changeNameAction:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    self.changeRemarkTipView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_changeName andTitle:@"修改备注" andPlaceHold:@"请输入备注" withAnimation:NO];
    self.changeRemarkTipView.maxCount = 100;
    [self.changeRemarkTipView resetNameTvText:[infoDic objectForKey:@"remark"]];
    
    self.changeRemarkTipView.DismissBlock = ^{
        ;[weakSelf.changeRemarkTipView removeFromSuperview];
    };
    self.changeRemarkTipView.ContinueBlock = ^(NSString *str) {
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_editStudent_RemarkWithDic:@{kRemark:str,kmemberId:[infoDic objectForKey:kUserId]} withNotifiedObject:weakSelf];
        [weakSelf.changeRemarkTipView removeFromSuperview];
    };
    [self.view addSubview:self.changeRemarkTipView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.tableView isEqual:tableView]) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 2, view.hd_height) andTitle:@"作品"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"时间"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"点评"];
        [view addSubview:timeLB];
        
        UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
        bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [view addSubview:bottomView];
        
        if (self.leftIndexPath.row == 0) {
            return nil;
        }
        return view;
    }else if ([self.taskTableView isEqual:tableView]) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 6, view.hd_height) andTitle:@"作业类型"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width /4, view.hd_height) andTitle:@"作业详情"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 4, view.hd_height) andTitle:@"所属作业"];
        [view addSubview:timeLB];
        
        UILabel * detailLB = [self headLB:CGRectMake(CGRectGetMaxX(timeLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"状态"];
        [view addSubview:detailLB];
        
        UILabel * operationLB = [self headLB:CGRectMake(CGRectGetMaxX(detailLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"操作"];
        [view addSubview:operationLB];
        
        UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
        bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [view addSubview:bottomView];
        
        return view;
    }
    else if ([self.productTableView isEqual:tableView]) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLB = [[UILabel alloc]init];;
        if (self.productHySegmentControl.selectIndex != 1) {
            titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"作品"];
            [view addSubview:titleLB];
        }else
        {
            titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 3, view.hd_height) andTitle:@"作业"];
            [view addSubview:titleLB];
        }
        
        UILabel * contentLB = [[UILabel alloc]init];
        if (self.productHySegmentControl.selectIndex != 2) {
            contentLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"上传时间"];
        }else
        {
            contentLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"已分享至"];
        }
        [view addSubview:contentLB];
        
        UILabel * prizeLB = [self headLB:CGRectMake(CGRectGetMaxX(contentLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"红花/奖章"];
        [view addSubview:prizeLB];
        
        UILabel * commentLB = [self headLB:CGRectMake(CGRectGetMaxX(prizeLB.frame), 0, view.hd_width / 9 * 2, view.hd_height) andTitle:@"点评"];
        [view addSubview:commentLB];
        
        UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
        bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [view addSubview:bottomView];
        
        if (self.leftIndexPath.row == 0) {
            return nil;
        }
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        if (self.leftIndexPath.row == 0) {
            return 0;
        }
        return 50;
    }
    else if ([self.productTableView isEqual:tableView])
    {
        return 50;
    }
    else if ([self.taskTableView isEqual:tableView])
    {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableView]) {
        return kScreenHeight / 8;
    }
    return kScreenHeight * 0.14;
}

- (UILabel *)headLB:(CGRect)rect andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}
- (void)addTopView
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight * 0.24)];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.topView.hd_height * 0.09, self.topView.hd_height * 0.12, self.topView.hd_height * 0.88, self.topView.hd_height * 0.88)];
    self.iconImageView.layer.cornerRadius = 10;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 5;
    self.iconImageView.image = [UIImage imageNamed:@"chat_image_normal"];
    [self.topView addSubview:self.iconImageView];
    
    self.studentNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + self.topView.hd_height * 0.15, self.topView.hd_height * 0.12, self.topView.hd_height * 1.1, self.topView.hd_height * 0.16)];
    self.studentNameLB.text = @"千书堂测试";
    self.studentNameLB.textColor = UIColorFromRGB(0x515151);
    [self.topView addSubview:self.studentNameLB];
    
    self.genderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentNameLB.frame) + 5, self.studentNameLB.hd_y, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    self.genderImageView.layer.cornerRadius = self.genderImageView.hd_height / 2;
    self.genderImageView.layer.masksToBounds = YES;
    self.genderImageView.image = [UIImage imageNamed:@"protect_eye_bg"];
    
    self.ageLB = [[UILabel alloc]initWithFrame:CGRectMake(self.genderImageView.hd_centerX, self.genderImageView.hd_y, self.topView.hd_height * 0.5, self.topView.hd_height * 0.16)];
    self.ageLB.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.ageLB.text = @"1岁";
    self.ageLB.textAlignment = NSTextAlignmentRight;
    self.ageLB.textColor = UIColorFromRGB(0x515151);
    [self.topView addSubview:self.ageLB];
    
    [self.topView addSubview:self.genderImageView];
    
    UIImageView * starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.studentNameLB.hd_x, CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    starImageView.image = [UIImage imageNamed:@"star"];
    [self.topView addSubview:starImageView];
    
    self.starLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starImageView.frame) + 5, starImageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.starLB.textColor = UIColorFromRGB(0x0b0b0b);
    self.starLB.text = @"12";
    [self.topView addSubview:self.starLB];
    
    UIImageView * flowermageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starLB.frame), CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    flowermageView.image = [UIImage imageNamed:@"flower"];
    [self.topView addSubview:flowermageView];
    
    self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(flowermageView.frame) + 5, flowermageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.flowerLB.textColor = UIColorFromRGB(0x0b0b0b);
    self.flowerLB.text = @"11";
    [self.topView addSubview:self.flowerLB];
    
    UIImageView * goldImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerLB.frame), CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    goldImageView.image = [UIImage imageNamed:@"medal_btn"];
    [self.topView addSubview:goldImageView];
    
    self.goldLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goldImageView.frame) + 5, goldImageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.goldLB.text = @"10";
    self.goldLB.textColor = UIColorFromRGB(0x0b0b0b);
    [self.topView addSubview:self.goldLB];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PrizeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrizeCollectionCellID forIndexPath:indexPath];
    cell.isHaveConversion = YES;
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc] initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kPrizeName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:kPrizeIntegral] forKey:@"integral"];
    
    [cell refreshWith:infoDic];
    return cell;
}

- (void)addnoDataView
{
    if (self.categoryselectIndepath.row == 3) {
        if (self.taskProductArray.count == 0) {
            self.failedView.hidden = NO;
        }else
        {
            self.failedView.hidden = YES;
        }
    }else if (self.categoryselectIndepath.row == 5 && self.integralHySegmentControl.selectIndex == 2)
    {
        if (self.collectionDataArray.count == 0) {
            self.failedView.hidden = NO;
        }else
        {
            self.failedView.hidden = YES;
        }
    }
    
    UIImage * image = [UIImage imageNamed:@""];
    NSString * content = @"";
    NSMutableAttributedString * detail ;
    
    
    if ([[UserManager sharedManager] getUserType] == UserType_teacher)
    {
        switch (self.categoryselectIndepath.row) {
            case 3:
            {
                if (self.productHySegmentControl.selectIndex == 0) {
                    image = [UIImage imageNamed:@"default_works_icon"];
                    content = @"暂无作品";
                }else if (self.productHySegmentControl.selectIndex == 1)
                {
                    image = [UIImage imageNamed:@"default_homework_icon"];
                    if (self.awardPopTaskIndexpath.row == 0) {
                        content = @"该学员还未上传过录音作业";
                    }else
                    {
                        content = @"该学员还未上传过创作作业";
                    }
                }else{
                    image = [UIImage imageNamed:@"default_works_icon"];
                    if (self.awardPopHaveShowProductIndexpath.row == 0) {
                        content = @"该学员还未分享过录音作品";
                    }else
                    {
                        content = @"该学员还未分享过创作作品";
                    }
                }
            }
                break;
            case 5:
            {
                image = [UIImage imageNamed:@"default_prize_icon"];
                content = @"暂无已兑奖品";
            }
                break;
            default:
                break;
        }
    }
    
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
    
}

- (void)detailAction{
    TeakEveryDayDetailViewController * vc = [[TeakEveryDayDetailViewController alloc]init];
    vc.isTeacher = YES;
    vc.memberId = [[self.infoDic objectForKey:@"userId"] intValue];
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - remark
- (void)didRequestTeacher_editStudent_remarkSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestClassMemberInformationWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
}

- (void)didRequestTeacher_editStudent_remarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - taskProduct
- (void)didRequestMyProductSuccessed
{
    [self refreshUsertableView];
}

- (void)didRequestMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_studentHistoryTaskSuccessed
{
    NSArray * titleArray = @[@"今日",@"本周",@"上周",@"本月",@"上月"];
    NSArray * complateProgressArr = [[UserManager sharedManager] getTeacherStudentHistoryTaskArray];
    
    NSMutableArray * countArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        if (complateProgressArr.count > i) {
            NSDictionary * infoDic = [complateProgressArr objectAtIndex:i];
            if ([[infoDic objectForKey:@"dayStr"] isEqualToString:[titleArray objectAtIndex:i]]) {
                [countArray addObject:[infoDic objectForKey:@"complete"]];
            }
        }else
        {
            [countArray addObject:@"0"];
        }
    }
    
    [self.ptView refreshUIWithnameArray:titleArray countArray:countArray];
    
    [self refreshUsertableView];
}

- (void)didRequestTeacher_studentHistoryTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - productDetail
- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    
    if (self.isNotFromCommentTaskVC) {
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
        [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
        
        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
        vc.infoDic = infoDic;
        vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
        vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        vc.commentTaskType = CommentTaskType_teacherLookStudent;
        
        vc.productType = ProductType_record;
        
        [self presentViewController:vc animated:NO completion:nil];
        
    }else
    {
        if (self.selectProductBlock) {
            self.selectProductBlock(ProductType_record);
        };
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    return;
    
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyFriendProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    
    if (self.isNotFromCommentTaskVC) {
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
        [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
        
        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
        vc.infoDic = infoDic;
        vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
        vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        vc.commentTaskType = CommentTaskType_teacherLookStudent;
        
        vc.productType = ProductType_create;
        
        [self presentViewController:vc animated:NO completion:nil];
        
    }else
    {
        if (self.selectProductBlock) {
            self.selectProductBlock(ProductType_create);
        };
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
    return;
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}



- (void)didRequestclassMemberInformationSuccessed
{
    [SVProgressHUD dismiss];
    [self.dataArray removeAllObjects];
    NSDictionary * infoDic = [[UserManager sharedManager] getMemberInformation];
    
    NSLog(@"infoDic = %@", infoDic);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshUIWith:infoDic];
    });
    
    [self.basicArray addObject:@{@"title":@"昵称",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"nickName"]]}];
    [self.basicArray addObject:@{@"title":@"用户名",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:kUserName]]}];
    [self.basicArray addObject:@{@"title":@"手机",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"telephone"]]}];
    [self.basicArray addObject:@{@"title":@"城市",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"city"]]}];
    [self.basicArray addObject:@{@"title":@"生日",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"birthday"]]}];
    [self.basicArray addObject:@{@"title":@"班级",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"grade"]]}];
    [self.basicArray addObject:@{@"title":@"有效期",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"validityTime"]]}];
    [self.basicArray addObject:@{@"title":@"备注信息",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"remark"]]}];
    [self.basicArray addObject:@{@"title":@"收货地址",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"receiveAddress"]]}];
    self.dataArray = self.basicArray;
    
    [self.tableView reloadData];
}
- (void)didRequestclassMemberInformationFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestPunchCardListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestPunchCardListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyStudyTimeLengthListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyStudyTimeLengthListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyAchievementListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyAchievementListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyCourseCostSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyCourseCostFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyEveryDayTaskSuccessed
{
    [SVProgressHUD dismiss];
    [self.taskTableView.mj_header endRefreshing];
    [self refreshUsertableView];
}

- (void)didRequestMyEveryDayTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.taskTableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    });
}

#pragma mark - courseRequestDelegate
- (void)didRequestMyCourseListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestBuyCourseRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestBuyCourseRecordFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


#pragma mark - integralRecord
- (void)didRequestMyIntegralRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    
    [self refreshUsertableView];
}

- (void)didRequestMyIntegralRecordFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeRecordFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestComplateConvertPrizeSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestComplateConvertPrizeFailed:(NSString *)failedInfo
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
