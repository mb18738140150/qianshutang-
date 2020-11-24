//
//  CommentTaskViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentTaskViewController.h"
#import "PageControlLB.h"
#import "CreateProductionViewController.h"
#import "ShowBigImageView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "HomeworkDetailView.h"
#import "TextCommentView.h"
#import "CommentModulViewController.h"
#import "PraiseAndFlowerView.h"
#import "PlayVideoViewController.h"
#import "StudentInformationViewController.h"
#import "LearnTextViewController.h"
#import "Mp3Review.h"

@interface CommentTaskViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,Task_CreateTaskProblemContent,ChangeMusicProtocol,MyClassroom_MyFriendProductDetail,MyStudy_ShareMyProduct, Teacher_commentTask,Teacher_addTextToCommentModul, WXApiShareManagerDelegate,Teacher_PriseAndflower>
// 导航视图
@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic, strong)UIButton * playRecordBtn;// 录音
@property (nonatomic, strong)NSArray * recordPageList;// 录音页码数组
@property (nonatomic, strong)NSArray * recordPointList;// 录音翻页点数组
@property (nonatomic, assign)int currentPlayRecordPage;// 记录当前播放录音页码数组页码
@property (nonatomic, strong)NSTimer * playRecordTimer;
@property (nonatomic, assign)float currentPlayRecordTime;

@property (nonatomic, assign)PlayOriginOrRecordType playOriginOrRecordType;
@property (nonatomic, strong)UIButton * playOriginalBtn;// 原音
@property (nonatomic, strong)UIButton * resultBtn;// 答案
@property (nonatomic, strong)UIButton * resultPlayBtn;// 答案播放
@property (nonatomic, strong)UIButton * taskBtn;// 作业题
@property (nonatomic, strong)HomeworkDetailView * homeworkDetailView; // 作业题view
@property (nonatomic, strong)UIButton * productAudioPlayBtn;//自主创作作业播放

@property (nonatomic, assign)int currentPage;
@property (nonatomic, assign)BOOL isModifySuccess;

// 左边视图
@property (nonatomic, strong)UIImageView * iconImage;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * scoreLB;
@property (nonatomic, strong)UILabel * flowerLB;
@property (nonatomic, strong)UIImageView * flowerImageView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

// 内容视图
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)PageControlLB * pageControlLB;
@property (nonatomic, assign)int currentCount;
@property (nonatomic, strong)NSMutableArray * imaegArray;
@property (nonatomic, strong)ShowBigImageView * showBigImageView;

@property (nonatomic, strong)TextCommentView * textCommentView;

@property (nonatomic, strong)Mp3Review * mp3Review;
@property (nonatomic, strong)NSString * recordIntroUrl;
@property (nonatomic, assign)BOOL isPlayMp3Review;

@property (nonatomic, assign)ShareObjectType shareType;

@end

@implementation CommentTaskViewController

- (NSMutableArray *)imaegArray
{
    if (!_imaegArray) {
        _imaegArray = [NSMutableArray array];
    }
    return _imaegArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[BTVoicePlayer share] isHavePlayerItem]) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    __weak typeof(self)weakSelf = self;
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf backAction];
    };
    
    [self addNavigationView];
    
    [self.view addSubview:self.navigationView];
    
    [BTVoicePlayer share].delegate = self;
    
    if (self.productType == ProductType_record) {
        self.recordPageList = [[self.infoDic objectForKey:@"pageList"] componentsSeparatedByString:@","];
        self.recordPointList = [[self.infoDic objectForKey:@"pointList"] componentsSeparatedByString:@","];
    }
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = self.model.name;
    [self.navigationView.rightView addSubview:self.titleLB];
    
    [self addLeftView];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 13, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 20)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.backView.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.pagingEnabled = YES;
    [self.backView addSubview:self.scrollView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageAction)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.pageControlLB = [[PageControlLB alloc]initWithFrame:CGRectMake(self.backView.hd_width * 0.89, self.backView.hd_height * 0.895, self.backView.hd_width * 0.086, self.backView.hd_height * 0.07)];
    [self.backView addSubview:self.pageControlLB];
    
    [self refreshScroll];
    [[WXApiShareManager shareManager] setDelegate:self];
}

- (void)backAction
{
    if (self.isModifySuccess) {
        if (self.modifuProductBlock) {
            self.modifuProductBlock(YES);
        }
    }
    
    if (self.playRecordTimer) {
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
    }
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    if ([[RecordTool sharedInstance] isRecording]) {
        [[RecordTool sharedInstance] stopRecordVoice];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)refreshScroll
{
    __weak typeof(self)weakSelf = self;
    [self.scrollView removeAllSubviews];
    [self.imaegArray removeAllObjects];
    switch (self.model.modelType) {
        case ProductModelType_text:
        {
            dispatch_group_t group = dispatch_group_create();
            dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
            
            for (int i = 0; i < self.model.textProductArray.count; i++) {
                TextProductModel * model = [self.model.textProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                
                dispatch_group_enter(group);
                dispatch_async(queue, ^{
                    
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:model.textImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        model.textImage = image;
                        if (i == 0) {
                            weakSelf.model.image = image;
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            dispatch_group_leave(group);
                        });
                    }];
                    
                });
                
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                [self.scrollView addSubview:imageView];
                [self.imaegArray addObject:imageView];
            }
            
            dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
            
            self.scrollView.contentSize = CGSizeMake(self.model.textProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.textProductArray.count];
        }
            break;
        case ProductModelType_music:
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = self.model.image;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.model.image = image;
            }];
            imageView.userInteractionEnabled = YES;
            [self.scrollView addSubview:imageView];
            [self.imaegArray addObject:imageView];
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"1/1"];
        }
            break;
        case ProductModelType_photo:
        {
            dispatch_group_t group = dispatch_group_create();
            dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
            for (int i = 0; i < self.model.imageProductArray.count; i++) {
                ImageProductModel * model = [self.model.imageProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                
                UIImageView * originImageView = [[UIImageView alloc]init];
                
                [SVProgressHUD show];
                
                dispatch_group_enter(group);
                dispatch_async(queue, ^{
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:model.fanleImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        model.fanleImage = image;
                        if (i == 0) {
                            weakSelf.model.image = image;
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            dispatch_group_leave(group);
                        });
                        
                    }];
                    
                });
                
                dispatch_group_enter(group);
                dispatch_async(queue, ^{
                    
                    [originImageView sd_setImageWithURL:[NSURL URLWithString:model.originImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        model.originImage = image;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            dispatch_group_leave(group);
                        });
                        
                    }];
                    
                });
                
                
                [self.scrollView addSubview:imageView];
                [self.imaegArray addObject:imageView];
            }
            
            dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
            
            self.scrollView.contentSize = CGSizeMake(self.model.imageProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
        }
            break;
        case ProductModelType_video:
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.model.image = image;
            }];
            [self.scrollView addSubview:imageView];
            
            UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            playButton.frame = CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10);
            playButton.hd_centerX = imageView.hd_centerX;
            playButton.hd_centerY = imageView.hd_centerY;
            [playButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
            [self.scrollView addSubview:playButton];
            [playButton addTarget:self action:@selector(playVideoAction) forControlEvents:UIControlEventTouchUpInside];
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"1/1"];
        }
            break;
            
        default:
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    // 播放录音
    if (self.productType == ProductType_record) {
        self.playOriginOrRecordType = PlayOriginOrRecordType_record;
        [[BTVoicePlayer share] playLine:[self.infoDic objectForKey:@"recordUrl"]];
        self.playRecordBtn.selected = YES;
        [self.scrollView scrollRectToVisible:CGRectMake(([self.recordPageList[0] intValue] - 1) * self.scrollView.hd_width, 0, self.scrollView.hd_width, self.scrollView.hd_height) animated:YES];
        
        self.currentPage = [self.recordPageList[0] intValue] - 1;
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.model.imageProductArray.count];
        
        self.playRecordTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.playRecordTimer forMode:NSDefaultRunLoopMode];
    }
    
}

