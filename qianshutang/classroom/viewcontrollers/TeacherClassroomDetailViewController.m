//
//  TeacherClassroomDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherClassroomDetailViewController.h"

#import "UserCenterTableView.h"
#import "StudentInformationViewController.h"
#import "Teacher_StudentInformationViewController.h"
#import "MyTaskAttendanceRecordViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"
#import "TextbookDetailViewController.h"
#import "ClassMemberViewController.h"
#import "MyTaskListDetailViewController.h"

#import "LearnTextViewController.h"
#import "CommentTaskListViewController.h"
#import "AddMusicCategoryViewController.h"
#import "TeacherCourseListViewController.h"
#import "ArrangeTaskView.h"
#import "ClassroomArrangrTaskViewController.h"
#import "ClassmemberAchievementCustomTimeView.h"
#import "PlayVideoViewController.h"
#import "PlayAudioViewController.h"
#import "MyTaskViewController.h"


@interface TeacherClassroomDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,Teacher_changeHaveArrangeModulName,Teacher_MyCourseList,Teacher_haveArrangeTask,Teacher_getXilieDetail,Teacher_getSuitangDetail,MyClassroom_classTextbook, MyClassroom_classCourseWare,ActiveStudy_TextBookContentList,ActiveStudy_TextContent,Teacher_deleteClassroomTextBook,Teacher_addClassroomTextBook,Teacher_deleteHaveArrangeTask>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)HYSegmentedControl *  achievementHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  metarialHySegmentControl;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * categorydataArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)NSMutableArray * informationArray;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, assign)teacherCollectionCellType collectionCellType;

// 获奖榜单
@property (nonatomic, strong)PopListView * awardPopListView;// 排行榜操作
@property (nonatomic, strong)NSIndexPath * awardPopIndexpath;
@property (nonatomic, strong)NSMutableArray * awardListArray;

@property (nonatomic, strong)UIButton * iconImageBtn;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * iconTipLB;

@property (nonatomic, assign)BOOL isDelete;

@property (nonatomic, strong)PopListView * haveArrangeOperationListView;// 作业操作
@property (nonatomic, strong)NSMutableArray * haveArrangeOperationList;

@property (nonatomic, strong)ToolTipView * changeNameTipView;
@property (nonatomic, strong)NSDictionary * currentOperationInfoDic;

@property (nonatomic, strong)NSDictionary * currentTextBookInfo; // 当前选中课本
@property (nonatomic, strong)NSDictionary * currentCourseWareInfo;
@property (nonatomic, assign)LearnTextType  learntextType;

@property (nonatomic, strong)NSString * timeStr;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, assign)int timeType;

@property (nonatomic, assign)TaskShowType taskShowType;


@property (nonatomic, strong)ClassmemberAchievementCustomTimeView * customTimeView;
@property (nonatomic, strong)FailedView * failedView;// 暂无数据view

@end

