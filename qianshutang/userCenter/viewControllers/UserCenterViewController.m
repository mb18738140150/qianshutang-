//
//  UserCenterViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "UserCenterViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "UserInformationTableViewCell.h"
#define kUserInformationCellID @"UserInformationTableViewCell"

#import "ModifyPasswordViewController.h"
#import "BindPhoneNumberViewController.h"
#import "GenderSelectView.h"
#import "GSPickerView.h"
#import "AddressView.h"
#import "NotifiTypeView.h"
#import "ProtectEyeView.h"
#import "ProtectEyeTimeView.h"
#import "UserCenterTableView.h"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "StartCollectionViewCell.h"
#define kStartCellID   @"startCellID"

#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"

#import "TaskListViewController.h"
#import "MyTaskAttendanceRecordViewController.h"
#import "StudentInformationViewController.h"
#import "CommonQuestionViewController.h"
#import "TeacherCourseListViewController.h"
#import "ExplainView.h"
#import "TextbookDetailViewController.h"

#import "CommentTaskViewController.h"
#import "StudyLengthViewController.h"

typedef enum : NSUInteger {
    collectionCellType_product,
    collectionCellType_group,
    
} collectionCellType;


@interface UserCenterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, HttpUploadProtocol, UserInfo_changeIconImage, UserInfo_ChangeNickName, UserInfo_ChangeGender, UserInfo_ChangeBirthday, UserInfo_ChangeReceiveAddress, UserInfo_NotificationNoDisturbConfig, UserInfo_Logout, MyStudy_MyHeadTaskList, UserData_MyCollectiontextBook, UserData_MyBookMarkList,UserData_MyHeadQuestion, UserData_SearchMyCollectiontextBook,UserData_DeleteMyBookmark,UserData_ClearnMyBookmark, MyStudy_MyProduct,MyStudy_ShareMyProduct, MyStudy_DeleteMyProduct, MyStudy_MyCourseList, MyStudy_MyCourseCost, MyStudy_BuyCourseRecord, MyStudy_MyAchievementList, MyStudy_MyStudyTimeLengthList, MyStudy_PunchCardList, UserData_SetaHaveReadQuestion, ActiveStudy_TextBookContentList, UserData_DeleteMyCollectiontextBook,MyClassroom_MyFriendProductDetail,MyClassroom_MyRecordProductDetail,Teacher_MyCourseList,WXApiShareManagerDelegate>

@property (nonatomic, strong)NavigationView * navigationView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSMutableArray * hotArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITableView * informationTableView;
@property (nonatomic, strong)NSMutableArray * informationArray;
@property (nonatomic, strong)NSMutableArray * userINformationArray;
@property (nonatomic, strong)NSMutableArray * systemInformationArray;

@property (nonatomic, strong)UserCenterTableView * userTableview;

@property (nonatomic, strong)HYSegmentedControl * informationSegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  myProductHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  achievementHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  myFriendHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  myCourseHySegmentControl;


@property (nonatomic, strong)NSDictionary * selectProductInfo;// 当前选中作品info
// 朋友type
@property (nonatomic, strong)PopListView * popListView;
@property (nonatomic, strong)NSIndexPath * popIndexpath;
@property (nonatomic, strong)NSMutableArray * friendTypeArray;
@property (nonatomic, strong)UILabel * titleLB;

// 获奖榜单
@property (nonatomic, strong)PopListView * awardPopListView;
@property (nonatomic, strong)NSIndexPath * awardPopIndexpath;
@property (nonatomic, strong)NSMutableArray * awardListArray;

// 管理
@property (nonatomic, strong)PopListView * operationPopListView;
@property (nonatomic, strong)NSIndexPath * operationPopIndexpath;
@property (nonatomic, strong)NSMutableArray * operationListArray;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;
@property (nonatomic, strong)NSMutableArray * productArray;
@property (nonatomic, strong)NSMutableArray * groupArray;
@property (nonatomic, assign)collectionCellType collectionCellType;

@property (nonatomic, assign)BOOL isMyProductDelete;//是否删除我的作品
@property (nonatomic, assign)BOOL isMyproductShare;//是否分享我的作品
@property (nonatomic, assign)BOOL isMyCollectDelete;//是否删除我的收藏
@property (nonatomic, assign)BOOL isMyCollectShare;//是否分享我的收藏
@property (nonatomic, assign)BOOL isMyBookmarkDelete;//是否删除我的标签
@property (nonatomic, strong)NSMutableArray * myCollectSelectArray;// 分享我的收藏选中课本列表
@property (nonatomic, assign)BOOL isSearchTextBook;

@property (nonatomic, strong)NSDictionary * currentSelectPlayTextbook;// 当前选中课本

@property (nonatomic,strong)GSPickerView *pickerView;

// 个人信息设置
@property (nonatomic, strong)NSString * userNameStr;
@property (nonatomic, strong)NSString * genderStr;
@property (nonatomic, strong)NSString * birthdayStr;
@property (nonatomic, strong)NSDictionary * addressInfoDic;
@property (nonatomic, strong)NSString * notificationNoDisturb;
@property (nonatomic, strong)NSString * iconImageUrl;

@property (nonatomic, strong)ToolTipView * deleteMyProductTipView;

@property (nonatomic, strong)FailedView * failedView;// 暂无数据view
@property (nonatomic, assign)ShareObjectType shareType;// 分享类型
@property (nonatomic, strong)NSDictionary * currentSelectShareInfoDic;// 当前选中分享对象
@property (nonatomic, assign)BOOL isShareApp;

@end

@implementation UserCenterViewController

- (NSMutableArray *)friendTypeArray
{
    if (!_friendTypeArray) {
        _friendTypeArray = [NSMutableArray array];
    }
    return _friendTypeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
    [[WXApiShareManager shareManager] setDelegate:self];
}

- (NSMutableArray *)myCollectSelectArray
{
    if (!_myCollectSelectArray) {
        _myCollectSelectArray = [NSMutableArray array];
    }
    return _myCollectSelectArray;
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        // 老师端个人中心
        [self.tableDataArray addObject:@{@"title":@"信息设置"}];
        [self.tableDataArray addObject:@{@"title":@"我的作品"}];
        [self.tableDataArray addObject:@{@"title":@"我的课程"}];
//        [self.tableDataArray addObject:@{@"title":@"我的朋友"}];
        [self.tableDataArray addObject:@{@"title":@"收藏内容"}];
        [self.tableDataArray addObject:@{@"title":@"阅读书签"}];
        [self.tableDataArray addObject:@{@"title":@"使用帮助"}];
    }else if ([[UserManager sharedManager] getUserType] == UserType_student)
    {
        // 学生端个人中心
        [self.tableDataArray addObject:@{@"title":@"信息设置"}];
        [self.tableDataArray addObject:@{@"title":@"我的作品"}];
        [self.tableDataArray addObject:@{@"title":@"我的作业"}];
        [self.tableDataArray addObject:@{@"title":@"我的课程"}];
        [self.tableDataArray addObject:@{@"title":@"学习成就"}];
//        [self.tableDataArray addObject:@{@"title":@"我的朋友"}];
        [self.tableDataArray addObject:@{@"title":@"收藏内容"}];
        [self.tableDataArray addObject:@{@"title":@"阅读书签"}];
        [self.tableDataArray addObject:@{@"title":@"使用帮助"}];
    }
    
    
    self.friendTypeArray = [NSMutableArray array];
    [self.friendTypeArray addObject:@{@"title":@"好友"}];
    [self.friendTypeArray addObject:@{@"title":@"群组"}];
    [self.friendTypeArray addObject:@{@"title":@"消息"}];
    
    self.awardListArray = [NSMutableArray array];
    [self.awardListArray addObject:@{@"title":@"总榜"}];
    [self.awardListArray addObject:@{@"title":@"本月"}];
    [self.awardListArray addObject:@{@"title":@"上月"}];
    [self.awardListArray addObject:@{@"title":@"本周"}];
    [self.awardListArray addObject:@{@"title":@"上周"}];
    [self.awardListArray addObject:@{@"title":@"自定义"}];
    
    self.operationListArray = [NSMutableArray array];
