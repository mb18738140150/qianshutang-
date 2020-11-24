//
//  ViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ViewController.h"
#import "BasicCategoryView.h"
#import "BasicClassroomCollectionViewCell.h"
#define kBasicCellID @"BasicClassroomCollectionViewCellID"
#import "LoginViewController.h"
#import "MoerduoView.h"
#import "AddMusicCategoryViewController.h"
#import "CreatProductionShowViewController.h"
#import "ProductShowViewController.h"
#import "UserCenterViewController.h"
#import "ActiveStudyViewController.h"
#import "MessageCenterViewController.h"
#import "MyClassroomViewController.h"
#import "MyTaskViewController.h"
#import "IntegralPrizeViewController.h"
#import "TodayCourseViewController.h"
#import "ArrangeTaskViewController.h"
#import "TeacherIntegralPrizeViewController.h"

#import "ClassroomDetailViewController.h"
#import "TeacherClassroomDetailViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UserModule_MyClassroomProtocol, ActiveStudy_TextContent,IsHaveNewMessage>

@property (nonatomic, strong)UIImageView * imageView;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIView * bottomView;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSArray * dataArr;

@property (nonatomic, strong)BasicCategoryView * starView;
@property (nonatomic, strong)BasicCategoryView * florwerView;
@property (nonatomic, strong)BasicCategoryView * prizeView;

@property (nonatomic, strong)BasicCategoryView * mainView;

@property (nonatomic, strong)NSArray * selectMoerduoArray;
@property (nonatomic, assign)int moerduoReqauestCount;

@property (nonatomic, strong)MoerduoView * moerduoView;

@property (nonatomic, strong)UIView * messageCenterTipView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.dataArr = @[@{@"imageStr":@"today_course_icon",kClassroomName:@"今日课程",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"homework_student",kClassroomName:@"今日作业",@"type":@(BasicCategoryType_task)},@{@"imageStr":@"books_area_teacher",kClassroomName:@"阅读录音",@"type":@(BasicCategoryType_read)},@{@"imageStr":@"listen",kClassroomName:@"磨耳朵听",@"type":@(BasicCategoryType_music)},@{@"imageStr":@"creation_st",kClassroomName:@"创作作品",@"type":@(BasicCategoryType_create)},@{@"imageStr":@"record_show",kClassroomName:@"作业秀",@"type":@(BasicCategoryType_show)}];
    
    [self loadData];
    
    [self prepareUI];
    
    __weak typeof(self)weakSelf = self;
    if (![[UserManager sharedManager] isUserLogin]) {
        LoginViewController * vc = [[LoginViewController alloc]init];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:NO completion:nil];
            vc.loginSuccessBlock = ^(BOOL isSuccess) {
                [weakSelf loadData];
            }
            ;
        });
        NSLog(@"******");
        return;
    }
}

- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyClassroomInfoWithNotifiedObject:self];
    [[UserManager sharedManager] didRequestGetIsHaveNewMessageWithDic:@{} withNotifiedObject:self];
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [backImageView sd_setImageWithURL:[NSURL URLWithString:[[UserManager sharedManager]getCoverImg]] placeholderImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    
    self.topView = [self topView];
    [self.view addSubview:self.topView];
    
    self.bottomView = [self getbottomView];
    [self.view addSubview:self.bottomView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([[UserManager sharedManager] isUserLogin]) {
        NSDictionary * infoDic = [[UserManager sharedManager]getUserInfos];
        self.starView.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kStarCount]];
        self.florwerView.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kFlowerCount]];
        self.prizeView.titleLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kPrizeCount]];
        [self.mainView resetTitle:[infoDic objectForKey:kUserNickName]];
        [self.mainView resetIconImageView:[infoDic objectForKey:kUserHeaderImageUrl]];
    }
}