- (void)timerAction
{
    self.currentPlayRecordTime += 0.1;
    NSLog(@"%.2f *** %d", self.currentPlayRecordTime, self.currentPlayRecordPage);
    NSString * currentTimeStr = [NSString stringWithFormat:@"%.1f", self.currentPlayRecordTime];
    // 判断是否到下一个播放节点，
    if ([currentTimeStr isEqualToString: [self.recordPointList objectAtIndex:self.currentPlayRecordPage]]) {
        NSLog(@"currentTimeStr = %@", currentTimeStr);
        if (self.currentPlayRecordPage + 1 < self.recordPageList.count) {
            // 翻页到下一个节点
            self.currentPlayRecordPage++;
            NSLog(@"[self.recordPageList[self.currentPlayRecordPage] intValue] = %d", [self.recordPageList[self.currentPlayRecordPage] intValue]);
            [self.scrollView scrollRectToVisible:CGRectMake(([self.recordPageList[self.currentPlayRecordPage] intValue]  - 1) * self.scrollView.hd_width, 0, self.scrollView.hd_width, self.scrollView.hd_height) animated:YES];
            
            self.currentPage = [self.recordPageList[self.currentPlayRecordPage] intValue] - 1;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.model.imageProductArray.count];
        }
    }
    
}

- (void)playVideoAction
{
    PlayVideoViewController * videoVC = [[PlayVideoViewController alloc]init];
    videoVC.infoDic = @{kMP4Src:self.model.videoUrl};
    [self presentViewController:videoVC animated:NO completion:nil];
}

- (void)showBigImageAction
{
    if (self.model.modelType != ProductModelType_video) {
        if (!self.showBigImageView) {
            self.showBigImageView = [[ShowBigImageView alloc]initWithFrame:self.view.frame andArray:self.imaegArray];
        }
        [self.view addSubview:self.showBigImageView];
        CGFloat duration = 1.0;
        
        self.showBigImageView.currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(0.8);
            scaleAnimation.toValue = @(1);
            scaleAnimation.duration = duration;
            
            CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            alphaAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.backView.hd_centerX, self.backView.hd_centerY)];
            // 终止位置
            alphaAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.hd_centerX, self.view.hd_centerY)];
            alphaAnimation.duration = duration;
            
            CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = duration;
            animationGroup.autoreverses = NO;
            [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation,alphaAnimation, nil]];
            
            [self.showBigImageView.layer addAnimation:animationGroup forKey:@"animationGroup"];
        });
        
        __weak typeof(self)weakSelf = self;
        self.showBigImageView.dismissBlock = ^{
            CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(1.0);
            scaleAnimation.toValue = @(0.8);
            scaleAnimation.duration = duration;
            
            CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            alphaAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.view.hd_centerX, weakSelf.view.hd_centerY)];
            // 终止位置
            alphaAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.backView.hd_centerX, weakSelf.backView.hd_centerY)];
            alphaAnimation.duration = duration;
            
            CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = duration;
            animationGroup.autoreverses = NO;
            [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation,alphaAnimation, nil]];
            
            [weakSelf.showBigImageView.layer addAnimation:animationGroup forKey:@"animationGroup"];
            [weakSelf performSelector:@selector(dismissBigImageView) withObject:nil afterDelay:duration - 0.05];
        };
        
    }
}

