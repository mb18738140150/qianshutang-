//
//  MoerduoView.m
//  qianshutang
//
//  Created by aaa on 2018/7/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MoerduoView.h"
#import "MusicTableViewCell.h"
#define kMusicCellID   @"musicCellID"

#import "AddMusicCategoryViewController.h"

#import "ToolTipView.h"

typedef enum : NSUInteger {
    CircleType_all,
    CircleType_one,
} CircleType;

@interface MoerduoView ()<ChangeMusicProtocol>

@property (nonatomic, assign)BOOL isClean;// 是否清空
@property (nonatomic, assign)CircleType circletype;

@property (nonatomic, strong)NSIndexPath * selectIndexpath;

@property (nonatomic, assign)int currentPartIndex;
@end


@implementation MoerduoView

- (NSMutableArray *)musicList
{
    if (!_musicList) {
        _musicList = [NSMutableArray array];
    }
    return _musicList;
}

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)audioList
{
    if (self = [super initWithFrame:frame]) {
        
        [self.musicList removeAllObjects];
        for (NSDictionary * info in audioList) {
            NSMutableDictionary * minfo = [[NSMutableDictionary alloc]initWithDictionary:info];
            [minfo setObject:[info objectForKey:kpartName] forKey:@"title"];
            [self.musicList addObject:minfo];
        }
        [BTVoicePlayer share].delegate = self;
        [self prepareTaskUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
        [BTVoicePlayer share].delegate = self;
    }
    return self;
}

- (void)prepareTaskUI
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    NSLog(@"****");
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 320, kScreenHeight)];
    leftView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self addSubview:leftView];
    
    UITapGestureRecognizer * dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [leftView addGestureRecognizer:dismissTap];
    
    self.playBackView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 320, 0, 320, kScreenHeight)];
    self.playBackView.backgroundColor = UIRGBColor(255, 251, 244);
    [self addSubview:self.playBackView];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.backImageView.image = [UIImage imageNamed:@"listen_bg_image"];
    [self.playBackView addSubview:self.backImageView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(self.playBackView.hd_width / 2 - 25, 5, 50, 50);
    [self.playBtn setImage:[UIImage imageNamed:@"listen_play_btn"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"listen_suspend_btn"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.playBtn];
    
    self.previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(self.playBackView.hd_width / 2 - 90, self.playBtn.hd_centerY - 15, 30, 30);
    [self.previousBtn setImage:[UIImage imageNamed:@"listen_last_btn"] forState:UIControlStateNormal];
    [self.previousBtn addTarget:self action:@selector(previousAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.previousBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(self.playBackView.hd_width / 2 + 60, self.playBtn.hd_centerY - 15, 30, 30);
    [self.nextBtn setImage:[UIImage imageNamed:@"listen_next_btn"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.nextBtn];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playBtn.frame) + 10, self.playBackView.hd_width, 15)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x4a494c);
    self.titleLB.text = @"";
    self.titleLB.font = kMainFont;
    [self.playBackView addSubview:self.titleLB];
    
    self.unitTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 5, self.playBackView.hd_width, 15)];
    self.unitTitleLB.textAlignment = NSTextAlignmentCenter;
    self.unitTitleLB.textColor = UIColorFromRGB(0x4a494c);
    self.unitTitleLB.text = @"";
    self.unitTitleLB.font = kMainFont;
    [self.playBackView addSubview:self.unitTitleLB];
    
    self.currentTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.unitTitleLB.frame) + 10, 65, 15)];
    self.currentTimeLB.textAlignment = NSTextAlignmentRight;
    self.currentTimeLB.textColor = UIColorFromRGB(0x4a494c);
    self.currentTimeLB.text = @"00:00";
    self.currentTimeLB.font = kMainFont;
    [self.playBackView addSubview:self.currentTimeLB];
    
    self.totalTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.playBackView.hd_width - 70, CGRectGetMaxY(self.unitTitleLB.frame) + 10, 65, 15)];
    self.totalTimeLB.textAlignment = NSTextAlignmentRight;
    self.totalTimeLB.textColor = UIColorFromRGB(0x4a494c);
    self.totalTimeLB.text = @"00:00";
    self.totalTimeLB.font = kMainFont;
    [self.playBackView addSubview:self.totalTimeLB];
    
    self.pregressSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentTimeLB.frame) + 5, self.currentTimeLB.hd_centerY - 5, self.playBackView.hd_width - 140 - 10, 10)];
    [self.pregressSlider setMinimumTrackTintColor:UIRGBColor(255, 199, 74)];
    [self.pregressSlider setMaximumTrackTintColor:[UIColor whiteColor]];
    [self.pregressSlider setThumbTintColor:UIRGBColor(255, 199, 74)];
    self.pregressSlider.maximumValue = 1;
    [self.pregressSlider addTarget:self action:@selector(pregressAction) forControlEvents:UIControlEventValueChanged];
    [self.playBackView addSubview:self.pregressSlider];