//    [self.operationListArray addObject:@{@"title":@"分享"}];
    [self.operationListArray addObject:@{@"title":@"删除"}];
    
    NSDictionary * userInfoDic = [[UserManager sharedManager] getUserInfos];
    
    self.informationArray = [NSMutableArray array];
    self.userINformationArray = [NSMutableArray array];
    [self.userINformationArray addObject:@{@"title":@"头像",@"content":[userInfoDic objectForKey:kUserHeaderImageUrl],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"昵称",@"content":[userInfoDic objectForKey:kUserNickName],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"密码",@"content":@"修改密码",@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"用户名",@"content":[userInfoDic objectForKey:kUserName],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"手机号",@"content":[userInfoDic objectForKey:kUserTelephone],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"有效期",@"content":[userInfoDic objectForKey:kvalidityTime],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"性别",@"content":[userInfoDic objectForKey:kgender],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"生日",@"content":[userInfoDic objectForKey:kbirthday],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"城市",@"content":[userInfoDic objectForKey:kCity],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"收货地址",@"content":[userInfoDic objectForKey:kreceiveAddress],@"imageStr":@"head_portrait"}];
    
    self.informationArray = self.userINformationArray;
    
    self.systemInformationArray = [NSMutableArray array];
    NSString * notify = @"";
    if ([[userInfoDic objectForKey:knotificationNoDisturb] intValue] == 0) {
        notify = @"关闭";
    }else
    {
        notify = @"开启";
    }
    [self.systemInformationArray addObject:@{@"title":@"聊天消息免打扰",@"content":@"关闭",@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"护眼模式",@"content":@"无限制",@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"清除缓存",@"content":@"",@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"当前版本",@"content":@"2.3445.3（已是最新版本）",@"imageStr":@"head_portrait"}];
    
    self.collectionDataArray = [NSMutableArray array];
    self.productArray = [NSMutableArray array];
    self.groupArray = [NSMutableArray array];
    
    
    self.collectionDataArray = self.productArray;
    
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.shareBlock = ^(BOOL isShare) {
        if (weakSelf.categoryselectIndepath.row == 1) {
            if (isShare) {
                weakSelf.isMyproductShare = YES;
                [weakSelf.collectionView reloadData];
            }else
            {
                weakSelf.isMyproductShare = NO;
                [weakSelf.collectionView reloadData];
            }
        }else if (weakSelf.categoryselectIndepath.row == 0)
        {
            [weakSelf shareAPP];
        }
    };
    self.navigationView.deleteBlock = ^(BOOL isDelete) {
        if (weakSelf.categoryselectIndepath.row == 1) {
#pragma mark             // 删除我的作品
            if (isDelete) {
                weakSelf.isMyProductDelete = YES;
                [weakSelf.collectionView reloadData];
            }else
            {
                weakSelf.isMyProductDelete = NO;
                [weakSelf.collectionView reloadData];
            }
            return ;
        }
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            if (weakSelf.categoryselectIndepath.row == 4)
            {
                if (isDelete) {
                    weakSelf.isMyBookmarkDelete = YES;
                    weakSelf.userTableview.isMyBookmarkDelete = YES;
                }else
                {
                    weakSelf.isMyBookmarkDelete = NO;
                    weakSelf.userTableview.isMyBookmarkDelete = NO;
                }
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
            }
        }else
        {
            if (weakSelf.categoryselectIndepath.row == 6)
            {
                if (isDelete) {
                    weakSelf.isMyBookmarkDelete = YES;
                    weakSelf.userTableview.isMyBookmarkDelete = YES;
                }else
                {
                    weakSelf.isMyBookmarkDelete = NO;
                    weakSelf.userTableview.isMyBookmarkDelete = NO;
                }
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
            }
        }
    };

    self.navigationView.cleanBlock = ^(BOOL isClean) {
#pragma mark        // 清空阅读书签
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestClearnMyBookmarkListWithWithDic:@{} withNotifiedObject:weakSelf];
    };
    self.navigationView.explainBlock = ^{
        ExplainView * explainView = [[ExplainView alloc]initWithFrame:weakSelf.view.bounds];
        [weakSelf.view addSubview:explainView];
    };
    
    self.navigationView.quitBlock = ^{
        [SVProgressHUD show];
        NSString * cid = [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
        if (cid && cid.length > 0) {
            [[UserManager sharedManager] didRequestlogoutWithWithDic:@{@"CID":cid} withNotifiedObject:weakSelf];
        }else
        {
            [[UserManager sharedManager] didRequestlogoutWithWithDic:@{@"CID":@""} withNotifiedObject:weakSelf];
        }
    };
    
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        if (weakSelf.categoryselectIndepath.row == 7) {
#pragma mark - 设为已读
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestSetaHaveReadQuestionWithWithDic:@{kHeadQuestionId:@(0)} withNotifiedObject:weakSelf];
            return ;
        }
        if (isShow) {
            [weakSelf showListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
        }else
        {
            [weakSelf.awardPopListView removeFromSuperview];
        }
    };
    self.navigationView.OperationBlock = ^(BOOL isShow,CGRect rect) {
        if (isShow) {
            [weakSelf showOperationListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
        }else
        {
            [weakSelf.operationPopListView removeFromSuperview];
        }
    };
    self.navigationView.cancelOperationBlock = ^(BOOL isCancel) {
        [weakSelf.myCollectSelectArray removeAllObjects];
        weakSelf.isMyCollectDelete = NO;
        weakSelf.isMyCollectShare = NO;
        [weakSelf.collectionView reloadData];
    };
    
    self.navigationView.sureShareListBlock = ^(BOOL isShare) {
        for (int i = 0; i < weakSelf.myCollectSelectArray.count; i++) {
            NSDictionary * infoDic = [weakSelf.myCollectSelectArray objectAtIndex:i];
            NSLog(@"%@", [infoDic objectForKey:@"title"]);
        }
        [weakSelf.myCollectSelectArray removeAllObjects];
    };
    self.navigationView.searchBlock = ^(BOOL isSearch){
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            if (weakSelf.categoryselectIndepath.row == 3) {
                if (isSearch) {
                    [weakSelf searchCollectTextBook];
                }else
                {
                    weakSelf.isSearchTextBook = NO;
                    [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearchTextBook];
                    [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:weakSelf];
                }
            }
            return ;
        }
        
        if (weakSelf.categoryselectIndepath.row == 5) {
            if (isSearch) {
                [weakSelf searchCollectTextBook];
            }else
            {
                weakSelf.isSearchTextBook = NO;
                [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearchTextBook];
                [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:weakSelf];
            }
        }
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.informationSegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"个人信息",@"系统设置"] delegate:self];
    [self.informationSegmentControl hideBottomView];
    [self.informationSegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.informationSegmentControl];
    self.informationSegmentControl.hidden = NO;
    self.informationSegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.informationSegmentControl]) {
            if (index == 0) {
                weakSelf.informationArray = weakSelf.userINformationArray;
            }else
            {
                weakSelf.informationArray = weakSelf.systemInformationArray;
            }
            [weakSelf.informationTableView reloadData];
        }
    };
    
    if ([[UserManager sharedManager] getUserType] == UserType_student) {
        self.myProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    }else if ([[UserManager sharedManager] getUserType] == UserType_teacher)
    {
        self.myProductHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"讲解作品",@"创作作品"] delegate:self];
    }
    [self.myProductHySegmentControl hideBottomView];
    [self.myProductHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.myProductHySegmentControl];
    self.myProductHySegmentControl.hidden = YES;
    self.myProductHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.myProductHySegmentControl]) {
            if (index == 0) {
                weakSelf.collectionDataArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
                [weakSelf addnoDataView];
                [weakSelf.collectionView reloadData];
            }else
            {
                weakSelf.collectionDataArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
                [weakSelf addnoDataView];
                [weakSelf.collectionView reloadData];
            }
        }
    };
    
    self.achievementHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"学习打卡",@"学习时长",@"成就"] delegate:self];
    [self.achievementHySegmentControl hideBottomView];
    [self.achievementHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.achievementHySegmentControl];
    self.achievementHySegmentControl.hidden = YES;
    self.achievementHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.achievementHySegmentControl]) {
            
            [SVProgressHUD show];
            if (self.achievementHySegmentControl.selectIndex == 1) {
                [weakSelf.navigationView refreshWith:userCenterItemType_none];
                [[UserManager sharedManager] didRequestMyStudyTimeLengthListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }else if(self.achievementHySegmentControl.selectIndex == 2)
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_none];
                [[UserManager sharedManager] didRequestMyAchievementListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }else
            {
                [[UserManager sharedManager] didRequestPunchCardListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }
        }
    };
    
    self.myCourseHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"我的课程",@"课耗记录",@"购课记录"] delegate:self];
    [self.myCourseHySegmentControl hideBottomView];
    [self.myCourseHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.myCourseHySegmentControl];
    self.myCourseHySegmentControl.hidden = YES;
    self.myCourseHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.myCourseHySegmentControl]) {
            
            if (weakSelf.myCourseHySegmentControl.selectIndex == 1) {
                [[UserManager sharedManager] didRequestMyCourseCostWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }else if(weakSelf.myCourseHySegmentControl.selectIndex == 2)
            {
                [[UserManager sharedManager] didRequestBuyCourseRecordWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }else
            {
                [[UserManager sharedManager] didRequestMyCourseListWithWithDic:@{kClassroomId:@(0),kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:weakSelf];
            }
        }
    };
    
    self.myFriendHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"校友",@"星星榜",@"红花榜",@"奖章榜"] delegate:self];
    [self.myFriendHySegmentControl hideBottomView];
    [self.myFriendHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.myFriendHySegmentControl];
    self.myFriendHySegmentControl.hidden = YES;
    self.myFriendHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.myFriendHySegmentControl]) {
            
            weakSelf.userTableview.hidden = NO;
            weakSelf.collectionView.hidden = YES;
            if (index == 1) {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
            }else if(index == 2)
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
            }else if (index == 3)
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
            }else
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_addAndDelete];
                weakSelf.userTableview.hidden = YES;
                weakSelf.collectionCellType = collectionCellType_group;
                weakSelf.collectionView.hidden = NO;
                weakSelf.collectionDataArray = weakSelf.groupArray;
                [weakSelf.collectionView reloadData];
            }
            
        }
    };
   
    self.categoryselectIndepath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.popIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 10, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.informationTableView = [[UITableView alloc]initWithFrame:self.backView.bounds style:UITableViewStylePlain];
    self.informationTableView.delegate = self;
    self.informationTableView.dataSource = self;
    [self.informationTableView registerClass:[UserInformationTableViewCell class] forCellReuseIdentifier:kUserInformationCellID];
    [self.backView addSubview:self.informationTableView];
    
    
    
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
    [self.collectionView registerClass:[StartCollectionViewCell class] forCellWithReuseIdentifier:kStartCellID];
    [self.collectionView registerClass:[CreatProductionCollectionViewCell class] forCellWithReuseIdentifier:kCreatProductionCellID];
    self.collectionView.hidden = YES;
    
    self.failedView = [[FailedView alloc]initWithFrame:self.backView.bounds andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self.backView addSubview:self.failedView];
    self.failedView.hidden = YES;
    
    
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
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:myTaskattVC animated:NO completion:nil];
                    });
                }
            }
                break;
            case UserCenterTableViewType_flower:
            case UserCenterTableViewType_star:
            case UserCenterTableViewType_gold:
            {
                StudentInformationViewController * stuVC = [[StudentInformationViewController alloc]init];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:stuVC animated:NO completion:nil];
                });
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
            case UserCenterTableViewType_bookmark:
            {
                if (weakSelf.isMyBookmarkDelete) {
#pragma mark                    // 删除阅读书签
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestDeleteMyBookmarkWithWithDic:@{kBookmarkId:[infoDic objectForKey:kBookmarkId]} withNotifiedObject:weakSelf];
                    return ;
                }
                
