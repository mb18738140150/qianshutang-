//
//  ClassroomDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomDetailViewController.h"
#import "UserCenterTableView.h"
#import "StudentInformationViewController.h"
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
#import "MyTaskAttendanceRecordViewController.h"

#import "LearnTextViewController.h"
#import "CommentTaskListViewController.h"
#import "ClassmemberAchievementCustomTimeView.h"
#import "PlayVideoViewController.h"



@interface ClassroomDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MyClassroom_classMemberAchievementList,MyClassroom_classTaskList,MyClassroom_classTextbook, MyClassroom_classCourseWare, MyStudy_MyCourseList,ActiveStudy_TextBookContentList,ActiveStudy_TextContent>

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

@property (nonatomic, strong)NSDictionary * currentTextBookInfo; // 当前选中课本
@property (nonatomic, strong)NSDictionary * currentCourseWareInfo;
@property (nonatomic, assign)LearnTextType  learntextType;
// 获奖榜单
@property (nonatomic, strong)PopListView * awardPopListView;
@property (nonatomic, strong)NSIndexPath * awardPopIndexpath;
@property (nonatomic, strong)NSMutableArray * awardListArray;

@property (nonatomic, strong)UIImageView * classRoomIconImageView;
@property (nonatomic, strong)UIButton * iconImageBtn;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * iconTipLB;

@property (nonatomic, strong)NSString * timeStr;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, assign)int timeType;

@property (nonatomic, strong)ClassmemberAchievementCustomTimeView * customTimeView;
@property (nonatomic, strong)FailedView * failedView;// 暂无数据view

@end

@implementation ClassroomDetailViewController


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
            
            [weakSelf.navigationView refreshWith:userCenterItemType_latest];
            
            weakSelf.userTableview.hidden = NO;
            weakSelf.collectionView.hidden = YES;
           
            [weakSelf reloadUsertableData];
            
        }
    };
    
    self.metarialHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"课本",@"课件"] delegate:self];
    [self.metarialHySegmentControl hideBottomView];
    [self.metarialHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.metarialHySegmentControl];
    self.metarialHySegmentControl.hidden = YES;
    self.metarialHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        
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
    
    UIImageView * classRoomIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.036, self.navigationView.hd_height + kScreenWidth * 0.0115, kScreenWidth * 0.124, kScreenWidth * 0.124)];
    [classRoomIconImageView sd_setImageWithURL:[NSURL URLWithString:[self.infoDic objectForKey:kClassroomIcon]] placeholderImage:[UIImage imageNamed:@"logo1"]];
    self.classRoomIconImageView = classRoomIconImageView;
    self.classRoomIconImageView.layer.cornerRadius = 10;
    self.classRoomIconImageView.layer.masksToBounds = YES;
    [self.view addSubview:classRoomIconImageView];
    
    self.iconImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageBtn.frame = CGRectMake(kScreenWidth * 0.036, self.navigationView.hd_height + kScreenWidth * 0.0115, kScreenWidth * 0.124, kScreenWidth * 0.124);
    self.iconImageBtn.backgroundColor = [UIColor clearColor];
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
    self.nameLB.text = [self.infoDic objectForKey:kClassroomName];
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
    self.userTableview.isClassroom = YES;
    self.userTableview.isCourse = YES;
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_star];
    
    self.userTableview.headRefreshBlock = ^{
        [weakSelf reloaData:weakSelf.categoryselectIndepath.row];
    };
    
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        switch (type) {
            case UserCenterTableViewType_flower:
            case UserCenterTableViewType_star:
            case UserCenterTableViewType_gold:
            case UserCenterTableViewType_completeness:
            {
                StudentInformationViewController * stuVC = [[StudentInformationViewController alloc]init];
                stuVC.isNotFromCommentTaskVC = YES;
                stuVC.infoDic = infoDic;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:stuVC animated:NO completion:nil];
                });
            }
                break;
            case UserCenterTableViewType_ClassroomTask:
            {
                MyTaskListDetailViewController * myTaskattVC = [[MyTaskListDetailViewController alloc]init];
                
                myTaskattVC.infoDic = infoDic;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:myTaskattVC animated:NO completion:nil];
                });
            }
                break;
            case UserCenterTableViewType_Course:
            {
                MyTaskAttendanceRecordViewController * vc = [[MyTaskAttendanceRecordViewController alloc]init];
                vc.myCourseInfo = infoDic;
                [weakSelf presentViewController:vc animated:NO completion:nil];
            }
                break;
            default:
                break;
        }
    };
}

- (void)classMemberAction
{
    ClassMemberViewController * vc = [[ClassMemberViewController alloc]init];
    vc.infoDic = self.infoDic;
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
            if ([[infoDic objectForKey:@"mp4Src"] class] == [NSNull class] || [infoDic objectForKey:@"mp4Src"] == nil || [[infoDic objectForKey:@"mp4Src"] isEqualToString:@""]) {
                
            }else{
                
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

- (void)showSegmentWith:(NSInteger)productCategory
{
    self.achievementHySegmentControl.hidden = YES;
    self.metarialHySegmentControl.hidden = YES;
    self.titleLB.hidden = YES;
    [self.navigationView hideLatestBtn];
    self.userTableview.hidden = YES;
    self.collectionView.hidden = YES;
    self.failedView.hidden = YES;
    
    switch (productCategory) {
        case 0:
        {
            [self.navigationView refreshWith:userCenterItemType_latest];
            self.achievementHySegmentControl.hidden = NO;
            self.collectionView.hidden = YES;
            self.userTableview.hidden = NO;
            [self.navigationView showLatestBtn];
//            [self reloadUsertableData];
        }
            break;
        case 1:
        {
            self.titleLB.hidden = NO;
            self.titleLB.text = @"我的作业";
            [self.navigationView refreshWith:userCenterItemType_comment];
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
            
        }
            break;
        case 2:
        {
            [self.navigationView refreshWith:userCenterItemType_none];
            self.metarialHySegmentControl.hidden = NO;
            self.collectionView.hidden = NO;
            [self reloadtextBookAndCourseWareData];
        }
            break;
        default:
            break;
    }
    
    [self reloaData:productCategory];
    
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
            [[UserManager sharedManager] didRequestClassTaskListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
            break;
        case 3:
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestMyCourseListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId],kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
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

#pragma mark - course Delegate
- (void)didRequestMyCourseListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_Course];
}

- (void)didRequestMyCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestclassTaskListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_ClassroomTask];
}

- (void)didRequestclassTaskListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - achievementList
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
    
    self.timeStr = @"总榜";
    self.beginTime = @"";
    self.endTime = @"";
    self.timeType = 1;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberAchievementListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId],@"type":@(1),@"timeType":@(self.timeType),@"timeFormat":self.timeStr,@"beginTime":self.beginTime,@"endTime":self.endTime} withNotifiedObject:self];
    
    return;
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

#pragma mark - classMemberAchievementListDelegate
- (void)reloadUsertableData
{
    [[UserManager sharedManager] didRequestClassMemberAchievementListWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId],@"type":@(self.achievementHySegmentControl.selectIndex + 1),@"timeType":@(self.timeType),@"timeFormat":self.timeStr,@"beginTime":self.beginTime,@"endTime":self.endTime} withNotifiedObject:self];
    
}

- (void)didRequestclassMemberAchievementListSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
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


- (void)didRequestclassMemberAchievementListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    [self.userTableview endRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