- (UIView *)topView
{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    
    BasicCategoryView * appBasic = [[BasicCategoryView alloc]initWithFrame:CGRectMake(20, 0, 60, 80) andInfo:@{@"imageStr":@"logo1",@"title":@"千书堂",@"type":@(BasicCategoryType_APP)}];
    appBasic.ClickBlock = ^(BasicCategoryType type) {
        ;
    };
    [appBasic.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[UserManager sharedManager] getLogoUrl]] placeholderImage:[UIImage imageNamed:@"logo1"]];
    [topView addSubview:appBasic];
    
    
    NSArray * array = @[@{@"imageStr":@"today_course_icon",@"title":@"今日课程",@"type":@(BasicCategoryType_course)},@{@"imageStr":@"homework_student",@"title":@"今日作业",@"type":@(BasicCategoryType_task)},@{@"imageStr":@"books_area_teacher",@"title":@"自主学习",@"type":@(BasicCategoryType_read)},@{@"imageStr":@"listen",@"title":@"磨耳朵听",@"type":@(BasicCategoryType_music)},@{@"imageStr":@"record_show",@"title":@"作业秀",@"type":@(BasicCategoryType_show)}];
    
    
        switch ([[UserManager sharedManager] getUserType]) {
            case UserType_student:
                break;
            case UserType_teacher:
                NSLog(@"老师");
                break;
            case UserType_manager:
                break;
            default:
                break;
        }
    
    
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i < array.count; i++) {
        BasicCategoryView * appBasic = [[BasicCategoryView alloc]initWithFrame:CGRectMake(kScreenWidth - 80 *(i + 1), 0, 60, 80) andInfo:[array objectAtIndex:array.count - i - 1]];
        [topView addSubview:appBasic];
        appBasic.ClickBlock = ^(BasicCategoryType type) {
            NSLog(@"%ld", type);
            switch (type) {
                case BasicCategoryType_course:
                    [self todayCourseAction];
                    break;
                case BasicCategoryType_task:
                {
                    if ([[UserManager sharedManager] getUserType] == UserType_student) {
                        [weakSelf myTask];
                    }else if ([[UserManager sharedManager] getUserType] == UserType_teacher)
                    {
                        [weakSelf arrangTask];
                    }
                }
                    break;
                case BasicCategoryType_read:
                    [weakSelf ActiveStudy];
                    break;
                case BasicCategoryType_music:
                    [weakSelf playMusic];
                    break;
                case BasicCategoryType_show:
                    [weakSelf productShow];
                    break;
                    
                default:
                    break;
            }
            
        };
    }
    
    return topView;
}