@implementation TeacherClassroomDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[BTVoicePlayer share] isHavePlayerItem]) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    
    [self loadData];
    
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_latest];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        if (isShow) {
            [weakSelf showListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
        }else
        {
            [weakSelf.awardPopListView removeFromSuperview];
        }
    };
    self.navigationView.commentBlock = ^(NSDictionary *infoDic) {
        CommentTaskListViewController * vc = [[CommentTaskListViewController alloc]init];
        vc.isTeacher = YES;
        vc.infoDic = weakSelf.infoDic;
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    
    self.navigationView.deleteBlock = ^(BOOL isDelete) {
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
    self.navigationView.addBlock = ^(NSDictionary *infoDic) {
        [weakSelf addclassroomMetarial:weakSelf.infoDic];
    };
    
    self.navigationView.arrangeBlock = ^(NSDictionary *infoDic) {
        ClassroomArrangrTaskViewController * vc = [[ClassroomArrangrTaskViewController alloc]init];
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    self.navigationView.todayBlock = ^(NSDictionary *infoDic) {
        MyTaskViewController * vc = [[MyTaskViewController alloc]init];
        vc.taskShowType = TaskShowType_Teacher_classroomTodayTask;
        vc.infoDic = weakSelf.infoDic;
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.achievementHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"星星榜",@"红花榜",@"奖章榜",@"完成度"] delegate:self];
    [self.achievementHySegmentControl hideBottomView];
    [self.achievementHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.achievementHySegmentControl];
    self.achievementHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.achievementHySegmentControl]) {
            
            weakSelf.userTableview.hidden = NO;
            weakSelf.collectionView.hidden = YES;
            if (index == 0) {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
            }else if(index == 1)
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
            }else if (index == 2)
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
            }else
            {
                [weakSelf.navigationView refreshWith:userCenterItemType_latest];
                [weakSelf.userTableview resetUsercenterTableViewType:UserCenterTableViewType_completeness];
            }
            
        }
    };
    
    self.metarialHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"课本",@"课件"] delegate:self];
    [self.metarialHySegmentControl hideBottomView];
    [self.metarialHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.metarialHySegmentControl];
    self.metarialHySegmentControl.hidden = YES;
    self.metarialHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        
        weakSelf.isDelete = NO;
        [weakSelf.collectionView reloadData];
        [weakSelf.navigationView refreshDeleteBtnWith:NO];
        
        if ([segmentControl isEqual:weakSelf.metarialHySegmentControl]) {
            if (weakSelf.metarialHySegmentControl.selectIndex == 0) {
                weakSelf.collectionCellType = collectionCellType_textbook;
                weakSelf.currentCourseWareInfo = nil;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[weakSelf.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
            }else
            {
                weakSelf.collectionCellType = collectionCellType_courseware;
                weakSelf.currentTextBookInfo = nil;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestClassCourseWareWithWithDic:@{kClassroomId:[weakSelf.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
            }
            [weakSelf.collectionView reloadData];
        }
        
    };
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.iconImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageBtn.frame = CGRectMake(kScreenWidth * 0.036, self.navigationView.hd_height + kScreenWidth * 0.0115, kScreenWidth * 0.124, kScreenWidth * 0.124);
    [self.iconImageBtn setImage:[UIImage imageNamed:@"logo1"] forState:UIControlStateNormal];
    self.iconImageBtn.layer.cornerRadius = 10;
    self.iconImageBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.iconImageBtn];
    [self.iconImageBtn addTarget:self action:@selector(classMemberAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconTipLB = [[UILabel alloc]initWithFrame:CGRectMake(5, self.iconImageBtn.hd_height * 0.7 - 5, self.iconImageBtn.hd_width - 10, self.iconImageBtn.hd_height * 0.3)];
    self.iconTipLB.text = @"班级成员";
    self.iconTipLB.textColor = [UIColor whiteColor];
    UIBezierPath * tipPath = [UIBezierPath bezierPathWithRoundedRect:self.iconTipLB.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.iconTipLB.bounds;
    shapLayer.path = tipPath.CGPath;
    [self.iconTipLB.layer setMask:shapLayer];
    self.iconTipLB.textAlignment = NSTextAlignmentCenter;
    self.iconTipLB.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.iconImageBtn addSubview:self.iconTipLB];
    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageBtn.frame) + 10, kScreenWidth * 0.2, 20)];
    self.nameLB.textColor = [UIColor whiteColor];
    self.nameLB.text = @"千书堂";
    self.nameLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLB];
    
    self.categoryselectIndepath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.awardPopIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + self.view.hd_height * 0.32, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height - self.view.hd_height * 0.32) style:UITableViewStylePlain];
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
    self.collectionView.hidden = YES;
    
    self.failedView = [[FailedView alloc]initWithFrame:self.backView.bounds andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    [self.backView addSubview:self.failedView];
    self.failedView.hidden = YES;
    
    self.userTableview = [[UserCenterTableView alloc]initWithFrame:self.backView.bounds];
    [self.backView addSubview:self.userTableview];
    self.userTableview.isCourse = YES;
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        switch (type) {
            case UserCenterTableViewType_flower:
            case UserCenterTableViewType_star:
            case UserCenterTableViewType_gold:
            case UserCenterTableViewType_completeness:
            {
                
                if ([[infoDic objectForKey:@"isTeacher"] intValue] == 0) {
                    Teacher_StudentInformationViewController * teacher_stuVC = [[Teacher_StudentInformationViewController alloc]init];
                    teacher_stuVC.isNotFromCommentTaskVC = YES;
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                    [mInfo setObject:[weakSelf.infoDic objectForKey:kClassroomId] forKey:kClassroomId];
                    teacher_stuVC.infoDic = mInfo;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:teacher_stuVC animated:NO completion:nil];
                    });
                }else
                {
                    StudentInformationViewController * stuVC = [[StudentInformationViewController alloc]init];
                    stuVC.isNotFromCommentTaskVC = YES;
                    stuVC.infoDic = infoDic;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:stuVC animated:NO completion:nil];
                    });
                }
            }
                break;
            case UserCenterTableViewType_ClassroomTask:
            {
                
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
        [weakSelf reloaData:weakSelf.categoryselectIndepath.row];
    };
    
    self.userTableview.haveArrangeTaskOperationBlock = ^(NSDictionary *infoDic, CGRect rect) {
         [weakSelf addHaveArrangeTaskOperationPopListView:infoDic andRect:rect];
    };
}