- (void)dismissBigImageView
{
    [self.showBigImageView removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width ;
    self.currentPage = currentCount;
    
    
    // 录音作品
    if (self.productType == ProductType_record) {
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
        // 播放原音
        if (self.playOriginOrRecordType == PlayOriginOrRecordType_origin) {
            ImageProductModel * imageModel = self.model.imageProductArray[self.currentPage];
            if ([BTVoicePlayer share].isPlaying) {
                [[BTVoicePlayer share] stop];
                [[BTVoicePlayer share] playLine:imageModel.audioUrl];
            }else
            {
                [[BTVoicePlayer share] playLine:imageModel.audioUrl];
                [[BTVoicePlayer share] stop];
            }
        }else
        {
            // 播放录音
        }
        return;
    }
    
    switch (self.model.modelType) {
        case ProductModelType_text:
        {
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.textProductArray.count];
        }
            break;
        case ProductModelType_photo:
        {
            int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
            self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - addNavigationView
- (void)addNavigationView
{
    [self.navigationView.rightView removeAllSubviews];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.hd_height + 10, 5, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = kMainColor;
    self.shareBtn.layer.cornerRadius = self.shareBtn.hd_height / 2;
    self.shareBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.playRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playRecordBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_height * 1.7, self.shareBtn.hd_y, self.shareBtn.hd_height * 1.7, self.shareBtn.hd_height);
    [self.playRecordBtn setImage:[UIImage imageNamed:@"listen_record_n_btn"] forState:UIControlStateNormal];
    [self.playRecordBtn setImage:[UIImage imageNamed:@"listen_record_p_btn"] forState:UIControlStateSelected];
    [self.navigationView.rightView addSubview:self.playRecordBtn];
    
    self.playOriginalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playOriginalBtn.frame = CGRectMake(self.playRecordBtn.hd_x - 15 - self.shareBtn.hd_height * 1.7, self.shareBtn.hd_y, self.shareBtn.hd_height * 1.7, self.shareBtn.hd_height);
    [self.playOriginalBtn setImage:[UIImage imageNamed:@"play_solo_n_btn"] forState:UIControlStateNormal];
    [self.playOriginalBtn setImage:[UIImage imageNamed:@"play_solo_p_btn"] forState:UIControlStateSelected];
    [self.navigationView.rightView addSubview:self.playOriginalBtn];
    
    self.resultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resultBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, self.shareBtn.hd_y, self.navigationView.hd_height - 10, self.navigationView.hd_height - 10);
    [self.resultBtn setTitle:@"答案" forState:UIControlStateNormal];
    [self.resultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.resultBtn.backgroundColor = kMainColor;
    self.resultBtn.layer.cornerRadius = self.resultBtn.hd_height / 2;
    self.resultBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.resultBtn];
    
    self.resultPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resultPlayBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_height * 1.37, self.shareBtn.hd_y, self.shareBtn.hd_height * 1.37, self.navigationView.hd_height - 10);
    [self.resultPlayBtn setTitle:@"作品" forState:UIControlStateNormal];
    [self.resultPlayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.resultPlayBtn.backgroundColor = kMainColor;
    self.resultPlayBtn.layer.cornerRadius = self.resultPlayBtn.hd_height / 2;
    self.resultPlayBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.resultPlayBtn];
    
    self.productAudioPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.productAudioPlayBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_height * 1.37, self.shareBtn.hd_y, self.shareBtn.hd_height * 1.37, self.navigationView.hd_height - 10);
//    [self.productAudioPlayBtn setTitle:@"作品" forState:UIControlStateNormal];
//    [self.productAudioPlayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.productAudioPlayBtn setImage:[UIImage imageNamed:@"student_opus_n"] forState:UIControlStateNormal];
    [self.productAudioPlayBtn setImage:[UIImage imageNamed:@"student_opus_p"] forState:UIControlStateSelected];
    self.productAudioPlayBtn.backgroundColor = kMainColor;
    self.productAudioPlayBtn.layer.cornerRadius = self.productAudioPlayBtn.hd_height / 2;
    self.productAudioPlayBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.productAudioPlayBtn];
    [self.productAudioPlayBtn addTarget:self action:@selector(playAudioProductAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.taskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.taskBtn.frame = CGRectMake(self.resultBtn.hd_x - 15 - self.shareBtn.hd_height * 1.37, self.shareBtn.hd_y, self.shareBtn.hd_height * 1.37, self.navigationView.hd_height - 10);
    [self.taskBtn setTitle:@"作业题" forState:UIControlStateNormal];
    [self.taskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.taskBtn.backgroundColor = kMainColor;
    self.taskBtn.layer.cornerRadius = self.resultPlayBtn.hd_height / 2;
    self.taskBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.taskBtn];
    
    self.playRecordBtn.hidden = YES;
    self.playOriginalBtn.hidden = YES;
    self.resultBtn.hidden = YES;
    self.resultPlayBtn.hidden = YES;
    self.taskBtn.hidden = YES;
    self.productAudioPlayBtn.hidden = YES;
    
    if (self.productType == ProductType_record) {
        self.playRecordBtn.hidden = NO;
        self.playOriginalBtn.hidden = NO;
    }else if (self.productType == ProductType_create)
    {
        if ([[self.infoDic objectForKey:@"type"] intValue] == 3) {
            // 自主创作视频作品
            self.productAudioPlayBtn.hidden = NO;
            [self.productAudioPlayBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.productAudioPlayBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            [self.productAudioPlayBtn setTitle:@"作品" forState:UIControlStateNormal];
            [self.productAudioPlayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }else
        {
            self.productAudioPlayBtn.hidden = NO;
        }
    }
    if (self.taskType == TaskType_create || self.taskType == TaskType_video) {
        self.playRecordBtn.hidden = YES;
        self.playOriginalBtn.hidden = YES;
        
        self.resultPlayBtn.hidden = YES;
        
        self.resultBtn.hidden = NO;
        self.taskBtn.hidden = NO;
    }
    
    [self.playRecordBtn addTarget:self action:@selector(playRecordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.playOriginalBtn addTarget:self action:@selector(playOriginalAction) forControlEvents:UIControlEventTouchUpInside];
    [self.resultPlayBtn addTarget:self action:@selector(playResultAction) forControlEvents:UIControlEventTouchUpInside];
    [self.taskBtn addTarget:self action:@selector(taskAction) forControlEvents:UIControlEventTouchUpInside];
    [self.resultBtn addTarget:self action:@selector(resultAction ) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareAction
{
    ShareView * shareView = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_productShowAndWeixin];
    [self.view addSubview:shareView];
    shareView.shareBlock = ^(NSDictionary *infoDic) {
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case ShareObjectType_ProductShow:
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[self.infoDic objectForKey:kProductId],kshareType:@(1)} withNotifiedObject:self];
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
    
}

- (void)playRecordAction
{
    // 判断这是否正在播放原音，是的话停止
    if (self.playOriginOrRecordType == PlayOriginOrRecordType_origin || self.playOriginOrRecordType == PlayOriginOrRecordType_mp3Review) {
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
    }
    self.playOriginOrRecordType = PlayOriginOrRecordType_record;
    
    self.playOriginalBtn.selected = NO;
    
    if (self.playRecordBtn.selected) {
        self.playRecordBtn.selected = NO;
    }else
    {
        self.playRecordBtn.enabled = YES;
        self.playRecordBtn.selected = YES;
    }
    
//    self.playRecordBtn.selected = !self.playRecordBtn.selected;
    
    if (self.playRecordBtn.selected) {
        
        // 如果当前页码大于初始播放页码，需要把播放录音时间切换到下一个最近时间点
        int currentIndex = 0;
        
        if (self.currentPage + 1 < [[self.recordPageList firstObject] intValue] || self.currentPage + 1 > [[self.recordPageList lastObject] intValue]) {
            // 处于第一页之前或最后一页之后，均从第一页开始播放
            currentIndex = 0;
        }else
        {
            for (int i = 0; i < self.recordPageList.count; i++) {
                int page = [self.recordPageList[i] intValue];
                // 等于当前播放节点页码
                if (page == self.currentPage + 1) {
                    currentIndex = i;
                    break;
                }else
                {
                    if (i > 0) {
                        // 处于两播放节点页码之间
                        int lastPage = [self.recordPageList[i - 1] intValue];
                        if (lastPage < self.currentPage + 1 && page > self.currentPage+1) {
                            currentIndex = i;
                            break;
                        }
                    }
                }
            }
            
        }
        
        self.currentPlayRecordPage = currentIndex;
        [self.scrollView scrollRectToVisible:CGRectMake(([self.recordPageList[currentIndex] intValue]  - 1) * self.scrollView.hd_width, 0, self.scrollView.hd_width, self.scrollView.hd_height) animated:YES];
        self.currentPage = [self.recordPageList[currentIndex] intValue] - 1;
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.model.imageProductArray.count];
        [[BTVoicePlayer share] playLine:[self.infoDic objectForKey:@"recordUrl"]];
        
        if (currentIndex == 0) {
            // 第一页不作处理，直接播放
            self.playRecordTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.playRecordTimer forMode:NSDefaultRunLoopMode];
        }else
        {
            // 不是第一页进行切换
            self.currentPlayRecordTime = [[self.recordPointList objectAtIndex:currentIndex - 1] floatValue];
            float rate = 0.0;
            rate = ([self.recordPointList[currentIndex - 1] floatValue]) / ([[self.recordPointList lastObject] floatValue]);
            NSLog(@"rate = %.2f", rate);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.playRecordTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.playRecordTimer forMode:NSDefaultRunLoopMode];
                [[BTVoicePlayer share]seekToTime:rate];
            });
        }
       
    }else
    {
        // 停止播放录音
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
        self.currentPlayRecordTime = 0.0;
        self.currentPlayRecordPage = 0;
    }
}

