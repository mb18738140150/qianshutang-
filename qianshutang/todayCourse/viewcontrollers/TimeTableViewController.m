//
//  TimeTableViewController.m
//  qianshutang
//
//  Created by aaa on 2018/9/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TimeTableViewController.h"

#import "SelectDayView.h"
#import "TodayCourseCollectionViewCell.h"
#define kTodayCourseCollectionCellID @"TodayCourseCollectionViewCell"


#import "NTESCommonTableDelegate.h"
#import "NTESCommonTableData.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "NTESMeetingViewController.h"
#import "NTESMeetingManager.h"
#import "NTESDemoService.h"
#import "NTESTextSettingCell.h"
#import "NTESMeetingRolesManager.h"
#import <NIMAVChat/NIMAVChat.h>

@interface TimeTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MyStudy_MyCourse_BigCourseList, MyStudy_CurrentWeekCourseList>
@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)SelectDayView * selectDayView;
@property (nonatomic, strong)UIButton * todayBtn;
@property (nonatomic, strong)UIImageView * backImageView;

@property (nonatomic, assign)BOOL isToday;
@property (nonatomic, strong)NSDate * currentDate;

@end

@implementation TimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
}

- (void)prepareUI
{
    self.isToday = YES;
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(239, 239, 239);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.selectDayView = [[SelectDayView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - (self.navigationView.hd_height * 7 + 80) / 2, 0, self.navigationView.hd_height * 7 + 80, self.navigationView.hd_height)];
    self.selectDayView.SelectDayBlock = ^(NSDate *date) {
        [weakSelf loadDataWithDate:date];
    };
    self.selectDayView.previousWeekBlock = ^(NSDate *date, NSDate * currentDate) {
        weakSelf.currentDate = currentDate;
        [weakSelf refreshWeekData:date];
    };
    self.selectDayView.nextWeekBlock = ^(NSDate *date, NSDate * currentDate) {
        weakSelf.currentDate = currentDate;
        [weakSelf refreshWeekData:date];
    };
    [self.view addSubview:self.selectDayView];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.rightView.hd_height + 10, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.todayBtn.backgroundColor = kMainColor;
    self.todayBtn.layer.cornerRadius = self.todayBtn.hd_height / 2;
    self.todayBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.todayBtn];
    [self.todayBtn addTarget:self action:@selector(todayAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    self.backImageView.image = [UIImage imageNamed:@"course_bg"];
    [self.view addSubview:self.backImageView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.18, kScreenWidth, kScreenHeight * 0.689) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[TodayCourseCollectionViewCell class] forCellWithReuseIdentifier:kTodayCourseCollectionCellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodayCourseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTodayCourseCollectionCellID forIndexPath:indexPath];
    [cell resetWith:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.46, kScreenHeight * 0.689);
}

- (void)todayAction
{
    [self.selectDayView resetTiday];
}


- (void)loadData
{
    self.dataArray = [[[UserManager sharedManager] getMyCourse_BigCourseList] mutableCopy];
    [self.collectionView reloadData];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
    self.currentDate = [NSDate date];
    [[UserManager sharedManager] didRequestCurrentWeekCourseListWithWithDic:@{kTime:timeStr} withNotifiedObject:self];
}

- (void)refreshWeekData:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:date];
    
    [[UserManager sharedManager] didRequestCurrentWeekCourseListWithWithDic:@{kTime:timeStr} withNotifiedObject:self];
    
}

- (void)didRequestCurrentWeekCourseListSuccessed
{
    
    [self.selectDayView refreshCurrentWeekCourse];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:self.currentDate];
    
    [[UserManager sharedManager] didRequestMyCourse_BigCourseListWithWithDic:@{kTime:timeStr} withNotifiedObject:self];
}

- (void)didRequestCurrentWeekCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyCourse_BigCourseListSuccessed
{
    self.dataArray = [[[UserManager sharedManager] getMyCourse_BigCourseList] mutableCopy];
    [self.collectionView reloadData];
}

- (void)didRequestMyCourse_BigCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)loadDataWithDate:(NSDate *)date
{
    
    [self reserveNetCallMeeting:@"哈哈哈ha"];
    
    return;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:date];
    
    NSString * currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    if ([currentTimeStr isEqualToString:timeStr]) {
        self.isToday = YES;
    }else
    {
        self.isToday = NO;
    }
    
    [[UserManager sharedManager] didRequestMyCourse_BigCourseListWithWithDic:@{kTime:timeStr} withNotifiedObject:self];
}

- (void)didRequestMyEveryDayTaskSuccessed
{
    [SVProgressHUD dismiss];
    [self loadData];
}