- (void)classMemberAction
{
    ClassMemberViewController * vc = [[ClassMemberViewController alloc]init];
    vc.infoDic = self.infoDic;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)addclassroomMetarial:(NSDictionary *)classroomInfoDic
{
    __weak typeof(self)weakSelf = self;
    AddMusicCategoryViewController * vc = [[AddMusicCategoryViewController alloc]init];
    vc.infoDic = classroomInfoDic;
    if (self.metarialHySegmentControl.selectIndex == 0) {
        vc.taskEditType = TaskEditType_addClassroomTextBook;
    }else
    {
        vc.taskEditType = TaskEditType_addClassroomCourseWare;
    }
    
    vc.addClassroomTextbookBlock = ^(NSDictionary *infoDic) {
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addClassroomTextBookWithWithDic:@{kbookId:[infoDic objectForKey:kitemId],kitemId:[infoDic objectForKey:kitemId],kitemType:@1,kgradeId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
    };
    vc.addClassroomCourseWareBlock = ^(NSDictionary *infoDic) {
        
        NSLog(@"addClassroomCourseWare %@", infoDic);
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addClassroomTextBookWithWithDic:@{kbookId:[infoDic objectForKey:kbookId],kitemId:[infoDic objectForKey:kitemId],kitemType:[infoDic objectForKey:@"coursewareType"],kgradeId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - tab;eView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categorydataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    
    [cell resetWithInfoDic:self.categorydataArray[indexPath.row]];
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
    
    [self.navigationView showSearch];
    [self showSegmentWith:indexPath.row];
    
    [self.tableView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    if (self.collectionCellType == collectionCellType_textbook) {
        [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
    }else
    {
        [cell resetCCoursewareWithInfoDic:self.collectionDataArray[indexPath.row]];
        cell.readTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_read;
            [SVProgressHUD show];
            weakSelf.currentCourseWareInfo = infoDic;
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:weakSelf];
            
        };
        cell.recordTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_record;
            [SVProgressHUD show];
            weakSelf.currentCourseWareInfo = infoDic;
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:weakSelf];
        };
        cell.videoBlock = ^(NSDictionary *infoDic) {
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kpartName];
            playVC.infoDic = mInfo;
            [weakSelf presentViewController:playVC animated:NO completion:nil];
        };
    }
    if (self.isDelete) {
        [cell deleteReset];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionCellType == collectionCellType_textbook) {
        return CGSizeMake(self.backView.hd_width / 4 - 0.5, self.backView.hd_width / 4  + 15);
    }else if (self.collectionCellType == collectionCellType_courseware )
    {
        return CGSizeMake(self.backView.hd_width / 4  - 0.5, self.backView.hd_width / 4  + 65);
    }
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
    if (self.isDelete) {
        
        NSLog(@"%@", infoDic);
        [SVProgressHUD show];
        if (self.metarialHySegmentControl.selectIndex == 0) {
            [[UserManager sharedManager] didRequestTeacher_deleteClassroomTextBookWithWithDic:@{kitemType:@1,kitemId:@0,kbookId:[infoDic objectForKey:kTextBookId],kgradeId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }else
        {
            [[UserManager sharedManager] didRequestTeacher_deleteClassroomTextBookWithWithDic:@{kitemType:[infoDic objectForKey:@"coursewareType"],kitemId:[infoDic objectForKey:@"coursewareId"],kbookId:[infoDic objectForKey:@"bookId"],kgradeId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
        return;
    }
    
    if (self.collectionCellType == collectionCellType_textbook) {
        
        self.currentTextBookInfo = infoDic;
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:kTextBookId]} withNotifiedObject:self];
        
        //        TextbookDetailViewController * vc = [[TextbookDetailViewController alloc]init];
        //        [self presentViewController:vc  animated:NO completion:nil];
        //        return;
    }else
    {
        self.currentCourseWareInfo = infoDic;
        if ([[infoDic objectForKey:@"coursewareType"] intValue] == 5) {
            // 课文单独处理
            if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0)
            {
                // 纯视频课文
                PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kpartName];
                playVC.infoDic = mInfo;
                [self presentViewController:playVC animated:NO completion:nil];
                return;
            }
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:self];
            self.learntextType = LearnTextType_read;
        }else
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:self];
        }
    }
}