- (void)playAudioProductAction
{
    if ([BTVoicePlayer share].isPlaying) {
        [[BTVoicePlayer share] stop];
    }
    
    self.productAudioPlayBtn.selected = !self.productAudioPlayBtn.selected;
    if (self.productAudioPlayBtn.selected) {
        switch ([[self.infoDic objectForKey:@"type"] intValue]) {
            case 2:
            case 3:
            {
                // 文字、视频不作处理
            }
                break;
            case 4:
            {
                ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:self.currentPage];
                if (imageModel.audioUrl && imageModel.audioUrl.length > 0) {
                    [[BTVoicePlayer share] playLine:imageModel.audioUrl];
                }
            }
                break;
            case 1:
            {
                [[BTVoicePlayer share] playLine:self.model.audioUrl];
            }
                break;
            
            default:
                break;
        }
    }else
    {
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
    }
}

#pragma mark - playMusicDelegate
- (void)changeMusic
{
    if (self.playOriginOrRecordType == PlayOriginOrRecordType_mp3Review) {
        // 播放录音点评完成
        self.isPlayMp3Review = NO;
        return;
    }
    
    if (self.playRecordTimer) {
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
    }
    self.currentPlayRecordTime = 0.0;
    self.currentPlayRecordPage = 0;
    
    // 录音作品
    if (self.productType == ProductType_record) {
        // 播放原音
        if (self.playOriginOrRecordType == PlayOriginOrRecordType_origin) {
            if (self.currentPage + 1 < self.model.imageProductArray.count) {
                [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.hd_width * (self.currentPage + 1), 0, self.scrollView.hd_width, self.scrollView.hd_height) animated:YES];
                self.currentPage++;
                self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", self.currentPage + 1, self.model.imageProductArray.count];

                self.currentPage += 1;
                if ([[BTVoicePlayer share] isPlaying]) {
                    [[BTVoicePlayer share] stop];
                }
                ImageProductModel * imageModel = self.model.imageProductArray[self.currentPage];
                [[BTVoicePlayer share] playLine:imageModel.audioUrl];
            }
        }else
        {
            // 播放录音完成不做处理
            self.playRecordBtn.selected = NO;
        }
        return;
    }
    
    // 创作作品
    self.productAudioPlayBtn.selected = NO;
    switch ([[self.infoDic objectForKey:@"type"] intValue]) {
        case 4:
        {
            if (self.currentPage + 1 < self.model.imageProductArray.count) {
//                [self playAudioProductAction];
            }
            
        }
            break;
        default:
            break;
    }
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
}

- (void)playOriginalAction
{
    if (self.playRecordTimer) {
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
        self.currentPlayRecordTime = 0.0;
        self.currentPlayRecordPage = 0;
    }
    
    // 判断这是否正在播放录音，是的话停止
    if (self.playOriginOrRecordType == PlayOriginOrRecordType_record || self.playOriginOrRecordType == PlayOriginOrRecordType_mp3Review) {
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
        ImageProductModel * imageModel = self.model.imageProductArray[self.currentPage];
        [[BTVoicePlayer share] playLine:imageModel.audioUrl];
        [[BTVoicePlayer share] stop];
    }
    self.playOriginOrRecordType = PlayOriginOrRecordType_origin;
    self.playRecordBtn.selected = NO;
    self.playOriginalBtn.selected = !self.playOriginalBtn.selected;
    if (self.playOriginalBtn.selected) {
        // 播放原音
        if ([[BTVoicePlayer share] isHavePlayContent]) {
            [[BTVoicePlayer share] playContinu];
        }else
        {
            ImageProductModel * imageModel = self.model.imageProductArray[self.currentPage];
            [[BTVoicePlayer share] playLine:imageModel.audioUrl];
        }
    }else
    {
        // 停止播放原音
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
    }
}

- (void)playResultAction
{
    self.resultPlayBtn.selected = !self.resultPlayBtn.selected;
    if (self.resultPlayBtn.selected) {
        // 播放答案
    }else
    {
        // 停止播放答案
        if ([BTVoicePlayer share].isPlaying) {
            [[BTVoicePlayer share] stop];
        }
    }
    [self.homeworkDetailView removeFromSuperview];
}

- (void)resultAction
{
    [self.homeworkDetailView removeFromSuperview];
}

- (void)taskAction
{
    self.taskBtn.selected = !self.taskBtn.selected;
    
    if (!self.homeworkDetailView) {
        self.homeworkDetailView = [[HomeworkDetailView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height) withInfo:[[UserManager sharedManager] getTaskProbemContentInfo]];
    }
    [self.view addSubview:self.homeworkDetailView];
    
}