//    self.pregressSlider.enabled = NO;
    
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.playBackView.hd_width / 2, CGRectGetMaxX(self.backImageView.frame) + 10, 1, 20)];
    seperateLine.backgroundColor = kMainColor;
    [self.playBackView addSubview:seperateLine];
    
    self.playListtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backImageView.frame), self.playBackView.hd_width, kScreenHeight - CGRectGetMaxY(self.backImageView.frame) - 40) style:UITableViewStylePlain];
    self.playListtableView.delegate = self;
    self.playListtableView.dataSource = self;
    [self.playBackView addSubview:self.playListtableView];
    [self.playListtableView registerClass:[MusicTableViewCell class] forCellReuseIdentifier:kMusicCellID];
    [self.playListtableView reloadData];
    self.playListtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.playListtableView reloadData];

    self.circletype = CircleType_all;
    
    self.circleTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleTypeBtn.frame = CGRectMake(0, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width, 40);
    [self.circleTypeBtn setImage:[UIImage imageNamed:@"circ_all"] forState:UIControlStateNormal];
    [self.circleTypeBtn setImage:[UIImage imageNamed:@"circ_one"] forState:UIControlStateSelected];
    [self.circleTypeBtn setTitle:@"列表循环" forState:UIControlStateNormal];
    [self.circleTypeBtn setTitle:@"单曲循环" forState:UIControlStateSelected];
    [self.circleTypeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.playBackView addSubview:self.circleTypeBtn];
    [self.circleTypeBtn addTarget:self action:@selector(changeCircleTypeAction) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self)weakSelf = self;
    [BTVoicePlayer share].getMusicLengthBlock = ^(NSString *lengthStr) {
        weakSelf.totalTimeLB.text = lengthStr;
    };
    [BTVoicePlayer share].getMusicProgressBlock = ^(NSDictionary *infoDic) {
        
        MusicTableViewCell * cell = [weakSelf.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.selectIndexpath.row inSection:0]];
        
        
        float currentTime = 0.0;
        for (int i = 0; i < self.currentPartIndex; i++) {
            currentTime += [[cell.timeLengthArray objectAtIndex:i] floatValue];
        }
        currentTime += [[infoDic objectForKey:@"currentTime"] floatValue];
        
        weakSelf.pregressSlider.value = currentTime / (cell.totalTimeLength * 1.0);
        int min = (int)currentTime / 60;
        int sec = (int)currentTime % 60;
        
        NSString * minStr = @"";
        NSString * secStr = @"";
        if (min > 9) {
            minStr = [NSString stringWithFormat:@"%d", min];
        }else
        {
            minStr = [NSString stringWithFormat:@"0%d", min];
        }
        if (sec > 9) {
            secStr = [NSString stringWithFormat:@"%d", sec];
        }else
        {
            secStr = [NSString stringWithFormat:@"0%d", sec];
        }
        
        weakSelf.currentTimeLB.text = [NSString stringWithFormat:@"%@:%@", minStr,secStr];
    };
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    NSLog(@"****");
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 320, kScreenHeight)];
    leftView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self addSubview:leftView];
    
    UITapGestureRecognizer * dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction)];
    [leftView addGestureRecognizer:dismissTap];
    
    [self reloadDate];
    
    self.playBackView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 320, 0, 320, kScreenHeight)];
    self.playBackView.backgroundColor = UIRGBColor(255, 251, 244);
    [self addSubview:self.playBackView];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.backImageView.image = [UIImage imageNamed:@"listen_bg_image"];
    [self.playBackView addSubview:self.backImageView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(self.playBackView.hd_width / 2 - 25, 5, 50, 50);
    [self.playBtn setImage:[UIImage imageNamed:@"listen_play_btn"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"listen_suspend_btn"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.playBtn];
    
    self.previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(self.playBackView.hd_width / 2 - 90, self.playBtn.hd_centerY - 15, 30, 30);
    [self.previousBtn setImage:[UIImage imageNamed:@"listen_last_btn"] forState:UIControlStateNormal];
    [self.previousBtn addTarget:self action:@selector(previousAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.previousBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(self.playBackView.hd_width / 2 + 60, self.playBtn.hd_centerY - 15, 30, 30);
    [self.nextBtn setImage:[UIImage imageNamed:@"listen_next_btn"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBackView addSubview:self.nextBtn];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playBtn.frame) + 10, self.playBackView.hd_width, 15)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = UIColorFromRGB(0x4a494c);
    self.titleLB.text = @"";
    self.titleLB.font = kMainFont;
    [self.playBackView addSubview:self.titleLB];
    
    self.unitTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLB.frame) + 5, self.playBackView.hd_width, 15)];
    self.unitTitleLB.textAlignment = NSTextAlignmentCenter;
    self.unitTitleLB.textColor = UIColorFromRGB(0x4a494c);
    self.unitTitleLB.text = @"";
    if (self.musicList.count == 0) {
        self.unitTitleLB.text = @"请点击 “添加” 按钮选择磨耳朵内容";
    }
    self.unitTitleLB.font = kMainFont;
    [self.playBackView addSubview:self.unitTitleLB];
    
    self.currentTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.unitTitleLB.frame) + 10, 65, 15)];
    self.currentTimeLB.textAlignment = NSTextAlignmentRight;
    self.currentTimeLB.textColor = UIColorFromRGB(0x4a494c);
    self.currentTimeLB.text = @"00:00";
    self.currentTimeLB.font = kMainFont;
    [self.playBackView addSubview:self.currentTimeLB];
    
    self.totalTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(self.playBackView.hd_width - 70, CGRectGetMaxY(self.unitTitleLB.frame) + 10, 65, 15)];
    self.totalTimeLB.textAlignment = NSTextAlignmentRight;
    self.totalTimeLB.textColor = UIColorFromRGB(0x4a494c);
    self.totalTimeLB.text = @"00:00";
    self.totalTimeLB.font = kMainFont;
    [self.playBackView addSubview:self.totalTimeLB];
    
    self.pregressSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentTimeLB.frame) + 5, self.currentTimeLB.hd_centerY - 5, self.playBackView.hd_width - 140 - 10, 10)];
    [self.pregressSlider setMinimumTrackTintColor:UIRGBColor(255, 199, 74)];
    [self.pregressSlider setMaximumTrackTintColor:[UIColor whiteColor]];
    [self.pregressSlider setThumbTintColor:UIRGBColor(255, 199, 74)];
    self.pregressSlider.maximumValue = 1;
    [self.pregressSlider addTarget:self action:@selector(pregressAction) forControlEvents:UIControlEventValueChanged];
    [self.playBackView addSubview:self.pregressSlider];
    self.pregressSlider.enabled = NO;
    
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.playBackView.hd_width / 2, CGRectGetMaxY(self.backImageView.frame) + 10, 1, 20)];
    seperateLine.backgroundColor = kMainColor;
    [self.playBackView addSubview:seperateLine];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(0, CGRectGetMaxY(self.backImageView.frame), self.playBackView.hd_width / 2 - 1, 40);
    [self.addBtn setImage:[UIImage imageNamed:@"listen_add_icon"] forState:UIControlStateNormal];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.addBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.playBackView addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addMusicAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.timerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timerBtn.frame = CGRectMake(self.playBackView.hd_width / 2 + 1, CGRectGetMaxY(self.backImageView.frame), self.playBackView.hd_width / 2 - 1, 40);
    [self.timerBtn setImage:[UIImage imageNamed:@"listen_time_icon"] forState:UIControlStateNormal];
    [self.timerBtn setTitle:@"定时" forState:UIControlStateNormal];
    self.timerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.timerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.timerBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.playBackView addSubview:self.timerBtn];
    [self.timerBtn addTarget:self action:@selector(timerAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.playListtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addBtn.frame), self.playBackView.hd_width, kScreenHeight - CGRectGetMaxY(self.addBtn.frame) - 40) style:UITableViewStylePlain];
    self.playListtableView.delegate = self;
    self.playListtableView.dataSource = self;
    [self.playBackView addSubview:self.playListtableView];
    [self.playListtableView registerClass:[MusicTableViewCell class] forCellReuseIdentifier:kMusicCellID];
    [self.playListtableView reloadData];
    self.playListtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.circletype = CircleType_all;
    
    self.circleTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleTypeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width / 3, 40);
    [self.circleTypeBtn setImage:[UIImage imageNamed:@"circ_all"] forState:UIControlStateNormal];
    [self.circleTypeBtn setImage:[UIImage imageNamed:@"circ_one"] forState:UIControlStateSelected];
    [self.circleTypeBtn setTitle:@"列表循环" forState:UIControlStateNormal];
    [self.circleTypeBtn setTitle:@"单曲循环" forState:UIControlStateSelected];
    [self.circleTypeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.circleTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.circleTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.playBackView addSubview:self.circleTypeBtn];
    [self.circleTypeBtn addTarget:self action:@selector(changeCircleTypeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.isClean = NO;
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.playBackView.hd_width / 3* 2, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width / 3, 40);
    [self.deleteBtn setImage:[UIImage imageNamed:@"listen_delete"] forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.playBackView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteMusicAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(self.playBackView.hd_width / 3 * 2, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width / 3, 40);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.cancelBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.playBackView addSubview:self.cancelBtn];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn.hidden = YES;
    
    __weak typeof(self)weakSelf = self;
    [BTVoicePlayer share].getMusicLengthBlock = ^(NSString *lengthStr) {
        weakSelf.totalTimeLB.text = lengthStr;
    };
    [BTVoicePlayer share].getMusicProgressBlock = ^(NSDictionary *infoDic) {
        
        MusicTableViewCell * cell = [weakSelf.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.selectIndexpath.row inSection:0]];
        
        
        float currentTime = 0.0;
        for (int i = 0; i < self.currentPartIndex; i++) {
            currentTime += [[cell.timeLengthArray objectAtIndex:i] floatValue];
        }
        currentTime += [[infoDic objectForKey:@"currentTime"] floatValue];
        
        weakSelf.pregressSlider.value = currentTime / (cell.totalTimeLength * 1.0);
        int min = (int)currentTime / 60;
        int sec = (int)currentTime % 60;
        
        NSString * minStr = @"";
        NSString * secStr = @"";
        if (min > 9) {
            minStr = [NSString stringWithFormat:@"%d", min];
        }else
        {
            minStr = [NSString stringWithFormat:@"0%d", min];
        }
        if (sec > 9) {
            secStr = [NSString stringWithFormat:@"%d", sec];
        }else
        {
            secStr = [NSString stringWithFormat:@"0%d", sec];
        }
        
        weakSelf.currentTimeLB.text = [NSString stringWithFormat:@"%@:%@", minStr,secStr];
    };
}