- (UIView *)getbottomView
{
    CGFloat unitWidth = (kScreenWidth - 80) / 5;
    
    CGFloat radio = 40;
    __weak typeof(self)weakSelf = self;
    // 底部
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 160, kScreenWidth, 160)];
    bottomView.backgroundColor = [UIColor colorWithRed:90 / 255.0 green:174 / 255.0 blue:141 / 255.0 alpha:0.7];
    
    UIBezierPath * bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(unitWidth * 2 + radio, 0)];
    [bezierPath addCurveToPoint:CGPointMake(unitWidth * 2 + radio * 2, 0 + radio) controlPoint1:CGPointMake(unitWidth * 2 + radio * 1.5, 0) controlPoint2:CGPointMake(unitWidth * 2 + radio * 1.5, radio )];
    [bezierPath addLineToPoint:CGPointMake(unitWidth * 4 + radio, 0 + radio)];
    [bezierPath addCurveToPoint:CGPointMake(unitWidth * 4 + radio * 2, 0 ) controlPoint1:CGPointMake(unitWidth * 4 + radio * 1.5, 0 + radio ) controlPoint2:CGPointMake(unitWidth * 4 + radio * 1.5 , 0 )];
    [bezierPath addLineToPoint:CGPointMake(kScreenWidth, 0)];
    [bezierPath addLineToPoint:CGPointMake(kScreenWidth, kScreenHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, kScreenHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = bottomView.bounds;
    //    [shapLayer setFillColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.5].CGColor];
    shapLayer.path = bezierPath.CGPath;
    [bottomView.layer setMask:shapLayer];
    
    // 奖励
    CGFloat giftWidtgh = (unitWidth + radio) / 3;
    CGFloat star_x = (giftWidtgh - radio * 0.75) / 2;
    
    BasicCategoryView * startView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(star_x, 0, radio * 0.75, radio) andInfo:@{@"imageStr":@"star",@"title":@"0",@"type":@(BasicCategoryType_course)}];
    [startView resetTitleColor:[UIColor whiteColor]];
    [bottomView addSubview:startView];
    self.starView = startView;
    
    BasicCategoryView * flowerView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(giftWidtgh + (giftWidtgh - radio * 0.75) / 2, 0, radio * 0.75, radio) andInfo:@{@"imageStr":@"flower",@"title":@"0",@"type":@(BasicCategoryType_course)}];
    [flowerView resetTitleColor:[UIColor whiteColor]];
    [bottomView addSubview:flowerView];
    self.florwerView = flowerView;
    
    BasicCategoryView * giftView = [[BasicCategoryView alloc]initWithFrame:CGRectMake(giftWidtgh * 2 + (giftWidtgh - radio * 0.75) / 2, 0, radio * 0.75, radio) andInfo:@{@"imageStr":@"medal_btn",@"title":@"0",@"type":@(BasicCategoryType_course)}];
    [giftView resetTitleColor:[UIColor whiteColor]];
    [bottomView addSubview:giftView];
    self.prizeView = giftView;
    
    UIView * jifenView = [[UIView alloc]initWithFrame:CGRectMake(unitWidth + radio, 8, unitWidth , 32)];
    jifenView.backgroundColor = [UIColor whiteColor];
    jifenView.layer.cornerRadius = jifenView.hd_height / 2;
    jifenView.layer.masksToBounds = YES;
    [bottomView addSubview:jifenView];
    
    UIImageView * jiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(jifenView.hd_height / 2 - 5, 8, 19, 19)];
    jiangImageView.image = [UIImage imageNamed:@"integral"];
    [jifenView addSubview:jiangImageView];
    
    UILabel * jifenLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jiangImageView.frame) + 2, 0, 80, jifenView.hd_height)];
    jifenLB.text = @"积分兑奖";
     jifenLB.font = [UIFont systemFontOfSize:15];
    jifenLB.textColor = UIColorFromRGB(0x5aae8d);
    [jifenView addSubview:jifenLB];
    
    UIImageView * jifenImageView = [[UIImageView alloc]initWithFrame:CGRectMake(jifenView.hd_width - 7 - 19, 7, 19, 19)];
    jifenImageView.image = [UIImage imageNamed:@"green_arrow_right"];
    [jifenView addSubview:jifenImageView];
    
    UIButton * jiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jiangBtn.frame = CGRectMake(0, 0, jifenView.hd_width, jifenView.hd_height);
    [jifenView addSubview:jiangBtn];
    [jiangBtn addTarget:self action:@selector(jiangCenterAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 个人中心
    BasicCategoryView * mainView = [[BasicCategoryView alloc]initWithFrame:CGRectMake((unitWidth + radio - 75) / 2, CGRectGetMaxY(startView.frame) + 10, 75, 100) andInfo:@{@"imageStr":@"head_portrait",@"title":@"示例老师",@"type":@(BasicCategoryType_main)}];
    [mainView resetTitleColor:[UIColor whiteColor]];
    mainView.ClickBlock = ^(BasicCategoryType type) {
        
        UserCenterViewController * vc = [[UserCenterViewController alloc]init];
        vc.quitBlock = ^(BOOL sQuit) {
            if (sQuit) {
                LoginViewController * vc = [[LoginViewController alloc]init];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:vc animated:NO completion:nil];
                    vc.loginSuccessBlock = ^(BOOL isSuccess) {
                        [weakSelf loadData];
                    };
                });
            }
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    self.mainView = mainView;
    [bottomView addSubview:mainView];
    
    // 消息中心
    UIView * xiaoxiView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - unitWidth, 8, unitWidth - 10, 32)];
    xiaoxiView.backgroundColor = [UIColor whiteColor];
    xiaoxiView.layer.cornerRadius = xiaoxiView.hd_height / 2;
    xiaoxiView.layer.masksToBounds = YES;
    [bottomView addSubview:xiaoxiView];
    
    UILabel * xiaoxiLB = [[UILabel alloc]initWithFrame:CGRectMake(xiaoxiView.hd_height / 2, 0, 80, xiaoxiView.hd_height)];
    xiaoxiLB.text = @"消息中心";
    xiaoxiLB.font = [UIFont systemFontOfSize:15];
    xiaoxiLB.textColor = UIColorFromRGB(0x5aae8d);
    [xiaoxiView addSubview:xiaoxiLB];
    
    self.messageCenterTipView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(xiaoxiLB.frame) - 5, 5, 5, 5)];
    self.messageCenterTipView.backgroundColor = [UIColor redColor];
    self.messageCenterTipView.layer.cornerRadius = self.messageCenterTipView.hd_height / 2.0;
    self.messageCenterTipView.layer.masksToBounds = YES;
    [xiaoxiView addSubview:self.messageCenterTipView];
    self.messageCenterTipView.hidden = YES;
    
    UIImageView * xiaoxiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xiaoxiView.hd_width - 7 - 19, 7, 19, 19)];
    xiaoxiImageView.image = [UIImage imageNamed:@"green_arrow_right"];
    [xiaoxiView addSubview:xiaoxiImageView];
    
    UIButton * xiaoxiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiaoxiBtn.frame = CGRectMake(0, 0, xiaoxiView.hd_width, xiaoxiView.hd_height);
    [xiaoxiView addSubview:xiaoxiBtn];
    [xiaoxiBtn addTarget:self action:@selector(xiaoxiCenterAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 班级列表
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(unitWidth + radio, 10 + radio, unitWidth * 4 + radio - 10, bottomView.hd_height - 20 - radio)];
    contentView.backgroundColor = [UIColor whiteColor];
    
//    UIBezierPath * contentPath = [[UIBezierPath alloc]init];
//    [contentPath moveToPoint:CGPointMake(5, radio)];
//    [contentPath addLineToPoint:CGPointMake(unitWidth * 3 + 10, radio)];
//    [contentPath addCurveToPoint:CGPointMake(unitWidth * 3 + radio + 10, 0) controlPoint1:CGPointMake(unitWidth * 3 + radio * 0.5 + 10, radio) controlPoint2:CGPointMake(unitWidth * 3 + radio * 0.5 + 10, 0)];
//    [contentPath addLineToPoint:CGPointMake(contentView.hd_width, 0)];
//    [contentPath addLineToPoint:CGPointMake(contentView.hd_width, contentView.hd_height)];
//    [contentPath addLineToPoint:CGPointMake(0, contentView.hd_height)];
//    [contentPath addLineToPoint:CGPointMake(0, radio + 5)];
//    [contentPath addQuadCurveToPoint:CGPointMake(5, radio) controlPoint:CGPointMake(0, radio)];
//    CAShapeLayer * contentLayer = [[CAShapeLayer alloc]init];
//    contentLayer.frame = contentView.bounds;
//    contentLayer.path = contentPath.CGPath;
//    [contentView.layer setMask:contentLayer];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [bottomView addSubview:contentView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(unitWidth * 3 / 4, contentView.hd_height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, unitWidth * 3 + radio, contentView.hd_height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BasicClassroomCollectionViewCell class] forCellWithReuseIdentifier:kBasicCellID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [contentView addSubview:self.collectionView];
    
    // 班级
    BasicCategoryView * classroom = [[BasicCategoryView alloc]initWithFrame:CGRectMake(contentView.hd_width - unitWidth + 40, 8, (contentView.hd_height - 13) * 0.75, contentView.hd_height - 13) andInfo:@{@"imageStr":@"my_class2",@"title":@"班 级",@"type":@(BasicCategoryType_classroom)}];
    [contentView addSubview:classroom];
    classroom.ClickBlock = ^(BasicCategoryType type) {
        NSLog(@"%ld", type);
        MyClassroomViewController * vc = [[MyClassroomViewController alloc]init];
        [weakSelf presentViewController:vc animated:NO completion:nil];
    };
    
    return bottomView;
}