#pragma mark - leftView
- (void)addLeftView
{
    if (!self.iconImage) {
        UIView * leftBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
        leftBackView.backgroundColor = kMainColor;
        [self.view addSubview:leftBackView];
        
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(leftBackView.hd_width * 0.18, 15, leftBackView.hd_width * 0.64, leftBackView.hd_width * 0.64)];
        self.iconImage.layer.cornerRadius = 10;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.iconImage.layer.borderWidth = 5;
        
        self.iconImage.userInteractionEnabled = YES;
        [leftBackView addSubview:self.iconImage];
        
        UITapGestureRecognizer * iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(icontapAction)];
        [self.iconImage addGestureRecognizer:iconTap];
        
        self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImage.frame) + 5, leftBackView.hd_width, 20)];
        self.nameLB.textColor = [UIColor whiteColor];
        
        self.nameLB.textAlignment = NSTextAlignmentCenter;
        [leftBackView addSubview:self.nameLB];
        
        if (self.commentTaskType == CommentTaskType_nomal) {
            self.scoreLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 5, leftBackView.hd_width - 30, 20)];
            self.scoreLB.text = @"老师点评:100";
            self.scoreLB.textColor = [UIColor whiteColor];
            [leftBackView addSubview:self.scoreLB];
        }
        
        NSString * flowerStr = [NSString stringWithFormat:@"红花： %@", [self.infoDic objectForKey:@"flowerCount"]];
        CGSize flowerLBSize = [flowerStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        
        if (self.commentTaskType == CommentTaskType_nomal) {
            self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scoreLB.frame) + 5, flowerLBSize.width, 20)];
        }else
        {
            self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 5, flowerLBSize.width, 20)];
        }
        self.flowerLB.textColor = [UIColor whiteColor];
        self.flowerLB.text = flowerStr;
        self.flowerLB.textAlignment = NSTextAlignmentCenter;
        [leftBackView addSubview:self.flowerLB];
        
        self.flowerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerLB.frame) + 5, self.flowerLB.hd_y, 20, 20)];
        self.flowerImageView.image = [UIImage imageNamed:@"flower"];
        [leftBackView addSubview:self.flowerImageView];
        
        [self loadData];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.flowerLB.frame) + 5, leftBackView.hd_width, leftBackView.hd_height - CGRectGetMaxY(self.flowerLB.frame) - 5) style:UITableViewStylePlain];
        if (self.commentTaskType == CommentTaskType_studentLookTeacherProduct) {
            self.tableView.frame = CGRectMake(0, leftBackView.hd_height - 20 - kScreenHeight / 8, leftBackView.hd_width, kScreenHeight / 8);
        }
        
        if (self.commentTaskType == CommentTaskType_studentLookStarProduct || self.commentTaskType == CommentTaskType_teacherLookTeacherOrStar) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = kMainColor;
        [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
        [leftBackView addSubview:self.tableView];
    }
    
    if ([[self.infoDic objectForKey:@"userIcon"] class] != [NSNull class]) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[self.infoDic objectForKey:@"userIcon"]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    }else
    {
        self.iconImage.image = [UIImage imageNamed:@"head_portrait"];
    }
    self.nameLB.text = [self.infoDic objectForKey:@"userName"];
    
    NSString * flowerStr = [NSString stringWithFormat:@"红花： %@", [self.infoDic objectForKey:@"flowerCount"]];
    CGSize flowerLBSize = [flowerStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    
    if (self.commentTaskType == CommentTaskType_nomal) {
        self.flowerLB.frame = CGRectMake(15, CGRectGetMaxY(self.scoreLB.frame) + 5, flowerLBSize.width, 20);
    }else
    {
        self.flowerLB.frame = CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 5, flowerLBSize.width, 20);
    }
    self.flowerLB.text = flowerStr;
    self.flowerImageView.frame = CGRectMake(CGRectGetMaxX(self.flowerLB.frame) + 5, self.flowerLB.hd_y, 20, 20);
}