#pragma nark - bookmark click
                NSMutableDictionary * info = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                [info setObject:[infoDic objectForKey:kTextBookId] forKey:kitemId];
                weakSelf.currentSelectPlayTextbook = info;
                
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:kTextBookId]} withNotifiedObject:weakSelf];
                
            }
                break;
                
            default:
                break;
        }
    };
    self.userTableview.headRefreshBlock = ^{
        [weakSelf reloadStudentTableData];
    };
    self.userTableview.shichangBlock = ^(NSDictionary *infoDic) {
        StudyLengthViewController *vc =  [[StudyLengthViewController alloc]init];
        vc.infoDic = infoDic;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:vc animated:NO completion:nil];
        });
    };
    
//    self.collectionBackView = [[UIImageView alloc]initWithFrame:self.collectionView.frame];
//    [self.backView addSubview:self.collectionBackView];
    
}

#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return self.tableDataArray.count;
    }else
    {
        if (self.categoryselectIndepath.row == 0) {
            return self.informationArray.count;
        }
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView isEqual:tableView]) {
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            if (indexPath.row == 3) {
                cell.ishaveCategory = YES;
            }else
            {
            }
            cell.ishaveCategory = NO;
            
        }else
        {
            if (indexPath.row == 5) {
                cell.ishaveCategory = YES;
            }else
            {
            }
            cell.ishaveCategory = NO;
        }
        
        
        [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
        if ([indexPath isEqual:self.categoryselectIndepath]) {
            [cell selectReset];
        }
        
        return cell;
    }
    else if ([self.informationTableView isEqual:tableView])
    {
        
        UserInformationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kUserInformationCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.informationSegmentControl.selectIndex == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 3 || indexPath.row == 5) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.informationCellType = InformationTableCellType_nomal;
            if (indexPath.row == 0) {
                cell.informationCellType = InformationTableCellType_icon;
            }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == self.informationArray.count - 1)
            {
                cell.informationCellType = InformationTableCellType_color;
            }
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 3 ) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.informationCellType = InformationTableCellType_nomal;
            if (indexPath.row == 0) {
                cell.informationCellType = InformationTableCellType_color;
            }
        }
        
        
        [cell resetWith:self.informationArray[indexPath.row]];
        
        cell.modifyIconBlock = ^(BOOL isChange) {
            ;
        };
        cell.modifyInformationBlock = ^(NSDictionary *infoDic) {
            ;
        };
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.informationTableView]) {
        return kScreenHeight * 0.15;
    }
    
    return kScreenHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([tableView isEqual:self.tableView]) {
        
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            [self teacherTableviewcellSelect:indexPath andTableView:tableView] ;
        }else if ([[UserManager sharedManager] getUserType] == UserType_student)
        {
            [self studentTableviewcellSelect:indexPath andTableView:tableView];
        }
    }else if ([self.informationTableView isEqual:tableView])
    {
        if (self.informationSegmentControl.selectIndex == 0) {
            
            [self setUserInformation:indexPath.row andInfoDic:self.informationArray[indexPath.row]];
            
        }else
        {
            [self setSystemInformation:indexPath.row andInfoDic:self.informationArray[indexPath.row]];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionCellType == collectionCellType_group) {
        TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
        
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
#pragma mark - teacher
            NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
            if (self.categoryselectIndepath.row == 5) {
                [cell showContentNumberWith:[[infoDic objectForKey:kNewHeadQuestionCount] intValue]];
            }else if (self.categoryselectIndepath.row == 3)
            {
                NSMutableDictionary * minfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.item]];
                [minfoDic setObject:[infoDic objectForKey:kitemType] forKey:@"type"];
                [cell resetWithInfoDic:minfoDic];
                // 我的收藏分享、删除设置
                if (self.isMyCollectDelete) {
                    [cell deleteReset];
                }
                if (self.isMyCollectShare) {
                    NSDictionary * infoDick = self.collectionDataArray[indexPath.row];
                    if ([self.myCollectSelectArray containsObject:infoDick]) {
                        [cell shareSelectReset];
                    }else
                    {
                        [cell shareNoSelectReset];
                    }
                }
            }
        }else if ([[UserManager sharedManager] getUserType] == UserType_student)
        {
#pragma mark - student
            NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
            if (self.categoryselectIndepath.row == 7) {
                [cell showContentNumberWith:[[infoDic objectForKey:kNewHeadQuestionCount] intValue]];
            }else if (self.categoryselectIndepath.row == 5)
            {
                NSMutableDictionary * minfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.item]];
                [minfoDic setObject:[infoDic objectForKey:kitemType] forKey:@"type"];
                [cell resetWithInfoDic:minfoDic];
                // 我的收藏分享、删除设置
                if (self.isMyCollectDelete) {
                    [cell deleteReset];
                }
                if (self.isMyCollectShare) {
                    NSDictionary * infoDick = self.collectionDataArray[indexPath.row];
                    if ([self.myCollectSelectArray containsObject:infoDick]) {
                        [cell shareSelectReset];
                    }else
                    {
                        [cell shareNoSelectReset];
                    }
                }
            }
        }
        
        return cell;
    }else
    {
        CreatProductionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCreatProductionCellID forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.isHaveComment = YES;
        }else
        {
            cell.isHaveComment = NO;
        }
        
        [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
        
            if (self.isMyProductDelete) {
                [cell resetDeleteView];
            }
        if (self.isMyproductShare) {
            [cell resetShareView];
        }
        
        if (self.categoryselectIndepath.row == 1) {
            __weak typeof(self)weakSelf = self;
            cell.delateBlock = ^(NSDictionary *infoDic) {
                
                [SVProgressHUD show];
                int productType = 0;
                if (self.myProductHySegmentControl.selectIndex == 1) {
                    productType = 2;
                }else
                {
                    productType = 1;
                }
                
                [[UserManager sharedManager] didRequestDeleteMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId],@"productType":@(productType)} withNotifiedObject:weakSelf];            };
            cell.shareBlock = ^(NSDictionary *infoDic) {
                [weakSelf shareMyProduct:infoDic];
            };
        }
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionCellType == collectionCellType_product) {
        return CGSizeMake(self.backView.hd_width / 4 - 0.5, self.backView.hd_width / 4  + 30);
    }else if (self.collectionCellType == collectionCellType_group )
    {
        return CGSizeMake(self.backView.hd_width / 4  - 0.5, self.backView.hd_width / 4  + 15);
    }
    
    return CGSizeZero;
}

