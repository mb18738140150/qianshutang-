//
//  PlayAudioViewController.m
//  qianshutang
//
//  Created by aaa on 2018/9/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PlayAudioViewController.h"

@interface PlayAudioViewController ()<ChangeMusicProtocol>

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIButton * backBtn;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton *playBtn;

@property (nonatomic, strong)UILabel * currentTimeLB;
@property (nonatomic, strong)UILabel * totalTimeLB;
@property (nonatomic, strong)UISlider * pregressSlider;

@property (nonatomic, strong)CABasicAnimation *animation;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, assign)BOOL isOver;

@end

@implementation PlayAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadData];
    
    self.backView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.backView.backgroundColor = UIRGBColor(246, 125, 89);
    [self.view addSubview:self.backView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.backBtn setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.5 - 100, 5, 200, self.backBtn.hd_height)];
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [self.infoDic objectForKey:kpartName];
    self.titleLB.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.titleLB];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenHeight * 0.6) / 2, self.backBtn.hd_height, kScreenHeight * 0.6, kScreenHeight * 0.6)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:0] objectForKey:kImgSrc]] placeholderImage:[UIImage imageNamed:@"icon_orange_circle"]];
    [self.view addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = self.iconImageView.hd_height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 2;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                                   //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
                                   animation.fromValue = [NSNumber numberWithFloat:0.f];
                                   animation.toValue = [NSNumber numberWithFloat: M_PI *2];
                                   animation.duration = 10;
                                   animation.autoreverses = NO;
                                   animation.fillMode = kCAFillModeForwards;
                                   animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    self.animation = animation;
    
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + kScreenHeight / 24, kScreenHeight / 12, kScreenHeight / 12 );
    self.playBtn.hd_centerX = kScreenWidth / 2;
    [self.playBtn setImage:[UIImage imageNamed:@"icon_suspended_white"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play_white"] forState:UIControlStateSelected];
    [self.view addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.playBtn.frame) + kScreenHeight / 24, 65, 15)];
    self.currentTimeLB.textAlignment = NSTextAlignmentRight;
    self.currentTimeLB.textColor = UIColorFromRGB(0xffffff);
    self.currentTimeLB.text = @"00:00";
    self.currentTimeLB.font = kMainFont;
    [self.view addSubview:self.currentTimeLB];
    
    self.totalTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 115, CGRectGetMaxY(self.playBtn.frame) + kScreenHeight / 24, 65, 15)];
    self.totalTimeLB.textColor = UIColorFromRGB(0xffffff);
    self.totalTimeLB.text = @"00:00";
    self.totalTimeLB.font = kMainFont;
    [self.view addSubview:self.totalTimeLB];
    
    self.pregressSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentTimeLB.frame) + 5, self.currentTimeLB.hd_centerY - 5, kScreenWidth - 230 - 10, 10)];
    [self.pregressSlider setMinimumTrackTintColor:UIRGBColor(255, 199, 74)];
    [self.pregressSlider setMaximumTrackTintColor:[UIColor whiteColor]];
    [self.pregressSlider setThumbTintColor:UIRGBColor(255, 199, 74)];
    [self.pregressSlider setThumbImage:[UIImage imageNamed:@"icon_schedule"] forState:UIControlStateNormal];
    [self.pregressSlider setThumbImage:[UIImage imageNamed:@"icon_schedule"] forState:UIControlStateHighlighted];
    [self.pregressSlider setMinimumTrackImage:[UIImage imageNamed:@"progress_bar_yellow"] forState:UIControlStateNormal];
    [self.pregressSlider setMaximumTrackImage:[UIImage imageNamed:@"progress_bar_white"] forState:UIControlStateNormal];
    
    
    self.pregressSlider.maximumValue = 1;
    [self.pregressSlider addTarget:self action:@selector(pregressAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pregressSlider];
    
    [BTVoicePlayer share].delegate = self;
    __weak typeof(self)weakSelf = self;
    [BTVoicePlayer share].getMusicLengthBlock = ^(NSString *lengthStr) {
        weakSelf.totalTimeLB.text = lengthStr;
    };
    [BTVoicePlayer share].getMusicProgressBlock = ^(NSDictionary *infoDic) {
        if (![weakSelf.iconImageView.layer animationForKey:@"animation"]) {
            [weakSelf.iconImageView.layer addAnimation:animation forKey:@"animation"];
        }
        weakSelf.pregressSlider.value = [[infoDic objectForKey:@"progress"] floatValue];
        weakSelf.totalTimeLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"totalTime"]];
