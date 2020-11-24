//
//  MyTaskViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyTaskViewController.h"
#import "TodayTaskCollectionViewCell.h"
#define kTodayTaskCellID @"TodayTaskCollectionViewCell"
#import "AddMusicCategoryViewController.h"
#import "TeakEveryDayDetailViewController.h"
#import "CreateProductionViewController.h"
#import "MoerduoView.h"
#import "LearnTextViewController.h"
#import "CreateTaskTypeView.h"
#import "XilieTaskYulanSelectDayView.h"
#import "CreateTaskViewController.h"
#import "AddMusicViewController.h"
#import "AddXiLieTaskView.h"
#import "AttendanceTaskRepeatPickerView.h"
#import "CommentTaskViewController.h"

@interface MyTaskViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyStudy_MyEveryDayTask, ActiveStudy_TextContent,Task_CreateTaskProblemContent,Teacher_getXilieDetail, Teacher_addSuitangTaskType,Teacher_addXilieTaskType, Teacher_getSuitangDetail, Teacher_getEditXilieTaskDetail, Teacher_deleteModul,Teacher_changeSuitangModulTextBook,Teacher_changeSuitangModulRepeatCount,Teacher_getTodayClassroomTask,Task_SubmitMoerduoAndReadTask, MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * detailBtn;
@property (nonatomic, strong)UIButton * moerduoBtn;
@property (nonatomic, strong)FailedView * failedView;

@property (nonatomic, strong)UICollectionView * collectionView;
//@property (nonatomic, strong)NSMutableArray * collectionViewArray;


@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UICollectionView * bottomCollectionView;
@property (nonatomic, strong)NSIndexPath * bottomIndexpath;

@property (nonatomic, strong)NSDictionary * currentSelectTextInfo;// 当前选中作业

@property (nonatomic, strong)ToolTipView * tooView;
@property (nonatomic, assign)LearnTextType  learntextType;

@property (nonatomic, assign)CreatProductionType createProductionType;
@property (nonatomic, strong)CreateTaskTypeView * createTaskTypeView;
@property (nonatomic, strong)MoerduoView *moerduoView;

@property (nonatomic, strong)UIButton * addTaskTypeBtn;
@property (nonatomic, strong)UIButton * yulanBtn;// 编辑系列作业
@property (nonatomic, strong)UILabel * taskCountDayLB;// 系列作业预览
@property (nonatomic, assign)int currentDay;// 系列作业当前日期

@property (nonatomic, strong)AddXiLieTaskView * addXiLieTaskView;// 系列
@property (nonatomic, strong)ToolTipView * repeatView;
@property (nonatomic, strong)NSDictionary * xilieTextBookInfo;
@property (nonatomic, strong)NSDictionary * startTextInfoDic;// 起始课文
@property (nonatomic, strong)NSDictionary * endTextInfoDic;// 结束课文
@property (nonatomic, strong)NSArray * xilieSelectTextArray;// 系列作业已选择课文列表
@property (nonatomic, assign)TaskEditType taskEditType;// 作业编辑类型
@property (nonatomic, strong)AttendanceTaskRepeatPickerView *attendancePickerView;

@property (nonatomic, strong)XilieTaskYulanSelectDayView * selectDayView;

@property (nonatomic, strong)NSDictionary * selectProductInfo;
@property (nonatomic, assign)TaskType tasktype;
@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[BTVoicePlayer share] isHavePlayerItem]) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(239, 239, 239);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 3 - 0.5, kScreenHeight * 0.657);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + kScreenHeight * 0.03, kScreenWidth, kScreenHeight * 0.657) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    [self.collectionView registerClass:[TodayTaskCollectionViewCell class] forCellWithReuseIdentifier:kTodayTaskCellID];
    self.collectionView.contentSize = CGSizeMake(kScreenWidth / 4 * self.dataArray.count, kScreenHeight * 0.61);
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.86, kScreenWidth, kScreenHeight * 0.14)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UICollectionViewFlowLayout * bottomLayout = [[UICollectionViewFlowLayout alloc]init];
    bottomLayout.itemSize = CGSizeMake(kScreenWidth / 5 - 0.5, self.bottomView.hd_height);
    bottomLayout.minimumLineSpacing = 0;
    bottomLayout.minimumInteritemSpacing = 0;
    bottomLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.bottomCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bottomView.hd_height) collectionViewLayout:bottomLayout];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.bottomView addSubview:self.bottomCollectionView];
    self.bottomCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.failedView = [[FailedView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height - self.bottomView.hd_height) andImage:[UIImage imageNamed:@"default_homework_icon"] andContent:@"暂无作业" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    self.failedView.backgroundColor = UIRGBColor(249, 244, 233);
    [self.view addSubview:self.failedView];
    self.failedView.hidden = YES;
    
    if (self.bottomCollectionViewArray.count > 0) {
        // 从作业详情界面过来
        self.bottomIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        for (int i = 0; i < self.bottomCollectionViewArray.count; i++) {
            NSDictionary * info = [self.bottomCollectionViewArray objectAtIndex:i];
            if ([[info objectForKey:@"type"] isEqual:[self.infoDic objectForKey:@"type"]]) {
                self.bottomIndexpath = [NSIndexPath indexPathForRow:i inSection:0];
                break;
            }
        }
        
        self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
        [self loadDataWith:self.bottomIndexpath.row];
        [self.bottomCollectionView reloadData];
        [self.collectionView reloadData];
    }else
    {
        [self loadData];
    }
    
    [self addNavigationView];
}