- (void)xiaoxiCenterAction
{
    NSLog(@"消息中心");
    self.messageCenterTipView.hidden = YES;
    MessageCenterViewController * vc = [[MessageCenterViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)jiangCenterAction
{
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        TeacherIntegralPrizeViewController * vc = [[TeacherIntegralPrizeViewController alloc]init];
        [self presentViewController:vc
                           animated:NO completion:nil];
        return;
    }
    
    NSLog(@"积分兑奖");
    IntegralPrizeViewController * vc = [[IntegralPrizeViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - 今日课程
- (void)todayCourseAction
{
    TodayCourseViewController * vc = [[TodayCourseViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - 今日作业
- (void)myTask
{
    MyTaskViewController * vc = [[MyTaskViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - 布置作业

- (void)arrangTask
{
    ArrangeTaskViewController * vc = [[ArrangeTaskViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - 自主学习
- (void)ActiveStudy
{    
    ActiveStudyViewController * creatProductionVC = [[ActiveStudyViewController alloc]init];
    
    [self presentViewController:creatProductionVC animated:NO completion:nil];
}

#pragma mark - 作品秀
- (void)productShow
{
    ProductShowViewController * vc = [[ProductShowViewController alloc]init];
    
    [self presentViewController:vc  animated:NO completion:nil];
}

#pragma mark - 磨耳朵
- (void)playMusic
{
    MoerduoView * moerduoView = [[MoerduoView alloc]initWithFrame:self.view.bounds];
    self.moerduoView = moerduoView;
    __weak typeof(moerduoView)weakMoerduoView = moerduoView;
    __weak typeof(self)weakSelf = self;
    moerduoView.dismissBlock = ^{
        [weakMoerduoView removeFromSuperview];
    };
    
    moerduoView.AddMusicBlock = ^{
        AddMusicCategoryViewController * addVC = [[AddMusicCategoryViewController alloc]init];
        
        addVC.complateBlock = ^(NSArray *array) {
            weakSelf.selectMoerduoArray = array;
            for (NSDictionary * infoDic in array) {
                NSLog(@"%@", infoDic);
            }
            [SVProgressHUD show];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf requestSelectMoersuoInfo];
            });
        };
        
        [weakSelf presentViewController:addVC animated:NO completion:nil];
    };
    
    [self.view addSubview:moerduoView];
}

- (void)requestSelectMoersuoInfo
{
    for (int i = 0; i < self.selectMoerduoArray.count; i++) {
        
        NSDictionary * infoDic = [self.selectMoerduoArray objectAtIndex:i];
        NSMutableDictionary * requestInfo = [NSMutableDictionary dictionary];
        [requestInfo setObject:kCommandTextContent forKey:kCommand];
        [requestInfo setObject:[infoDic objectForKey:kpartId] forKey:kpartId];
        [requestInfo setObject:@([[UserManager sharedManager] getUserId]) forKey:@"userId"];
        [requestInfo setObject:@([[UserManager sharedManager] getDepartId]) forKey:kDepartId];
        
        NSArray * mp3UrlList = [infoDic objectForKey:@"mp3List"];
        for (int j = 0 ; j < mp3UrlList.count; j++) {
            NSString * mp3Str = [mp3UrlList objectAtIndex:j];
            
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //设置保存路径和生成文件名
            NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [infoDic objectForKey:kpartName], j];
            //保存
            
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [SVProgressHUD dismiss];
                // 已下载 存储路径
                [self saveDownloadAudio:infoDic andNumber:j];
                if (i == self.selectMoerduoArray.count - 1 && j == mp3UrlList.count - 1) {
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.moerduoView refreshUI];
                    });
                }
            }else
            {
                // 未下载。先下载，再存储路径
                NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
                if ([audioData writeToFile:filePath atomically:YES]) {
                      NSLog(@"succeed");
                    
                    [self saveDownloadAudio:infoDic andNumber:j];
                    
                    if (i == self.selectMoerduoArray.count - 1 && j == mp3UrlList.count - 1) {
                        [SVProgressHUD dismiss];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.moerduoView refreshUI];
                        });
                    }
                    
                }else{
                       NSLog(@"faild");
                }
                
            }
            
        }
    }
    return;
    /*
     
     dispatch_group_t group = dispatch_group_create();
     dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
     for (int i = 0; i < self.selectMoerduoArray.count; i++) {
     
     NSDictionary * infoDic = [self.selectMoerduoArray objectAtIndex:i];
     NSMutableDictionary * requestInfo = [NSMutableDictionary dictionary];
     [requestInfo setObject:kCommandTextContent forKey:kCommand];
     [requestInfo setObject:[infoDic objectForKey:kpartId] forKey:kpartId];
     [requestInfo setObject:@([[UserManager sharedManager] getUserId]) forKey:@"userId"];
     [requestInfo setObject:@([[UserManager sharedManager] getDepartId]) forKey:kDepartId];
     
     NSArray * mp3UrlList = [infoDic objectForKey:@"mp3List"];
     for (int j = 0 ; j < mp3UrlList.count; j++) {
     NSString * mp3Str = [mp3UrlList objectAtIndex:j];
     dispatch_group_enter(group);
     dispatch_sync(queue, ^{
     
     [[HDNetworking sharedHDNetworking] downLoadWithURL:mp3Str progress:^(NSProgress * _Nullable progress) {
     ;
     } destination:^NSURL * _Nullable(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
     
     NSString *docPath = [PathUtility getDocumentPath];
     NSString *path1 = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d",[infoDic objectForKey:kpartName],j]];
     NSFileManager *fileManager = [NSFileManager defaultManager];
     if (![fileManager fileExistsAtPath:path1 isDirectory:nil]) {
     [fileManager createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
     }
     
     return [NSURL URLWithString:@""];
     } downLoadSuccess:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath) {
     
     NSMutableDictionary * audioDic = [NSMutableDictionary dictionary];
     [audioDic setObject:[infoDic objectForKey:kpartName] forKey:kAudioName];
     [audioDic setObject:[NSString stringWithFormat:@"%@%d", [infoDic objectForKey:kpartName],j] forKey:kAudioId];
     [audioDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
     [audioDic setObject:@(j) forKey:@"number"];
     [[DBManager sharedManager] saveDownloadAudioInfo:audioDic];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     dispatch_group_leave(group);
     });
     } failure:^(NSError * _Nonnull error) {
     
     dispatch_async(dispatch_get_main_queue(), ^{
     dispatch_group_leave(group);
     });
     }];
     });
     }
     }
     
     dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
     dispatch_async(dispatch_get_main_queue(), ^{
     [SVProgressHUD dismiss];
     });
     });
     */
    
}

- (void)saveDownloadAudio:(NSDictionary *)infoDic andNumber:(int )j
{
    NSMutableDictionary * audioDic = [NSMutableDictionary dictionary];
    [audioDic setObject:[infoDic objectForKey:kpartName] forKey:kAudioName];
    [audioDic setObject:[NSString stringWithFormat:@"%@-%d", [infoDic objectForKey:kpartName],j] forKey:kAudioId];
    [audioDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioDic setObject:@(j) forKey:@"number"];
    [[DBManager sharedManager] saveDownloadAudioInfo:audioDic];
    
    NSLog(@"saveAudioId = %@", [audioDic objectForKey:kAudioId]);
    
    NSMutableDictionary * audioListDic = [NSMutableDictionary dictionary];
    [audioListDic setObject:[infoDic objectForKey:kpartName] forKey:kpartName];
    [audioListDic setObject:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartId]] forKey:kpartId];
    [audioListDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioListDic setObject:@(DownloadAudioType_moerduo) forKey:@"type"];
    [[DBManager sharedManager] saveDownloadAudioListInfo:audioListDic];
}