#pragma mark - 查看个人信息
- (void)icontapAction
{
    if ([BTVoicePlayer share].isPlaying) {
        [[BTVoicePlayer share] stop];
    }
    
    if (self.playRecordTimer) {
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
    }
    self.currentPlayRecordTime = 0.0;
    self.currentPlayRecordPage = 0;
    
    StudentInformationViewController * vc = [[StudentInformationViewController alloc]init];
    vc.infoDic = self.infoDic;
    
    __weak typeof(self)weakSelf = self;
    vc.selectProductBlock = ^(ProductType productType) {
        weakSelf.productType = productType;
        if (productType == ProductType_record) {
            NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
            weakSelf.infoDic = infoDic;
            weakSelf.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
            weakSelf.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        }else if (productType == ProductType_create)
        {
            NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
            weakSelf.infoDic = infoDic;
            weakSelf.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
            weakSelf.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        }
        [weakSelf addNavigationView];
        if (weakSelf.productType == ProductType_record) {
            weakSelf.recordPageList = [[self.infoDic objectForKey:@"pageList"] componentsSeparatedByString:@","];
            weakSelf.recordPointList = [[self.infoDic objectForKey:@"pointList"] componentsSeparatedByString:@","];
        }
        [weakSelf addLeftView];
        [weakSelf refreshScroll];
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
    [cell resetWithInfoDic:self.dataArray[indexPath.row]];
    
    if (self.commentTaskType != CommentTaskType_studentLookTeacherProduct) {
        if (indexPath.row == 0) {
            if ([[UserManager sharedManager] getUserType] == UserType_student) {
                if ([self.infoDic objectForKey:ktextReview] && [[self.infoDic objectForKey:ktextReview] length] > 0) {
                    cell.isCanClick = YES;
                }else
                {
                    [cell cannotClickReset];
                }
            }else
            {
                cell.isCanClick = YES;
            }
            
        }else if (indexPath.row == 1)
        {
            if ([[UserManager sharedManager] getUserType] == UserType_student) {
                if ([self.infoDic objectForKey:kmp3Review] && [[self.infoDic objectForKey:kmp3Review] length] > 0) {
                    cell.isCanClick = YES;
                }else
                {
                    [cell cannotClickReset];
                }
            }else
            {
                cell.isCanClick = YES;
            }
        }else
        {
            cell.isCanClick = YES;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self)weakSelf = self;
    
    if ([[UserManager sharedManager] getUserType] == UserType_student) {
        MainLeftTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell.isCanClick) {
            return;
        }
        
        if (self.commentTaskType == CommentTaskType_studentLookTeacherProduct) {
            if (indexPath.row == 0) {
#pragma mark - 点赞送花
                [self showPraiseAndFlowerView];
            }
            return;
        }
        if (indexPath.row == 0) {
            [self showTextCommentView];
            return;
        }
        if (indexPath.row == 1) {
            [self playRecoreComment];
            return;
        }
        if (indexPath.row == 2) {
            switch (self.commentTaskType) {
                case CommentTaskType_studentLookStudent:
                {
                    [self showPraiseAndFlowerView];
                }
                    break;
                case CommentTaskType_studentLookSelf:
                {
                    if (self.productType == ProductType_record) {
#pragma mark - 重录
                        NSLog(@"重录");
                        if ([BTVoicePlayer share].isPlaying) {
                            [[BTVoicePlayer share] stop];
                        }
                        
                        if (self.playRecordTimer) {
                            [self.playRecordTimer invalidate];
                            self.playRecordTimer = nil;
                        }
                        self.currentPlayRecordTime = 0.0;
                        self.currentPlayRecordPage = 0;
                        
                        NSLog(@"%@", [[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
                        [mInfo setObject:[mInfo objectForKey:@"partFileList"] forKey:@"data"];
                        [mInfo setObject:[mInfo objectForKey:kProductName] forKey:kpartName];
                        [mInfo setObject:[mInfo objectForKey:kProductId] forKey:kpartId];
                        
                        [[UserManager sharedManager] resetTextContentArray:mInfo];
                        
                        [self saveDownloadAudioFile];
                        
                        LearnTextViewController * vc = [[LearnTextViewController alloc]init];
                        vc.infoDic = mInfo;
                        vc.isAgainRecord = YES;
                        vc.productId = [[mInfo objectForKey:kProductId] intValue];
                        vc.learntextType = LearnTextType_record;
                        
                        vc.againRecordSuccessBlock = ^(BOOL isSuccess) {
                            if (isSuccess) {
                                [SVProgressHUD show];
                                [BTVoicePlayer share].delegate = weakSelf;
                                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[weakSelf.infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
                            }
                        };
                        
                        [self presentViewController:vc  animated:NO completion:nil];
                        
                    }else
                    {
                        if ([BTVoicePlayer share].isPlaying) {
                            [[BTVoicePlayer share] stop];
                        }
                        [self modifyProduct];
                    }
                }
                    break;
                    
                default:
                    break;
            }
            return;
        }
        
        
    }else if ([[UserManager sharedManager] getUserType] == UserType_teacher)
    {
        if (indexPath.row == 0) {
            [self showTextCommentView];
            return;
        }
        if (indexPath.row == 1) {
            switch (self.commentTaskType) {
                case CommentTaskType_nomal:
                case CommentTaskType_teacherLookStudent:
                {
                    if (self.playRecordTimer) {
                        [self.playRecordTimer invalidate];
                        self.playRecordTimer = nil;
                    }
                    if ([[BTVoicePlayer share] isPlaying]) {
                        [[BTVoicePlayer share] stop];
                    }
                    if ([[BTVoicePlayer share] isLocalPlaying]) {
                        [[BTVoicePlayer share] localstop];
                    }
//                    [self.dataArray addObject:@{@"title":@"语音点评"}];
                    self.mp3Review = [[Mp3Review alloc]initWithFrame:CGRectMake(3, self.tableView.hd_y + self.tableView.contentOffset.y + kScreenHeight / 4, self.view.hd_width * 0.2 - 6, self.view.hd_width * 0.2 - 6)];
                    [self.view addSubview:self.mp3Review];
                    [self.mp3Review recordAction];
                    self.mp3Review.voiceCommentComplateBlock = ^(NSDictionary *infoDic) {
#pragma mark - 语音点评
                        // 上传点评
                        if ([[infoDic objectForKey:@"record"] intValue] == 1) {
                            [weakSelf uploadMp3Review];
                        }
                        
                    };
                    self.mp3Review.voiceCommentCancelBlock = ^(NSDictionary *infoDic) {
                        ;
                    };
                    
                }
                    break;
                default:
                {
                }
                    break;
            }
            return;
        }
        if (indexPath.row == 2) {
            switch (self.commentTaskType) {
                case CommentTaskType_nomal:
                {
                    [self playRecoreComment];
                    [self.dataArray addObject:@{@"title":@"发回重做"}];
                    [self.dataArray addObject:@{@"title":@"点赞送花"}];
                }
                    break;
                case CommentTaskType_teacherLookStudent:
                {
                    [self playRecoreComment];
                    [self.dataArray addObject:@{@"title":@"点赞送花"}];
                }
                    break;
                case CommentTaskType_studentLookSelf:
                {
                    if (self.productType == ProductType_record) {
#pragma mark - 重录
                        NSLog(@"重录");
                        if ([BTVoicePlayer share].isPlaying) {
                            [[BTVoicePlayer share] stop];
                        }
                        
                        if (self.playRecordTimer) {
                            [self.playRecordTimer invalidate];
                            self.playRecordTimer = nil;
                        }
                        self.currentPlayRecordTime = 0.0;
                        self.currentPlayRecordPage = 0;
                        
                        NSLog(@"%@", [[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
                        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
                        [mInfo setObject:[mInfo objectForKey:@"partFileList"] forKey:@"data"];
                        [mInfo setObject:[mInfo objectForKey:kProductName] forKey:kpartName];
                        [mInfo setObject:[mInfo objectForKey:kProductId] forKey:kpartId];
                        [[UserManager sharedManager] resetTextContentArray:mInfo];
                        
                        [self saveDownloadAudioFile];
                        
                        LearnTextViewController * vc = [[LearnTextViewController alloc]init];
                        vc.infoDic = mInfo;
                        vc.isAgainRecord = YES;
                        vc.productId = [[mInfo objectForKey:kProductId] intValue];
                        vc.learntextType = LearnTextType_record;
                        
                        vc.againRecordSuccessBlock = ^(BOOL isSuccess) {
                            if (isSuccess) {
                                [SVProgressHUD show];
                                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[weakSelf.infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
                            }
                        };
                        
                        [self presentViewController:vc  animated:NO completion:nil];
                        
                    }else
                    {
                        if ([BTVoicePlayer share].isPlaying) {
                            [[BTVoicePlayer share] stop];
                        }
                        [self modifyProduct];
                    }
                }
                    break;
                    
                default:
                    break;
            }
            return;
        }
        if (indexPath.row == 3) {
            [self showPraiseAndFlowerView];
        }
        
    }
}

- (void)saveDownloadAudioFile
{
    [SVProgressHUD show];
    
//    NSMutableDictionary *
    
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary *infoDic in [[[UserManager sharedManager] getTextContentArray] objectForKey:@"data"]) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:[infoDic objectForKey:kpageIndex] forKey:kpageIndex];
        [mInfo setObject:[NSString stringWithFormat:@"%@-%@", [self.infoDic objectForKey:kProductName],@([[infoDic objectForKey:kpageIndex] intValue] - 1)] forKey:kAudioId];
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
    
    
    // 阅读课文或听录音，先缓存课文
    
    for (int j = 0 ; j < dataArray.count; j++) {
        NSString * mp3Str = [[dataArray objectAtIndex:j] objectForKey:kMP3Src];
        
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //设置保存路径和生成文件名
        NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [self.infoDic objectForKey:kProductName], j];
        //保存
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [SVProgressHUD dismiss];
            // 已下载 存储路径
            [self saveDownloadAudio:self.infoDic andNumber:j];
            
        }else
        {
            // 未下载。先下载，再存储路径
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
            if ([audioData writeToFile:filePath atomically:YES]) {
                NSLog(@"succeed");
                
                [self saveDownloadAudio:self.infoDic andNumber:j];
                
            }else{
                NSLog(@"faild");
            }
            
        }
        
    }
    [SVProgressHUD dismiss];
    
}

- (void)saveDownloadAudio:(NSDictionary *)infoDic andNumber:(int )j
{
    NSMutableDictionary * audioDic = [NSMutableDictionary dictionary];
    [audioDic setObject:[infoDic objectForKey:kProductName] forKey:kAudioName];
    [audioDic setObject:[NSString stringWithFormat:@"%@-%d", [infoDic objectForKey:kpartName],j] forKey:kAudioId];
    [audioDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioDic setObject:@(j) forKey:@"number"];
    [[DBManager sharedManager] saveDownloadAudioInfo:audioDic];
    
    NSMutableDictionary * audioListDic = [NSMutableDictionary dictionary];
    [audioListDic setObject:[infoDic objectForKey:kProductName] forKey:kpartName];
    [audioListDic setObject:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kProductId]] forKey:kpartId];
    [audioListDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioListDic setObject:@(DownloadAudioType_read) forKey:@"type"];
    [[DBManager sharedManager] saveDownloadAudioListInfo:audioListDic];
}

// 录音作品
- (void)didRequestMyRecordProductDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    self.infoDic = infoDic;
    self.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
    self.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    
    self.recordPageList = [[self.infoDic objectForKey:@"pageList"] componentsSeparatedByString:@","];
    self.recordPointList = [[self.infoDic objectForKey:@"pointList"] componentsSeparatedByString:@","];
    
    [self refreshScroll];
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
    [SVProgressHUD dismiss];
    FlowerView * starView = [[FlowerView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:starView];
    [SVProgressHUD dismiss];
    
    NSString * flowerStr = [NSString stringWithFormat:@"红花： %@",[[[UserManager sharedManager] getShareMyproductInfo] objectForKey:@"flowerNum"] ];
    CGSize flowerLBSize = [flowerStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.flowerLB.text = flowerStr;
    self.flowerLB.frame = CGRectMake(15, self.flowerLB.hd_y, flowerLBSize.width, 20);
    self.flowerImageView.frame = CGRectMake(CGRectGetMaxX(self.flowerLB.frame) + 5, self.flowerLB.hd_y, 20, 20);
}

- (void)didRequestShareMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 查看录音点评
- (void)playRecoreComment
{
    if (self.playRecordTimer) {
        [self.playRecordTimer invalidate];
        self.playRecordTimer = nil;
        self.currentPlayRecordTime = 0.0;
        self.currentPlayRecordPage = 0;
    }
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    if ([[RecordTool sharedInstance] isRecording]) {
        [[RecordTool sharedInstance] stopRecordVoice];
    }
    
    self.playOriginOrRecordType = PlayOriginOrRecordType_mp3Review;
    [[BTVoicePlayer share] playLine:[self.infoDic objectForKey:kmp3Review]];
    
}

- (void)modifyProduct
{
    __weak typeof(self)weakSelf = self;
    CreateProductionViewController * createVc = [[CreateProductionViewController alloc]init];
    createVc.model = self.model;
    createVc.productId = [[self.infoDic objectForKey:kProductId] intValue];
    
    createVc.modifyProductSuccessBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.isModifySuccess = isSuccess;
            [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[weakSelf.infoDic objectForKey:kProductId]} withNotifiedObject:weakSelf];
        }
    };
    
    [self presentViewController:createVc animated:NO completion:nil];
}

- (void)showTextCommentView
{
    NSLog(@"%@", self.infoDic);
    if (!self.textCommentView) {
        self.textCommentView = [[TextCommentView alloc]initWithFrame:self.view.bounds];
    }
    [self.view addSubview:self.textCommentView];
    [self.textCommentView resetUIWith:self.infoDic];
    
    if ([[UserManager sharedManager] getUserType] == 1) {
        [self.textCommentView limitClick];
    }
    
    __weak typeof(self)weakSelf = self;
    self.textCommentView.updataCommentBlock = ^(NSDictionary *infoDic) {
        [weakSelf commenttipAction:infoDic];
    };
    self.textCommentView.commentModulBlock = ^(NSDictionary *infoDic) {
        [weakSelf presntCommentModulVC];
    };
    self.textCommentView.storeCommentModulBlock = ^(NSDictionary *infoDic) {
        NSLog(@"%@", infoDic);
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_addTextToCommentModulWithDic:@{@"content":[infoDic objectForKey:@"content"]} withNotifiedObject:weakSelf];
    };
}