//        weakSelf.currentTimeLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"currentTime"]];
        
        float currentTime = 0.0;
        
        currentTime += [[infoDic objectForKey:@"currentTime"] floatValue];
        
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
    
    NSDictionary * infoDic = self.dataArray[0];;
    
    NSString * audioID = [NSString stringWithFormat:@"%@-%d", [self.infoDic objectForKey:kpartName],0];
    NSMutableDictionary * mInfoDic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [mInfoDic setObject:audioID forKey:kAudioId];
    [[BTVoicePlayer share] play:[self getLocalFilePath:mInfoDic]];
    self.playBtn.selected = YES;
}

- (NSString *)getLocalFilePath:(NSDictionary *)audioInfo
{
    NSString*docDirPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString*filePath=[NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioInfo objectForKey:kAudioId]];
    return filePath;
}

- (void)reloadData
{
    NSMutableArray * dataArray = [NSMutableArray array];
    for (NSDictionary *infoDic in [[[UserManager sharedManager] getTextContentArray] objectForKey:@"data"]) {
        NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
        [mInfo setObject:[infoDic objectForKey:kpageIndex] forKey:kpageIndex];
        
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
    self.dataArray = dataArray;
}

- (void)pregressAction
{
    [[BTVoicePlayer share] seekToTime:self.pregressSlider.value];
}

- (void)playAction:(UIButton *)button
{
    if ([[BTVoicePlayer share] isPlaying]) {
        [self pasueAnimation];
        [[BTVoicePlayer share] pause];
        self.playBtn.selected = NO;
    }else
    {
        [self resumeAnimation];
        self.playBtn.selected = YES;
        if (self.isOver) {
            self.isOver = NO;
            NSDictionary * infoDic = self.dataArray[0];;
            [[BTVoicePlayer share] playLine:[infoDic objectForKey:kMP3Src]];
            self.currentTimeLB.text = @"00:00";
            self.pregressSlider.value = 0.0;
            [[BTVoicePlayer share] seekToTime:self.pregressSlider.value];
            
            return;
        }
        
        if ([[BTVoicePlayer share] isHavePlayContent]) {
            [[BTVoicePlayer share] playContinu];
            return;
        }
        NSDictionary * infoDic = self.dataArray[0];;
        [[BTVoicePlayer share] playLine:[infoDic objectForKey:kMP3Src]];
    }
}

- (void)pasueAnimation
{
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pasueTime = [self.iconImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.iconImageView.layer.timeOffset = pasueTime;
     //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    self.iconImageView.layer.speed = 0;
}

- (void)resumeAnimation {
    //1.将动画的时间偏移量作为暂停的时间点
    
    CFTimeInterval pauseTime = self.iconImageView.layer.timeOffset;
    
    //2.计算出开始时间
    
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [self.iconImageView.layer setTimeOffset:0];
    
    [self.iconImageView.layer setBeginTime:begin];
    
    self.iconImageView.layer.speed = 1;
    
}

- (void)changeMusic
{
    self.isOver = YES;
    [self pasueAnimation];
    [[BTVoicePlayer share] stop];
    self.playBtn.selected = NO;
}

- (void)backAction
{
    if ([[BTVoicePlayer share] isPlaying]) {
        [[BTVoicePlayer share] stop];
    }
    if ([[BTVoicePlayer share] isLocalPlaying]) {
        [[BTVoicePlayer share] localstop];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