- (void)shareMyProduct:(NSDictionary *)model
{
#pragma mark                分享我的作品
    self.currentSelectShareInfoDic = model;
    self.isShareApp = NO;
    ShareView * shareView = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_productShowAndWeixin];
    [self.view addSubview:shareView];
    shareView.shareBlock = ^(NSDictionary *infoDic) {
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case ShareObjectType_ProductShow:
            {
                [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[model objectForKey:kProductId],kshareType:@(1)} withNotifiedObject:self];
            }
                break;
            case ShareObjectType_weixinFriend:
            {
                // 分享给微信好友
                self.shareType = ShareObjectType_weixinFriend;
                [[WXApiShareManager shareManager] shareToSessionWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_friendCircle:
            {
                // 分享给微信朋友圈
                self.shareType = ShareObjectType_friendCircle;
                [[WXApiShareManager shareManager] shareToTimelineWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_WeixinCollect:
            {
                // 分享给微信收藏
                self.shareType = ShareObjectType_WeixinCollect;
                [[WXApiShareManager shareManager] shareToFavoriteWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
                
            default:
                break;
        }
    };
    
    return;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
//        if (self.categoryselectIndepath.row == 3 && self.popIndexpath.row == 0) {
//            StudentInformationViewController * stuVC = [[StudentInformationViewController alloc]init];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [self presentViewController:stuVC animated:NO completion:nil];
//            });
//        }else
        if (self.categoryselectIndepath.row == 5)
        {
            CommonQuestionViewController * vc = [[CommonQuestionViewController alloc]init];
            vc.infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
            [self presentViewController:vc animated:NO completion:nil];
        }
        else if (self.categoryselectIndepath.row == 3)
        {// 我的收藏删除、分享点击事件
            NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
            if (self.isMyCollectShare) {
#pragma mark               分享我的收藏
                if ([self.myCollectSelectArray containsObject:infoDic]) {
                    [self.myCollectSelectArray removeObject:infoDic];
                }else
                {
                    [self.myCollectSelectArray addObject:infoDic];
                }
                [self addnoDataView];
                [self.collectionView reloadData];
                return;
            }
            if (self.isMyCollectDelete) {
#pragma mark              delete我的收藏
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestDeleteMyCollectionTextBookWithWithDic:@{kTextBookId:[infoDic objectForKey:@"collectId"]} withNotifiedObject:self];
                return;
            }
#pragma mark - 判断收藏类型
            
            self.currentSelectPlayTextbook = infoDic;
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:kitemId]} withNotifiedObject:self];
            return;
        }else if (self.categoryselectIndepath.row == 1)
        {
            
            NSDictionary * model = self.collectionDataArray[indexPath.row];
            self.selectProductInfo = model;
            if (self.isMyproductShare) {
#pragma mark                分享我的作品
                [self shareMyProduct:model];
                
                
                return;
            }
            if (self.isMyProductDelete) {
#pragma mark               delete我的作品
                
                self.deleteMyProductTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"提示" withAnimation:YES];
                if ([[model objectForKey:kuserWorkId] intValue] != 0) {
                    
                    NSString * tipStr = @"";
                    if (self.myProductHySegmentControl.selectIndex == 0) {
                        tipStr = [NSString stringWithFormat:@"该录音来源于作业，删除后会影响您的作业，确定删除%@?", [model objectForKey:kProductId]];
                    }else
                    {
                        tipStr = [NSString stringWithFormat:@"该作品来源于作业，删除后会影响您的作业，确定删除创作作业?"];
                    }
                    
                    [self.deleteMyProductTipView resetContentLbTetx:[NSString stringWithFormat:tipStr, [model objectForKey:kProductName]]];
                }else
                {
                    [self.deleteMyProductTipView resetContentLbTetx:[NSString stringWithFormat:@"删除：%@？", [model objectForKey:kProductName]]];
                }
                [self.view addSubview:self.deleteMyProductTipView];
                self.deleteMyProductTipView.DismissBlock = ^{
                    [weakSelf.deleteMyProductTipView removeFromSuperview];
                };
                self.deleteMyProductTipView.ContinueBlock = ^(NSString *str) {
                    [SVProgressHUD show];
                    
                    int productType = 0;
                    if (self.myProductHySegmentControl.selectIndex == 1) {
                        productType = 2;
                    }else
                    {
                        productType = 1;
                    }
                    
                    [[UserManager sharedManager] didRequestDeleteMyProductWithWithDic:@{kProductId:[model objectForKey:kProductId],@"productType":@(productType)} withNotifiedObject:weakSelf];
                    [weakSelf.deleteMyProductTipView removeFromSuperview];
                    weakSelf.deleteMyProductTipView = nil;
                };
                
                return;
            }
            
            if (self.myProductHySegmentControl.selectIndex == 1) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId]} withNotifiedObject:self];
            }
            
            return;
        }
    }else if ([[UserManager sharedManager] getUserType] == UserType_student)
    {
        if (self.categoryselectIndepath.row == 1) {
            
            NSDictionary * model = self.collectionDataArray[indexPath.row];
            self.selectProductInfo = model;
            if (self.isMyproductShare) {
#pragma mark                分享我的作品
                [self shareMyProduct:model];
//                ShareView * shareView = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_productShowAndWeixin];
//                [self.view addSubview:shareView];
//                shareView.shareBlock = ^(NSDictionary *infoDic) {
//                    switch ([[infoDic objectForKey:@"type"] integerValue]) {
//                        case ShareObjectType_ProductShow:
//                        {
//                            [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[model objectForKey:kProductId]} withNotifiedObject:weakSelf];
//                        }
//                            break;
//                        case ShareObjectType_weixinFriend:
//                        {
//                            // 分享给微信好友
//                        }
//                            break;
//                        case ShareObjectType_friendCircle:
//                        {
//                            // 分享给微信朋友圈
//                        }
//                            break;
//                        case ShareObjectType_WeixinCollect:
//                        {
//                            // 分享给微信收藏
//                        }
//                            break;
//
//                        default:
//                            break;
//                    }
//                };
                
                return;
            }
            if (self.isMyProductDelete) {
 #pragma mark               delete我的作品
                
                self.deleteMyProductTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"提示" withAnimation:YES];
                if ([[model objectForKey:kuserWorkId] intValue] != 0) {
                    
                    NSString * tipStr = @"";
                    if (self.myProductHySegmentControl.selectIndex == 0) {
                        tipStr = [NSString stringWithFormat:@"该录音来源于作业，删除后会影响您的作业，确定删除%@?", [model objectForKey:kProductId]];
                    }else
                    {
                        tipStr = [NSString stringWithFormat:@"该作品来源于作业，删除后会影响您的作业，确定删除创作作业?"];
                    }
                    
                    [self.deleteMyProductTipView resetContentLbTetx:[NSString stringWithFormat:tipStr, [model objectForKey:kProductName]]];
                }else
                {
                    [self.deleteMyProductTipView resetContentLbTetx:[NSString stringWithFormat:@"删除：%@？", [model objectForKey:kProductName]]];
                }
                [self.view addSubview:self.deleteMyProductTipView];
                self.deleteMyProductTipView.DismissBlock = ^{
                    [weakSelf.deleteMyProductTipView removeFromSuperview];
                };
                self.deleteMyProductTipView.ContinueBlock = ^(NSString *str) {
                    [SVProgressHUD show];
                    
                    int productType = 0;
                    if (self.myProductHySegmentControl.selectIndex == 1) {
                        productType = 2;
                    }else
                    {
                        productType = 1;
                    }
                    
                    [[UserManager sharedManager] didRequestDeleteMyProductWithWithDic:@{kProductId:[model objectForKey:kProductId],@"productType":@(productType)} withNotifiedObject:weakSelf];
                    [weakSelf.deleteMyProductTipView removeFromSuperview];
                    weakSelf.deleteMyProductTipView = nil;
                };
                
                return;
            }
            
            if (self.myProductHySegmentControl.selectIndex == 1) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId]} withNotifiedObject:self];
            }
            
            return;
        }else if (self.categoryselectIndepath.row == 5)
        {// 我的收藏删除、分享点击事件
            NSDictionary * infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
            if (self.isMyCollectShare) {
 #pragma mark               分享我的收藏
                if ([self.myCollectSelectArray containsObject:infoDic]) {
                    [self.myCollectSelectArray removeObject:infoDic];
                }else
                {
                    [self.myCollectSelectArray addObject:infoDic];
                }
                [self addnoDataView];
                [self.collectionView reloadData];
                return;
            }
            if (self.isMyCollectDelete) {
  #pragma mark              delete我的收藏
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestDeleteMyCollectionTextBookWithWithDic:@{kTextBookId:[infoDic objectForKey:@"collectId"]} withNotifiedObject:self];
                return;
            }
#pragma mark - 判断收藏类型
            
            self.currentSelectPlayTextbook = infoDic;
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:kitemId]} withNotifiedObject:self];
            return;
        }
        
        if (self.categoryselectIndepath.row == 5 && self.popIndexpath.row == 0) {
            StudentInformationViewController * stuVC = [[StudentInformationViewController alloc]init];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self presentViewController:stuVC animated:NO completion:nil];
            });
        }else if (self.categoryselectIndepath.row == 7)
        {
            CommonQuestionViewController * vc = [[CommonQuestionViewController alloc]init];
            vc.infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
            [self presentViewController:vc animated:NO completion:nil];
        }
    }
}


- (void)studentTableviewcellSelect:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView
{
    
    self.categoryselectIndepath = indexPath;
    
    [self.navigationView showSearch];
    [self showSegmentWith:100];
    self.titleLB.hidden = NO;
    self.failedView.hidden = YES;
    
    if(indexPath.row == 2)
    {
        [self.navigationView refreshWith:userCenterItemType_none];
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_MyTask];
        self.titleLB.text = @"我的作业";
        self.userTableview.hidden = NO;
        self.informationTableView.hidden = YES;
        self.collectionView.hidden = YES;

    }else if (indexPath.row == 5)
    {
        [self.navigationView refreshWith:userCenterItemType_searchAndOperation];
        self.titleLB.text = @"收藏内容";
        self.collectionDataArray = self.groupArray;
        self.collectionCellType = collectionCellType_group;
        [self addnoDataView];
        [self.collectionView reloadData];
        self.collectionView.hidden = NO;
    }else if (indexPath.row == 6)
    {
        [self.navigationView refreshWith:userCenterItemType_delete];
        self.titleLB.text = @"阅读书签";
        self.userTableview.hidden = NO;
        self.informationTableView.hidden = YES;
        self.collectionView.hidden = YES;
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
    }
    else if (indexPath.row == 7)
    {
        [self.navigationView refreshWith:userCenterItemType_haveRead];
        self.collectionCellType = collectionCellType_group;
        self.titleLB.text = @"使用帮助";
        self.collectionView.hidden = NO;
        self.collectionDataArray = self.groupArray;
        [self addnoDataView];
        [self.collectionView reloadData];
    }
//    else if (indexPath.row == 5)
//    {
//        [self showSegmentWith:indexPath.row];
//
//        MainLeftTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        CGRect cellRect = [cell.titleLB convertRect:cell.titleLB.bounds toView:self.view];
//
//        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width, cellRect.size.height / 2 + cellRect.origin.y);
//
//        if (self.popListView == nil) {
//
//            self.popListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.friendTypeArray anDirection:ArrowDirection_left andArrowPoint:startPoint andWidth:80];
//            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
//            [delegate.window addSubview:self.popListView];
//
//            __weak typeof(self.popListView)weakListView = self.popListView;
//            __weak typeof(self)weakSelf = self;
//            self.popListView.dismissBlock = ^{
//                [weakListView removeFromSuperview];
//
//
//                [weakSelf.tableView reloadData];
//            };
//            self.popListView.SelectBlock = ^(NSDictionary *infoDic) {
//
//                int row = [[infoDic objectForKey:@"row"] intValue];
//                weakSelf.popIndexpath = [NSIndexPath indexPathForRow:row inSection:0];
//                [weakSelf showSegmentWith:indexPath.row];
//            };
//
//        }else
//        {
//            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
//            [delegate.window addSubview:self.popListView];
//            [self.popListView refreshWithPoint:startPoint];
//        }
//    }
    else
    {
        self.titleLB.hidden = YES;
        [self showSegmentWith:indexPath.row];
    }
    
    [self reloadStudentTableData];
    [self.tableView reloadData];
    
}

