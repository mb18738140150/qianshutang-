//
//  LearnTextViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "LearnTextViewController.h"

#define kSelectColor UIRGBColor(50, 115, 88)

#import <AVFoundation/AVFoundation.h>
#define kRecordAudioFile @"myRecord.caf"
#define kPlayUrl @"playUrl"
#define kPageRecordTimeLength @"PageRecordTimeLength"

typedef enum : NSUInteger {
    ReadOrRecordType_none,
    ReadOrRecordType_hear,
    ReadOrRecordType_againHearCurrentPage,
    ReadOrRecordType_modu,
    ReadOrRecordType_followerRead,
    ReadOrRecordType_recordTotal,
    ReadOrRecordType_recordPage
} ReadOrRecordType;

@interface LearnTextViewController ()<UIScrollViewDelegate,AVAudioRecorderDelegate, ActiveStudy_TextContent, ChangeMusicProtocol, Task_SubmitMoerduoAndReadTask, Task_UploadWholeRecordProduct, Task_UploadPagingRecordProduct, Task_AgainUploadWholeRecordProduct,MyStudy_ShareMyProduct,WXApiShareManagerDelegate>

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (nonatomic, assign)CGFloat timeLength;// 录音时长
@property (nonatomic, strong)NSString * savepath;


@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)NSMutableArray * pageArray;// 数据源
@property (nonatomic, strong)UILabel * pageControlLB;

@property (nonatomic, assign)int currentPage;

@property (nonatomic, strong)UIButton * backBtn;

@property (nonatomic, assign)ReadOrRecordType readOrRecordType; // 当前阅读或录音模式

// 阅读
@property (nonatomic, strong)UIButton * hearBtn;

@property (nonatomic, strong)UIButton * silentReadBtn;// 默读
@property (nonatomic, assign)BOOL   isSilenRead;
@property (nonatomic, strong)UIButton * followReadBtn;// 跟读
@property (nonatomic, assign)BOOL isFollowRead;

@property (nonatomic, strong)UIView * followReadOperationView;// 跟读或分页录音操作页
@property (nonatomic, strong)UIButton * foldBtn;
@property (nonatomic, strong)UIButton * playBtn;
@property (nonatomic, strong)UIButton * recordBtn;
@property (nonatomic, strong)UIButton * playRecordBtn;
//@property (nonatomic, strong)UIImageView * playRecordImg;// 播放录音
@property (nonatomic, strong)NSMutableArray * FollowRecordArray;// 跟读录音数组

@property (nonatomic, strong)UIButton * againhearBtn;// 重读
@property (nonatomic, assign)BOOL isAgainHear;

@property (nonatomic, assign)BOOL isHaveGetPrize;// 第一次听完获奖，每次录音完毕也获奖

@property (nonatomic, strong)StarPrizeView * readStarView ;
@property (nonatomic, strong)StarPrizeView * recordStarView ;
// 录音
@property (nonatomic, strong)UIButton * togetherRecordBtn;
@property (nonatomic, strong)UIButton * togetherRecordAnimateBtn;
@property (nonatomic, strong)UIButton * reRecordBtn;// 重新录音
@property (nonatomic, strong)UIButton * backHearBtn;// 回听

@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic, strong)UIButton * pageRecordBtn;// 分页录音
@property (nonatomic, strong)UIButton * hearFormalBtn;// 听原音
@property (nonatomic, strong)UIButton * hearLineRecordBtn;// 听录音
@property (nonatomic, strong)UIButton * submitBtn;// 提交

@property (nonatomic, assign)RecordProductType recordProductType;

@property (nonatomic, strong)RecordTool * recoardTool;

@property (nonatomic, strong)NSMutableArray * playyAnimateImageArray;
@property (nonatomic, strong)NSMutableArray * recordAnimateImageArray;

@property (nonatomic, strong)ToolTipView * recordShotTipView;

@property (nonatomic, strong)NSString * savePath;

@property (nonatomic, strong)NSMutableArray * pageRecordArray;// 分页录音存储数组

@property (nonatomic, strong)NSTimer * studuyTimer;// 学习时长计时器
@property (nonatomic, assign)int studytimeLength;// 学习时长

@property (nonatomic, assign)ShareObjectType shareType;

@end

@implementation LearnTextViewController

- (NSMutableArray *)pageRecordArray
{
    if (!_pageRecordArray) {
        _pageRecordArray = [NSMutableArray array];
    }
    return _pageRecordArray;
}

- (NSMutableArray *)pageArray
{
    if (!_pageArray) {
        _pageArray = [NSMutableArray array];
    }
    return _pageArray;
}

- (NSMutableArray *)FollowRecordArray
{
    if (!_FollowRecordArray) {
        _FollowRecordArray = [NSMutableArray array];
    }
    return _FollowRecordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[BTVoicePlayer share] isHavePlayerItem]) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    
    [self loadData];
    
    [self setAudioSession];
    
    if (self.userWorkId <= 0) {
        self.userWorkId = 0;
    }
    
    self.recoardTool = [RecordTool sharedInstance];
    [[RecordTool sharedInstance] resetproperty];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.contentSize = CGSizeMake(self.pageArray.count * kScreenWidth, kScreenHeight);
    
    self.pageControlLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - 25, kScreenWidth, 15)];
    self.pageControlLB.textColor = UIColorFromRGB(0x222222);
    self.pageControlLB.textAlignment = NSTextAlignmentCenter;
    self.pageControlLB.text = [NSString stringWithFormat:@"1/%d", self.pageArray.count];
    [self.view addSubview:self.pageControlLB];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [BTVoicePlayer share].delegate = self;
    
    if (self.learntextType != LearnTextType_record) {
        [self prepareUI];
    }else
    {
        [self prepareRecordUI];
    }
    [self addFollowReadSubViews];
    
    [self reloadData];
}

- (void)backAction
{
    if ([BTVoicePlayer share].isHavePlayerItem) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    [self.recoardTool stopRecordVoice];
    
    if (self.studuyTimer) {
        [self.studuyTimer invalidate];
        self.studuyTimer = nil;
    }
    [BTVoicePlayer share].delegate = nil;
    if (self.againRecordSuccessBlock) {
        self.againRecordSuccessBlock(YES);
    }
    
    if (self.learntextType == LearnTextType_read && self.studytimeLength > 0) {
        [[UserManager sharedManager] didRequestSubmitMoerduoAndReadTaskWithWithDic:@{kuserWorkId:@(self.userWorkId), kitemId:[self.infoDic objectForKey:kitemId], kpartId:[self.infoDic objectForKey:kpartId], @"second":@(self.studytimeLength), @"isEnd":@(0), @"type":@(2)} withNotifiedObject:self];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - loadData
- (void)loadData
{
    self.playyAnimateImageArray = [NSMutableArray array];
    [self.playyAnimateImageArray addObject:[UIImage imageNamed:@"play_record_one"]];
    [self.playyAnimateImageArray addObject:[UIImage imageNamed:@"play_record_two"]];
    [self.playyAnimateImageArray addObject:[UIImage imageNamed:@"play_recordThree"]];
    
    self.recordAnimateImageArray = [NSMutableArray array];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_one"]];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_two"]];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_three"]];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_four"]];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_five"]];
    [self.recordAnimateImageArray addObject:[UIImage imageNamed:@"bottom_record_six"]];
}