- (void)addNavigationView
{
    __weak typeof(self)weakSelf = self;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWidth * 0.7 - 160, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"今日作业";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    
    switch (self.taskShowType) {
        case TaskShowType_nomal:
            {
                self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.detailBtn.frame = CGRectMake(30 + kScreenHeight * 0.15 - 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
                [self.detailBtn setTitle:@"详情" forState:UIControlStateNormal];
                [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.detailBtn.backgroundColor = kMainColor;
                self.detailBtn.layer.cornerRadius = self.detailBtn.hd_height / 2;
                self.detailBtn.layer.masksToBounds = YES;
                [self.navigationView addSubview:self.detailBtn];
                [self.detailBtn addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self addMoerduoView];
                
                [self.navigationView.rightView addSubview:self.titleLB];
            }
            break;
        case TaskShowType_teacher_yulan_suitang:
        {
            self.titleLB.text = [self.infoDic objectForKey:@"name"];
            [self.navigationView addSubview:self.titleLB];
            [self addMoerduoView];
        }
            break;
        case TaskShowType_teacher_yulan_Xilie:
        {
            self.selectDayView = [[XilieTaskYulanSelectDayView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - ((self.navigationView.hd_height + 5) * 7 + 80) / 2, 0, (self.navigationView.hd_height + 5) * 7 + 80, self.navigationView.hd_height)];
            [self.selectDayView resetTaskCount:self.allTaskArray.count];
            self.selectDayView.SelectDayBlock = ^(int day) {
                weakSelf.currentDay = day;
                [weakSelf loadData];
            };
            [self.view addSubview:self.selectDayView];
            
            self.taskCountDayLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 5, 80, self.navigationView.hd_height - 10)];
            NSString * str = [NSString stringWithFormat:@"本次作业共%d天", self.allTaskArray.count];
            self.taskCountDayLB.numberOfLines = 0;
            self.taskCountDayLB.textAlignment = NSTextAlignmentCenter;
            self.taskCountDayLB.textColor = UIColorFromRGB(0x666666);
            NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor_orange};
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(5, str.length - 6)];
            self.taskCountDayLB.attributedText = mStr;
            [self.view addSubview:self.taskCountDayLB];
        }
            break;
        case TaskShowType_teacher_edit_suitang:
        {
            self.addTaskTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addTaskTypeBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, kScreenHeight * 0.15 - 10);
            self.addTaskTypeBtn.backgroundColor = kMainColor;
            [self.addTaskTypeBtn setTitle:@"添加类型" forState:UIControlStateNormal];
            [self.addTaskTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.addTaskTypeBtn.layer.cornerRadius = self.addTaskTypeBtn.hd_height / 2;
            self.addTaskTypeBtn.layer.masksToBounds = YES;
            
            [self.navigationView.rightView addSubview:self.addTaskTypeBtn];
            
            self.titleLB.frame = CGRectMake( self.addTaskTypeBtn.hd_width + 16 + 20, 0,  kScreenWidth - ( self.addTaskTypeBtn.hd_width + 16) * 2 - 40, self.navigationView.hd_height);
            self.titleLB.text = [NSString stringWithFormat:@"编辑“%@”的作业内容", [self.infoDic objectForKey:@"name"]];
            [self.navigationView addSubview:self.titleLB];
            [self.addTaskTypeBtn addTarget:self action:@selector(addTaskTypeAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case TaskShowType_teacher_edit_Xilie:
        {
            self.addTaskTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addTaskTypeBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, kScreenHeight * 0.15 - 10);
            self.addTaskTypeBtn.backgroundColor = kMainColor;
            [self.addTaskTypeBtn setTitle:@"添加类型" forState:UIControlStateNormal];
            [self.addTaskTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.addTaskTypeBtn.layer.cornerRadius = self.addTaskTypeBtn.hd_height / 2;
            self.addTaskTypeBtn.layer.masksToBounds = YES;
            [self.addTaskTypeBtn addTarget:self action:@selector(addTaskTypeAction) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationView.rightView addSubview:self.addTaskTypeBtn];
            
            self.yulanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.yulanBtn.frame = CGRectMake(self.addTaskTypeBtn.hd_x - 16 - self.navigationView.rightView.hd_height + 10 , 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
            [self.yulanBtn setTitle:@"预览" forState:UIControlStateNormal];
            [self.yulanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.yulanBtn.backgroundColor = kMainColor;
            self.yulanBtn.layer.cornerRadius = self.yulanBtn.hd_height / 2;
            self.yulanBtn.layer.masksToBounds = YES;
            [self.navigationView.rightView addSubview:self.yulanBtn];
            
            self.titleLB.frame = CGRectMake( self.yulanBtn.hd_width + self.addTaskTypeBtn.hd_width + 32 + 20, 0,  kScreenWidth - (self.yulanBtn.hd_width + self.addTaskTypeBtn.hd_width + 32) * 2 - 40, self.navigationView.hd_height);
            self.titleLB.text = [NSString stringWithFormat:@"编辑“%@”的作业内容", [self.infoDic objectForKey:@"name"]];
            [self.navigationView addSubview:self.titleLB];
            [self.yulanBtn addTarget:self action:@selector(yulanAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)addMoerduoView
{
    self.moerduoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moerduoBtn.frame = CGRectMake(kScreenWidth - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.moerduoBtn setImage:[UIImage imageNamed:@"listen_area"] forState:UIControlStateNormal];
    [self.navigationView addSubview:self.moerduoBtn];
    [self.moerduoBtn addTarget:self action:@selector(moerduoAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.taskShowType == TaskShowType_teacher_yulan_suitang) {
        if (self.bottomCollectionViewArray.count > 0) {
            NSDictionary * infoDic = self.bottomCollectionViewArray[0];
            if ([[infoDic objectForKey:@"type"] intValue] == 1) {
                self.moerduoBtn.hidden = NO;
            }else
            {
                self.moerduoBtn.hidden = YES;
            }
        }else
        {
            self.moerduoBtn.hidden = YES;
        }
    }else
    {
        self.moerduoBtn.hidden = YES;
    }
}

- (void)detailAction{
    TeakEveryDayDetailViewController * vc = [[TeakEveryDayDetailViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    vc.doBlock = ^(NSDictionary *infoDic) {
        NSLog(@"infoDic = %@", infoDic);
        ;
        int currentIndex = 0;
        for (int i = 0; i < weakSelf.bottomCollectionViewArray.count; i++) {
            NSDictionary * bottomInfo = weakSelf.bottomCollectionViewArray[i];
            if ([[infoDic objectForKey:@"type"] isEqual:[bottomInfo objectForKey:@"type"]]) {
                currentIndex = i;
                break;
            }
        }
        weakSelf.bottomIndexpath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataArray = [[weakSelf.bottomCollectionViewArray objectAtIndex:weakSelf.bottomIndexpath.row] objectForKey:@"data"];
            [weakSelf loadDataWith:weakSelf.bottomIndexpath.row];
            [weakSelf.bottomCollectionView reloadData];
            [weakSelf.collectionView reloadData];
        });
        
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.collectionView]) {
        
        return self.dataArray.count;
    }
    return self.bottomCollectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if ([collectionView isEqual:self.collectionView]) {
        TodayTaskCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTodayTaskCellID forIndexPath:indexPath];
        cell.currentpage = indexPath.row + 1;
        cell.totalPage = self.dataArray.count;
        
        if (self.bottomIndexpath.row == 0 || self.bottomIndexpath.row == 1) {
            cell.isRead = YES;
        }else
        {
            cell.isRead = NO;
        }
        cell.taskShowType = self.taskShowType;
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[indexPath.row]];
        [infoDic setObject:@(indexPath.row + 1) forKey:@"currentPage"];
        [infoDic setObject:@(self.dataArray.count) forKey:@"totalPage"];
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        
        [cell resetWithInfoDic:mInfo];
        
        cell.changeBlock = ^(NSDictionary *infoDic) {
            weakSelf.currentSelectTextInfo = infoDic;
            [weakSelf editeSuitangTask:infoDic];
        };
        cell.deleteBlock = ^(NSDictionary *infoDic) {
            
            [SVProgressHUD show];
            if (weakSelf.taskShowType == TaskShowType_teacher_edit_Xilie) {
                NSLog(@"系列作业 workTempId = %@\n**%@",[weakSelf.infoDic objectForKey:kworkTempId], infoDic);
                [[UserManager sharedManager] didRequestTeacher_DeleteModulWithWithDic:@{kworkTempType:@2,kworkTempId:[weakSelf.infoDic objectForKey:kworkTempId],kinfoId:[infoDic objectForKey:kinfoId]} withNotifiedObject:weakSelf];
            }else if (weakSelf.taskShowType == TaskShowType_teacher_edit_suitang)
            {
                NSLog(@"随堂作业 workTempId = %@\n**%@",[weakSelf.infoDic objectForKey:kworkTempId], infoDic);
                [[UserManager sharedManager] didRequestTeacher_DeleteModulWithWithDic:@{kworkTempType:@1,kworkTempId:[weakSelf.infoDic objectForKey:kworkTempId],kinfoId:[infoDic objectForKey:kinfoId]} withNotifiedObject:weakSelf];
            }
            
            
        };
        cell.changeRepeatCountBlock = ^(NSDictionary *infoDic) {
            // 修改重复次数
            weakSelf.currentSelectTextInfo = infoDic;
            [weakSelf changeRepeatCount:indexPath.row];
        };
        return cell;
    }
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.hd_width, cell.hd_height)];
    titleLB.text = [[self.bottomCollectionViewArray objectAtIndex:indexPath.item] objectForKey:@"typeStr"];
    if (self.bottomIndexpath.row == indexPath.row) {
        titleLB.textColor = kMainColor;
    }else
    {
        titleLB.textColor = UIColorFromRGB(0x555555);
    }
    titleLB.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLB];
    return cell;
}

- (void)moerduoAction
{
    NSDictionary * infoDic = self.bottomCollectionViewArray[0];
    NSArray * dataArray = [infoDic objectForKey:@"data"];
    NSDictionary * taskInfo = [dataArray objectAtIndex:0];
    self.currentSelectTextInfo = taskInfo;
    if (self.moerduoView == nil) {
        MoerduoView * moerduoView = [[MoerduoView alloc]initWithFrame:self.view.bounds andInfo:dataArray];
        moerduoView.isTask = YES;
        self.moerduoView = moerduoView;
    }else if (![self.view.subviews containsObject:self.moerduoView]) {
        [self.view addSubview:self.moerduoView];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    self.moerduoView.dismissBlock = ^{
        [weakSelf.moerduoView removeFromSuperview];
    };
    self.moerduoView.DoMoerduoTaskComplate = ^(NSDictionary *infoDic) {
        // 磨耳朵作业阅读完毕，提交作业
        NSLog(@" ****** %@", infoDic);
        
#pragma mark - moerduo complate
        
        [[UserManager sharedManager] didRequestSubmitMoerduoAndReadTaskWithWithDic:@{kuserWorkId:[infoDic objectForKey:kuserWorkId], kitemId:[infoDic objectForKey:kpartId], kpartId:[infoDic objectForKey:kpartId], @"second":@(0), @"isEnd":@(1), @"type":@(1)} withNotifiedObject:weakSelf];
        
    };
    [self.view addSubview:self.moerduoView];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.bottomCollectionView]) {
        self.bottomIndexpath = indexPath;
        [self.bottomCollectionView reloadData];
        
        [self loadDataWith:indexPath.item];
    }else
    {
        NSDictionary * infoDic = self.bottomCollectionViewArray[self.bottomIndexpath.row];
        
        switch (self.taskShowType) {
            case TaskShowType_teacher_yulan_Xilie:
            case TaskShowType_teacher_yulan_suitang:
            case TaskShowType_Teacher_classroomTodayTask:
            case TaskShowType_nomal:
            {
                NSArray * dataArray = [infoDic objectForKey:@"data"];
                NSDictionary * taskInfo = [dataArray objectAtIndex:indexPath.row];
                self.currentSelectTextInfo = taskInfo;
                switch ([[infoDic objectForKey:@"type"] intValue] ) {
                    case 1:
                    {
                        // moreduo
                        
                        if (self.moerduoView == nil) {
                            MoerduoView * moerduoView = [[MoerduoView alloc]initWithFrame:self.view.bounds andInfo:dataArray];
                            moerduoView.isTask = YES;
                            self.moerduoView = moerduoView;
                        }else if (![self.view.subviews containsObject:self.moerduoView]) {
                            [self.view addSubview:self.moerduoView];
                            return;
                        }
                        
                        __weak typeof(self)weakSelf = self;
                        self.moerduoView.dismissBlock = ^{
                            [weakSelf.moerduoView removeFromSuperview];
                        };
                        self.moerduoView.DoMoerduoTaskComplate = ^(NSDictionary *infoDic) {
                            // 磨耳朵作业阅读完毕，提交作业
                            NSLog(@" ****** %@", infoDic);

#pragma mark - moerduo complate
                            
                            [[UserManager sharedManager] didRequestSubmitMoerduoAndReadTaskWithWithDic:@{kuserWorkId:[infoDic objectForKey:kuserWorkId], kitemId:[infoDic objectForKey:kpartId], kpartId:[infoDic objectForKey:kpartId], @"second":@(0), @"isEnd":@(1), @"type":@(1)} withNotifiedObject:weakSelf];
                            
                        };
                        [self.view addSubview:self.moerduoView];
                    }
                        break;
                    case 2:
                    {
                        // read
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[taskInfo objectForKey:kpartId]} withNotifiedObject:self];
                        self.learntextType = LearnTextType_read;
                    }
                        break;
                    case 3:
                    {
                        // record
                        [SVProgressHUD show];
                        
                        if ([[taskInfo objectForKey:@"doState"] isEqualToString:@"已完成"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已检查"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已点评"]) {
                            [self requestProductWith:taskInfo and:[[infoDic objectForKey:@"type"] intValue]];
                            
                            return;
                        }
                        
                        [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[taskInfo objectForKey:kpartId]} withNotifiedObject:self];
                        self.learntextType = LearnTextType_record;
                    }
                        break;
                    case 4:
                    {
                        [SVProgressHUD show];
                        if ([[taskInfo objectForKey:@"doState"] isEqualToString:@"已完成"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已检查"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已点评"]) {
                            self.tasktype = TaskType_create;
                            [self requestProductWith:taskInfo and:[[infoDic objectForKey:@"type"] intValue]];
                            
                            return;
                        }
                        self.createProductionType = CreatProductionType_new;
                        [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:[taskInfo objectForKey:@"madeId"]} withNotifiedObject:self];
                    }
                        break;
                    case 5:
                    {
                        // video
                        [SVProgressHUD show];
                        if ([[taskInfo objectForKey:@"doState"] isEqualToString:@"已完成"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已检查"] || [[taskInfo objectForKey:@"doState"] isEqualToString:@"已点评"]) {
                            self.tasktype = TaskType_video;
                            [self requestProductWith:taskInfo and:[[infoDic objectForKey:@"type"] intValue]];
                            
                            return;
                        }
                        self.createProductionType = CreatProductionType_video;
                        [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:[taskInfo objectForKey:@"madeId"]} withNotifiedObject:self];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
            case TaskShowType_teacher_edit_suitang:
            {
                NSArray * dataArray = [infoDic objectForKey:@"data"];
                NSDictionary * taskInfo = [dataArray objectAtIndex:indexPath.row];
                self.currentSelectTextInfo = taskInfo;
                [self editeSuitangTask:taskInfo];
            }
                break;
            default:
                break;
        }
        
    }
}