- (void)reloadStudentTableData
{
//    [SVProgressHUD show];
    if (self.categoryselectIndepath.row == 2) {
        [[UserManager sharedManager] didRequestMyHeadTaskListWithWithDic:@{kClassroomId:@(0),kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 5)
    {
        [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:self];
    }
    else if (self.categoryselectIndepath.row == 6)
    {
        [[UserManager sharedManager] didRequestMyBookmarkListWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 7)
    {
        [[UserManager sharedManager] didRequestMyHeadQuestionListWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 1)
    {
        [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 3)
    {
        if (self.myCourseHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestMyCourseCostWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }else if(self.myCourseHySegmentControl.selectIndex == 2)
        {
            [[UserManager sharedManager] didRequestBuyCourseRecordWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }else
        {
            [[UserManager sharedManager] didRequestMyCourseListWithWithDic:@{kClassroomId:@(0),kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }
    }else if (self.categoryselectIndepath.row == 4)
    {
        if (self.achievementHySegmentControl.selectIndex == 1) {
            [[UserManager sharedManager] didRequestMyStudyTimeLengthListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }else if(self.achievementHySegmentControl.selectIndex == 2)
        {
            [[UserManager sharedManager] didRequestMyAchievementListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
            
        }else
        {
            [[UserManager sharedManager] didRequestPunchCardListWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }
    }
}

- (void)refreshUsertableView
{
    NSIndexPath * indexPath = self.categoryselectIndepath;
    
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        if(indexPath.row == 2)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacherCourse];
        }else if (indexPath.row == 3)
        {
            self.collectionDataArray = [[[UserManager sharedManager] getMyCollectionTextbookArray] mutableCopy];
            [self addnoDataView];
            [self.collectionView reloadData];
        }else if (indexPath.row == 4)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
        }
        else if (indexPath.row == 5)
        {
            self.collectionDataArray = [[[UserManager sharedManager] getMyHeadTaskList] mutableCopy];
            [self addnoDataView];
            [self.collectionView reloadData];
        }
//        else if (indexPath.row == 3)
//        {
//
//        }
    }else if ([[UserManager sharedManager] getUserType] == UserType_student)
    {
        
        if(indexPath.row == 2)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_MyTask];
        }else if (indexPath.row == 5)
        {
            self.collectionDataArray = [[[UserManager sharedManager] getMyCollectionTextbookArray] mutableCopy];
            [self addnoDataView];
            [self.collectionView reloadData];
        }else if (indexPath.row == 6)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
        }
        else if (indexPath.row == 7)
        {
            self.collectionDataArray = [[[UserManager sharedManager] getMyHeadTaskList] mutableCopy];
            [self addnoDataView];
            [self.collectionView reloadData];
        }
//        else if (indexPath.row == 5)
//        {
//            [self addnoDataView];
//            [self.collectionView reloadData];
//        }
        else if (indexPath.row == 3)
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
        }else if (indexPath.row == 4)
        {
            if (self.achievementHySegmentControl.selectIndex == 1) {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_shichang];
            }else if(self.achievementHySegmentControl.selectIndex == 2)
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_achievement];
            }else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_calendr];
            }
        }
    }
}

- (void)reloadTeacherData
{
    //    [SVProgressHUD show];
    if (self.categoryselectIndepath.row == 2) {
        [[UserManager sharedManager] didRequestTeacher_MyCourseWithWithDic:@{kClassroomId:@0} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 3)
    {
        [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:self];
    }
    else if (self.categoryselectIndepath.row == 4)
    {
        [[UserManager sharedManager] didRequestMyBookmarkListWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 5)
    {
        [[UserManager sharedManager] didRequestMyHeadQuestionListWithWithDic:@{} withNotifiedObject:self];
    }else if (self.categoryselectIndepath.row == 1)
    {
        [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
    }
//    else if (self.categoryselectIndepath.row == 3)
//    {
//        if (self.myCourseHySegmentControl.selectIndex == 1) {
//            [[UserManager sharedManager] didRequestMyCourseCostWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserType])} withNotifiedObject:self];
//        }else if(self.myCourseHySegmentControl.selectIndex == 2)
//        {
//            [[UserManager sharedManager] didRequestBuyCourseRecordWithWithDic:@{} withNotifiedObject:self];
//        }else
//        {
//            [[UserManager sharedManager] didRequestMyCourseListWithWithDic:@{kClassroomId:@(0)} withNotifiedObject:self];
//        }
//    }

}


- (void)teacherTableviewcellSelect:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView
{
    self.categoryselectIndepath = indexPath;
    [self.navigationView showSearch];
    [self showSegmentWith:100];
    self.titleLB.hidden = NO;
   if (indexPath.row == 3)
    {
        [self.navigationView refreshWith:userCenterItemType_searchAndOperation];
        self.titleLB.text = @"收藏内容";
        self.collectionDataArray = self.groupArray;
        self.collectionCellType = collectionCellType_group;
        self.collectionView.hidden = NO;
    }else if (indexPath.row == 4)
    {
        [self.navigationView refreshWith:userCenterItemType_delete];
        self.titleLB.text = @"阅读书签";
        self.userTableview.hidden = NO;
        self.informationTableView.hidden = YES;
        self.collectionView.hidden = YES;
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_bookmark];
    }
    else if (indexPath.row == 5)
    {
        [self.navigationView refreshWith:userCenterItemType_haveRead];
        self.collectionCellType = collectionCellType_group;
        self.titleLB.text = @"使用帮助";
        self.collectionView.hidden = NO;
        self.collectionDataArray = self.groupArray;
        [self addnoDataView];
        [self.collectionView reloadData];
    }
//    else if (indexPath.row == 3)
//    {
//        [self showSegmentWith:indexPath.row];
//
//        MainLeftTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        CGRect cellRect = [cell.titleLB convertRect:cell.titleLB.bounds toView:self.view];
//
//        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width, cellRect.size.height / 2 + cellRect.origin.y);
//
//        if (self.popListView == nil) {
//
//            self.popListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.friendTypeArray anDirection:ArrowDirection_left andArrowPoint:startPoint andWidth:80];
//            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
//            [delegate.window addSubview:self.popListView];
//
//            __weak typeof(self.popListView)weakListView = self.popListView;
//            __weak typeof(self)weakSelf = self;
//            self.popListView.dismissBlock = ^{
//                [weakListView removeFromSuperview];
//
//
//                [weakSelf.tableView reloadData];
//            };
//            self.popListView.SelectBlock = ^(NSDictionary *infoDic) {
//
//                int row = [[infoDic objectForKey:@"row"] intValue];
//                weakSelf.popIndexpath = [NSIndexPath indexPathForRow:row inSection:0];
//                [weakSelf showSegmentWith:indexPath.row];
//            };
//
//        }else
//        {
//            AppDelegate * delegate = [UIApplication sharedApplication].delegate;
//            [delegate.window addSubview:self.popListView];
//            [self.popListView refreshWithPoint:startPoint];
//        }
//    }
    else
    {
        self.titleLB.hidden = YES;
        [self showSegmentWith:indexPath.row];
    }
    
    [self reloadTeacherData];
    [self.tableView reloadData];
    
}

#pragma mark - 查看作品详情
// 录音作品
- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.productType = ProductType_record;
    
    vc.modifuProductBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:weakSelf];
        }
    };
    
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
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.productType = ProductType_create;
    
    vc.modifuProductBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:weakSelf];
        }
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 收藏作品操作
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

- (void)didRequestDeleteMyCollectiontextBookSuccessed
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyCollectionTextBookWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestDeleteMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - bookmark

- (void)didRequestMyBookMarkListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyBookMarkListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestDeleteMyBookmarkSuccessed
{
    [[UserManager sharedManager] didRequestMyBookmarkListWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestDeleteMyBookmarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestClearnMyBookmarkSuccessed
{
    [[UserManager sharedManager] didRequestMyBookmarkListWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestClearnMyBookmarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyHeadQuestionSuccessed
{
    [SVProgressHUD dismiss];
    self.collectionDataArray = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyHeadQuestionArray]) {
        NSMutableDictionary * mDic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mDic setObject:[infoDic objectForKey:kHeadQuestionName] forKey:@"title"];
        [self.collectionDataArray addObject:mDic];
    }
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestMyHeadQuestionFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSetaHaveReadQuestionSuccessed
{
    [[UserManager sharedManager] didRequestMyHeadQuestionListWithWithDic:@{} withNotifiedObject:self];
}

- (void)didRequestSetaHaveReadQuestionFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - searckMyCollectTextBook
- (void)searchCollectTextBook
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
        weakSelf.isSearchTextBook = YES;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearchTextBook];
        [[UserManager sharedManager] didRequestSearchMyCollectionTextBookWithWithDic:@{kTextBookName:text} withNotifiedObject:self];
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        weakSelf.isSearchTextBook = NO;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearchTextBook];
        [weakToolView removeFromSuperview];
    };
}