- (void)refreshUI
{
    [self reloadDate];
    [self.playListtableView reloadData];
}

- (void)reloadDate
{
    self.selectIndexpath = nil;
    
    self.musicList = [NSMutableArray array];
    
    for (NSDictionary * infoDic in [[DBManager sharedManager] getMoerduoDownloadAudioList:@{kUserId:@([[UserManager sharedManager] getUserId]),@"type":@(DownloadAudioType_moerduo)}]) {
        NSMutableDictionary * mInfo= [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:kpartName] forKey:@"title"];
        [self.musicList addObject:mInfo];
    }
}

- (void)dismissAction
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

// 添加播放列表
- (void)addMusicAction
{
    if (self.AddMusicBlock) {
        self.AddMusicBlock();
    }
}

// 定时
- (void)timerAction
{
    ToolTipView * tooltipView = [[ToolTipView alloc]initWithFrame:self.bounds andType:ToolTipTye_timer andTitle:@"本次播放时长定为" withAnimation:YES];
    [self addSubview:tooltipView];
    
    __weak typeof(tooltipView)weakToolView = tooltipView;
    tooltipView.DismissBlock = ^{
        [weakToolView removeFromSuperview];
    };
    tooltipView.TimerTypeBlock = ^(TimerType type, int time) {
        [weakToolView removeFromSuperview];
    };
    
}