#pragma mark - 查看已完成作品
- (void)requestProductWith:(NSDictionary *)infoDic and:(int)type
{
    self.selectProductInfo = infoDic;
    if (type == 3) {
        [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
    }else
    {
        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
    }
        
}

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
    
    [self presentViewController:vc animated:NO completion:nil];
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
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    [infoDic setObject:[self.selectProductInfo objectForKey:kmadeId] forKey:kmadeId];
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.taskType = self.tasktype;
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


#pragma mark - suitang 作业
- (void)editeSuitangTask:(NSDictionary *)infoDic
{
    self.taskEditType = TaskEditType_ChangeSuitangTaskTextbook;
    switch ([[infoDic objectForKey:@"type"] intValue] ) {
        case 1:
        {
            // moreduo
            [self createTaskWithTaskType:ArrangeTaskType_moerduo];
        }
            break;
        case 2:
        {
            // read
            [self createTaskWithTaskType:ArrangeTaskType_read];
        }
            break;
        case 3:
        {
            // record
            [self createTaskWithTaskType:ArrangeTaskType_record];
        }
            break;
        case 4:
        {
            [self createVideoTaskWithTaskType:ArrangeTaskType_Create];
        }
            break;
        case 5:
        {
            // video
            [self createVideoTaskWithTaskType:ArrangeTaskType_video];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - xilie 作业

- (void)didRequestCreateTaskProblemContentSuccessed
{
    // create
    [SVProgressHUD dismiss];
    __weak typeof(self)weakSelf = self;
    CreateProductionViewController * vc = [[CreateProductionViewController alloc]init];
    vc.isDoTask = YES;
    vc.createProductionType = CreatProductionType_yulan;
    vc.userWorkId = [[self.currentSelectTextInfo objectForKey:kuserWorkId] intValue];
    
    vc.ComplateTaskSuccessBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestCreateTaskProblemContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTextContentSuccessed
{
    // 阅读课文或听录音，先缓存课文
    NSDictionary * infoDic = self.currentSelectTextInfo;
    NSArray * mp3UrlList = [infoDic objectForKey:@"partMp3List"];
    for (int j = 0 ; j < mp3UrlList.count; j++) {
        
        NSString * mp3Str = [[mp3UrlList objectAtIndex:j] objectForKey:@"mp3Url"];
        if ([mp3Str containsString:kDomainName]) {
        }else
        {
            mp3Str = [NSString stringWithFormat:@"%@%@",kDomainName, [[mp3UrlList objectAtIndex:j] objectForKey:@"mp3Url"]];
        }
        
//        NSString * mp3Str = [kDomainName stringByAppendingString:[[mp3UrlList objectAtIndex:j] objectForKey:@"mp3Url"]];
        
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //设置保存路径和生成文件名
        NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [infoDic objectForKey:kpartName], j];
        //保存
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [SVProgressHUD dismiss];
            // 已下载 存储路径
            [self saveDownloadAudio:infoDic andNumber:j];
            
        }else
        {
            // 未下载。先下载，再存储路径
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
            if ([audioData writeToFile:filePath atomically:YES]) {
                NSLog(@"succeed");
                
                [self saveDownloadAudio:infoDic andNumber:j];
                
            }else{
                NSLog(@"faild");
            }
            
        }
        
    }
    [SVProgressHUD dismiss];
    
    __weak typeof(self)weakSelf = self;
    LearnTextViewController * vc = [[LearnTextViewController alloc]init];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.currentSelectTextInfo];
    [mInfo setObject:@(0) forKey:kitemId];
    vc.userWorkId = [[mInfo objectForKey:@"userWorkId"] intValue];
    vc.infoDic = mInfo;
    vc.learntextType = self.learntextType;
    vc.taskShowType = self.taskShowType;
    vc.againRecordSuccessBlock = ^(BOOL isSuccess) {
        [weakSelf loadData];
    };
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

- (void)didRequestMyEveryDayTaskSuccessed
{
    self.bottomCollectionViewArray = [[[UserManager sharedManager] getMyEveryDayTaskList] mutableCopy];
    if (self.bottomCollectionViewArray.count > self.bottomIndexpath.row) {
        self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
        [self loadDataWith:self.bottomIndexpath.row];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bottomCollectionView reloadData];
        [self.collectionView reloadData];
    });
    
    if (self.bottomCollectionViewArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
        NSDictionary * infoDic = self.bottomCollectionViewArray[0];
        if ([[infoDic objectForKey:@"type"] intValue] == 1) {
            self.moerduoBtn.hidden = NO;
        }else
        {
            self.moerduoBtn.hidden = YES;
        }
    }
}

- (void)didRequestMyEveryDayTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getTodayClassroomTaskSuccessed
{
    self.bottomCollectionViewArray = [[[UserManager sharedManager] getTeacher_TodayClassroomTaskArray] mutableCopy];
    if (self.bottomCollectionViewArray.count > self.bottomIndexpath.row) {
        self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
        [self loadDataWith:self.bottomIndexpath.row];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bottomCollectionView reloadData];
        [self.collectionView reloadData];
    });
    if (self.bottomCollectionViewArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
    }
}