- (void)didRequestSearchMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getSearchMyCollectionTextbookArray]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:@"itemType"] forKey:@"type"];
        if ([[infoDic objectForKey:@"itemName"] class] == [NSNull class] || [infoDic objectForKey:@"itemName"] == nil || [[infoDic objectForKey:@"itemName"] isEqualToString:@""]) {
            [mInfo setObject:@"" forKey:@"title"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"itemName"] forKey:@"title"];
        }
        if ([[infoDic objectForKey:@"itemImageUrl"] class] == [NSNull class] || [infoDic objectForKey:@"itemImageUrl"] == nil || [[infoDic objectForKey:@"itemImageUrl"] isEqualToString:@""]) {
            [mInfo setObject:@"" forKey:@"imagrUrl"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"itemImageUrl"] forKey:@"imagrUrl"];
        }
        if ([[infoDic objectForKey:kitemId] intValue] > 0) {
            [array addObject:mInfo];
        }
        
    }
    
    self.collectionDataArray = array;
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestSearchMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyCollectiontextBookSuccessed
{
    [SVProgressHUD dismiss];
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getMyCollectionTextbookArray]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:@"itemType"] forKey:@"type"];
        if ([[infoDic objectForKey:@"itemName"] class] == [NSNull class] || [infoDic objectForKey:@"itemName"] == nil || [[infoDic objectForKey:@"itemName"] isEqualToString:@""]) {
            [mInfo setObject:@"" forKey:@"title"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"itemName"] forKey:@"title"];
        }
        if ([[infoDic objectForKey:@"itemImageUrl"] class] == [NSNull class] || [infoDic objectForKey:@"itemImageUrl"] == nil || [[infoDic objectForKey:@"itemImageUrl"] isEqualToString:@""]) {
            [mInfo setObject:@"" forKey:@"imagrUrl"];
        }else{
            [mInfo setObject:[infoDic objectForKey:@"itemImageUrl"] forKey:@"imagrUrl"];
        }
        if ([[infoDic objectForKey:kitemId] intValue] > 0) {
            [array addObject:mInfo];
        }
    }
    self.groupArray = array;
    self.collectionDataArray = self.groupArray;
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestMyCollectiontextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - myProductRequestDelegate
- (void)didRequestMyProductSuccessed
{
    [SVProgressHUD dismiss];
    if (self.myProductHySegmentControl.selectIndex == 0) {
        self.collectionDataArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
    }else
    {
        self.collectionDataArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
    }
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - wexin share success delegate
- (void)shareSuccess
{
    if (self.isShareApp) {
        return;
    }
    int type = 1;
    switch (self.shareType) {
        case ShareObjectType_weixinFriend:
            type = 2;
            break;
        case ShareObjectType_friendCircle:
            type = 3;
            break;
        case ShareObjectType_WeixinCollect:
            type = 4;
            break;
            
        default:
            break;
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[self.currentSelectShareInfoDic objectForKey:kProductId],kshareType:@(type)} withNotifiedObject:self];
}

#pragma mark - share

- (void)didRequestShareMyProductSuccessed
{
    [SVProgressHUD dismiss];
    FlowerView * starView = [[FlowerView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:starView];
    [SVProgressHUD dismiss];
}

- (void)didRequestShareMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestDeleteMyProductSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
}

- (void)didRequestDeleteMyProductFailed:(NSString *)failedInfo
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

- (void)didRequestTeacher_MyCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_MyCourseListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
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

#pragma mark - MyHeadTaskRequestDelegate
- (void)didRequestMyHeadTaskListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestMyHeadTaskListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}



#pragma mark - 系统信息设置

- (void)setSystemInformation:(NSUInteger)row andInfoDic:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    if (row == 0) {
        NotifiTypeView * view = [[NotifiTypeView alloc]initWithFrame:self.view.bounds andType:[infoDic objectForKey:@"content"]];
        [self.view addSubview:view];
        
        __weak typeof(view)weakGenderView = view;
        
        view.DismissBlock = ^{
            [weakGenderView removeFromSuperview];
        };
        view.NotifySelectBlock = ^(NSString *notifyType) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [dic setObject:notifyType forKey:@"content"];
            
            if ([notifyType isEqualToString:@"关闭"]) {
                [SVProgressHUD show];
                self.notificationNoDisturb = @"关闭";
                [[UserManager sharedManager] didRequestNotificationNoDisturbWithWithDic:@{@"notificationNoDisturb":@0} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                self.notificationNoDisturb = @"开启";
                [[UserManager sharedManager] didRequestNotificationNoDisturbWithWithDic:@{@"notificationNoDisturb":@1} withNotifiedObject:self];
            }
            
        };
        
    }else if (row == 1)
    {
        ProtectEyeView * protectView = [[ProtectEyeView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:protectView];
        protectView.changeProtectTimeBlock = ^(NSString *time) {
            [weakSelf addProtectTimeView:infoDic];
        };
        
    }else if (row == 2){
        // 清空
        
        NSArray * audioList = [[DBManager sharedManager]getDownloadAudioList:@{kUserId:@([[UserManager sharedManager] getUserId])}];
        
        for (int i = 0; i < audioList.count; i++) {
            NSDictionary * audioInfo = [audioList objectAtIndex:i];
            NSArray *audioArray = [audioInfo objectForKey:@"audioInfos"];
            NSLog(@"%@", audioArray);
            
            for (int j = 0; j < audioArray.count; j++) {
                NSDictionary * audioDic = [audioArray objectAtIndex:j];
                NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                //设置保存路径和生成文件名
                NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioDic objectForKey:kAudioId]];
                //保存
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                }
            }
        }
        
        [[DBManager sharedManager] deleteAllAudios:@{kUserId:@([[UserManager sharedManager] getUserId])}];
        [[DBManager sharedManager] deleteAllAudioList:@{kUserId:@([[UserManager sharedManager] getUserId])}];
        
    }
}

- (void)addProtectTimeView:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    ProtectEyeTimeView * view = [[ProtectEyeTimeView alloc]initWithFrame:self.view.bounds andTime:[infoDic objectForKey:@"content"]];
    __weak typeof(view)weakView = view;
    [self.view addSubview:view];
    view.NotifySelectBlock = ^(NSString *notifyType) {
        NSString * time = notifyType;
        if ([notifyType isEqualToString:@"0"]) {
            time = @"无限制";
        }
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [dic setObject:time forKey:@"content"];
        int number = [weakSelf.informationArray indexOfObject:infoDic];
        [weakSelf.informationArray removeObject:infoDic];
        [weakSelf.informationArray insertObject:dic atIndex:number];
        [weakSelf.informationTableView reloadData];
        [weakView removeFromSuperview];
    };
    view.DismissBlock = ^{
        [weakView removeFromSuperview];
    };
}

#pragma mark - 个人信息设置
- (void)setUserInformation:(NSUInteger)row andInfoDic:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    switch (row) {
        case 0:
            {
                [self changeIcon];
            }
            break;
            
        case 1:
        {
            ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_tf andTitle:[infoDic objectForKey:@"content"] andPlaceHold:@"请输入昵称" withAnimation:NO];
            __weak typeof(toolView)weakToolView = toolView;
            [self.view addSubview:toolView];
            toolView.TextBlock = ^(NSString *text) {
                if (text.length == 0) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    return ;
                }
               
                [SVProgressHUD show];
                weakSelf.userNameStr = text;
                [[UserManager sharedManager] didRequestChangeNickNameWithWithDic:@{kUserNickName:text} withNotifiedObject:weakSelf];
                [weakToolView removeFromSuperview];
            };
            toolView.DismissBlock = ^{
                [weakToolView removeFromSuperview];
            };
        }
            break;
        case 2:
        {
            ModifyPasswordViewController * vc = [[ModifyPasswordViewController alloc]init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:vc animated:NO completion:nil];
            });
            return;
        }
            break;
        case 4:
        {
            BindPhoneNumberViewController * vc = [[BindPhoneNumberViewController alloc]init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:vc animated:NO completion:nil];
                
                vc.BindPhoneNumberBlock = ^(NSString *phoneNumber) {
#pragma mark - bind PhoneNumber success  ;
                    
                    [SVProgressHUD dismiss];
                    [[UserManager sharedManager] changePhone:phoneNumber];
                    [[UserManager sharedManager] encodeUserInfo];
                    [self refreshUserInfo];
                    
                };
                
            });
            
            return;
        }
            break;
        case 6:
        {
            GenderSelectView * genderView = [[GenderSelectView alloc]initWithFrame:self.view.bounds andGender:[infoDic objectForKey:@"content"]];
            [self.view addSubview:genderView];
            
            __weak typeof(genderView)weakGenderView = genderView;
            
            genderView.DismissBlock = ^{
                [weakGenderView removeFromSuperview];
            };
            genderView.genderSelectBlock = ^(NSString *gender) {
                [SVProgressHUD show];
                weakSelf.genderStr = gender;
                [[UserManager sharedManager] didRequestChangeGenderWithWithDic:@{kgender:gender} withNotifiedObject:weakSelf];
                [weakGenderView removeFromSuperview];
            };
            
        }
            break;
        case 7:
        {
            
            [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {

                NSDateFormatter * formater1 = [[NSDateFormatter alloc]init];
                formater1.dateFormat = @"yyyy年MM月dd日";
                NSDateFormatter * formater2 = [[NSDateFormatter alloc]init];
                formater2.dateFormat = @"yyyy-MM-dd";
                NSDate * date = [formater1 dateFromString:pathStr];
                NSString * dateStr = [formater2 stringFromDate:date];
                [SVProgressHUD show];
                weakSelf.birthdayStr = dateStr;
                [[UserManager sharedManager] didRequestChangeBirthdayWithWithDic:@{kbirthday:dateStr} withNotifiedObject:weakSelf];
                
            } cancleAction:^{
                
            }];
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            AddressView *addressView = [[AddressView alloc]initWithFrame:self.view.bounds];
            
            __weak typeof(addressView)weakView = addressView;
            [addressView refreshWithAddressInfo:[[UserManager sharedManager] getUserInfos]];
            addressView.AddressSelectBlock = ^(NSDictionary *addressDic) {
                [SVProgressHUD show];
                weakSelf.addressInfoDic = addressDic;
                [[UserManager sharedManager] didRequestChangeReceiveAddressWithWithDic:addressDic withNotifiedObject:weakSelf];
            };
            [self.view addSubview:addressView];
        }
            break;
        default:
            break;
    }
}

#pragma mark - ChangeUserInfoDelegate
- (void)didRequestLogoutSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] logout];
    if (self.quitBlock) {
        self.quitBlock(YES);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didRequestLogoutFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestNotificationNoDisturbConfigSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] changeNotificationNoDisturb:self.notificationNoDisturb];
    [self refreshSystemInfo];
}