- (void)showSegmentWith:(int)productCategory
{
    self.achievementHySegmentControl.hidden = YES;
    self.metarialHySegmentControl.hidden = YES;
    self.titleLB.hidden = YES;
    [self.navigationView hideLatestBtn];
    self.userTableview.hidden = YES;
    self.collectionView.hidden = YES;
    
    switch (productCategory) {
        case 0:
        {
            [self.navigationView refreshWith:userCenterItemType_latest];
            self.achievementHySegmentControl.hidden = NO;
            self.collectionView.hidden = YES;
            self.userTableview.hidden = NO;
            [self.navigationView showLatestBtn];
            if (self.achievementHySegmentControl.selectIndex == 1) {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
            }else if(self.achievementHySegmentControl.selectIndex == 2)
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
            }else if(self.achievementHySegmentControl.selectIndex == 3)
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_completeness];
            }
            else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
            }
            
        }
            break;
        case 1:
        {
            self.titleLB.hidden = NO;
            self.titleLB.text = @"作业";
            [self.navigationView refreshWith:userCenterItemType_ArrangeAndCommentAndToday];
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacher_ClassroomTaskList];
            self.userTableview.hidden = NO;
        }
            break;
        case 3:
        {
            self.titleLB.hidden = NO;
            self.titleLB.text = @"课程";
            [self.navigationView refreshWith:userCenterItemType_none];
            self.collectionView.hidden = YES;
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_Course];
        }
            break;
        case 2:
        {
            [self.navigationView refreshWith:userCenterItemType_addAndDelete];
            self.metarialHySegmentControl.hidden = NO;
            self.collectionView.hidden = NO;
            if (self.metarialHySegmentControl.selectIndex == 0) {
                self.collectionCellType = collectionCellType_textbook;
            }else
            {
                self.collectionCellType = collectionCellType_courseware;
            }
            
            [self.collectionView reloadData];
        }
            break;
        default:
            break;
    }
    [self reloaData:self.categoryselectIndepath.row];
}