// 删除
- (void)deleteMusicAction
{
    if (self.isClean) {
        // 清空
        NSLog(@"clean list");
        [self.musicList removeAllObjects];
        
        NSArray * audioList = [[DBManager sharedManager]getMoerduoDownloadAudioList:@{kUserId:@([[UserManager sharedManager] getUserId]),@"type":@(DownloadAudioType_moerduo)}];
        
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
        [[DBManager sharedManager] deleteMoerduoAllAudioList:@{kUserId:@([[UserManager sharedManager] getUserId]),@"type":@(DownloadAudioType_moerduo)}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshUI];
            [self.playListtableView reloadData];
        });
    }else
    {
        // 删除
        NSLog(@"delete cell");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.deleteBtn.frame = CGRectMake(self.playBackView.hd_width / 3 + 20, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width / 3, 40);
            [self.deleteBtn setTitle:@"清空" forState:UIControlStateNormal];
        });
        self.isClean = YES;
        self.cancelBtn.hidden = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playListtableView reloadData];
        });
    }
}

// 取消
- (void)cancelAction
{
    NSLog(@"cancel ");
    self.isClean = NO;
    self.cancelBtn.hidden = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.deleteBtn.frame = CGRectMake(self.playBackView.hd_width / 3 * 2, CGRectGetMaxY(self.playListtableView.frame), self.playBackView.hd_width / 3, 40);
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.playListtableView reloadData];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMusicCellID forIndexPath:indexPath];
    cell.isTask = self.isTask;
    [cell resetWith:self.musicList[indexPath.row]];
    cell.numberLB.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    if (indexPath.row == self.selectIndexpath.row) {
        if (self.isTask) {
            [cell selectReset:[[BTVoicePlayer share] isPlaying]];
        }else
        {
          [cell selectReset:[[BTVoicePlayer share] isLocalPlaying]];
        }
        
    }
    if (self.isClean) {
        [cell deleteReset];
    }
    
    __weak typeof(self)weakSelf = self;
    cell.deleteMusicBlock = ^(NSDictionary *infoDic) {
        NSDictionary * deleteInfo;
        
        NSArray * audioArray = [[DBManager sharedManager] getDownloadAudioInfosWith:infoDic];
        
        for (NSDictionary * audioInfo in audioArray) {
            
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //设置保存路径和生成文件名
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioInfo objectForKey:kAudioId]];
            //保存
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
        }
        
        [[DBManager sharedManager] deleteMoerduoAudioListWith:infoDic];
        [[DBManager sharedManager] deleteAudioWith:@{kAudioName:[infoDic objectForKey:kpartName], kUserId:[infoDic objectForKey:kUserId]}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf refreshUI];
            [weakSelf.playListtableView reloadData];
        });
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectIndexpath isEqual:indexPath]) {
        if (self.isTask) {
            
            if ([[BTVoicePlayer share] isPlaying]) {
                [[BTVoicePlayer share] pause];
            }else
            {
                [[BTVoicePlayer share] playContinu];
            }
            self.playBtn.selected = [[BTVoicePlayer share] isPlaying];
        }else
        {
            if ([[BTVoicePlayer share] isLocalPlaying]) {
                [[BTVoicePlayer share] localpause];
            }else
            {
                [[BTVoicePlayer share] playLocalContinu];
            }
            self.playBtn.selected = [[BTVoicePlayer share] isLocalPlaying];

        }
        [self.playListtableView reloadData];
        return;
    }
    self.selectIndexpath = indexPath;
    
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    
    self.currentPartIndex = 0;
    NSDictionary * infoDic = self.musicList[self.selectIndexpath.row];;
    
    self.unitTitleLB.text = [infoDic objectForKey:kpartName];
    MusicTableViewCell * cell = [self.playListtableView cellForRowAtIndexPath:self.selectIndexpath];
    self.totalTimeLB.text = cell.totalTimeLB.text;
    
    [self playMoerduoAudio:infoDic];
    
    self.playBtn.selected = YES;
    [self.playListtableView reloadData];
}

