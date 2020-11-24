//
//  ClassroomArrangrTaskViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomArrangrTaskViewController.h"
#import "UserCenterTableView.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "MyClassroomViewController.h"
#import "CreateTaskTypeView.h"
#import "AddMusicCategoryViewController.h"
#import "CreateTaskViewController.h"
#import "MyTaskViewController.h"
#import "ArrangeTaskView.h"
#import "CommentTaskViewController.h"
#import "AddXiLieTaskView.h"

#import "AddMusicCategoryViewController.h"
#import "AddMusicViewController.h"
#import "AttendanceTaskRepeatPickerView.h"
@interface ClassroomArrangrTaskViewController ()<UITableViewDelegate, UITableViewDataSource,Teacher_getTaskMould,Teacher_shareTaskMouldToschool,Teacher_createSuiTangTask, Teacher_createXiLieTask,Teacher_shareTaskMouldToschool,Teacher_changeModulName, Teacher_changeModulRemark, Teacher_getSuitangDetail, Teacher_getXilieDetail,Teacher_haveArrangeTask,Teacher_changeHaveArrangeModulName,Teacher_commentTaskList, Teacher_getEditXilieTaskDetail,Teacher_todayTaskComplateList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)HYSegmentedControl *  arrangetaskHySegmentControl;
@property (nonatomic, strong)HYSegmentedControl *  taskLibraryHySegmentControl;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * categorydataArray;
@property (nonatomic, strong)NSIndexPath * categoryselectIndepath;

@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)NSMutableArray * informationArray;

@property (nonatomic, strong)PopListView * arrangePopListView;
@property (nonatomic, strong)PopListView * operationListView;
@property (nonatomic, strong)PopListView * deleteListView;
@property (nonatomic, strong)PopListView * haveArrangeOperationListView;

@property (nonatomic, strong)NSMutableArray * arrangePopList;
@property (nonatomic, strong)NSMutableArray * operationList;
@property (nonatomic, strong)NSMutableArray * deleteList;
@property (nonatomic, strong)NSMutableArray * haveArrangeOperationList;

@property (nonatomic, strong)ToolTipView * recordShotTipView;

@property (nonatomic, strong)ToolTipView * changeNameTipView;

@property (nonatomic, strong)ToolTipView * changeRemarkTipView;

@property (nonatomic, assign)TaskType taskType;


@property (nonatomic, strong)NSDictionary * currentOperationInfoDic;// 当前操作info
@property (nonatomic, strong)NSDictionary * currentSelectTaskInfo;

@property (nonatomic, strong)CreateTaskTypeView*createTaskTypeView;

@property (nonatomic, strong)AddXiLieTaskView * addXiLieTaskView;// 系列
@property (nonatomic, strong)ToolTipView * repeatView;
@property (nonatomic, strong)NSDictionary * xilieTextBookInfo;
@property (nonatomic, strong)NSDictionary * startTextInfoDic;// 起始课文
@property (nonatomic, strong)NSDictionary * endTextInfoDic;// 结束课文
@property (nonatomic, strong)NSArray * xilieSelectTextArray;// 系列作业已选择课文列表
@property (nonatomic, strong)NSDictionary * selectEditXilieTaskInfo;// 选中编辑系的列作业

@property (nonatomic, strong)AttendanceTaskRepeatPickerView *attendancePickerView;

@property (nonatomic, assign)TaskShowType taskShowType;

@property (nonatomic, assign)BOOL isSearch;
@property (nonatomic, strong)NSString * key;


@end