- (void)reloadData
{
    NSMutableArray * dataArray = [NSMutableArray array];
//    for (NSDictionary *infoDic in [[[UserManager sharedManager] getTextContentArray] objectForKey:@"data"]) {
//        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
//        [mInfo setObject:[infoDic objectForKey:kpageIndex] forKey:kpageIndex];
//        [mInfo setObject:[NSString stringWithFormat:@"%@-%@", [self.infoDic objectForKey:kpartName],@([[infoDic objectForKey:kpageIndex] intValue] - 1)] forKey:kAudioId];
//        NSArray * pageFileList = [infoDic objectForKey:@"pageFile"];
//        for (NSDictionary * fileInfo in pageFileList) {
//            if ([[fileInfo objectForKey:kfileType] intValue] == 1) {
//                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kImgSrc];
//            }else if ([[fileInfo objectForKey:kfileType] intValue] == 2)
//            {
//                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kMP3Src];
//            }else
//            {
//                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kMP4Src];
//            }
//        }
//        NSLog(@"infoDic = %@", mInfo);
//        [dataArray addObject:mInfo];
//    }
    NSArray * mp3IfoArray = [[[UserManager sharedManager] getTextContentArray] objectForKey:@"data"];
    for (int i = 0; i < [mp3IfoArray count]; i++) {
        NSDictionary * infoDic = [mp3IfoArray objectAtIndex:i];
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:[infoDic objectForKey:kpageIndex] forKey:kpageIndex];
        [mInfo setObject:[NSString stringWithFormat:@"%@-%@", [self.infoDic objectForKey:kpartName],@(i)] forKey:kAudioId];
        NSArray * pageFileList = [infoDic objectForKey:@"pageFile"];
        for (NSDictionary * fileInfo in pageFileList) {
            if ([[fileInfo objectForKey:kfileType] intValue] == 1) {
                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kImgSrc];
            }else if ([[fileInfo objectForKey:kfileType] intValue] == 2)
            {
                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kMP3Src];
            }else
            {
                [mInfo setObject:[fileInfo objectForKey:kfileSrc] forKey:kMP4Src];
            }
        }
        NSLog(@"infoDic = %@", mInfo);
        [dataArray addObject:mInfo];
    }
    
    self.pageArray = dataArray;
    [self.FollowRecordArray removeAllObjects];
    if ([self.pageArray class] == [NSNull class]) {
        return;
    }
    for (NSDictionary * infoDic in self.pageArray) {
        NSMutableDictionary * mInfoDic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [self.FollowRecordArray addObject:mInfoDic];
    }
    for (int i = 0; i < self.pageArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.pageArray[i] objectForKey:kImgSrc]]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.pageArray.count * kScreenWidth, kScreenHeight);
    self.pageControlLB.text = [NSString stringWithFormat:@"1/%d", self.pageArray.count];
    
    if (self.learntextType == LearnTextType_read) {// 直接开始 read
        self.readOrRecordType = ReadOrRecordType_hear;
        [self hearAction];
    }else
    {
        // record
#pragma mark - record
    }
    [self addStudyLengthTimer];
}