- (void)changeMusic
{
    NSDictionary * infoDic = self.musicList[self.selectIndexpath.row];;
    self.currentPartIndex++;
    [self playMoerduoAudio:infoDic];
}


- (void)pregressAction
{
    [[BTVoicePlayer share] seekToTime:self.pregressSlider.value];
}

#pragma mark - playMusic

// 播放&暂停
- (void)playAction:(UIButton *)button
{
    if (self.musicList.count <= 0) {
        return;
    }
    if (self.isTask) {
        if ([[BTVoicePlayer share] isPlaying]) {
            [[BTVoicePlayer share] pause];
            self.playBtn.selected = NO;
        }else
        {
            if ([[BTVoicePlayer share] isHavePlayContent]) {
                [[BTVoicePlayer share] playContinu];
                self.playBtn.selected = YES;
                [self.playListtableView reloadData];
                return;
            }
            NSDictionary * infoDic = self.musicList[self.selectIndexpath.row];;
            MusicTableViewCell * cell = [self.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndexpath.row inSection:0]];
            self.totalTimeLB.text = cell.totalTimeLB.text;
            [self playMoerduoAudio:infoDic];
            self.playBtn.selected = YES;
        }
    }else
    {
        if ([[BTVoicePlayer share] isLocalPlaying]) {
            [[BTVoicePlayer share] localpause];
            self.playBtn.selected = NO;
        }else
        {
            if ([[BTVoicePlayer share] isHaveLocalPlayerItem]) {
                [[BTVoicePlayer share] playLocalContinu];
                self.playBtn.selected = YES;
                [self.playListtableView reloadData];
                return;
            }
            NSDictionary * infoDic = self.musicList[self.selectIndexpath.row];;
            self.unitTitleLB.text = [infoDic objectForKey:kpartName];
            MusicTableViewCell * cell = [self.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndexpath.row inSection:0]];
            self.totalTimeLB.text = cell.totalTimeLB.text;
            
            [self playMoerduoAudio:infoDic];
            self.playBtn.selected = YES;
        }
    }
    [self.playListtableView reloadData];
}