@implementation ClassroomArrangrTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_creatAndSearch];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.createBlock = ^{
        [weakSelf creattask];
    };
    self.navigationView.searchBlock = ^(BOOL isSearch){
        if (isSearch) {
            [weakSelf searchMember];
        }else
        {
            weakSelf.isSearch = NO;
            weakSelf.key = @"";
            [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
            [weakSelf reloadData];
        }
    };
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, kScreenWidth * 0.8 - 80, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height , kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    
    self.arrangetaskHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"随堂作业",@"系列作业"] delegate:self];
    [self.arrangetaskHySegmentControl hideBottomView];
    [self.arrangetaskHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.arrangetaskHySegmentControl];
    self.arrangetaskHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.arrangetaskHySegmentControl]) {
            
            weakSelf.userTableview.hidden = NO;
            [weakSelf reloadData];
        }
    };
    
    self.taskLibraryHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"随堂作业",@"系列作业"] delegate:self];
    [self.taskLibraryHySegmentControl hideBottomView];
    [self.taskLibraryHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.taskLibraryHySegmentControl];
    self.taskLibraryHySegmentControl.hidden = YES;
    self.taskLibraryHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.taskLibraryHySegmentControl]) {
            weakSelf.userTableview.hidden = NO;
            [weakSelf reloadData];
        }
    };
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 10, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIRGBColor(240, 240, 240);
    
    self.userTableview = [[UserCenterTableView alloc]initWithFrame:self.backView.bounds];
    [self.backView addSubview:self.userTableview];
    self.userTableview.isCourse = YES;
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_main_xilie];
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        weakSelf.currentSelectTaskInfo = infoDic;
        weakSelf.selectEditXilieTaskInfo = infoDic;
        switch (type) {
            case UserCenterTableViewType_arrangeTask_main_xilie:
            case UserCenterTableViewType_arrangeTask_school_xilie:
            {
                weakSelf.taskShowType = TaskShowType_teacher_yulan_Xilie;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestTeacher_getXilieDetailWithWithDic:@{kworkTempId:[infoDic objectForKey:kworkTempId]} withNotifiedObject:weakSelf];
            }
                break;
            case UserCenterTableViewType_arrangeTask_main_suitang:
            case UserCenterTableViewType_arrangeTask_school_suitang:
            {
                weakSelf.taskShowType = TaskShowType_teacher_yulan_suitang;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[infoDic objectForKey:kworkTempId]} withNotifiedObject:weakSelf];
            }
                break;
                
            case UserCenterTableViewType_commentTask:
            {
                CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
                [weakSelf presentViewController:vc animated:NO completion:nil];
            }
                break;
                
            default:
                break;
        }
        
    };
    
    self.userTableview.arrangeTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
        
        [weakSelf addArrangePoplistView:infoDic andRect:rect];
        
    };
    self.userTableview.operationTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
        [weakSelf addOperationPopListView:infoDic andRect:rect];
    };
    self.userTableview.deleteTaskBlock = ^(NSDictionary *infoDic, CGRect rect) {
        [weakSelf addDeletePopListView:infoDic andRect:rect];
    };
    
    self.userTableview.shareTaskBlock = ^(NSDictionary *infoDic) {
        weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"分享至学校作业库" withAnimation:YES];
        [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"确定将《%@》分享至学校作业库?", [infoDic objectForKey:@"name"]]];
        [weakSelf.view addSubview:weakSelf.recordShotTipView];
        weakSelf.recordShotTipView.DismissBlock = ^{
            [weakSelf.recordShotTipView removeFromSuperview];
        };
        weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
            [weakSelf.recordShotTipView removeFromSuperview];
            weakSelf.recordShotTipView = nil;
        };
    };
    self.userTableview.commentTaskBlock = ^(NSDictionary *infoDic) {
        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    self.userTableview.collectTaskBlock = ^(NSDictionary *infoDic) {
        weakSelf.recordShotTipView = [[ToolTipView alloc] initWithFrame:weakSelf.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"收藏作业模板" withAnimation:YES];//[NSString stringWithFormat:@"确定收藏作业模板《%@》？确定后磕在布置作业页面查看", [infoDic objectForKey:@"name"]]
        [weakSelf.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"确定收藏作业模板《%@》？确定后磕在布置作业页面查看", [infoDic objectForKey:@"name"]]];
        [weakSelf.view addSubview:weakSelf.recordShotTipView];
        weakSelf.recordShotTipView.DismissBlock = ^{
            [weakSelf.recordShotTipView removeFromSuperview];
        };
        weakSelf.recordShotTipView.ContinueBlock = ^(NSString *str) {
            [weakSelf.recordShotTipView removeFromSuperview];
            weakSelf.recordShotTipView = nil;
        };
    };
    
}

- (void)searchMember
{
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_tf andTitle:@"" andPlaceHold:@"请输入作业名称" withAnimation:NO];
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
        weakSelf.key = text;
        [weakSelf reloadData];
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        weakSelf.isSearch = NO;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        [weakToolView removeFromSuperview];
    };
}