- (void)addStudyLengthTimer
{
    if (self.learntextType == LearnTextType_read) {
        // 阅读模式，添加学习时长定时器
        if (self.studuyTimer) {
            [self.studuyTimer invalidate];
            self.studuyTimer = nil;
            self.studytimeLength = 0;
        }
        
        self.studuyTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.studuyTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)timerAction
{
    self.studytimeLength++;
    NSLog(@"studytimeLength = %d", self.studytimeLength);
}

- (void)prepareUI
{
    self.followReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.followReadBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.followReadBtn setTitle:@"跟读" forState:UIControlStateNormal];
    [self.followReadBtn setTitle:@"完成" forState:UIControlStateSelected];
    [self.followReadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.followReadBtn.backgroundColor = kMainColor;
    self.followReadBtn.layer.cornerRadius = self.followReadBtn.hd_height / 2;
    self.followReadBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.followReadBtn];
    [self.followReadBtn addTarget:self action:@selector(followReadAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.silentReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.silentReadBtn.frame = CGRectMake(self.followReadBtn.hd_x - 15 - self.followReadBtn.hd_width, 5, self.followReadBtn.hd_width, self.followReadBtn.hd_height);
    [self.silentReadBtn setTitle:@"默读" forState:UIControlStateNormal];
    [self.silentReadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.silentReadBtn.backgroundColor = kMainColor;
    self.silentReadBtn.layer.cornerRadius = self.followReadBtn.hd_height / 2;
    self.silentReadBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.silentReadBtn];
    [self.silentReadBtn addTarget:self action:@selector(silentReadAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.hearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hearBtn.frame = CGRectMake(self.silentReadBtn.hd_x - 15 - self.silentReadBtn.hd_width, 5, self.followReadBtn.hd_height, self.followReadBtn.hd_height);
    [self.hearBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    [self.hearBtn setImage:[UIImage imageNamed:@"suspend_btn"] forState:UIControlStateSelected];
    self.hearBtn.backgroundColor = kMainColor;
    self.hearBtn.layer.cornerRadius = self.followReadBtn.hd_height / 2;
    self.hearBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.hearBtn];
    [self.hearBtn addTarget:self action:@selector(hearAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.againhearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.againhearBtn.frame = CGRectMake(10, kScreenHeight * 0.85, kScreenWidth * 0.15, kScreenHeight * 0.14);
    [self.againhearBtn setTitle:@"重听本页" forState:UIControlStateNormal];
    [self.againhearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.againhearBtn.backgroundColor = kMainColor;
    self.againhearBtn.layer.cornerRadius = self.againhearBtn.hd_height / 2;
    self.againhearBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.againhearBtn];
    [self.againhearBtn addTarget:self action:@selector(againHearAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)resreshRecordUI
{
    [self.followReadBtn removeFromSuperview];
    [self.silentReadBtn removeFromSuperview];
    [self.hearBtn removeFromSuperview];
    [self.againhearBtn removeFromSuperview];
    
    [self prepareRecordUI];
}

- (void)prepareRecordUI
{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = kMainColor;
    self.shareBtn.layer.cornerRadius = self.shareBtn.hd_height / 2;
    self.shareBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareAndSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = kMainColor;
    self.submitBtn.layer.cornerRadius = self.submitBtn.hd_height / 2;
    self.submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.submitBtn];
    [self.submitBtn addTarget:self action:@selector(shareAndSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.hidden = YES;
    
    self.togetherRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[self.infoDic objectForKey:@"isRecord"] intValue] == 1) {
        self.shareBtn.hidden = NO;
        self.togetherRecordBtn.frame = CGRectMake(self.shareBtn.hd_x - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    }else
    {
        self.shareBtn.hidden = YES;
        self.togetherRecordBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
        
    }
    [self.togetherRecordBtn setTitle:@"录音" forState:UIControlStateNormal];
    [self.togetherRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.togetherRecordBtn.backgroundColor = kMainColor;
    self.togetherRecordBtn.layer.cornerRadius = self.togetherRecordBtn.hd_height / 2;
    self.togetherRecordBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.togetherRecordBtn];
    [self.togetherRecordBtn addTarget:self action:@selector(togetherRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.togetherRecordAnimateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.togetherRecordAnimateBtn.frame = CGRectMake(self.shareBtn.hd_x - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    
    [self.togetherRecordAnimateBtn setImage:[UIImage imageNamed:@"bottom_record_six"] forState:UIControlStateNormal];
    self.togetherRecordAnimateBtn.imageView.animationImages = self.recordAnimateImageArray;
    self.togetherRecordAnimateBtn.imageView.animationDuration = 1.5;
    self.togetherRecordAnimateBtn.layer.cornerRadius = self.togetherRecordAnimateBtn.hd_height / 2;
    self.togetherRecordAnimateBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.togetherRecordAnimateBtn];
    [self.togetherRecordAnimateBtn addTarget:self action:@selector(togetherRecordAnimateAction) forControlEvents:UIControlEventTouchUpInside];
   self.togetherRecordAnimateBtn.hidden = YES;
    
    self.pageRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pageRecordBtn.frame = CGRectMake(self.togetherRecordBtn.hd_x - 14 - kScreenWidth * 0.15, 5, kScreenWidth * 0.15, kScreenHeight * 0.15 - 10);
    [self.pageRecordBtn setTitle:@"分页录音" forState:UIControlStateNormal];
    [self.pageRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pageRecordBtn.backgroundColor = kMainColor;
    self.pageRecordBtn.layer.cornerRadius = self.pageRecordBtn.hd_height / 2;
    self.pageRecordBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.pageRecordBtn];
    [self.pageRecordBtn addTarget:self action:@selector(pageRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.backHearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backHearBtn.frame = CGRectMake(self.togetherRecordBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.backHearBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    [self.backHearBtn setImage:[UIImage imageNamed:@"suspend_btn"] forState:UIControlStateSelected];
    self.backHearBtn.backgroundColor = kMainColor;
    self.backHearBtn.layer.cornerRadius = self.backHearBtn.hd_height / 2;
    self.backHearBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.backHearBtn];
    [self.backHearBtn addTarget:self action:@selector(backHearAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.reRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reRecordBtn.frame = CGRectMake(self.backHearBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.reRecordBtn setTitle:@"重录" forState:UIControlStateNormal];
    [self.reRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reRecordBtn.backgroundColor = kMainColor;
    self.reRecordBtn.layer.cornerRadius = self.reRecordBtn.hd_height / 2;
    self.reRecordBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.reRecordBtn];
    [self.reRecordBtn addTarget:self action:@selector(togetherRecordAction) forControlEvents:UIControlEventTouchUpInside];
    self.reRecordBtn.hidden = YES;
    self.backHearBtn.hidden = YES;
    
    
    self.hearFormalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hearFormalBtn.frame = CGRectMake(10, kScreenHeight * 0.85, kScreenWidth * 0.15, kScreenHeight * 0.14);
    [self.hearFormalBtn setImage:[UIImage imageNamed:@"play_solo_n_btn"] forState:UIControlStateNormal];
    [self.hearFormalBtn setImage:[UIImage imageNamed:@"play_solo_p_btn"] forState:UIControlStateSelected];
    self.hearFormalBtn.backgroundColor = kMainColor;
    self.hearFormalBtn.layer.cornerRadius = self.hearFormalBtn.hd_height / 2;
    self.hearFormalBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.hearFormalBtn];
    [self.hearFormalBtn addTarget:self action:@selector(hearFormalAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary * basicInfo = self.infoDic;
    if ([[self.infoDic objectForKey:@"isRecord"] intValue] == 1) {
        // 有录音
        if (([[basicInfo objectForKey:@"pointList"] class] == [NSNull class] || [basicInfo objectForKey:@"pointList"] == nil || [[basicInfo objectForKey:@"pointList"] isEqualToString:@""]) || ([[basicInfo objectForKey:@"recordUrl"] class] == [NSNull class] || [basicInfo objectForKey:@"recordUrl"] == nil || [[basicInfo objectForKey:@"recordUrl"] isEqualToString:@""])) {
            // 没有录音数据
        }else
        {
            // 有录音数据
            self.hearLineRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.hearLineRecordBtn.frame = CGRectMake(CGRectGetMaxX(self.hearFormalBtn.frame) + 10, kScreenHeight * 0.85, kScreenWidth * 0.15, kScreenHeight * 0.14);
            [self.hearLineRecordBtn setImage:[UIImage imageNamed:@"listen_record_n_btn"] forState:UIControlStateNormal];
            [self.hearLineRecordBtn setImage:[UIImage imageNamed:@"listen_record_p_btn"] forState:UIControlStateSelected];
            self.hearLineRecordBtn.backgroundColor = kMainColor;
            self.hearLineRecordBtn.layer.cornerRadius = self.hearFormalBtn.hd_height / 2;
            self.hearLineRecordBtn.layer.masksToBounds = YES;
            [self.view addSubview:self.hearLineRecordBtn];
            [self.hearLineRecordBtn addTarget:self action:@selector(hearLineRecordAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
}

- (void)addFollowReadSubViews
{
    int currentCount = self.scrollView.contentOffset.x / kScreenWidth ;
    self.currentPage = currentCount;
    NSMutableDictionary * infoDic = nil;
    if (self.FollowRecordArray.count > currentCount) {
        infoDic = self.FollowRecordArray[currentCount];
    }
    
    self.followReadOperationView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.44, 80, kScreenHeight * 0.56)];
    self.followReadOperationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.followReadOperationView];
    
    self.foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foldBtn.frame = CGRectMake(10, self.followReadOperationView.hd_height - 10 - kScreenHeight * 0.14, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.foldBtn setTitle:@"收起" forState:UIControlStateNormal];
    [self.foldBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.foldBtn.backgroundColor = kMainColor;
    self.foldBtn.layer.cornerRadius = self.foldBtn.hd_height / 2;
    self.foldBtn.layer.masksToBounds = YES;
    [self.followReadOperationView addSubview:self.foldBtn];
    [self.foldBtn addTarget:self action:@selector(foldAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.playRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playRecordBtn.frame = CGRectMake(0, self.foldBtn.hd_y - 15 - self.foldBtn.hd_width * 0.86, self.foldBtn.hd_width * 0.86, self.foldBtn.hd_width * 0.86);
    self.playRecordBtn.hd_centerX = self.foldBtn.hd_centerX;
    if ([infoDic objectForKey:kPlayUrl]) {
        
        if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
            self.playRecordBtn.enabled = YES;
            [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
        }else
        {
            self.playRecordBtn.enabled = NO;
            [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
        }
        
    }else
    {
        self.playRecordBtn.enabled = NO;
        [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
    }
    self.playRecordBtn.imageView.animationImages = self.playyAnimateImageArray;
    self.playRecordBtn.imageView.animationDuration = 1;
    self.playRecordBtn.layer.cornerRadius = self.playRecordBtn.hd_height / 2;
    self.playRecordBtn.layer.masksToBounds = YES;
    [self.followReadOperationView addSubview:self.playRecordBtn];
    [self.playRecordBtn addTarget:self action:@selector(playRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake(self.playRecordBtn.hd_x, self.playRecordBtn.hd_y - 15 - self.playRecordBtn.hd_width, self.foldBtn.hd_width * 0.86, self.foldBtn.hd_width * 0.86);
    [self.recordBtn setImage:[UIImage imageNamed:@"bottom_record"] forState:UIControlStateNormal];
    self.recordBtn.imageView.animationImages = self.recordAnimateImageArray;
    self.recordBtn.imageView.animationDuration = 1.5;
    self.recordBtn.layer.cornerRadius = self.playRecordBtn.hd_height / 2;
    self.recordBtn.layer.masksToBounds = YES;
    [self.followReadOperationView addSubview:self.recordBtn];
    [self.recordBtn addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(self.playRecordBtn.hd_x, self.recordBtn.hd_y - 15 - self.playRecordBtn.hd_width, self.foldBtn.hd_width * 0.86, self.foldBtn.hd_width * 0.86);
    [self.playBtn setImage:[UIImage imageNamed:@"ori_voice_play"] forState:UIControlStateNormal];// ori_voice_suspend
    [self.playBtn setImage:[UIImage imageNamed:@"ori_voice_suspend"] forState:UIControlStateSelected];
    self.playBtn.layer.cornerRadius = self.playRecordBtn.hd_height / 2;
    self.playBtn.layer.masksToBounds = YES;
    [self.followReadOperationView addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.followReadOperationView.hidden = YES;
}

- (void)foldAction
{
    self.foldBtn.selected = !self.foldBtn.selected;
    if (self.foldBtn.selected) {
        [self.foldBtn setTitle:@"展开" forState:UIControlStateNormal];
        self.playBtn.hidden = YES;
        self.recordBtn.hidden = YES;
        self.playRecordBtn.hidden = YES;
    }else
    {
        [self.foldBtn setTitle:@"收起" forState:UIControlStateNormal];
        self.playBtn.hidden = NO;
        self.recordBtn.hidden = NO;
        self.playRecordBtn.hidden = NO;
    }
}

- (void)playRecordAction
{
    __weak typeof(self)weakSelf = self;
    int currentCount = self.scrollView.contentOffset.x / kScreenWidth ;
    self.currentPage = currentCount;
    NSMutableDictionary * infoDic = nil;
    if (self.FollowRecordArray.count > currentCount) {
        infoDic = self.FollowRecordArray[currentCount];
    }
    if ([BTVoicePlayer share].isLocalPlaying) {
        [[BTVoicePlayer share] localstop];
        if (self.playBtn.selected) {
            self.playBtn.selected = NO;
            [self.playRecordBtn.imageView startAnimating];
            if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
                [[BTVoicePlayer share] play:[infoDic objectForKey:kPlayUrl]];
                [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
                    [weakSelf resetPlayRecordBtn];
                }];
            }
        }else
        {
            [self.playRecordBtn.imageView stopAnimating];
            [self.playRecordBtn setBackgroundImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
        }
    }else
    {
        [self.playRecordBtn.imageView startAnimating];
        if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
            [[BTVoicePlayer share] play:[infoDic objectForKey:kPlayUrl]];
            [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
                [weakSelf resetPlayRecordBtn];
            }];
        }
    }
}

- (void)resetPlayRecordBtn
{
    [self.playRecordBtn.imageView stopAnimating];
    [self.playRecordBtn setImage:[[UIImage imageNamed:@"play_recordThree"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

- (void)recordAction
{
    int currentCount = self.scrollView.contentOffset.x / kScreenWidth ;
    self.currentPage = currentCount;
    NSMutableDictionary * infoDic = nil;
    if (self.FollowRecordArray.count > currentCount) {
        infoDic = self.FollowRecordArray[currentCount];
    }
    self.recordBtn.selected = !self.recordBtn.selected;
    if (self.recordBtn.selected) {
        // 开始录音
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
        [self.playRecordBtn.imageView stopAnimating];
        [self.recoardTool startRecordVoice];
        [self.recordBtn.imageView startAnimating];
        self.playRecordBtn.enabled = NO;
        self.playBtn.enabled = NO;
        self.scrollView.scrollEnabled = NO;
        self.backBtn.enabled = NO;
        self.shareBtn.enabled = NO;
    }else
    {
        // 停止录音
        [self.recoardTool stopRecordVoice];
        self.submitBtn.enabled = YES;
        [self.recordBtn.imageView stopAnimating];
        [self.recordBtn setTitle:@"bottom_record" forState:UIControlStateNormal];
        self.playRecordBtn.enabled = YES;
        self.playBtn.enabled = YES;
        [infoDic setValue:self.recoardTool.savePath forKey:kPlayUrl];
        [infoDic setValue:@([[RecordTool sharedInstance] timelenght]) forKey:kPageRecordTimeLength];
        self.playRecordBtn.enabled = YES;
        [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
        self.scrollView.scrollEnabled = YES;
        self.backBtn.enabled = YES;
        self.followReadBtn.enabled = YES;
        self.shareBtn.enabled = YES;
    }
}


#pragma mark - 跟读或分页录音时-听原音
- (void)playAction
{
    if ([BTVoicePlayer share].isLocalPlaying) {
        [[BTVoicePlayer share] localstop];
    }
    if (self.playRecordBtn.imageView.isAnimating) {
        [self.playRecordBtn.imageView stopAnimating];
    }
    self.playBtn.selected = !self.playBtn.selected;
    __weak typeof(self)weakSelf = self;
    if (self.playBtn.selected) {
        
        NSDictionary * infoDic = self.pageArray[self.currentPage];
        [[BTVoicePlayer share]play:[self getLocalFilePath:infoDic]];
        
    }else
    {
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
        }
    }
    
}

#pragma mark - 录音

// 听原音
- (void)hearFormalAction
{
    self.readOrRecordType = ReadOrRecordType_againHearCurrentPage;
    __weak typeof(self)weakSelf = self;
    self.hearFormalBtn.selected = !self.hearFormalBtn.selected;
    if (self.hearFormalBtn.selected) {
        NSDictionary * infoDic = self.pageArray[self.currentPage];
        [[BTVoicePlayer share]play:[self getLocalFilePath:infoDic]];
        
    }else
    {
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
        }
    }
    
}

// 听录音
#pragma mark - tingluyin 未完成
- (void)hearLineRecordAction
{
    
}

- (void)backHearAction
{
    __weak typeof(self)weakSelf = self;
    self.backHearBtn.selected = !self.backHearBtn.selected;
    
    if (self.backHearBtn.selected) {
        
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
        }
        
        [[BTVoicePlayer share]play:self.savePath];
//        [[BTVoicePlayer share]play:[RecordTool sharedInstance].savePath];
        [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
            // 重听完毕
            weakSelf.backHearBtn.selected = NO;
        }];
    }else
    {
        [[BTVoicePlayer share] localstop];
        if ([BTVoicePlayer share].isLocalPlaying) {
        }
    }
}

#pragma mark - record_total
- (void)togetherRecordAction
{
    if ([self.togetherRecordBtn.titleLabel.text isEqualToString:@"提交"]) {
        
        if (self.taskShowType != TaskShowType_nomal) {
            [SVProgressHUD showInfoWithStatus:@"预览模式下不能提交作业"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        // 作业
        if (self.userWorkId > 0) {
            __weak typeof(self)weakSelf = self;
            ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"确认提交？" withAnimation:YES];
            __weak typeof(toolView)weakView = toolView;
            [toolView resetContentLbTetx:@"提交后，作业将发送至老师端检查"];
            [self.view addSubview:toolView];
            toolView.DismissBlock = ^{
                
                [weakView removeFromSuperview];
            };
            toolView.ContinueBlock = ^(NSString *str) {
                [weakView removeFromSuperview];
                [SVProgressHUD show];
                
                NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *mp3FilePath = [strUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"11.mp3"]];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:mp3FilePath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
                }
                
                NSLog(@"%@\n%@", mp3FilePath,[RecordTool sharedInstance].convertSavePath);
                
                NSString * wavPath =self.savePath;
//                NSString * wavPath = [RecordTool sharedInstance].savePath;
                [[RecordTool sharedInstance] convertWavToMp3:wavPath  withSavePath:mp3FilePath];
                
                NSMutableArray *pageRecordArray = [NSMutableArray array];
                HDPicModle * model = [[HDPicModle alloc]init];
                model.picName = [NSString stringWithFormat:@"%@", [weakSelf.infoDic objectForKey:kpartName]];
                
                model.url = mp3FilePath;
                [pageRecordArray addObject:model];
                
                [self upLoadRecord:pageRecordArray];
            };
            return;
        }
        
        // 上传录音作品
        NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *mp3FilePath = [strUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"11.mp3"]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:mp3FilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
        }
        
        NSLog(@"%@\n%@", mp3FilePath,[RecordTool sharedInstance].convertSavePath);
        
        NSString * wavPath = self.savePath;
//        NSString * wavPath = [RecordTool sharedInstance].savePath;
        [[RecordTool sharedInstance] convertWavToMp3:wavPath  withSavePath:mp3FilePath];
        
        NSMutableArray *pageRecordArray = [NSMutableArray array];
        HDPicModle * model = [[HDPicModle alloc]init];
        model.picName = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:kpartName]];
        
        model.url = mp3FilePath;
        [pageRecordArray addObject:model];
        
        [self upLoadRecord:pageRecordArray];
        return;
    }
    
    
    self.readOrRecordType = ReadOrRecordType_recordTotal;
    
    self.togetherRecordAnimateBtn.hidden = NO;
    [self.togetherRecordAnimateBtn.imageView startAnimating];
    [self recordClick];
//    [[RecordTool sharedInstance] startRecordVoice];
    
    self.togetherRecordBtn.hidden = YES;
    self.pageRecordBtn.hidden = YES;
    self.hearFormalBtn.hidden = YES;
    self.reRecordBtn.hidden = YES;
    self.backHearBtn.hidden = YES;
    self.shareBtn.hidden = YES;
    
    self.togetherRecordBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    self.togetherRecordAnimateBtn.frame = CGRectMake(kScreenWidth - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    self.backHearBtn.frame = CGRectMake(self.togetherRecordBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    self.reRecordBtn.frame = CGRectMake(self.backHearBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.pageRecordArray removeAllObjects];
}


- (void)upLoadRecord:(NSArray *)pageRecordArray
{
    [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andMP3Array:pageRecordArray progress:^(NSProgress * _Nullable progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        
        NSLog(@"[responseObject class] = %@", [responseObject class]);
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"jsonStr = %@", jsonStr);
        if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
#pragma mark - 上传整体录音
            NSString * pageListStr = @"";
            NSString * pointListStr = @"";
            CGFloat recordSecond = 0.0;
            for (int i = 0; i < self.pageRecordArray.count; i++) {
                NSMutableDictionary * infoDic = self.pageRecordArray[i];
                
                NSLog(@"%@", infoDic);
                
                if (i == 0) {
                    pageListStr = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"pageIndex"]];
                    pointListStr = [NSString stringWithFormat:@"%.1f", [[infoDic objectForKey:kPageRecordTimeLength] floatValue]];
                    recordSecond += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
                }else
                {
                    pageListStr = [pageListStr stringByAppendingString:[NSString stringWithFormat:@",%@", [infoDic objectForKey:@"pageIndex"]]];
                    pointListStr = [pointListStr stringByAppendingString:[NSString stringWithFormat:@",%.1f", [[infoDic objectForKey:kPageRecordTimeLength] floatValue]]];
                    recordSecond += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
                }
            }
            
            NSLog(@" ** %@, \n__%@", pageListStr, pointListStr);
            
            if (self.isAgainRecord) {
                __weak typeof(self)weakSelf = self;
                ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"提示" withAnimation:YES];
                __weak typeof(toolView)weakView = toolView;
                [toolView resetContentLbTetx:@"重新提交会覆盖以前提交的录音，确定提交吗？"];
                [self.view addSubview:toolView];
                toolView.DismissBlock = ^{
                    
                    [weakView removeFromSuperview];
                };
                toolView.ContinueBlock = ^(NSString *str) {
                    [weakView removeFromSuperview];
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestAgainUploadWholeRecordProductWithWithDic:@{kProductId:@(self.productId), @"recordUrl":jsonStr,@"pageList":pageListStr,@"pointList":pointListStr,@"second":@((int)recordSecond)} withNotifiedObject:weakSelf];
                };
                
            }else
            {
                [[UserManager sharedManager] didRequestUploadWholeRecordProductWithWithDic:@{kpartId:[self.infoDic objectForKey:kpartId],kitemId:[self.infoDic objectForKey:kitemId],kProductId:@(self.productId), kuserWorkId:@(self.userWorkId),@"recordUrl":jsonStr,@"pageList":pageListStr,@"pointList":pointListStr,@"second":@((int)recordSecond)} withNotifiedObject:self];
            }
            
        }else
        {
            [SVProgressHUD dismiss];
            jsonStr = @"";
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)togetherRecordAnimateAction
{
    __weak typeof(self)weakSelf = self;
    
    [self.togetherRecordAnimateBtn.imageView stopAnimating];
    self.togetherRecordAnimateBtn.hidden = NO;
    self.togetherRecordBtn.hidden = YES;
    // [RecordTool sharedInstance].length
    if (self.timeLength > 7 || self.taskShowType != TaskShowType_nomal) {
        // 录音大于7秒,
        
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:[self.FollowRecordArray objectAtIndex:self.currentPage]];
        [mInfo setObject:@(self.timeLength) forKey:kPageRecordTimeLength];
//        [mInfo setObject:@([RecordTool sharedInstance].length) forKey:kPageRecordTimeLength];
        
        [self.pageRecordArray addObject:mInfo];
        
        
        self.readOrRecordType = ReadOrRecordType_none;
        [self stopClick];
//        [[RecordTool sharedInstance] stopRecordVoice];
        self.reRecordBtn.hidden = NO;
        self.backHearBtn.hidden = NO;
        self.togetherRecordAnimateBtn.hidden = YES;
        self.togetherRecordBtn.hidden = NO;
        [self.togetherRecordBtn setTitle:@"提交" forState:UIControlStateNormal];
    }else
    {
        // 录音小于7秒
//        [self.recoardTool pauseRecordVoice];
        [self pauseClick];
        if (!self.recordShotTipView) {
            self.recordShotTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_recordShot andTitle:@"录音过短不能保存" withAnimation:YES];
        }
        [self.view addSubview:self.recordShotTipView];
//        [self.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"录音需大于7秒，当前长度为%.1f秒", [RecordTool sharedInstance].length]];
        [self.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"录音需大于7秒，当前长度为%.1f秒", self.timeLength]];
        self.recordShotTipView.DismissBlock = ^{
            weakSelf.readOrRecordType = ReadOrRecordType_none;
            [weakSelf stopClick];
//            [[RecordTool sharedInstance] stopRecordVoice];
            weakSelf.pageRecordBtn.hidden = NO;
            weakSelf.hearFormalBtn.hidden = NO;
            weakSelf.togetherRecordAnimateBtn.hidden = YES;
            weakSelf.togetherRecordBtn.hidden = NO;
            weakSelf.shareBtn.hidden = NO;
            
            weakSelf.togetherRecordBtn.frame = CGRectMake(weakSelf.shareBtn.hd_x - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
            weakSelf.togetherRecordAnimateBtn.frame = CGRectMake(weakSelf.shareBtn.hd_x - 16 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
            weakSelf.backHearBtn.frame = CGRectMake(weakSelf.togetherRecordBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
            weakSelf.reRecordBtn.frame = CGRectMake(weakSelf.backHearBtn.hd_x - 14 - kScreenHeight * 0.15 + 10, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
            [weakSelf.pageRecordArray removeAllObjects];
            [weakSelf.recordShotTipView removeFromSuperview];
            weakSelf.recordShotTipView = nil;
            
        };
        self.recordShotTipView.ContinueBlock = ^(NSString *str) {
            [weakSelf resumeClick];
//            [[RecordTool sharedInstance] recoverRecord];
            [weakSelf.togetherRecordAnimateBtn.imageView startAnimating];
            [weakSelf.recordShotTipView removeFromSuperview];
            weakSelf.recordShotTipView = nil;
        };
    }
    
}

#pragma mark - record_page
- (void)pageRecordAction
{
    self.recordProductType = RecordProductType_page;
    self.readOrRecordType = ReadOrRecordType_recordPage;
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    self.shareBtn.hidden = YES;
    self.togetherRecordBtn.hidden = YES;
    self.togetherRecordAnimateBtn.hidden = YES;
    self.pageRecordBtn.hidden = YES;
    self.hearFormalBtn.hidden = YES;
    self.shareBtn.hidden = YES;
    self.submitBtn.hidden = NO;
    self.submitBtn.enabled = NO;
    [self showFollwReadView];
}

- (void)shareAndSubmitAction:(UIButton *)button
{
    if ([button isEqual:self.submitBtn]) {
        
        if (self.taskShowType != TaskShowType_nomal) {
            [SVProgressHUD showInfoWithStatus:@"预览模式下不能提交作业"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        [self.pageRecordArray removeAllObjects];
        // submit
        NSMutableArray * pageRecordArray = [NSMutableArray array];// 上传；录音数组
        NSMutableArray * recordUrlArray = [NSMutableArray array];// 录音合成数组
        for (NSDictionary * infoDic in self.FollowRecordArray) {
            if ([infoDic objectForKey:kPlayUrl]) {
                if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
                    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                    
                    [recordUrlArray addObject:[NSURL fileURLWithPath:[infoDic objectForKey:kPlayUrl]]];
                    [self.pageRecordArray addObject:mInfo];
                }
            }
        }
        
        CGFloat recordTimeLength = 0.0;
        for (int i = 0; i < self.pageRecordArray.count; i++) {
            NSMutableDictionary * infoDic = self.pageRecordArray[i];
            
            NSLog(@"%@", infoDic);
            recordTimeLength += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
        }
        self.timeLength = recordTimeLength;
        
        if (recordTimeLength > 7) {
            [SVProgressHUD show];
            if (recordUrlArray.count > 1) {
                // 音频合成
                [[RecordTool sharedInstance] sourceURLs:recordUrlArray composeToURL:[NSURL fileURLWithPath:self.recoardTool.m4aSavePath] completed:^(NSError *error) {
                    // 合成完毕，m4a转换wav
                    [[RecordTool sharedInstance] convetM4aToWav:[NSURL fileURLWithPath:[RecordTool sharedInstance].m4aSavePath] destUrl:[NSURL fileURLWithPath:[RecordTool sharedInstance].convertSavePath] completed:^(NSError *error) {
                        // wav转换成mp3
                        NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                        NSString *mp3FilePath = [strUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"11.mp3"]];
                        
                        if ([[NSFileManager defaultManager] fileExistsAtPath:mp3FilePath]) {
                            [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
                        }
                        
                        NSLog(@"%@\n%@", mp3FilePath,[RecordTool sharedInstance].convertSavePath);
                        
                        NSString * wavPath =[RecordTool sharedInstance].convertSavePath;
                        [[RecordTool sharedInstance] convertWavToMp3:wavPath  withSavePath:mp3FilePath];
                        
                        // 转换完毕，开始上传
                        HDPicModle * model = [[HDPicModle alloc]init];
                        model.picName = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:kpartName]];
                        
                        model.url = mp3FilePath;
                        [pageRecordArray addObject:model];
                        
                        [self upLoadPageRecord:pageRecordArray];
                    }];
                    
                }];
            }else if(recordUrlArray.count == 1)
            {
                
                NSDictionary * infoDic = [self.FollowRecordArray objectAtIndex:0];
                
                HDPicModle * model = [[HDPicModle alloc]init];
                model.picName = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:kpartName]];
                NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *mp3FilePath = [strUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"11.mp3"]];
                if ([[NSFileManager defaultManager] fileExistsAtPath:mp3FilePath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
                }
                
                [[RecordTool sharedInstance] convertWavToMp3:[infoDic objectForKey:kPlayUrl]  withSavePath:mp3FilePath];
                model.url = mp3FilePath;
                [pageRecordArray addObject:model];
                
                [self upLoadPageRecord:pageRecordArray];
            }else
            {
                [SVProgressHUD showInfoWithStatus:@"还没有录音文件"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
        }else
        {
            [self isCancelPageRecord];
        }
        
    }else
    {
        // share
    }
}

- (void)isCancelPageRecord
{
    __weak typeof(self)weakSelf = self;
    if (!self.recordShotTipView) {
        self.recordShotTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_recordShot andTitle:@"录音过短不能保存" withAnimation:YES];
    }
    [self.view addSubview:self.recordShotTipView];
    [self.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"录音需大于7秒，当前长度为%.1f秒", self.timeLength]];
    // 取消录音恢复原状
    self.recordShotTipView.DismissBlock = ^{
        weakSelf.readOrRecordType = ReadOrRecordType_none;
        [weakSelf.pageRecordArray removeAllObjects];
        [weakSelf hideFollwReadView];
        weakSelf.shareBtn.hidden = NO;
        weakSelf.togetherRecordBtn.hidden = NO;
        weakSelf.pageRecordBtn.hidden = NO;
        weakSelf.hearFormalBtn.hidden = NO;
        weakSelf.submitBtn.hidden = YES;
        [weakSelf.recordShotTipView removeFromSuperview];
        weakSelf.recordShotTipView = nil;
    };
    
    self.recordShotTipView.ContinueBlock = ^(NSString *str) {
        [weakSelf.recordShotTipView removeFromSuperview];
        weakSelf.recordShotTipView = nil;
    };
}

- (void)upLoadPageRecord:(NSArray *)pageRecordArray
{
    [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andMP3Array:pageRecordArray progress:^(NSProgress * _Nullable progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        
        NSLog(@"[responseObject class] = %@", [responseObject class]);
        
        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"jsonStr = %@", jsonStr);
        if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
#pragma mark - 上传分页录音
            NSArray * addressArr = [jsonStr componentsSeparatedByString:@";"];
            for (int i = 0; i < addressArr.count; i++) {
                NSMutableDictionary * mInfo = self.pageRecordArray[i];
                [mInfo setObject:[addressArr objectAtIndex:i] forKey:kmp3FilePathLine];
            }
            
            NSString * pageListStr = @"";
            NSString * pointListStr = @"";
            CGFloat recordSecond = 0.0;
            for (int i = 0; i < self.pageRecordArray.count; i++) {
                NSMutableDictionary * infoDic = self.pageRecordArray[i];
                
                NSLog(@"%@", infoDic);
                
                if (i == 0) {
                    pageListStr = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"pageIndex"]];
                    pointListStr = [NSString stringWithFormat:@"%.1f", [[infoDic objectForKey:kPageRecordTimeLength] floatValue]];
                    recordSecond += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
                }else
                {
                    pageListStr = [pageListStr stringByAppendingString:[NSString stringWithFormat:@",%@", [infoDic objectForKey:@"pageIndex"]]];
                    pointListStr = [pointListStr stringByAppendingString:[NSString stringWithFormat:@",%.1f", ([[infoDic objectForKey:kPageRecordTimeLength] floatValue] + recordSecond)]];
                    recordSecond += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
                }
            }
            
            NSLog(@" ** %@, \n__%@", pageListStr, pointListStr);
            
            if (self.isAgainRecord) {
                
                __weak typeof(self)weakSelf = self;
                ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"提示" withAnimation:YES];
                __weak typeof(toolView)weakView = toolView;
                [toolView resetContentLbTetx:@"重新提交会覆盖以前提交的录音，确定提交吗？"];
                [self.view addSubview:toolView];
                toolView.DismissBlock = ^{
                    
                    [weakView removeFromSuperview];
                };
                toolView.ContinueBlock = ^(NSString *str) {
                    [weakView removeFromSuperview];
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestAgainUploadWholeRecordProductWithWithDic:@{kProductId:@(self.productId), @"recordUrl":jsonStr,@"pageList":pageListStr,@"pointList":pointListStr,@"second":@((int)recordSecond)} withNotifiedObject:weakSelf];
                };
                
            }else
            {
                [[UserManager sharedManager] didRequestUploadWholeRecordProductWithWithDic:@{kpartId:[self.infoDic objectForKey:kpartId],kitemId:[self.infoDic objectForKey:kitemId],kProductId:@(self.productId), kuserWorkId:@(self.userWorkId),@"recordUrl":jsonStr,@"pageList":pageListStr,@"pointList":pointListStr,@"second":@((int)recordSecond)} withNotifiedObject:self];
            }
            
            
        }else
        {
            [SVProgressHUD dismiss];
            jsonStr = @"";
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}


- (void)didRequestUploadWholeRecordProductSuccessed
{
    [self getRecordStarAction];
}

- (void)didRequestUploadWholeRecordProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestUploadPagingRecordProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestUploadPagingRecordProductSuccessed
{
    [self getRecordStarAction];
}

- (void)didRequestAgainUploadWholeRecordProductSuccessed
{
    [SVProgressHUD dismiss];
    [self getRecordStarAction];
}

- (void)didRequestAgainUploadWholeRecordProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 阅读 - 该模式下，所有音频均为已下载的本地音频文件

// 跟读
- (void)followReadAction
{
    if ([[RecordTool sharedInstance] isRecording]) {
        return;
    }
    
    self.readOrRecordType = ReadOrRecordType_followerRead;
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    
    self.followReadBtn.selected = !self.followReadBtn.selected;
    if (self.followReadBtn.selected) {
        self.isFollowRead = YES;
        [self showFollwReadView];
        
        self.hearBtn.hidden = YES;
        self.silentReadBtn.hidden = YES;
        self.againhearBtn.hidden = YES;
        self.hearBtn.selected = NO;
    }else
    {
        // 最后一页跟读完成，判断跟读时长，获得奖励
        if (self.currentPage + 1 == self.pageArray.count) {
            
            if (self.taskShowType != TaskShowType_nomal) {
                // 预览模式下不做操作
                return;
            }
            
            NSMutableDictionary * infoDic = self.FollowRecordArray[self.currentPage];
            BOOL isfinish = NO;
            if ([infoDic objectForKey:kPlayUrl]) {
                if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
                    isfinish = YES;
                }
            }
            
            if (isfinish) {
                CGFloat timeLength = 0.0;
                for (NSDictionary * infoDic in self.FollowRecordArray) {
                    if ([infoDic objectForKey:kPageRecordTimeLength]) {
                        timeLength += [[infoDic objectForKey:kPageRecordTimeLength] floatValue];
                    }
                }
                if (timeLength > 5) {
                    [self getReadStarAction];
                }else
                {
                    [SVProgressHUD showInfoWithStatus:@"阅读时间太短，未完成"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                }
            }
            
            return;
        }
        self.isFollowRead = NO;
        [self hideFollwReadView];
        self.hearBtn.hidden = NO;
        self.silentReadBtn.hidden = NO;
        self.againhearBtn.hidden = NO;
        self.playBtn.selected = NO;
        self.hearBtn.selected = NO;
    }
}

- (void)showFollwReadView
{
    self.followReadOperationView.hidden = NO;
}

- (void)hideFollwReadView
{
    self.followReadOperationView.hidden = YES;
}

// 默读
- (void)silentReadAction
{
    self.readOrRecordType = ReadOrRecordType_modu;
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    
    [self.hearBtn setImage:[UIImage imageNamed:@"play_txt_btn_n"] forState:UIControlStateNormal];
    self.hearBtn.selected = NO;
    
    self.silentReadBtn.backgroundColor = kSelectColor;
    self.againhearBtn.backgroundColor = kMainColor;
    [self.againhearBtn setTitle:@"听原音" forState:UIControlStateNormal];
    self.againhearBtn.hd_width = kScreenWidth * 0.12;
}

#pragma mark - 播放课文 - 获取本地已下载音频
// 听
- (void)hearAction
{
    [self.hearBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    // 判断是否正在 重听本页
    if (self.readOrRecordType == ReadOrRecordType_againHearCurrentPage && [[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    [self.againhearBtn setTitle:@"重听本页" forState:UIControlStateNormal];
    self.againhearBtn.hd_width = kScreenWidth * 0.15;
    self.againhearBtn.backgroundColor = kMainColor;
    self.readOrRecordType = ReadOrRecordType_hear;
    self.silentReadBtn.backgroundColor = kMainColor;
    
    // 判断是否正在 听
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        self.hearBtn.selected = NO;
        [[BTVoicePlayer share] localpause];
    }else
    {
        self.hearBtn.selected = YES;
        if ([[BTVoicePlayer share] isHaveLocalPlayerItem]) {
            [[BTVoicePlayer share] playLocalContinu];
            return;
        }
        NSDictionary * infoDic = self.pageArray[self.currentPage];
        [[BTVoicePlayer share]play:[self getLocalFilePath:infoDic]];
    }
    
    
    __weak typeof(self)weakSelf = self;
    [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
        [weakSelf localPlayFinish];
    }];
    
    
}

- (void)localPlayFinish
{
    if (self.readOrRecordType == ReadOrRecordType_againHearCurrentPage) {
        // 重听本页或者听原音，完毕不做处理
        self.againhearBtn.backgroundColor = kMainColor;
        self.hearFormalBtn.selected = NO;
        return;
    }
    
    // 跟读模式。本页播放完毕
    if (self.readOrRecordType == ReadOrRecordType_followerRead) {
        self.playBtn.selected = !self.playBtn.selected;
        return;
    }
    
    // 全本播放完毕获取奖励
    int currentCount = self.scrollView.contentOffset.x / kScreenWidth ;
    self.currentPage = currentCount;
    if ( currentCount + 1 >= self.pageArray.count) {
        // 当前页数为最后一页，
        if (self.isHaveGetPrize == NO) {// 没有获取星星奖励，获取；已获取，直接返回
#pragma mark - get star prize
            self.isHaveGetPrize = YES;
            
            if (self.taskShowType != TaskShowType_nomal) {
                // 预览模式下不做操作
                return;
            }
            
            [self getReadStarAction];
        }
        return;
    }
    
    // 重听完毕
    self.backHearBtn.selected = NO;
    
    // 听模式下，自动播放下一篇
    switch (self.readOrRecordType) {
        case ReadOrRecordType_hear:// 听模式
        {
            // 播放下一页
            [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * (currentCount + 1) , 0, kScreenWidth, kScreenHeight) animated:YES];
            
            self.pageControlLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.pageArray.count];
        }
            break;
        case ReadOrRecordType_againHearCurrentPage:
        {
            self.againhearBtn.backgroundColor = kMainColor;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 重听本页 - 获取本地已下载音频
// 重听本页
- (void)againHearAction
{
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
        if (self.readOrRecordType == ReadOrRecordType_modu) {
            [self.hearBtn setImage:[UIImage imageNamed:@"play_txt_btn_n"] forState:UIControlStateNormal];
            self.hearBtn.selected = NO;
        }else if (self.readOrRecordType == ReadOrRecordType_hear)
        {
            // 听模式下暂停 听
            [self.hearBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
            self.hearBtn.selected = NO;
        }
    }
    self.againhearBtn.backgroundColor = kSelectColor;
    
    self.readOrRecordType = ReadOrRecordType_againHearCurrentPage;
    
    NSDictionary * infoDic = self.pageArray[self.currentPage];
    [[BTVoicePlayer share]play:[self getLocalFilePath:infoDic]];
    
}

- (NSString *)getLocalFilePath:(NSDictionary *)audioInfo
{
    NSString*docDirPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString*filePath=[NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioInfo objectForKey:kAudioId]];
    return filePath;
}

#pragma mark - 播放完成
- (void)changeMusic
{
    
}

#pragma mark - 滑动切换课文内容

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentCount = self.scrollView.contentOffset.x / kScreenWidth ;
    self.pageControlLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.pageArray.count];
    
    // 整体录音情况下，进制往回翻页
    if (self.readOrRecordType == ReadOrRecordType_recordTotal) {
        
        NSLog(@"self.currentPage = %d *** %d", self.currentPage ,currentCount);
        
        if (currentCount < self.currentPage) {
            [self.scrollView scrollRectToVisible:CGRectMake(self.currentPage * kScreenWidth, 0, kScreenWidth, kScreenHeight) animated:YES];
            self.pageControlLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.pageArray.count];
            return;
        }
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:[self.FollowRecordArray objectAtIndex:self.currentPage]];
//        [mInfo setObject:@([RecordTool sharedInstance].length) forKey:kPageRecordTimeLength];
        [mInfo setObject:@(self.timeLength) forKey:kPageRecordTimeLength];
        [self.pageRecordArray addObject:mInfo];
        self.currentPage = currentCount;
        return;
    }
    
    self.currentPage = currentCount;
    
    switch (self.readOrRecordType) {
        case ReadOrRecordType_hear:// 听模式
        {
            NSDictionary * infoDic = [self.pageArray objectAtIndex:self.currentPage];
            if (self.hearBtn.selected) {
                // hearBtn处于播放状态
                [[BTVoicePlayer share] play:[self getLocalFilePath:infoDic]];
            }else
            {
                [[BTVoicePlayer share] play:[self getLocalFilePath:infoDic]];
                [[BTVoicePlayer share] localstop];
            }
        }
            break;
        case ReadOrRecordType_againHearCurrentPage:
        {
            // 正在播放中的话，停止播放
            if ([[BTVoicePlayer share] isLocalPlaying]) {
                [[BTVoicePlayer share] localstop];
            }
            self.againhearBtn.backgroundColor = kMainColor;
            self.hearFormalBtn.selected = NO;
        }
            break;
        case ReadOrRecordType_followerRead:
        {
            // 正在播放中的话，停止播放
            
            if ([[BTVoicePlayer share] isLocalPlaying]) {
                [[BTVoicePlayer share] localstop];
            }
            self.playBtn.selected = NO;
            NSMutableDictionary * infoDic = nil;
            if (self.FollowRecordArray.count > currentCount) {
                infoDic = self.FollowRecordArray[currentCount];
            }
            if ([infoDic objectForKey:kPlayUrl]) {
                if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
                    self.playRecordBtn.enabled = YES;
                    [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
                }else
                {
                    self.playRecordBtn.enabled = NO;
                    [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
                }
            }else
            {
                self.playRecordBtn.enabled = NO;
                [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
            }
        }
            break;
        case ReadOrRecordType_recordPage:
        {
            // 正在播放中的话，停止播放
            if ([[BTVoicePlayer share] isPlaying]) {
                [[BTVoicePlayer share] stop];
            }
            if ([[BTVoicePlayer share] isLocalPlaying]) {
                [[BTVoicePlayer share] localstop];
            }
            self.playBtn.selected = NO;
            NSMutableDictionary * infoDic = nil;
            if (self.FollowRecordArray.count > currentCount) {
                infoDic = self.FollowRecordArray[currentCount];
            }
            if ([infoDic objectForKey:kPlayUrl]) {
                if ([[infoDic objectForKey:kPlayUrl] length] > 0) {
                    self.playRecordBtn.enabled = YES;
                    [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
                }else
                {
                    self.playRecordBtn.enabled = NO;
                    [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
                }
            }else
            {
                self.playRecordBtn.enabled = NO;
                [self.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 阅读完毕获取星星
- (void)getReadStarAction
{
//    [SVProgressHUD show];
    if (self.isAgainRecord) {
        return;
    }
    
    [[UserManager sharedManager] didRequestSubmitMoerduoAndReadTaskWithWithDic:@{kuserWorkId:@(self.userWorkId), kitemId:[self.infoDic objectForKey:kitemId], kpartId:[self.infoDic objectForKey:kpartId], @"second":@(self.studytimeLength), @"isEnd":@(1), @"type":@(2)} withNotifiedObject:self];
    if (self.studuyTimer) {
        [self.studuyTimer invalidate];
        self.studuyTimer = nil;;
        self.studytimeLength = 0;
    }
   
}
#pragma mark - 录音完毕显示获取星星数
- (void)getRecordStarAction
{
    __weak typeof(self) weakSelf = self;
    
    StarPrizeView * starView = [[StarPrizeView alloc]initWithFrame:self.view.bounds andIsRecord:YES];
    self.recordStarView = starView;
    [self.view addSubview:starView];
    
    NSString * str = [NSString stringWithFormat:@"本次录音获得%d颗星星", [[UserManager sharedManager] getUploadRecordStar]];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor_orange};
    [mStr addAttributes:attribute range:NSMakeRange(6, str.length - 9)];
    
    [self.recordStarView resetContent:mStr];
    
    starView.shareBlock = ^(BOOL isShare) {
        [weakSelf addShareView];
    };
    starView.backBlock = ^(BOOL isBask) {
        [weakSelf backAction];
    };
}

- (void)addShareView
{
    __weak typeof(self)weakSelf = self;
    ShareView * shareView = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_productShowAndWeixin];
    [self.view addSubview:shareView];
    shareView.shareBlock = ^(NSDictionary *infoDic) {
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case ShareObjectType_ProductShow:
            {
                [SVProgressHUD show];
                
                if ([weakSelf.infoDic objectForKey:kProductId] != nil) {
                    // 重录分享
                    [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[weakSelf.infoDic objectForKey:kProductId],kshareType:@(1)} withNotifiedObject:weakSelf];
                }else
                {
                    [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[[[UserManager sharedManager] getUploadRecorgInfo] objectForKey:kProductId],kshareType:@(1)} withNotifiedObject:weakSelf];
                }
            }
                break;
            case ShareObjectType_weixinFriend:
            {
                // 分享给微信好友
                self.shareType = ShareObjectType_weixinFriend;
                [[WXApiShareManager shareManager] shareToSessionWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:weakSelf];
            }
                break;
            case ShareObjectType_friendCircle:
            {
                // 分享给微信朋友圈
                self.shareType = ShareObjectType_friendCircle;
                [[WXApiShareManager shareManager] shareToTimelineWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:weakSelf];
            }
                break;
            case ShareObjectType_WeixinCollect:
            {
                // 分享给微信收藏
                self.shareType = ShareObjectType_WeixinCollect;
                [[WXApiShareManager shareManager] shareToFavoriteWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:weakSelf];
            }
                break;
                
            default:
                break;
        }
    };
    
}

#pragma mark - wexin share success delegate
- (void)shareSuccess
{
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
    [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[self.infoDic objectForKey:kProductId],kshareType:@(type)} withNotifiedObject:self];
}


#pragma mark - share
- (void)didRequestShareMyProductSuccessed
{
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
    __weak typeof(self) weakSelf = self;
    [self.hearBtn setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    StarPrizeView * starView = [[StarPrizeView alloc]initWithFrame:self.view.bounds];
    if (self.userWorkId > 0) {
        [starView hideRecoedBtn];
    }
    self.readStarView = starView;
    [self.view addSubview:starView];
    
    NSString * str = [NSString stringWithFormat:@"本次阅读获得%d颗星星", [[UserManager sharedManager] getUploadRecordStar]];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainColor_orange};
    [mStr addAttributes:attribute range:NSMakeRange(6, str.length - 9)];
    
    [self.readStarView resetContent:mStr];
    
    starView.circleBlock = ^(BOOL isBask) {
#pragma mark - 循环阅读
        weakSelf.isFollowRead = NO;
        [weakSelf hideFollwReadView];
        weakSelf.hearBtn.hidden = NO;
        weakSelf.silentReadBtn.hidden = NO;
        weakSelf.againhearBtn.hidden = NO;
        weakSelf.playBtn.selected = NO;
        weakSelf.hearBtn.selected = NO;
        weakSelf.readOrRecordType = ReadOrRecordType_none;
        
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight) animated:YES];
        self.currentPage = 0;
        self.pageControlLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.pageArray.count];
        [weakSelf hearAction];
        [weakSelf addStudyLengthTimer];
        [weakSelf.readStarView removeFromSuperview];
    };
    starView.recordBlock = ^(BOOL isBask) {
        [weakSelf.readStarView removeFromSuperview];
        weakSelf.readOrRecordType = ReadOrRecordType_none;
        [weakSelf resreshRecordUI];
    };
    starView.reReadBlock = ^(BOOL isBask) {
        
        for (NSMutableDictionary * mInfo in weakSelf.FollowRecordArray) {
            [mInfo setObject:@"" forKey:kPlayUrl];
            [mInfo setObject:@0 forKey:kPageRecordTimeLength];
        }
        
        [weakSelf.pageRecordArray removeAllObjects];
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, kScreenHeight) animated:YES];
        
        weakSelf.currentPage = 0;
        weakSelf.pageControlLB.text = [NSString stringWithFormat:@"%d/%d", weakSelf.currentPage, weakSelf.pageArray.count];
        weakSelf.playRecordBtn.enabled = NO;
        [weakSelf.playRecordBtn setImage:[UIImage imageNamed:@"play_recordThree"] forState:UIControlStateNormal];
        
        weakSelf.playBtn.selected = NO;
        weakSelf.followReadBtn.selected = YES;
        [weakSelf playAction];
        [weakSelf addStudyLengthTimer];
        [weakSelf.readStarView removeFromSuperview];
    };
    starView.backBlock = ^(BOOL isBask) {
        [weakSelf backAction];
    };
}

#pragma mark - 录音参数设置
/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    self.timeLength = 0;
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    self.savePath = urlStr;
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

-(NSString *)getSavePathStr{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    return urlStr;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
//-(NSDictionary *)getAudioSetting{
//    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
//    //设置录音格式
//    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
//    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
//    [dicM setObject:@(8000) forKey:AVSampleRateKey];
//    //设置通道,这里采用单声道
//    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
//    //每个采样点位数,分为8、16、24、32
//    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
//    //是否使用浮点数采样
//    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
//    //....其他设置等
//    return dicM;
//}
//获取录音参数配置
- (NSDictionary *)getAudioSetting{
    
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMedium] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    return result;
}
/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    self.timeLength += 0.1;
}


- (void)recordClick {
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }
}

/**
 *  点击暂定按钮
 *
 *  @param sender 暂停按钮
 */
- (void)pauseClick {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate=[NSDate distantFuture];
    }
}

/**
 *  点击恢复按钮
 *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
 *
 *  @param sender 恢复按钮
 */
- (void)resumeClick {
    [self recordClick];
}

/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (void)stopClick {
    [self.audioRecorder stop];
    self.timer.fireDate=[NSDate distantFuture];
    self.timeLength = 0.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
