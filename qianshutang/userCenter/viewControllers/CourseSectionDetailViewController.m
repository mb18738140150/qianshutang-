//
//  CourseSectionDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CourseSectionDetailViewController.h"
#import "PlayVideoViewController.h"

@interface CourseSectionDetailViewController ()<Teacher_editCourseSection>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)PopListView * popListView;
@property (nonatomic, strong)NSMutableArray * popArray;
@property (nonatomic, strong)UITextField * courseNameLB;
@property (nonatomic, strong)UILabel * teacherLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UITextView * courseIntroLB;



@end

@implementation CourseSectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    if (self.isTeacher) {
        self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_save];
    }else
    {
        self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_playBack];
    }
    self.navigationView.DismissBlock = ^{
        if (weakSelf.editeBlock) {
            weakSelf.editeBlock(YES);
        }
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.latestProductBlock = ^(BOOL isShow,CGRect rect) {
        [weakSelf showListVIew:[weakSelf.navigationView.rightView convertRect:rect toView:weakSelf.navigationView]];
        
    };
    self.navigationView.saveBlock = ^{
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_editCourseSectionWithWithDic:@{kunitId:[weakSelf.courseInfo objectForKey:kunitId],kunitTitle:weakSelf.courseNameLB.text,kunitIntro:weakSelf.courseIntroLB.text} withNotifiedObject:weakSelf];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"课节详情";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];

    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    [self.view addSubview:backView];
    backView.backgroundColor = self.view.backgroundColor;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinTFAction )];
    [backView addGestureRecognizer:tap];
    
    UILabel * courseTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.05 + self.navigationView.hd_height, kScreenWidth * 0.135, kScreenHeight * 0.1)];
    courseTitleLB.text = @"课节标题";
    courseTitleLB.textColor = UIColorFromRGB(0x222222);
    courseTitleLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:courseTitleLB];
    
   self.courseNameLB = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(courseTitleLB.frame), kScreenHeight * 0.05 + self.navigationView.hd_height, kScreenWidth * 0.84, kScreenHeight * 0.1)];
    self.courseNameLB.text = [self.courseInfo objectForKey:@"title"];
    self.courseNameLB.backgroundColor = [UIColor whiteColor];
    self.courseNameLB.textColor = UIColorFromRGB(0x555555);
    [self.view addSubview:self.courseNameLB];
    self.courseNameLB.enabled = NO;
    
    UILabel * teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.05 + CGRectGetMaxY(courseTitleLB.frame), kScreenWidth * 0.135, kScreenHeight * 0.1)];
    teacherLB.text = @"老师信息";
    teacherLB.textColor = UIColorFromRGB(0x222222);
    teacherLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:teacherLB];
    
    self.teacherLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(teacherLB.frame), teacherLB.hd_y, kScreenWidth * 0.84, kScreenHeight * 0.1)];
    self.teacherLB.text = [self.courseInfo objectForKey:kTeacherName];
    self.teacherLB.backgroundColor = [UIColor whiteColor];
    self.teacherLB.textColor = UIColorFromRGB(0x555555);
    [self.view addSubview:self.teacherLB];
    
    UILabel * timeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.05 + CGRectGetMaxY(teacherLB.frame), kScreenWidth * 0.135, kScreenHeight * 0.1)];
    timeLB.text = @"上课时间";
    timeLB.textColor = UIColorFromRGB(0x222222);
    timeLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLB.frame), timeLB.hd_y, kScreenWidth * 0.84, kScreenHeight * 0.1)];
    self.timeLB.text = [NSString stringWithFormat:@"%@", [self.courseInfo objectForKey:@"beginendTime"]];
    self.timeLB.backgroundColor = [UIColor whiteColor];
    self.timeLB.textColor = UIColorFromRGB(0x555555);
    [self.view addSubview:self.timeLB];
    
    UILabel * courseIntroLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.05 + CGRectGetMaxY(timeLB.frame), kScreenWidth * 0.135, kScreenHeight * 0.1)];
    courseIntroLB.text = @"课程简介";
    courseIntroLB.textColor = UIColorFromRGB(0x222222);
    courseIntroLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:courseIntroLB];
    
    self.courseIntroLB = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(courseIntroLB.frame), courseIntroLB.hd_y, kScreenWidth * 0.84, kScreenHeight * 0.3)];
    self.courseIntroLB.font = [UIFont systemFontOfSize:17];
    self.courseIntroLB.text = [NSString stringWithFormat:@"%@", [self.courseInfo objectForKey:@"Intro"]];
    self.courseIntroLB.editable = NO;
    self.courseIntroLB.backgroundColor = [UIColor whiteColor];
    self.courseIntroLB.textColor = UIColorFromRGB(0x555555);
    [self.view addSubview:self.courseIntroLB];
    
    if (self.isTeacher) {
        self.courseNameLB.enabled = YES;
        self.courseIntroLB.editable = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)loadData
{
    self.popArray = [NSMutableArray array];
    
    for (NSDictionary * videoInfoDic in [self.courseInfo objectForKey:@"playBackList"]) {
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:videoInfoDic];
        [infoDic setObject:[videoInfoDic objectForKey:kVideoName] forKey:@"title"];
        [self.popArray addObject:infoDic];
    }
    
    if (self.popArray.count <= 0) {
        [self.navigationView hidePlayBackBtn];
    }
    
}

- (void)resinTFAction
{
    [self.courseIntroLB resignFirstResponder];
    [self.courseNameLB resignFirstResponder];
}

- (void)didRequestTeacher_editCourseSectionSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_editCourseSectionFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 排行榜列表
- (void)showListVIew:(CGRect)rect
{
    if (self.popListView == nil) {
        
        CGRect cellRect = rect;
        CGPoint startPoint = CGPointMake(cellRect.origin.x + cellRect.size.width / 2, cellRect.size.height + cellRect.origin.y);
        
        self.popListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.popArray anDirection:ArrowDirection_top andArrowPoint:startPoint andWidth:kScreenWidth * 0.12];
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.popListView];
        
        __weak typeof(self.popListView)weakListView = self.popListView;
        __weak typeof(self)weakSelf = self;
        self.popListView.dismissBlock = ^{
            [weakListView removeFromSuperview];
        };
        self.popListView.SelectBlock = ^(NSDictionary *infoDic) {
#pragma mark - 观看回放
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:kVideoName] forKey:kpartName];
            [mInfo setObject:[infoDic objectForKey:kVideoUrl] forKey:@"mp4Src"];
            playVC.infoDic = mInfo;
            [weakSelf presentViewController:playVC animated:NO completion:nil];
        };
        
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.popListView];
        [self.popListView refresh];
    }
}

#pragma mark - 键盘监听事件
- (void)keyboardWillShow:(NSNotification *)note
{
    if (self.courseNameLB.isEditing) {
        return;
    }
    
    CGRect begin = [[[note userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    
    CGRect end = [[[note userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    //因为第三方键盘或者是在键盘加个toolbar会导致回调三次，这个判断用来判断是否是第三次回调，原生只有一次
    if(begin.size.height>0 && (begin.origin.y-end.origin.y>0)){
        
        //处理逻辑
        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
        [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
        self.view.hd_y = end.origin.y - kScreenHeight;
        [UIView commitAnimations];//开始动画效果
    }
}

-(void)keyboardWillHide:(NSNotification *)note{
    
    if (self.courseNameLB.isEditing) {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    self.view.hd_y = 0;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