- (void)addArrangePoplistView:(NSDictionary *)taskInfoDic andRect:(CGRect)rect
{
    
    __weak typeof(taskInfoDic)weakTaskInfo = taskInfoDic;
    CGRect convertRect = [self.userTableview convertRect:rect toView:self.view];
    if (self.arrangePopListView == nil) {
        self.arrangePopListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.arrangePopList andArrowRect:convertRect andWidth:90];
        
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.arrangePopListView];
        
        __weak typeof(self.arrangePopListView)weakListView = self.arrangePopListView;
        __weak typeof(self)weakSelf = self;
        self.arrangePopListView.dismissBlock = ^{
            [weakListView removeFromSuperview];
        };
        self.arrangePopListView.SelectBlock = ^(NSDictionary *infoDic) {
            int row = [[infoDic objectForKey:@"row"] intValue];
            MyClassroomViewController * vc = [[MyClassroomViewController alloc]init];
            if (row == 0) {
                if (weakSelf.arrangetaskHySegmentControl.selectIndex == 0) {
                    vc.classroomType = MyClassroomType_arrangeTaskToClassroom_suitang;
                }else
                {
                    vc.classroomType = MyClassroomType_arrangeTaskToClassroom_Xilie;
                }
            }else
            {
                if (weakSelf.arrangetaskHySegmentControl.selectIndex == 0) {
                    vc.classroomType = MyClassroomType_arrangeTaskToStudent_Suitang;
                }else
                {
                    vc.classroomType = MyClassroomType_arrangeTaskToStudent_Xilie;
                }
            }
            vc.taskInfoDic = weakTaskInfo;
            [weakSelf presentViewController:vc animated:NO completion:nil];
        };
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.arrangePopListView];
        [self.arrangePopListView refreshWithRecr:convertRect];
    }
}

- (void)addOperationPopListView:(NSDictionary *)taskInfo andRect:(CGRect)rect
{
    self.currentOperationInfoDic = taskInfo;
    CGRect convertRect = [self.userTableview convertRect:rect toView:self.view];
    if (self.operationListView == nil) {
        self.operationListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.operationList andArrowRect:convertRect andWidth:80];
        
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.operationListView];
        
        __weak typeof(self.operationListView)weakListView = self.operationListView;
        __weak typeof(self)weakSelf = self;
        self.operationListView.dismissBlock = ^{
            [weakListView removeFromSuperview];
        };
        self.operationListView.SelectBlock = ^(NSDictionary *infoDic) {
            int row = [[infoDic objectForKey:@"row"] intValue];
            switch (row) {
                case 0:
                {
                    if (weakSelf.arrangetaskHySegmentControl.selectIndex) {
                        weakSelf.selectEditXilieTaskInfo = weakSelf.currentOperationInfoDic;
                        weakSelf.taskShowType = TaskShowType_teacher_edit_Xilie;
                        [[UserManager sharedManager] didRequestTeacher_getEditXilieTaskDetailWithWithDic:@{kworkTempId:[weakSelf.currentOperationInfoDic objectForKey:kworkTempId]} withNotifiedObject:weakSelf];
                    }else
                    {
                        weakSelf.taskShowType = TaskShowType_teacher_edit_suitang;
                        weakSelf.selectEditXilieTaskInfo = weakSelf.currentOperationInfoDic;
                        [[UserManager sharedManager] didRequestTeacher_getSuitangDetailWithWithDic:@{kworkTempId:[weakSelf.currentOperationInfoDic objectForKey:kworkTempId]} withNotifiedObject:weakSelf];
                    }
                    
                }
                    break;
                case 1:
                {
                    // 改名
                    [weakSelf changeNameAction:weakSelf.currentOperationInfoDic];
                }
                    break;
                case 2:
                {
                    // 修改备注
                    weakSelf.changeRemarkTipView = [[ToolTipView alloc]initWithFrame:weakSelf.view.bounds andType:ToolTipTye_changeName andTitle:@"修改备注" andPlaceHold:@"请输入备注信息，此信息仅管理员和老师可见限100字以内" withAnimation:NO];
                    weakSelf.changeRemarkTipView.maxCount = 100;
                    [weakSelf.changeRemarkTipView resetNameTvText:[weakSelf.currentOperationInfoDic objectForKey:@"remark"]];
                    weakSelf.changeRemarkTipView.DismissBlock = ^{
                        ;[weakSelf.changeRemarkTipView removeFromSuperview];
                    };
                    weakSelf.changeRemarkTipView.ContinueBlock = ^(NSString *str) {
                        
                        [SVProgressHUD show];
                        [[UserManager sharedManager] didRequestTeacher_changeModulRemarkWithWithDic:@{kworkTempId:[weakSelf.currentOperationInfoDic objectForKey:kworkTempId],kRemark:str} withNotifiedObject:weakSelf];
                        
                        [weakSelf.changeRemarkTipView removeFromSuperview];
                    };
                    [weakSelf.view addSubview:weakSelf.changeRemarkTipView];
                }
                    break;
                case 3:
                {
                    // 删除
                    
                    
                    
                }
                    break;
                    
                default:
                    break;
            }
        };
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.operationListView];
        [self.operationListView refreshWithRecr:convertRect];
    }
}