- (void)didRequestNotificationNoDisturbConfigFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestchangeIconImageSuccessed
{
    [SVProgressHUD dismiss];
    NSString * iconStr = [NSString stringWithFormat:@"%@%@",kDomainName, self.iconImageUrl];
    NSLog(@"iconStr = %@", iconStr);
    [[UserManager sharedManager] changeIconUrl:iconStr];
    [[UserManager sharedManager] encodeUserInfo];
    [self refreshUserInfo];
}

- (void)didRequestchangeIconImageFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChangeNickNameSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] changeUserName:self.userNameStr];
    [[UserManager sharedManager] encodeUserInfo];
    [self refreshUserInfo];
}

- (void)didRequestChangeNickNameFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChangeGenderSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] changeGender:self.genderStr];
    [self refreshUserInfo];
}

- (void)didRequestChangeGenderFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChangeBirthdaySuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] changeBirthday:self.birthdayStr];
    [self refreshUserInfo];
}

- (void)didRequestChangeBirthdayFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChangeReceiveAddressSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] changeRecieveAddress:self.addressInfoDic];
    [self refreshUserInfo];
}

- (void)didRequestChangeReceiveAddressFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(void)refreshUserInfo
{
    NSDictionary * userInfoDic = [[UserManager sharedManager] getUserInfos];
    self.userINformationArray = [NSMutableArray array];
    [self.userINformationArray addObject:@{@"title":@"头像",@"content":[userInfoDic objectForKey:kUserHeaderImageUrl],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"昵称",@"content":[userInfoDic objectForKey:kUserNickName],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"密码",@"content":@"修改密码",@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"用户名",@"content":[userInfoDic objectForKey:kUserName],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"手机号",@"content":[userInfoDic objectForKey:kUserTelephone],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"有效期",@"content":[userInfoDic objectForKey:kvalidityTime],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"性别",@"content":[userInfoDic objectForKey:kgender],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"生日",@"content":[userInfoDic objectForKey:kbirthday],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"城市",@"content":[userInfoDic objectForKey:kCity],@"imageStr":@"head_portrait"}];
    [self.userINformationArray addObject:@{@"title":@"收货地址",@"content":[userInfoDic objectForKey:kreceiveAddress],@"imageStr":@"head_portrait"}];
    self.informationArray = self.userINformationArray;
    [self.informationTableView reloadData];
}

- (void)refreshSystemInfo
{
    NSDictionary * userInfoDic = [[UserManager sharedManager] getUserInfos];
    NSString * notify = @"";
    if ([[userInfoDic objectForKey:knotificationNoDisturb] intValue] == 0) {
        notify = @"关闭";
    }else
    {
        notify = @"开启";
    }
    [self.systemInformationArray addObject:@{@"title":@"聊天消息免打扰",@"content":notify,@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"护眼模式",@"content":@"无限制",@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"清除缓存",@"content":@"",@"imageStr":@"head_portrait"}];
    [self.systemInformationArray addObject:@{@"title":@"当前版本",@"content":@"2.3445.3（已是最新版本）",@"imageStr":@"head_portrait"}];
    
    self.informationArray = self.systemInformationArray;
    [self.informationTableView reloadData];
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}


- (void)changeIcon
{
    
    UIAlertController * alertcontroller = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [SoftManager shareSoftManager].isCamera = YES;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.sourceType = sourceType;
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            picker.accessibilityLanguage = NSCalendarIdentifierChinese;
            [self presentViewController:picker animated:YES completion:nil];
        }else
        {
            UIAlertController * tipControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有相机,请选择图库" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ;
            }];
            [tipControl addAction:sureAction];
            [self presentViewController:tipControl animated:YES completion:nil];
            
        }
    }];
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            __weak typeof(self)weakSelf = self;
            BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
            vc.maxNum = 1;
            vc.imageClipping = NO;
            vc.showCamera = NO;
            [vc initDataProgress:^(CGFloat progress) {
                
            } finished:^(NSArray<UIImage *> *resultAry, NSArray<PHAsset *> *assetsArry, UIImage *editedImage) {
                
                for (int i = 0; i < resultAry.count; i++) {
                    UIImage *img = [resultAry objectAtIndex:i];
                    
                    NSData * imageData = UIImagePNGRepresentation(img);
                    [SVProgressHUD show];
                    [[HttpUploaderManager sharedManager]uploadImage:imageData withProcessDelegate:self];
                    
                }
                
            } cancle:^(NSString *cancleStr) {
                
            }];
            [self presentViewController:vc animated:YES completion:nil];
    }];
    
    [alertcontroller addAction:cancleAction];
    [alertcontroller addAction:cameraAction];
    [alertcontroller addAction:libraryAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [SoftManager shareSoftManager].isCamera = NO;
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSLog(@"%@", info);
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData * imageData = UIImagePNGRepresentation(img);
    imageData = UIImageJPEGRepresentation(img, 0.5);
    [SVProgressHUD show];
    [[HttpUploaderManager sharedManager]uploadImage:imageData withProcessDelegate:self];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [SoftManager shareSoftManager].isCamera = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didUploadSuccess:(NSDictionary *)successInfo
{
    NSLog(@"successInfo = %@", successInfo);
    NSString * imageStr = [successInfo objectForKey:@"msg"];
    NSArray * imageStrArr = [imageStr componentsSeparatedByString:@","];
    self.iconImageUrl = imageStrArr[0];
    [[UserManager sharedManager] didRequestChangeIconImageWithWithDic:@{@"icoImageUrl":imageStrArr[0]} withNotifiedObject:self];
}

- (void)didUploadFailed:(NSString *)uploadFailed
{
    [SVProgressHUD showErrorWithStatus:uploadFailed];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)showSegmentWith:(NSInteger)productCategory
{
    self.informationSegmentControl.hidden = YES;
    self.myProductHySegmentControl.hidden = YES;
    self.achievementHySegmentControl.hidden = YES;
    self.myFriendHySegmentControl.hidden = YES;
    self.myCourseHySegmentControl.hidden = YES;
    
    [self.navigationView hideLatestBtn];
    self.informationTableView.hidden = YES;
    self.userTableview.hidden = YES;
    self.collectionView.hidden = YES;
    
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        switch (productCategory) {
            case 0:
            {
                [self.navigationView refreshWith:userCenterItemType_quit];
                self.informationSegmentControl.hidden = NO;
                self.collectionView.hidden = YES;
                self.userTableview.hidden = YES;
                self.informationTableView.hidden = NO;
            }
                break;
            case 1:
            {
                [self.navigationView refreshWith:userCenterItemType_shareAndDelete];
                self.collectionCellType = collectionCellType_product;
                self.collectionDataArray = self.productArray;
                self.myProductHySegmentControl.hidden = NO;
                [self.navigationView showLatestBtn];
                self.informationTableView.hidden = YES;
                self.userTableview.hidden = YES;
                self.collectionView.hidden = NO;
                
                
                [self reloadTeacherData];
                
                if (self.myProductHySegmentControl.selectIndex == 0) {
                    self.collectionDataArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
                }else
                {
                    self.collectionDataArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
                    
                }
                [self addnoDataView];
                [self.collectionView reloadData];
                
            }
                
                break;
            case 2:
            {
                [self.navigationView refreshWith:userCenterItemType_none];
                self.informationTableView.hidden = YES;
                self.collectionView.hidden = YES;
                self.userTableview.hidden = NO;
                self.titleLB.hidden = NO;
                self.titleLB.text = @"我的课程";
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacherCourse];
            }
                break;
//            case 3:
//            {
//                if (self.popIndexpath.row == 0) {
//                    self.myFriendHySegmentControl.hidden = NO;
//                    self.titleLB.hidden = YES;
//                    if (self.myFriendHySegmentControl.selectIndex == 0) {
//                        [self.navigationView refreshWith:userCenterItemType_addAndDelete];
//                        self.collectionView.hidden = NO;
//                        self.userTableview.hidden = YES;
//                    }else
//                    {
//                        [self.navigationView refreshWith:userCenterItemType_latest];
//                        self.userTableview.hidden = NO;
//                        self.collectionView.hidden = YES;
//                        if (self.myFriendHySegmentControl.selectIndex == 1) {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
//                        }else if(self.myFriendHySegmentControl.selectIndex == 2)
//                        {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
//                        }else if (self.myFriendHySegmentControl.selectIndex == 3)
//                        {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
//                        }
//                    }
//                }else
//                {
//                    self.collectionView.hidden = NO;
//                    self.myFriendHySegmentControl.hidden = YES;
//                    self.titleLB.hidden = NO;
//
//                    if (self.popIndexpath.row == 1) {
//                        self.titleLB.text = @"群组";
//                        [self.navigationView refreshWith:userCenterItemType_create];
//                    }else
//                    {
//                        [self.navigationView refreshWith:userCenterItemType_none];
//                        self.titleLB.text = @"交流";
//                    }
//
//                    self.collectionCellType = collectionCellType_group;
//                    self.collectionDataArray = self.groupArray;
//                    [self addnoDataView];
//                    [self.collectionView reloadData];
//                }
//            }
                
//                break;
                
            default:
                break;
        }
    }else if ([[UserManager sharedManager] getUserType] == UserType_student)
    {
        switch (productCategory) {
            case 0:
            {
                [self.navigationView refreshWith:userCenterItemType_quit];
                self.informationSegmentControl.hidden = NO;
                self.collectionView.hidden = YES;
                self.userTableview.hidden = YES;
                self.informationTableView.hidden = NO;
            }
                break;
            case 1:
            {
                [self.navigationView refreshWith:userCenterItemType_shareAndDelete];
                self.collectionCellType = collectionCellType_product;
                self.collectionDataArray = self.productArray;
                self.myProductHySegmentControl.hidden = NO;
                [self.navigationView showLatestBtn];
                self.informationTableView.hidden = YES;
                self.userTableview.hidden = YES;
                self.collectionView.hidden = NO;
                
                
                [self reloadStudentTableData];
                
                if (self.myProductHySegmentControl.selectIndex == 0) {
                    self.collectionDataArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
                }else
                {
                    self.collectionDataArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
                    
                }
                [self addnoDataView];
                [self.collectionView reloadData];
                
            }
                
                break;
            case 3:
            {
                [self.navigationView refreshWith:userCenterItemType_none];
                self.myCourseHySegmentControl.hidden = NO;
                self.informationTableView.hidden = YES;
                self.collectionView.hidden = YES;
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
            case 4:
            {
                [self.navigationView refreshWith:userCenterItemType_explainAndShare];
                self.achievementHySegmentControl.hidden = NO;
                self.informationTableView.hidden = YES;
                self.collectionView.hidden = YES;
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
//            case 5:
//            {
//                if (self.popIndexpath.row == 0) {
//                    self.myFriendHySegmentControl.hidden = NO;
//                    self.titleLB.hidden = YES;
//                    if (self.myFriendHySegmentControl.selectIndex == 0) {
//                        [self.navigationView refreshWith:userCenterItemType_addAndDelete];
//                        self.collectionView.hidden = NO;
//                        self.userTableview.hidden = YES;
//                        [self addnoDataView];
//                        [self.collectionView reloadData];
//                    }else
//                    {
//                        [self.navigationView refreshWith:userCenterItemType_latest];
//                        self.userTableview.hidden = NO;
//                        self.collectionView.hidden = YES;
//                        if (self.myFriendHySegmentControl.selectIndex == 1) {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
//                        }else if(self.myFriendHySegmentControl.selectIndex == 2)
//                        {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
//                        }else if (self.myFriendHySegmentControl.selectIndex == 3)
//                        {
//                            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
//                        }
//                    }
//                }else
//                {
//                    self.collectionView.hidden = NO;
//                    self.myFriendHySegmentControl.hidden = YES;
//                    self.titleLB.hidden = NO;
//
//                    if (self.popIndexpath.row == 1) {
//                        self.titleLB.text = @"群组";
//                        [self.navigationView refreshWith:userCenterItemType_create];
//                    }else
//                    {
//                        [self.navigationView refreshWith:userCenterItemType_none];
//                        self.titleLB.text = @"交流";
//                    }
//
//                    self.collectionCellType = collectionCellType_group;
//                    self.collectionDataArray = self.groupArray;
//                    [self addnoDataView];
//                    [self.collectionView reloadData];
//                }
//            }
                
//                break;
                
            default:
                break;
        }
    }
    
}



#pragma mark - 排行榜列表
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
            [weakSelf.navigationView refreshLatestViewWith:[infoDic objectForKey:@"title"]];
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.awardPopListView];
        [self.awardPopListView refresh];
    }
}