- (void)didRequestTeacher_getTodayClassroomTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)changeRepeatCount:( NSInteger)row
{
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[row]];
    
    NSString * str = [NSString stringWithFormat:@"修改%@重复次数", [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"typeStr"]];
    ToolTipView * tooView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_changeRepeatCount andTitle:str withAnimation:NO];
    [tooView resetRepeatCount:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"repeatNum"]]];
    weakSelf.tooView = tooView;
    [self.view addSubview:tooView];
    tooView.DismissBlock = ^{
        [weakSelf.tooView removeFromSuperview];
    };
    tooView.ContinueBlock = ^(NSString *str) {
#pragma maek - 修改重复次数
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_changeSuitangModulRepeatCountWithWithDic:@{kinfoId:[weakSelf.currentSelectTextInfo objectForKey:kinfoId],krepeatNum:@(str.intValue)} withNotifiedObject:self];
        
        [weakSelf.collectionView reloadData];
        [weakSelf.tooView removeFromSuperview];
    };
}

- (void)loadDataWith:(NSInteger )item
{
    if (self.bottomCollectionViewArray.count < 5) {
        self.bottomCollectionView.frame = CGRectMake(kScreenWidth / 2 - self.bottomCollectionViewArray.count * kScreenWidth / 10, self.bottomCollectionView.hd_y, self.bottomCollectionViewArray.count * kScreenWidth / 5, self.bottomCollectionView.hd_height);
    }else
    {
        self.bottomCollectionView.frame = CGRectMake(0, self.bottomCollectionView.hd_y, kScreenWidth, self.bottomCollectionView.hd_height);
    }
    
    [self.bottomCollectionView reloadData];
    
    self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:item] objectForKey:@"data"];
    
    if (self.dataArray.count < 3) {
        self.collectionView.frame = CGRectMake(kScreenWidth / 2 - self.dataArray.count * kScreenWidth / 6, self.collectionView.hd_y, self.dataArray.count * kScreenWidth / 3, self.collectionView.hd_height);
    }else
    {
        self.collectionView.frame = CGRectMake(0, self.collectionView.hd_y, kScreenWidth, self.collectionView.hd_height);
    }
    
    [self.collectionView reloadData];
}