- (void)reloaData:(NSInteger)productCategory
{
    switch (productCategory) {
        case 0:
        {
            [self reloadUsertableData];
        }
            break;
        case 1:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_haveArrangeTaskWithWithDic:@{@"key":@"",kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
            break;
        case 3:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_MyCourseWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
            break;
        case 2:
        {
            [self reloadtextBookAndCourseWareData];
        }
            break;
        default:
            break;
    }
}

- (void)refreshUserTableView
{
    [self.userTableview endRefresh];
    NSIndexPath * indexPath = self.categoryselectIndepath;
    if(indexPath.row == 3)
    {
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacherCourse];
    }else if (indexPath.row == 1)
    {
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_haveArrangeTask];
    }else if (indexPath.row == 0)
    {
        if (self.achievementHySegmentControl.selectIndex == 1) {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_flower];
        }else if(self.achievementHySegmentControl.selectIndex == 2)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_gold];
        }else if(self.achievementHySegmentControl.selectIndex == 3)
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_completeness];
        }
        else
        {
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
        }
    }
    else if (indexPath.row == 2)
    {
        [self.collectionView reloadData];
    }
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
    image = [UIImage imageNamed:@"default_teaching_material_icon"];
    content = @"班级内暂无课程";
    detail = [[NSMutableAttributedString alloc]initWithString:@""];
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
    
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
            if ([[infoDic objectForKey:@"row"] intValue] == 5) {
                [weakSelf showCustomTimeView];
            }else
            {
                weakSelf.timeType = 1;
                weakSelf.beginTime = @"";
                weakSelf.endTime = @"";
                weakSelf.timeStr = [infoDic objectForKey:@"title"];
                [weakSelf reloadUsertableData];
            }
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.awardPopListView];
        [self.awardPopListView refresh];
    }
}
- (void)showCustomTimeView
{
    __weak typeof(self)weakSelf = self;
    self.customTimeView = [[ClassmemberAchievementCustomTimeView alloc]initWithFrame:self.view.bounds withTitle:@""];
    [self.view addSubview:self.customTimeView];
    self.customTimeView.continueBlock = ^(NSDictionary *infoDic) {
        weakSelf.timeStr = @"";
        weakSelf.timeType = 2;
        weakSelf.beginTime = [infoDic objectForKey:@"startTime"];
        weakSelf.endTime = [infoDic objectForKey:@"endTime"];
        [weakSelf reloadUsertableData];
    };
}
#pragma mark - 作业操作
- (void)addHaveArrangeTaskOperationPopListView:(NSDictionary *)taskInfo andRect:(CGRect)rect
{
    self.currentOperationInfoDic = taskInfo;
    CGRect convertRect = [self.userTableview convertRect:rect toView:self.view];
    if (self.haveArrangeOperationListView == nil) {
        self.haveArrangeOperationListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.haveArrangeOperationList andArrowRect:convertRect andWidth:80];
        
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.haveArrangeOperationListView];
        
        __weak typeof(self.haveArrangeOperationListView)weakListView = self.haveArrangeOperationListView;
        __weak typeof(self)weakSelf = self;
        self.haveArrangeOperationListView.dismissBlock = ^{
            [weakListView removeFromSuperview];
        };
        self.haveArrangeOperationListView.SelectBlock = ^(NSDictionary *infoDic) {
            int row = [[infoDic objectForKey:@"row"] intValue];
            switch (row) {
                case 3:
                {
                    // 检查
                }
                    break;
                case 0:
                {
                    // 预览
                    if ([[weakSelf.currentOperationInfoDic objectForKey:ktempType] intValue] == 1) {
                        weakSelf.taskShowType = TaskShowType_teacher_yulan_suitang;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[weakSelf.currentOperationInfoDic objectForKey:@"tempId"]} withNotifiedObject:weakSelf];
                    }else
                    {
                        weakSelf.taskShowType = TaskShowType_teacher_yulan_Xilie;
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestTeacher_getXilieDetailWithWithDic:@{kworkTempId:[weakSelf.currentOperationInfoDic objectForKey:@"tempId"]} withNotifiedObject:weakSelf];
                    }

                }
                    break;
                case 1:
                {
                    // 改名
                    if ([[weakSelf.currentOperationInfoDic objectForKey:@"logState"] isEqualToString:@"已完结"]) {
                        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"作业已结束，不能修改，请布置新作业"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        return ;
                    }
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:weakSelf.currentOperationInfoDic];
                    [mInfo setObject:[mInfo objectForKey:@"logTitle"] forKey:@"name"];
                    [weakSelf changeNameAction:mInfo];
                }
                    break;
                case 4:
                {
                    // 改时间
                    if ([[weakSelf.currentOperationInfoDic objectForKey:@"logState"] isEqualToString:@"已完结"]) {
                        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"作业已结束，不能修改，请布置新作业"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        return ;
                    }
                    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:weakSelf.currentOperationInfoDic];
                    ArrangeTaskView * arrangeTaskView = [[ArrangeTaskView alloc]initWithFrame:weakSelf.view.bounds andTitle:@"修改作业时间" andInfoDic:infoDic andIsStudent:YES];
                    [weakSelf.view addSubview:arrangeTaskView];
                    __weak typeof(arrangeTaskView)weakView = arrangeTaskView;
                    arrangeTaskView.DismissBlock = ^{
                        [weakView removeFromSuperview];
                    };
                    arrangeTaskView.ContinueBlock = ^(NSDictionary * infoDic) {
                        [weakView removeFromSuperview];
                    };
                }
                    break;
                case 2:
                {
                    // 删除
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestTeacher_deleteHaveArrangeTaskWithDic:@{kLogId:[weakSelf.currentOperationInfoDic objectForKey:kLogId]} withNotifiedObject:weakSelf];
                }
                    break;
                    
                default:
                    break;
            }
            
        };
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.haveArrangeOperationListView];
        [self.haveArrangeOperationListView refreshWithRecr:convertRect];
    }
}