- (void)showPraiseAndFlowerView
{
    __weak typeof(self)weakSelf = self;
    PraiseAndFlowerView * praiseView = [[PraiseAndFlowerView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:praiseView];
    praiseView.praiseBlock = ^(NSString *flowerCount) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_PriseAndflowerWithDic:@{kProductId:[weakSelf.infoDic objectForKey:kProductId], kflowerNum:@(flowerCount.intValue)} withNotifiedObject:weakSelf];
    };
}

- (void)didRequestTeacher_PriseAndflowerSuccessed
{
    [SVProgressHUD dismiss];
}

- (void)didRequestTeacher_PriseAndflowerFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)commenttipAction:(NSDictionary *)infoDic
{
    NSLog(@"%@", self.infoDic);
    
    if ([[self.infoDic objectForKey:@"textReview"] length] > 0 || [[self.infoDic objectForKey:@"score"] intValue] > 0) {
        __weak typeof(self)weakSelf = self;
        ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"提示" withAnimation:NO];
        __weak typeof(toolView)weakView = toolView;
        [toolView resetContentLbTetx:@"已有点评，确认覆盖提交？"];
        [self.view addSubview:toolView];
        toolView.DismissBlock = ^{
            
            [weakView removeFromSuperview];
            [weakSelf.textCommentView removeFromSuperview];
        };
        toolView.ContinueBlock = ^(NSString *str) {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_commentTaskWithWithDic:@{kProductId:[self.infoDic objectForKey:kProductId],kuserWorkId:[self.infoDic objectForKey:kuserWorkId],ktextReview:[infoDic objectForKey:@"comment"],kscore:[infoDic objectForKey:@"score"],kmp3Review:@""} withNotifiedObject:self];
            [weakView removeFromSuperview];
            [weakSelf.textCommentView removeFromSuperview];
        };
    }else
    {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_commentTaskWithWithDic:@{kProductId:[self.infoDic objectForKey:kProductId],kuserWorkId:[self.infoDic objectForKey:kuserWorkId],ktextReview:[infoDic objectForKey:@"comment"],kscore:[infoDic objectForKey:@"score"],kmp3Review:@""} withNotifiedObject:self];
        [self.textCommentView removeFromSuperview];
    }
}