- (void)loadData
{
    self.failedView.hidden = YES;
    switch (self.taskShowType) {
        case TaskShowType_nomal:
            {
                self.bottomIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                self.bottomCollectionViewArray = [NSMutableArray array];
                self.dataArray = [NSMutableArray array];
                
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
                dateFormatter.dateFormat = @"yyyy-MM-dd";
                
                NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
                
                [[UserManager sharedManager] didRequestMyEveryDayTaskWithWithDic:@{@"dayTime":timeStr,kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
            }
            break;
        case TaskShowType_Teacher_classroomTodayTask:
        {
            self.bottomIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            self.bottomCollectionViewArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray array];
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            
            NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
            
            [[UserManager sharedManager] didRequestTeacher_getTodayClassroomTaskWithDic:@{@"dayTime":timeStr,kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
            break;
        case TaskShowType_teacher_yulan_suitang:
        case TaskShowType_teacher_edit_suitang:
        {
            self.bottomCollectionViewArray = [[[UserManager sharedManager] getTeacherSuitangTAskArray] mutableCopy];
            if (self.bottomCollectionViewArray.count > self.bottomIndexpath.row) {
                self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
                [self loadDataWith:self.bottomIndexpath.row];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.bottomCollectionView reloadData];
                [self.collectionView reloadData];
            });

        }
            break;
        case TaskShowType_teacher_yulan_Xilie:
        {
            self.allTaskArray = [[[UserManager sharedManager] getTeacherXilieTaskArray] mutableCopy];
            
            if (self.allTaskArray.count == 0) {
                self.failedView.hidden = NO;
                return;
            }
            self.bottomCollectionViewArray = [[self.allTaskArray objectAtIndex:self.currentDay] objectForKey:@"dataArray"];
            if (self.bottomCollectionViewArray.count > self.bottomIndexpath.row) {
                self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
                [self loadDataWith:self.bottomIndexpath.row];
            }else
            {
                if (self.bottomCollectionViewArray.count > 0) {
                    self.bottomIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                    self.dataArray = [[self.bottomCollectionViewArray objectAtIndex:self.bottomIndexpath.row] objectForKey:@"data"];
                    [self loadDataWith:self.bottomIndexpath.row];
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.bottomCollectionView reloadData];
                [self.collectionView reloadData];
            });
        }
            break;
            
        default:
            break;
    }
    if (self.bottomCollectionViewArray.count == 0) {
        self.failedView.hidden = NO;
    }
}

// 添加作业类型
- (void)addTaskTypeAction
{
    __weak typeof(self)weakSelf = self;
    
    BOOL isXilie = NO;
    if (self.taskShowType == TaskShowType_teacher_edit_Xilie) {
        isXilie = YES;
    }
    
    CreateTaskTypeView * view = [[CreateTaskTypeView alloc]initWithFrame:self.view.bounds andisXiLie:isXilie];
    self.createTaskTypeView = view;
    [self.view addSubview:view];
    view.createTaskBlock = ^(CreateTaskType type){
        switch (type) {
            case CreateTaskType_moerduo:
                if (weakSelf.taskShowType == TaskShowType_teacher_edit_Xilie) {
                    [weakSelf createXilieMoerduoTask];
                }else if (weakSelf.taskShowType == TaskShowType_teacher_edit_suitang)
                {
                    [weakSelf createMoerduoTask];
                }
                break;
            case CreateTaskType_read:
                if (weakSelf.taskShowType == TaskShowType_teacher_edit_Xilie) {
                    [weakSelf createXilieReadTask];
                }else if (weakSelf.taskShowType == TaskShowType_teacher_edit_suitang)
                {
                    [weakSelf createreadTask];
                }
                break;
            case CreateTaskType_record:
                if (weakSelf.taskShowType == TaskShowType_teacher_edit_Xilie) {
                    [weakSelf createXilieRecordTask];
                }else if (weakSelf.taskShowType == TaskShowType_teacher_edit_suitang)
                {
                    [weakSelf createrecordTask];
                }
                break;
            case CreateTaskType_create:
                [weakSelf createcreateTask];
                break;
            case CreateTaskType_video:
                [weakSelf createvideoTask];
                break;
                
            default:
                break;
        }
        [weakSelf.createTaskTypeView removeFromSuperview];
    };
}

#pragma mark - 添加作类型业--suitang
- (void)createMoerduoTask
{
    self.taskEditType = TaskEditType_ArrangeSuitangTask;
    [self createTaskWithTaskType:ArrangeTaskType_moerduo];
}

- (void)createreadTask
{
    self.taskEditType = TaskEditType_ArrangeSuitangTask;
    [self createTaskWithTaskType:ArrangeTaskType_read];
}

- (void)createrecordTask
{
    self.taskEditType = TaskEditType_ArrangeSuitangTask;
    [self createTaskWithTaskType:ArrangeTaskType_record];
}

- (void)createTaskWithTaskType:(ArrangeTaskType)taskType
{
    __weak typeof(self)weakSelf = self;
    AddMusicCategoryViewController * vc = [[AddMusicCategoryViewController alloc]init];
    vc.taskEditType = self.taskEditType;
    vc.arrangeTaskType = taskType;
    
    vc.changeSuitangTaskTextbookBlock = ^(NSDictionary *infoDic) {
//        NSLog(@"change textBook %@\n %@", infoDic, weakSelf.currentSelectTextInfo);
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_changeSuitangModulTextBookWithWithDic:@{kinfoId:[weakSelf.currentSelectTextInfo objectForKey:kinfoId],kpartId:[infoDic objectForKey:kpartId]} withNotifiedObject:self];
        
    };
    
    vc.complateBlock = ^(NSArray *array) {
        
        if (array.count == 0) {
            // 此处表示更换单独一个课文
            
            return ;
        }
        
        NSMutableArray * mArray = [NSMutableArray array];
        NSString * name = @"";
        int typeId = 0;
        switch (taskType) {
            case ArrangeTaskType_moerduo:
            {
                typeId = 1;
            }
                break;
            case ArrangeTaskType_read:
            {
                typeId = 2;
            }
                break;
            case ArrangeTaskType_record:
            {
                typeId = 3;
            }
                break;
            default:
                break;
        }
        for (NSDictionary * infoDic in array) {
            NSLog(@"%@", infoDic);
            NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
            [mInfo setObject:@(typeId) forKey:ktypeId];
            [mInfo setObject:[infoDic objectForKey:kpartId] forKey:kpartId];
            [mInfo setObject:@1 forKey:krepeatNum];
            [mArray addObject:mInfo];
        }
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addSuitangTaskTypeWithWithDic:@{kworkTempId:[weakSelf.infoDic objectForKey:kworkTempId],ktypeList:mArray} withNotifiedObject:weakSelf];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)createcreateTask
{
    [self createVideoTaskWithTaskType:ArrangeTaskType_Create];
}