- (void)addDeletePopListView:(NSDictionary *)taskInfo andRect:(CGRect)rect
{
    CGRect convertRect = [self.userTableview convertRect:rect toView:self.view];
    if (self.deleteListView == nil) {
        self.deleteListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.deleteList andArrowRect:convertRect andWidth:80];
        
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.deleteListView];
        
        __weak typeof(self)weakSelf = self;
        self.deleteListView.dismissBlock = ^{
            [weakSelf.deleteListView removeFromSuperview];
        };
        self.deleteListView.SelectBlock = ^(NSDictionary *infoDic) {
            NSInteger row = [[infoDic objectForKey:@"row"] intValue];
            
        };
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.deleteListView];
        [self.deleteListView refreshWithRecr:convertRect];
    }
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

- (void)showSegmentWith:(int)productCategory
{
    self.arrangetaskHySegmentControl.hidden = YES;
    self.taskLibraryHySegmentControl.hidden = YES;
    self.titleLB.hidden = YES;
    [self.navigationView hideLatestBtn];
    self.userTableview.hidden = YES;
    
    switch (productCategory) {
        case 0:
        {
            [self.navigationView refreshWith:userCenterItemType_creatAndSearch];
            self.arrangetaskHySegmentControl.hidden = NO;
            self.userTableview.hidden = NO;
            [self.navigationView showLatestBtn];
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_main_xilie];
        }
            break;
        case 1:
        {
            [self.navigationView refreshWith:userCenterItemType_search];
            self.taskLibraryHySegmentControl.hidden = NO;
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_school_xilie];
            
        }
            break;
        default:
            break;
    }
    [self reloadData];
}

- (void)refreshUserTableView
{
    NSIndexPath *indexPath = self.categoryselectIndepath;
    switch (indexPath.row) {
        case 0:
        {
            if (self.arrangetaskHySegmentControl.selectIndex == 0) {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_main_suitang];
            }else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_main_xilie];
            }
        }
            break;
        case 1:
        {
            if (self.taskLibraryHySegmentControl.selectIndex == 0) {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_school_suitang];
            }else
            {
                [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_arrangeTask_school_xilie];
            }
        }
            break;
        default:
            break;
    }
}

- (void)reloadData
{
    switch (self.categoryselectIndepath.row) {
        case 0:
        {
            [SVProgressHUD show];
            if (self.arrangetaskHySegmentControl.selectIndex == 0) {
                [[UserManager sharedManager] didRequestTeacher_getTaskMouldWithWithDic:@{ktempType:@1,kshareType:@1,@"key":self.key} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestTeacher_getTaskMouldWithWithDic:@{ktempType:@2,kshareType:@1,@"key":self.key} withNotifiedObject:self];
            }
        }
            break;
        case 1:
        {
            [SVProgressHUD show];
            if (self.taskLibraryHySegmentControl.selectIndex == 0) {
                [[UserManager sharedManager] didRequestTeacher_getTaskMouldWithWithDic:@{ktempType:@1,kshareType:@2,@"key":self.key} withNotifiedObject:self];
            }else
            {
                [[UserManager sharedManager] didRequestTeacher_getTaskMouldWithWithDic:@{ktempType:@2,kshareType:@2,@"key":self.key} withNotifiedObject:self];
            }
        }
            break;
       
        default:
            break;
    }
}


- (void)loadData
{
    self.key = @"";
    self.categorydataArray = [NSMutableArray array];
    [self.categorydataArray addObject:@{@"title":@"布置作业"}];
    [self.categorydataArray addObject:@{@"title":@"学校作业库"}];
    
    self.arrangePopList = [NSMutableArray array];
    [self.arrangePopList addObject:@{@"title":@"布置到班级"}];
//    [self.arrangePopList addObject:@{@"title":@"布置给学员"}];
    
    self.deleteList = [NSMutableArray array];
    [self.deleteList addObject:@{@"title":@"删除"}];
    
    self.operationList = [NSMutableArray array];
    [self.operationList addObject:@{@"title":@"编辑"}];
    [self.operationList addObject:@{@"title":@"改名"}];
    [self.operationList addObject:@{@"title":@"修改备注"}];
    [self.operationList addObject:@{@"title":@"删除"}];
    [self reloadData];
}