- (void)didRequestMyEveryDayTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)requestChatRoom
{
    [SVProgressHUD show];
    __weak typeof(self) wself = self;

    [[NTESDemoService sharedService] requestChatRoom:@"哈哈哈ha"
                                          completion:^(NSError *error, NSString *meetingRoomID)
     {
         [SVProgressHUD dismiss];
         if (!error){
             [self reserveNetCallMeeting:meetingRoomID];
         }
         else
         {
             [wself.view makeToast:@"创建聊天室失败，请重试" duration:2.0 position:CSToastPositionCenter];
         }
     }];
}

- (void)reserveNetCallMeeting:(NSString *)roomId
{
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId = roomId;
    
    NIMNetCallMeeting *kmeeting = [[NIMNetCallMeeting alloc] init];
    kmeeting.name = roomId;
    kmeeting.type = NIMNetCallTypeVideo;
    kmeeting.actor = YES;

    //初始化option参数
    NIMNetCallOption *option = [[NIMNetCallOption alloc]init];
    kmeeting.option = option;
    
    //指定 option 中的 videoCaptureParam 参数
    NIMNetCallVideoCaptureParam *param = [[NIMNetCallVideoCaptureParam alloc] init];
    //清晰度480P
    param.preferredVideoQuality = NIMNetCallVideoQuality480pLevel;
    //裁剪类型 16:9
    param.videoCrop  = NIMNetCallVideoCrop16x9;
    //打开初始为前置摄像头
    param.startWithBackCamera = NO;
    
    option.videoCaptureParam = param;

    [SVProgressHUD show];
    __weak typeof(self) wself = self;
    [[NIMAVChatSDK sharedSDK].netCallManager reserveMeeting:kmeeting completion:^(NIMNetCallMeeting *meeting, NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
//            [self enterChatRoom:roomId];
//            [SoftManager shareSoftManager].isCamera = YES;
            
            
            NIMChatroomMember *me = [[NIMChatroomMember alloc]init];
            me.userId = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]];
            
            
            NIMChatroom *room = [[NIMChatroom alloc]init];
            room.roomId = meeting.name;
            
            if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
                room.creator = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]];
                me.type = NIMChatroomMemberTypeCreator;
            }else
            {
                room.creator = @"5";
            }
            
            [[NTESMeetingManager sharedInstance] cacheMyInfo:me roomId:request.roomId];
            [[NTESMeetingRolesManager sharedInstance] startNewMeeting:me withChatroom:room newCreated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NTESMeetingViewController *vc = [[NTESMeetingViewController alloc] initWithMeetingroom:meeting];
                
                [wself presentViewController:vc animated:YES completion:nil];
            });
            
        }
        else {
            
            if([[error.userInfo objectForKey:@"NSLocalizedDescription"] isEqualToString:@"对象已经存在"])
            {
//                [SoftManager shareSoftManager].isCamera = YES;
                
                NIMChatroomMember *me = [[NIMChatroomMember alloc]init];
                me.userId = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]];
                
                NIMChatroom *room = [[NIMChatroom alloc]init];
                room.roomId = meeting.name;
                
                if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
                    room.creator = [NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]];
                    me.type = NIMChatroomMemberTypeCreator;
                }else
                {
                    room.creator = @"5";
                }
                
                [[NTESMeetingManager sharedInstance] cacheMyInfo:me roomId:request.roomId];
                [[NTESMeetingRolesManager sharedInstance] startNewMeeting:me withChatroom:room newCreated:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NTESMeetingViewController *vc = [[NTESMeetingViewController alloc] initWithMeetingroom:meeting];
                    
                    [wself presentViewController:vc animated:YES completion:nil];
                });
                return ;
            }
            
            [self.view makeToast:@"分配视频会议失败，请重试" duration:2.0 position:CSToastPositionCenter];
        }
    }];
}

- (void)enterChatRoom:(NSString *)roomId
{
    NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
    request.roomId = roomId;
    [SVProgressHUD show];

    __weak typeof(self) wself = self;
    
    
    [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError *error, NIMChatroom *room, NIMChatroomMember *me) {
        [SVProgressHUD dismiss];
        if (!error) {
            [[NTESMeetingManager sharedInstance] cacheMyInfo:me roomId:request.roomId];
            [[NTESMeetingRolesManager sharedInstance] startNewMeeting:me withChatroom:room newCreated:YES];
            NTESMeetingViewController *vc = [[NTESMeetingViewController alloc] initWithChatroom:room];
            [wself.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [wself.view makeToast:@"进入会议失败，请重试" duration:2.0 position:CSToastPositionCenter];
        }
    }];

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