- (void)playMoerduoAudio:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    if (self.isTask) {
        
//        [[BTVoicePlayer share] playLine:[infoDic objectForKey:@"url"]];
        NSLog(@"%@", infoDic);
        NSArray * currentAudioList = [infoDic objectForKey:@"partMp3List"];

        if (self.currentPartIndex < currentAudioList.count) {
            NSDictionary * audioInfo = [currentAudioList objectAtIndex:self.currentPartIndex];
            
            NSString * urlStr = [audioInfo objectForKey:@"mp3Url"];
            if ([urlStr containsString:kDomainName]) {
            }else
            {
                urlStr = [NSString stringWithFormat:@"%@%@",kDomainName, [audioInfo objectForKey:@"mp3Url"]];
            }
            
            [[BTVoicePlayer share] playLine:urlStr];
            
        }else
        {
            self.currentPartIndex = 0;
            [self nextAction:self.nextBtn];
            
            if (self.DoMoerduoTaskComplate) {
                self.DoMoerduoTaskComplate(infoDic);
            }
        }
        
    }else
    {
        NSArray * currentAudioList = [infoDic objectForKey:@"audioInfos"];
        if (self.currentPartIndex < currentAudioList.count) {
            NSDictionary * audioInfo = [currentAudioList objectAtIndex:self.currentPartIndex];
            NSString*docDirPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString*filePath=[NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioInfo objectForKey:kAudioId]];
            
            [[BTVoicePlayer share] play:filePath];
            
            [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
                weakSelf.currentPartIndex++;
                [weakSelf playMoerduoAudio:infoDic];
            }];
        }else
        {
            self.currentPartIndex = 0;
            [self nextAction:self.nextBtn];
        }
    }
}