- (void)createVideoTaskWithTaskType:(ArrangeTaskType)taskType
{
    __weak typeof(self)weakSelf = self;
    CreateTaskViewController * vc = [[CreateTaskViewController alloc]init];
    if (taskType == ArrangeTaskType_video) {
        vc.isCreateTask = NO;
    }else
    {
        vc.isCreateTask = YES;
    }
    vc.madeId = [[self.currentSelectTextInfo objectForKey:@"madeId"] intValue];
    vc.changeMetarialBlock = ^(NSDictionary *infoDic) {
        [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[weakSelf.infoDic objectForKey:kworkTempId]} withNotifiedObject:weakSelf];
    };
    vc.createMetarialBlock = ^(NSDictionary *infoDic) {
        
        int typeId = 0;
        switch (taskType) {
            case ArrangeTaskType_Create:
            {
                typeId = 4;
            }
                break;
            case ArrangeTaskType_video:
            {
                typeId = 5;
            }
                break;
            default:
                break;
        }
        
        NSMutableArray * mArray = [NSMutableArray array];
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:@(typeId) forKey:ktypeId];
        [mInfo setObject:[infoDic objectForKey:kmadeId] forKey:kpartId];
        [mInfo setObject:@1 forKey:krepeatNum];
        [mArray addObject:mInfo];
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addSuitangTaskTypeWithWithDic:@{kworkTempId:[weakSelf.infoDic objectForKey:kworkTempId],ktypeList:mArray} withNotifiedObject:weakSelf];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)createvideoTask
{
    [self createVideoTaskWithTaskType:ArrangeTaskType_video];
}