#pragma mark - 修改作业名称
- (void)changeNameAction:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    self.changeNameTipView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_changeName andTitle:@"作业名称" andPlaceHold:@"请输入作业名称" withAnimation:NO];
    self.changeNameTipView.maxCount = 200;
    [self.changeNameTipView resetNameTvText:[infoDic objectForKey:@"name"]];
    
    self.changeNameTipView.DismissBlock = ^{
        ;[weakSelf.changeNameTipView removeFromSuperview];
    };
    self.changeNameTipView.ContinueBlock = ^(NSString *str) {
        
        if (str.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"作业名称不能为空"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_changeHaveArrangeModulNameWithWithDic:@{kWorkLogId:[infoDic objectForKey:@"logId"],@"name":str} withNotifiedObject:weakSelf];
        
        [weakSelf.changeNameTipView removeFromSuperview];
    };
    [self.view addSubview:self.changeNameTipView];
}




- (void)loadData
{
    self.categorydataArray = [NSMutableArray array];
    self.informationArray = [NSMutableArray array];
    self.collectionDataArray = [NSMutableArray array];
    
    [self.categorydataArray addObject:@{@"title":@"排行榜"}];
    [self.categorydataArray addObject:@{@"title":@"作业"}];
    [self.categorydataArray addObject:@{@"title":@"教材"}];
    [self.categorydataArray addObject:@{@"title":@"课程"}];
    
    self.awardListArray = [NSMutableArray array];
    [self.awardListArray addObject:@{@"title":@"总榜"}];
    [self.awardListArray addObject:@{@"title":@"本月"}];
    [self.awardListArray addObject:@{@"title":@"上月"}];
    [self.awardListArray addObject:@{@"title":@"本周"}];
    [self.awardListArray addObject:@{@"title":@"上周"}];
    [self.awardListArray addObject:@{@"title":@"自定义"}];
    
    
    [self.collectionDataArray addObject:@{@"title":@"A",@"type":@(MaterailType_nomal),@"startCount":@"10",@"name":@"小花",@"id":@(1)}];
    [self.collectionDataArray addObject:@{@"title":@"Phonics拼读Phonics拼读",@"type":@(MaterailType_nomal),@"startCount":@"10",@"name":@"小花",@"id":@(2)}];
    [self.collectionDataArray addObject:@{@"title":@"A",@"type":@(MaterailType_nomal),@"startCount":@"10",@"name":@"小花",@"id":@(3)}];
    [self.collectionDataArray addObject:@{@"title":@"A",@"type":@(MaterailType_nomal),@"startCount":@"10",@"name":@"小花",@"id":@(4)}];
    
    self.haveArrangeOperationList = [NSMutableArray array];
//    [self.haveArrangeOperationList addObject:@{@"title":@"检查"}];
    [self.haveArrangeOperationList addObject:@{@"title":@"预览"}];
    [self.haveArrangeOperationList addObject:@{@"title":@"改名"}];
    [self.haveArrangeOperationList addObject:@{@"title":@"删除"}];
    
    
    self.timeStr = @"总榜";
    self.beginTime = @"";
    self.endTime = @"";
    self.timeType = 1;
    
    [self reloaData:self.categoryselectIndepath.row];
}

- (void)didRequestTeacher_haveArrangeTaskSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUserTableView];
}

- (void)didRequestTeacher_haveArrangeTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - classMemberAchievementListDelegate
- (void)reloadUsertableData
{
    [[UserManager sharedManager] didRequestClassMemberAchievementListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId],@"type":@(self.achievementHySegmentControl.selectIndex + 1),@"timeType":@(self.timeType),@"timeFormat":self.timeStr,@"beginTime":self.beginTime,@"endTime":self.endTime} withNotifiedObject:self];
    
}

- (void)didRequestclassMemberAchievementListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUserTableView];
}

- (void)didRequestclassMemberAchievementListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - textBook & courseWare delegate
- (void)reloadtextBookAndCourseWareData
{
    [SVProgressHUD show];
    if (self.metarialHySegmentControl.selectIndex == 0) {
        [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestClassCourseWareWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
    }
}

- (void)didRequestclassTextbookSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    self.collectionDataArray = [[[UserManager sharedManager] getClassTextbookArray] mutableCopy];
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestclassTextbookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestclassCourseWareSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    self.collectionDataArray = [[[UserManager sharedManager] getClassCourseWareArray] mutableCopy];
    [self addnoDataView];
    [self.collectionView reloadData];
}