// 上一曲
- (void)previousAction:(UIButton *)button
{
    
    if (self.musicList.count <= 0) {
        return;
    }
    NSDictionary * infoDic;
    if (self.circletype == CircleType_one) {
        infoDic = self.musicList[self.selectIndexpath.row];
        
        [self playMoerduoAudio:infoDic];
        return;
    }
    
    NSInteger i = self.selectIndexpath.row;
    if (self.selectIndexpath.row == 0) {
        i = self.musicList.count - 1;
        self.selectIndexpath = [NSIndexPath indexPathForRow:i inSection:0];
    }else
    {
        i--;
        self.selectIndexpath = [NSIndexPath indexPathForRow:i inSection:0];
    }
    infoDic = self.musicList[i];
    [self playMoerduoAudio:infoDic];
    
    MusicTableViewCell * cell = [self.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndexpath.row inSection:0]];
    self.totalTimeLB.text = cell.totalTimeLB.text;
    
    self.playBtn.selected = YES;
    [self.playListtableView reloadData];
}

// 下一曲
- (void)nextAction:(UIButton *)button
{
    if (self.musicList.count <= 0) {
        return;
    }
    NSDictionary * infoDic;
    if (self.circletype == CircleType_one) {
        infoDic = self.musicList[self.selectIndexpath.row];
        [self playMoerduoAudio:infoDic];
        
        return;
    }
    
    NSInteger i = self.selectIndexpath.row;
    if (self.selectIndexpath.row == self.musicList.count - 1) {
        i = 0;
        self.selectIndexpath = [NSIndexPath indexPathForRow:i inSection:0];
    }else
    {
        i++;
        self.selectIndexpath = [NSIndexPath indexPathForRow:i inSection:0];
    }
    infoDic = self.musicList[i];
    [self playMoerduoAudio:infoDic];
    
    MusicTableViewCell * cell = [self.playListtableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndexpath.row inSection:0]];
    self.totalTimeLB.text = cell.totalTimeLB.text;
    
    self.playBtn.selected = YES;
    [self.playListtableView reloadData];
}

// 播放模式
- (void)changeCircleTypeAction
{
    self.circleTypeBtn.selected = !self.circleTypeBtn.selected;
    if (self.circleTypeBtn.selected) {
        self.circletype = CircleType_one;
    }else
    {
        self.circletype = CircleType_all;
    }
}

@end