- (NSString *)getUploadMp3UrlStr:(NSString *)mp3Str
{
    NSString * str;
    if ([mp3Str containsString:@"http://qst.kjjl100.com"]) {
        str = [mp3Str stringByReplacingOccurrencesOfString:@"http://qst.kjjl100.com" withString:@""];
    }else
    {
        str = mp3Str;
    }
    return str;
}

- (void)uploadMp3Review
{
    __weak typeof(self)weakSelf = self;
    
    if ([RecordTool sharedInstance].savePath.length > 0) {
        
        NSMutableArray *pageRecordArray = [NSMutableArray array];
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = @"录音点评";
        picModel.url = [RecordTool sharedInstance].savePath;
        [pageRecordArray addObject:picModel];
        
        [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andMP3Array:pageRecordArray progress:^(NSProgress * _Nullable progress) {
            [SVProgressHUD showProgress:progress.fractionCompleted];
        } success:^(id  _Nonnull responseObject) {
            [SVProgressHUD dismiss];
            
            NSLog(@"[responseObject class] = %@", [responseObject class]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    weakSelf.recordIntroUrl = jsonStr;
                }else
                {
                    jsonStr = @"";
                }
                
                int score = 0;
                if ([self.infoDic objectForKey:@"score"] != nil) {
                    score = [[self.infoDic objectForKey:@"score"] intValue];
                }
                
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestTeacher_commentTaskWithWithDic:@{kProductId:[self.infoDic objectForKey:kProductId],kuserWorkId:[self.infoDic objectForKey:kuserWorkId],ktextReview:@"",kscore:@(score),kmp3Review:jsonStr} withNotifiedObject:self];
            });
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            
        }];
    }else
    {
        self.recordIntroUrl = @"";
    }
}


- (void)presntCommentModulVC
{
    __weak typeof(self)weakSelf = self;
    CommentModulViewController * vc = [[CommentModulViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    vc.selectCommentModulBlock = ^(NSDictionary *infoDic) {
        [weakSelf.textCommentView resetCommentContent:[infoDic objectForKey:@"content"]];
    };
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    
    switch (self.commentTaskType) {
        case CommentTaskType_nomal:
            {
                [self.dataArray addObject:@{@"title":@"文字点评"}];
                [self.dataArray addObject:@{@"title":@"语音点评"}];
                [self.dataArray addObject:@{@"title":@"收听点评"}];
                [self.dataArray addObject:@{@"title":@"发回重做"}];
                [self.dataArray addObject:@{@"title":@"点赞送花"}];
            }
            break;
        case CommentTaskType_teacherLookStudent:
        {
            [self.dataArray addObject:@{@"title":@"文字点评"}];
            [self.dataArray addObject:@{@"title":@"语音点评"}];
            [self.dataArray addObject:@{@"title":@"收听点评"}];
            [self.dataArray addObject:@{@"title":@"点赞送花"}];
        }
            break;
        case CommentTaskType_teacherLookTeacherOrStar:
        {
            // 无操作
        }
            break;
        case CommentTaskType_studentLookStudent:
        {
            [self.dataArray addObject:@{@"title":@"查看点评"}];
            [self.dataArray addObject:@{@"title":@"收听点评"}];
            [self.dataArray addObject:@{@"title":@"点赞送花"}];
        }
            break;
        case CommentTaskType_studentLookStarProduct:
        {
            // 无操作
        }
            break;
        case CommentTaskType_studentLookTeacherProduct:
        {
            [self.dataArray addObject:@{@"title":@"点赞送花"}];
        }
            break;
        case CommentTaskType_studentLookSelf:
        {
            if (!self.isFromProductShow) {
                [self.dataArray addObject:@{@"title":@"查看点评"}];
                [self.dataArray addObject:@{@"title":@"收听点评"}];
                if ([[self.infoDic objectForKey:kuserWorkId] intValue] == 0) {
                    if (self.productType == ProductType_record) {
                        [self.dataArray addObject:@{@"title":@"重录"}];
                    }else
                    {
                        [self.dataArray addObject:@{@"title":@"修改"}];
                    }
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    if (self.taskType == TaskType_create || self.taskType == TaskType_video) {
        [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:[self.infoDic objectForKey:kmadeId]} withNotifiedObject:self];
    }
}

- (void)didRequestTextContentSuccessed
{
    [SVProgressHUD dismiss];
    LearnTextViewController * vc = [[LearnTextViewController alloc]init];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.infoDic];
    [mInfo setObject:[self.infoDic objectForKey:kitemId] forKey:kitemId];
    vc.infoDic = mInfo;
    vc.learntextType = LearnTextType_record;
    [self presentViewController:vc  animated:NO completion:nil];
}

- (void)didRequestTextContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyFriendProductDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:@(self.model.userWorkId) forKey:kuserWorkId];
    
    self.infoDic = infoDic;
    self.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    self.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    
    [self refreshScroll];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCreateTaskProblemContentSuccessed
{
    
}

- (void)didRequestCreateTaskProblemContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_commentTaskSuccessed
{
    [SVProgressHUD dismiss];
}

- (void)didRequestTeacher_commentTaskFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_addTextToCommentModulSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"存储模板成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_addTextToCommentModulFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