#pragma mark - 添加作类型业--Xilie

- (void)addXilieTaskAction:(ArrangeTaskTypedetail)taskType
{
    __weak typeof(self)weakSelf = self;
    if (self.xilieTextBookInfo == nil) {
        [SVProgressHUD showInfoWithStatus:@"请选择课本"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.startTextInfoDic == nil) {
        [SVProgressHUD showInfoWithStatus:@"请选择起始课文"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.endTextInfoDic == nil) {
        [SVProgressHUD showInfoWithStatus:@"请选择截止课文"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [self.addXiLieTaskView removeFromSuperview];
    
    int typeId = 0;
    NSString * name = @"";
    switch (taskType) {
        case ArrangeTaskTypedetail_moerduo:
            typeId = 1;
            name = [NSString stringWithFormat:@"磨耳朵：%@", [self.xilieTextBookInfo objectForKey:kitemName]];
            break;
        case ArrangeTaskTypedetail_read:
            typeId = 2;
            name = [NSString stringWithFormat:@"阅读：%@", [self.xilieTextBookInfo objectForKey:kitemName]];
            break;
        case ArrangeTaskTypedetail_record:
            typeId = 3;
            name = [NSString stringWithFormat:@"录音：%@", [self.xilieTextBookInfo objectForKey:kitemName]];
            break;
            
        default:
            break;
    }
    
    NSDictionary * typeDic = @{ktypeId:@(typeId),kbookId:[self.xilieTextBookInfo objectForKey:kitemId],kbeginInfoId:[self.startTextInfoDic objectForKey:kinfoId],kendInfoId:[self.endTextInfoDic objectForKey:kinfoId],@"dayNum":@(self.addXiLieTaskView.readTextCount.text.intValue),krepeatNum:@(self.addXiLieTaskView.repeatCount.text.intValue)};
    NSArray * typeList = @[typeDic];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_addXilieTaskTypeWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId],ktypeList:typeList} withNotifiedObject:weakSelf];
    
}

- (void)createXilieMoerduoTask
{
    [self createXilieTask:ArrangeTaskTypedetail_moerduo];
}

- (void)createXilieReadTask
{
    [self createXilieTask:ArrangeTaskTypedetail_read];
}

- (void)createXilieRecordTask
{
    [self createXilieTask:ArrangeTaskTypedetail_record];
}

- (void)createXilieTask:(ArrangeTaskTypedetail)taskType
{
    __weak typeof(self)weakSelf = self;
    AddXiLieTaskView * view = [[AddXiLieTaskView alloc]initWithFrame:self.view.bounds withTitle:@"添加系列作业"];
    self.addXiLieTaskView = view;
    [self.view addSubview:view];
    view.textBookBlock = ^{
        [weakSelf presentextBookVC];
    };
    view.starttextBlock = ^{
        [weakSelf presentextVC:taskType];
    };
    view.endTextBlock = ^{
        NSLog(@"截止课文");
        [weakSelf presenEndtextVC:taskType];
    };
    view.repeatBlock = ^{
        weakSelf.addXiLieTaskView.hidden = YES;
        [weakSelf showrepeatView];
    };
    view.continueBlock = ^(NSDictionary *infoDic) {
        [weakSelf addXilieTaskAction:taskType];
    };
    view.repeatCountBlock = ^(NSString *type) {
        [weakSelf choceCountAction:type];
    };
    view.readTextCountBlock = ^(NSString *type) {
        if (weakSelf.xilieSelectTextArray.count == 0 ) {
            [SVProgressHUD showInfoWithStatus:@"请选择起止课文"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        [weakSelf choceCountAction:type];
    };
}

- (void)presentextVC:(ArrangeTaskTypedetail)taskType
{
    if (self.xilieTextBookInfo == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先选择课本"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    __weak typeof(self)weakSelf = self;
    AddMusicViewController * vc = [[AddMusicViewController alloc]init];
    vc.taskEditType = TaskEditType_AggangrXiLieTask;
    vc.infoDic = self.xilieTextBookInfo;
    vc.isStart = YES;
    if (self.endTextInfoDic != nil) {
        vc.endTextInfo = self.endTextInfoDic;
    }
    vc.xilietaskBlock = ^(NSDictionary *infoDic) {
        weakSelf.startTextInfoDic = infoDic;
        [weakSelf.addXiLieTaskView resetStartBookWith:[infoDic objectForKey:kpartName]];
    };
    vc.complateBlock = ^(NSArray *array) {
        ;// 所选课文数组
        weakSelf.xilieSelectTextArray = array;
        if (weakSelf.xilieSelectTextArray.count < weakSelf.addXiLieTaskView.readTextCount.text.intValue) {
            weakSelf.addXiLieTaskView.readTextCount.text = [NSString stringWithFormat:@"%d", weakSelf.xilieSelectTextArray.count];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)presenEndtextVC:(ArrangeTaskTypedetail)taskType
{
    if (self.xilieTextBookInfo == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先选择课本"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    if (self.addXiLieTaskView.startTextView.contentTF.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先选择起始课文"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    AddMusicViewController * vc = [[AddMusicViewController alloc]init];
    vc.taskEditType = TaskEditType_AggangrXiLieTask;
    vc.isEnd = YES;
    vc.arrangeTaskType = taskType;
    vc.infoDic = self.xilieTextBookInfo;
    vc.startTextInfo = self.startTextInfoDic;
    vc.xilietaskBlock = ^(NSDictionary *infoDic) {
        weakSelf.endTextInfoDic = infoDic;
        [weakSelf.addXiLieTaskView resetEndBookWith:[infoDic objectForKey:kpartName]];
    };
    vc.complateBlock = ^(NSArray *array) {
        ;// 所选课文数组
        weakSelf.xilieSelectTextArray = array;
        if (weakSelf.xilieSelectTextArray.count < weakSelf.addXiLieTaskView.readTextCount.text.intValue) {
            weakSelf.addXiLieTaskView.readTextCount.text = [NSString stringWithFormat:@"%d", weakSelf.xilieSelectTextArray.count];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)presentextBookVC
{
    __weak typeof(self)weakSelf = self;
    AddMusicCategoryViewController * vc = [[AddMusicCategoryViewController alloc]init];
    vc.taskEditType = TaskEditType_AggangrXiLieTask;
    vc.xilietaskBlock = ^(NSDictionary *infoDic) {
        weakSelf.xilieTextBookInfo = infoDic;
        [weakSelf.addXiLieTaskView resetTextBookWith:[infoDic objectForKey:@"title"]];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (AttendanceTaskRepeatPickerView *)attendancePickerView
{
    if (!_attendancePickerView) {
        _attendancePickerView = [[AttendanceTaskRepeatPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _attendancePickerView;
}

- (void)choceCountAction:(NSString *)type
{
    __weak typeof(self)weakSelf = self;
    [self.attendancePickerView appearWithTitle:@"选择状态" subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        if ([type isEqualToString:@"read"]) {
            if (pathStr.intValue > weakSelf.xilieSelectTextArray.count) {
                [SVProgressHUD showInfoWithStatus:@"每天课文数不能大于选择的课文总数"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return ;
            }
            weakSelf.addXiLieTaskView.readTextCount.text = pathStr;
            
        }else
        {
            weakSelf.addXiLieTaskView.repeatCount.text = pathStr;
        }
        
    } cancleAction:^{
        
    }];
}

- (void)showrepeatView
{
    __weak typeof(self)weakSelf = self;
    
    weakSelf.repeatView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_deleteTeacherCourse andTitle:@"说明" withAnimation:YES];
    [weakSelf.repeatView resetContentLbTetx:[NSString stringWithFormat:@"重复天数指相同的操作重复多少天。例如重复天数为3，则连续3天重复同一操作，完成后取下一组内容再重复操作3天，以此类推至截止课文。"]];
    [weakSelf.repeatView addExplainBtn];
    [weakSelf.view addSubview:weakSelf.repeatView];
    
    weakSelf.repeatView.ContinueBlock = ^(NSString *str) {
        weakSelf.addXiLieTaskView.hidden = NO;
        [weakSelf.repeatView removeFromSuperview];
        weakSelf.repeatView = nil;
    };
}
#pragma mark - 系列作业编辑预览

- (void)yulanAction
{
    NSLog(@"预览");
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_getXilieDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
    
}

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
    vc.taskShowType = TaskShowType_teacher_yulan_Xilie;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - add task type
- (void)didRequestTeacher_addSuitangTaskTypeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_addSuitangTaskTypeSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_changeSuitangModulRepeatCountSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_changeSuitangModulRepeatCountFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_changeSuitangModulTextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_changeSuitangModulTextBookSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_getSuitangDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getSuitangDetailSuccessed
{
    [SVProgressHUD dismiss];
    [self loadData];
}

- (void)didRequestTeacher_addXilieTaskTypeSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_getEditXilieTaskDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_addXilieTaskTypeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getEditXilieTaskDetailSuccessed
{
    [SVProgressHUD dismiss];
    [self loadData];
}

- (void)didRequestTeacher_getEditXilieTaskDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_deleteModulSuccessed
{
    [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[self.infoDic objectForKey:kworkTempId]} withNotifiedObject:self];
}

- (void)didRequestTeacher_deleteModulFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (void)didRequestSubmitMoerduoAndReadTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSubmitMoerduoAndReadTaskSuccessed
{
    [SVProgressHUD dismiss];
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