- (void)didRequestclassCourseWareFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTextBookContentListSuccessed
{
    [SVProgressHUD dismiss];
    TextbookDetailViewController * vc = [[TextbookDetailViewController alloc]init];
    
    if (self.currentTextBookInfo) {
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentTextBookInfo];
        [infoDic setObject:[self.currentTextBookInfo objectForKey:kTextBookId] forKey:kitemId];
        vc.infoDic = infoDic;
    }else
    {
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentCourseWareInfo];
        [infoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareType"] forKey:kitemType];
        [infoDic setObject:[self.currentCourseWareInfo objectForKey:@"bookId"] forKey:kitemId];
        vc.infoDic = infoDic;
    }
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTextBookContentListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTextContentSuccessed
{
    NSMutableDictionary * mInfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentCourseWareInfo];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareId"] forKey:kpartId];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareName"] forKey:kpartName];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"bookId"] forKey:kitemId];
    
    // 阅读课文或听录音，先缓存课文
    NSArray * mp3UrlList = [mInfoDic objectForKey:@"mp3List"];
    for (int j = 0 ; j < mp3UrlList.count; j++) {
        NSString * mp3Str = [mp3UrlList objectAtIndex:j];
        
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //设置保存路径和生成文件名
        NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [mInfoDic objectForKey:kpartName], j];
        //保存
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [SVProgressHUD dismiss];
            // 已下载 存储路径
            [self saveDownloadAudio:mInfoDic andNumber:j];
            
        }else
        {
            // 未下载。先下载，再存储路径
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
            if ([audioData writeToFile:filePath atomically:YES]) {
                NSLog(@"succeed");
                
                [self saveDownloadAudio:mInfoDic andNumber:j];
                
            }else{
                NSLog(@"faild");
            }
            
        }
        
    }
    [SVProgressHUD dismiss];
    
    LearnTextViewController * vc = [[LearnTextViewController alloc]init];
    vc.infoDic = mInfoDic;
    vc.learntextType = self.learntextType;
    [self presentViewController:vc  animated:NO completion:nil];
}

- (void)saveDownloadAudio:(NSDictionary *)infoDic andNumber:(int )j
{
    NSMutableDictionary * audioDic = [NSMutableDictionary dictionary];
    [audioDic setObject:[infoDic objectForKey:kpartName] forKey:kAudioName];
    [audioDic setObject:[NSString stringWithFormat:@"%@-%d", [infoDic objectForKey:kpartName],j] forKey:kAudioId];
    [audioDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioDic setObject:@(j) forKey:@"number"];
    [[DBManager sharedManager] saveDownloadAudioInfo:audioDic];
    
    NSMutableDictionary * audioListDic = [NSMutableDictionary dictionary];
    [audioListDic setObject:[infoDic objectForKey:kpartName] forKey:kpartName];
    [audioListDic setObject:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartId]] forKey:kpartId];
    [audioListDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioListDic setObject:@(DownloadAudioType_read) forKey:@"type"];
    [[DBManager sharedManager] saveDownloadAudioListInfo:audioListDic];
}

- (void)didRequestTextContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
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
    [self refreshUserTableView];
}

- (void)didRequestTeacher_changeHaveArrangeMOdulNameSuccessed
{
    [self reloaData:self.categoryselectIndepath.row];
}

- (void)didRequestTeacher_changeHaveArrangeMOdulNameFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteHaveArrangeTaskSuccessed
{
    [self reloaData:self.categoryselectIndepath.row];
}

- (void)didRequestTeacher_deleteHaveArrangeTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteClassroomTextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteClassroomTextBookSuccessed
{
    [SVProgressHUD dismiss];
    [self reloaData:self.categoryselectIndepath.row];
}

- (void)didRequestTeacher_addClassroomTextBookSuccessed
{
    [self reloaData:self.categoryselectIndepath.row];
    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAddCoursewareNotification object:nil];
}

- (void)didRequestTeacher_addClassroomTextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - modul detail
- (void)didRequestTeacher_getXilieDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getXilieDetailSuccessed
{
    [SVProgressHUD dismiss];
    MyTaskViewController * vc = [[MyTaskViewController alloc]init];
    vc.taskShowType = self.taskShowType;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTeacher_getSuitangDetailSuccessed
{
    [SVProgressHUD dismiss];
    MyTaskViewController * vc = [[MyTaskViewController alloc]init];
    vc.taskShowType = self.taskShowType;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTeacher_getSuitangDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