- (void)showOperationListVIew:(CGRect)rect
{
    if (self.operationPopListView == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.operationPopListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.operationListArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.12];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.operationPopListView];
        
        __weak typeof(self.operationPopListView)weakListView = self.operationPopListView;
        __weak typeof(self)weakSelf = self;
        self.operationPopListView.dismissBlock = ^{
            [weakSelf.navigationView refreshOperationView];
            [weakListView removeFromSuperview];
        };
        self.operationPopListView.SelectBlock = ^(NSDictionary *infoDic) {
            if ([[infoDic objectForKey:@"row"] intValue] == 1) {
                // 分享
                [weakSelf.navigationView refreshLatestView_Share];
                weakSelf.isMyCollectShare = YES;
                [weakSelf.collectionView reloadData];
            }else{
                // 删除
                [weakSelf.navigationView refreshLatestView_Delete];
                weakSelf.isMyCollectDelete = YES;
                [weakSelf.collectionView reloadData];
            }
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.operationPopListView];
        [self.operationPopListView refresh];
    }
}

#pragma mark - shareAPP
- (void)shareAPP
{
    self.isShareApp = YES;
    ShareView * shareApp = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_weixin];
    [self.view addSubview:shareApp];
    __weak typeof(shareApp)weakView = shareApp;
    shareApp.shareBlock = ^(NSDictionary *infoDic) {
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case ShareObjectType_weixinFriend:
            {
                // 分享给微信好友
                self.shareType = ShareObjectType_weixinFriend;
                [[WXApiShareManager shareManager] shareToSessionWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_friendCircle:
            {
                // 分享给微信朋友圈
                self.shareType = ShareObjectType_friendCircle;
                [[WXApiShareManager shareManager] shareToTimelineWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_WeixinCollect:
            {
                // 分享给微信收藏
                self.shareType = ShareObjectType_WeixinCollect;
                [[WXApiShareManager shareManager] shareToFavoriteWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
                
            default:
                break;
        }
        [weakView removeFromSuperview];
    };
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
    
    
    if ([[UserManager sharedManager] getUserType] == UserType_student)
    {
        switch (self.categoryselectIndepath.row) {
            case 1:
            {
                if (self.myProductHySegmentControl.selectIndex == 1) {
                    image = [UIImage imageNamed:@"default_works_icon"];
                    content = @"还没有创作作品";
                    detail = [[NSMutableAttributedString alloc]initWithString:@"快去“创作作品”创作你自己的作品吧"];
                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                    [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                }else
                {
                    image = [UIImage imageNamed:@"default_works_icon"];
                    content = @"还没有录音作品";
                    detail = [[NSMutableAttributedString alloc]initWithString:@"快去“阅读录音”找你喜欢的课文开始录音吧"];
                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                    [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                }
            }
                break;
            case 5:
            {
                image = [UIImage imageNamed:@"default_collection_icon"];
                content = @"还没有收藏内容";
                detail = [[NSMutableAttributedString alloc]initWithString:@"快去“阅读录音”找下你喜欢的，点击“收藏”即可保存在这里，方便查找"];
                NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                [detail setAttributes:attribute range:NSMakeRange(16, 4)];
            }
                break;
            case 8:
            {
                image = [UIImage imageNamed:@"default_teaching_material_icon"];
                content = @"还没有使用帮助";
                detail = [[NSMutableAttributedString alloc]initWithString:@""];
                
            }
                break;
//            case 5:
//            {
//                if (self.popIndexpath.row == 1) {
//                    image = [UIImage imageNamed:@"default_group_icon"];
//                    content = @"还没有群组";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"这里会显示已创建的货已加入的群组"];
//                }else if (self.popIndexpath.row == 2)
//                {
//                    image = [UIImage imageNamed:@"default_news_icon"];
//                    content = @"还没有聊天信息";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"其他人给你发送的聊天信息，都会显示在这里"];
//                }else
//                {
//                    if (self.myFriendHySegmentControl.selectIndex != 0) {
//                        self.failedView.hidden = NO;
//                        return;
//                    }
//                    image = [UIImage imageNamed:@"default_friends_icon"];
//                    content = @"还没有好友";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"点击右上角“添加”按钮，添加你的小伙伴吧"];
//                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
//                    [detail setAttributes:attribute range:NSMakeRange(5, 4)];
//                }
//
//            }
//                break;
                
            default:
                break;
        }
    }else if ([[UserManager sharedManager] getUserType] == UserType_teacher){
        switch (self.categoryselectIndepath.row) {
            case 1:
            {
                if (self.myProductHySegmentControl.selectIndex == 1) {
                    image = [UIImage imageNamed:@"default_works_icon"];
                    content = @"还没有创作作品";
                    detail = [[NSMutableAttributedString alloc]initWithString:@"快去“创作作品”创作你自己的作品吧"];
                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                    [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                }else
                {
                    image = [UIImage imageNamed:@"default_works_icon"];
                    content = @"还没有讲解作品";
                    detail = [[NSMutableAttributedString alloc]initWithString:@"快去“阅读录音”找你喜欢的课文开始录音吧"];
                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                    [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                }
            }
                break;
            case 3:
            {
                image = [UIImage imageNamed:@"default_collection_icon"];
                content = @"还没有收藏内容";
                detail = [[NSMutableAttributedString alloc]initWithString:@"快去“阅读录音”找下你喜欢的，点击“收藏”即可保存在这里，方便查找"];
                NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                [detail setAttributes:attribute range:NSMakeRange(2, 6)];
                [detail setAttributes:attribute range:NSMakeRange(16, 4)];
            }
                break;
            case 6:
            {
                image = [UIImage imageNamed:@"default_teaching_material_icon"];
                content = @"还没有使用帮助";
                detail = [[NSMutableAttributedString alloc]initWithString:@""];
                
            }
                break;
//            case 3:
//            {
//                if (self.popIndexpath.row == 1) {
//                    image = [UIImage imageNamed:@"default_group_icon"];
//                    content = @"还没有群组";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"这里会显示已创建的货已加入的群组"];
//                }else if (self.popIndexpath.row == 2)
//                {
//                    image = [UIImage imageNamed:@"default_news_icon"];
//                    content = @"还没有聊天信息";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"其他人给你发送的聊天信息，都会显示在这里"];
//                }else
//                {
//                    if (self.myFriendHySegmentControl.selectIndex != 0) {
//                        self.failedView.hidden = NO;
//                        return;
//                    }
//                    image = [UIImage imageNamed:@"default_friends_icon"];
//                    content = @"还没有好友";
//                    detail = [[NSMutableAttributedString alloc]initWithString:@"点击右上角“添加”按钮，添加你的小伙伴吧"];
//                    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
//                    [detail setAttributes:attribute range:NSMakeRange(5, 4)];
//                }
//
//            }
//                break;
                
            default:
                break;
        }
    }
    
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
    
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