#pragma mark - collection delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BasicClassroomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBasicCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.dataArr[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kClassroomName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:@"classroomIcon"] forKey:@"imageStr"];
    [cell resetWith:infoDic];
    
    __weak typeof(self)weakSelf = self;
    cell.classroomClickBlock = ^(NSDictionary *infoDic) {
        NSLog(@"%@", infoDic);
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            TeacherClassroomDetailViewController * vc = [[TeacherClassroomDetailViewController alloc]init];
            vc.infoDic = infoDic;
            [weakSelf presentViewController:vc  animated:NO completion:nil];
        }else
        {
            ClassroomDetailViewController * vc = [[ClassroomDetailViewController alloc]init];
            vc.infoDic = infoDic;
            [weakSelf presentViewController:vc  animated:NO completion:nil];
        }
    };
    // FFFF
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.dataArr objectAtIndex:indexPath.row];
    if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
        TeacherClassroomDetailViewController * vc = [[TeacherClassroomDetailViewController alloc]init];
        vc.classroomId = [infoDic objectForKey:kClassroomId];
        [self presentViewController:vc  animated:NO completion:nil];
    }else
    {
        ClassroomDetailViewController * vc = [[ClassroomDetailViewController alloc]init];
        vc.infoDic = infoDic;
        [self presentViewController:vc  animated:NO completion:nil];
    }
}

- (void)didRequestMyClassroomSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArr = [[UserManager sharedManager] getmyClassroom];
    [self.collectionView reloadData];
}

- (void)didRequestMyClassroomFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestIsHaveNewMessageSuccessed
{
    [SVProgressHUD dismiss];
    
    if ([[[UserManager sharedManager] getIsHaveNewMessageInfoDic] count] > 0) {
        self.messageCenterTipView.hidden = NO;
    }
    
}

- (void)didRequestIsHaveNewMessageFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