#pragma mark - 创建作业
- (void)creattask
{
    BOOL isXiLie = NO;
    if (self.arrangetaskHySegmentControl.selectIndex == 1 ) {
        isXiLie = YES;
    }else
    {
        isXiLie = NO;
    }
    __weak typeof(self)weakSelf = self;
    CreateTaskTypeView * view = [[CreateTaskTypeView alloc]initWithFrame:self.view.bounds andisXiLie:isXiLie];
    self.createTaskTypeView = view;
    [self.view addSubview:view];
    view.createTaskBlock = ^(CreateTaskType type){
        switch (type) {
            case CreateTaskType_moerduo:
                if (isXiLie) {
                    [weakSelf createXilieMoerduoTask];
                }else
                {
                    [weakSelf createMoerduoTask];
                }                break;
            case CreateTaskType_read:
                if (isXiLie) {
                    [weakSelf createXilieReadTask];
                }else
                {
                    [weakSelf createreadTask];
                }                break;
            case CreateTaskType_record:
                if (isXiLie) {
                    [weakSelf createXilieRecordTask];
                }else
                {
                    [weakSelf createrecordTask];
                }                break;
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

- (NSArray *)getTaskList:(NSArray *)dataArray1
{
    NSMutableArray * moArray = [NSMutableArray array];
    NSMutableArray * readArray = [NSMutableArray array];
    NSMutableArray * recordArray = [NSMutableArray array];
    NSMutableArray * createArray = [NSMutableArray array];
    NSMutableArray * videoArray = [NSMutableArray array];
    
    NSMutableDictionary * moDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * readDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * recordDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * createDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * videoDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary * infoDic in dataArray1) {
        switch ([[infoDic objectForKey:@"type"] intValue]) {
            case 1:
            {
                [moArray addObject:infoDic];
            }
                break;
            case 2:
            {
                [readArray addObject:infoDic];
            }
                break;
            case 3:
            {
                [recordArray addObject:infoDic];
            }
                break;
            case 4:
            {
                [createArray addObject:infoDic];
            }
                break;
            case 5:
            {
                [videoArray addObject:infoDic];
            }
                break;
                
            default:
                break;
        }
    }
    
    [moDic setObject:@"磨耳朵" forKey:@"typeStr"];
    [moDic setObject:@(1) forKey:@"type"];
    [moDic setObject:moArray forKey:@"data"];
    
    [readDic setObject:@"阅读" forKey:@"typeStr"];
    [readDic setObject:@(2) forKey:@"type"];
    [readDic setObject:readArray forKey:@"data"];
    
    [recordDic setObject:@"录音" forKey:@"typeStr"];
    [recordDic setObject:@(3) forKey:@"type"];
    [recordDic setObject:recordArray forKey:@"data"];
    
    [createDic setObject:@"创作" forKey:@"typeStr"];
    [createDic setObject:@(4) forKey:@"type"];
    [createDic setObject:createArray forKey:@"data"];
    
    [videoDic setObject:@"视频" forKey:@"typeStr"];
    [videoDic setObject:@(5) forKey:@"type"];
    [videoDic setObject:videoArray forKey:@"data"];
    
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (moArray.count > 0) {
        [dataArray addObject:moDic];
    }
    if (readArray.count > 0) {
        [dataArray addObject:readDic];
    }
    if (recordArray.count > 0) {
        [dataArray addObject:recordDic];
    }
    if (createArray.count > 0) {
        [dataArray addObject:createDic];
    }
    if (videoArray.count > 0) {
        [dataArray addObject:videoDic];
    }
    
    
    return dataArray;
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
        if (weakSelf.categoryselectIndepath.row == 0) {
            [[UserManager sharedManager] didRequestTeacher_changeModulNameWithWithDic:@{kworkTempId:[infoDic objectForKey:kworkTempId],@"name":str} withNotifiedObject:weakSelf];
        }else
        {
            [[UserManager sharedManager] didRequestTeacher_changeHaveArrangeModulNameWithWithDic:@{kWorkLogId:[infoDic objectForKey:@"logId"],@"name":str} withNotifiedObject:weakSelf];
        }
        
        [weakSelf.changeNameTipView removeFromSuperview];
    };
    [self.view addSubview:self.changeNameTipView];
}

#pragma mark - 创建作业--suitang
- (void)createMoerduoTask
{
    [self createTaskWithTaskType:ArrangeTaskType_moerduo];
}

- (void)createreadTask
{
    [self createTaskWithTaskType:ArrangeTaskType_read];
}

- (void)createrecordTask
{
    [self createTaskWithTaskType:ArrangeTaskType_record];
}

- (void)createTaskWithTaskType:(ArrangeTaskType)taskType
{
    __weak typeof(self)weakSelf = self;
    AddMusicCategoryViewController * vc = [[AddMusicCategoryViewController alloc]init];
    vc.taskEditType = TaskEditType_ArrangeSuitangTask;
    vc.arrangeTaskType = taskType;
    
    vc.complateBlock = ^(NSArray *array) {
        NSMutableArray * mArray = [NSMutableArray array];
        NSString * name = @"";
        int typeId = 0;
        switch (taskType) {
            case ArrangeTaskType_moerduo:
            {
                name = [NSString stringWithFormat:@"磨耳朵："];
                typeId = 1;
            }
                break;
            case ArrangeTaskType_read:
            {
                name = [NSString stringWithFormat:@"阅读："];
                typeId = 2;
            }
                break;
            case ArrangeTaskType_record:
            {
                name = [NSString stringWithFormat:@"录音："];
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
            name = [name stringByAppendingString:[NSString stringWithFormat:@"/%@", [infoDic objectForKey:kpartName]]];
        }
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_createSuiTangTaskWithWithDic:@{kworkId:@0,@"name":name,kRemark:@"",ktypeList:mArray} withNotifiedObject:weakSelf];
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
    vc.createMetarialBlock = ^(NSDictionary *infoDic) {
        NSString * name = [infoDic objectForKey:@"name"];
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
        [[UserManager sharedManager] didRequestTeacher_createSuiTangTaskWithWithDic:@{kworkId:@0,@"name":name,kRemark:@"",ktypeList:mArray} withNotifiedObject:weakSelf];
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)createvideoTask
{
    [self createVideoTaskWithTaskType:ArrangeTaskType_video];
}


#pragma mark - 创建作业--Xilie

- (void)addXilieTaskAction:(ArrangeTaskTypedetail)taskType
{
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
    [[UserManager sharedManager] didRequestTeacher_createXiLieTaskWithWithDic:@{kworkId:@0,@"name":name,kRemark:@"",ktypeList:typeList} withNotifiedObject:self];
    
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
        weakSelf.startTextInfoDic = nil;
        weakSelf.endTextInfoDic = nil;
        [weakSelf.addXiLieTaskView resetEndBookWith:@""];
        [weakSelf.addXiLieTaskView resetStartBookWith:@""];
        
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

#pragma mark - createSuitangTask

- (void)didRequestTeacher_createSuiTangTaskSuccessed
{
    [self.userTableview endRefresh];
#pragma mark - cichu tiaozhuan xiangqing jiemian
    
    [self reloadData];
}

- (void)didRequestTeacher_createSuiTangTaskFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_createXiLieTaskFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_createXiLieTaskSuccessed
{
    [self.userTableview endRefresh];
#pragma mark - cichu tiaozhuan xiangqing jiemian
    //    [[UserManager sharedManager] didRequestMyEveryDayTaskDetailListWithWithDic:@{} withNotifiedObject:self];
    [self reloadData];
}

#pragma mark - edite task
- (void)didRequestTeacher_changeMOdulNameSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher_changeMOdulNameFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_changeMOdulRemarkSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher_changeMOdulRemarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_shareTaskMouldToschoolSuccessed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"作业分享成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_shareTaskMouldToschoolFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_changeHaveArrangeMOdulNameSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher_changeHaveArrangeMOdulNameFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - modul list
- (void)didRequestTeacher_getTaskMouldFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getTaskMouldSuccessed
{
    [SVProgressHUD dismiss];
    [self refreshUserTableView];
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
    vc.infoDic = self.selectEditXilieTaskInfo;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTeacher_getSuitangDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getEditXilieTaskDetailSuccessed
{
    [SVProgressHUD dismiss];
    MyTaskViewController * vc = [[MyTaskViewController alloc]init];
    vc.taskShowType = self.taskShowType;
    vc.infoDic = self.selectEditXilieTaskInfo;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTeacher_getEditXilieTaskDetailFailed:(NSString *)failedInfo
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
