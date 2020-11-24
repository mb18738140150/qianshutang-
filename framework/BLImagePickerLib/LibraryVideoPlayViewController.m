//
//  LibraryVideoPlayViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "LibraryVideoPlayViewController.h"

@interface LibraryVideoPlayViewController ()
@property (nonatomic, strong)AVPlayer * player;
@property (nonatomic, strong)NSURL * url;
@property (nonatomic, strong)NSData * data;
@end

@implementation LibraryVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    UIView * backView = [[UIView alloc]initWithFrame:self.view.bounds];
//    backView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:backView];
    
    
    if (self.asset.mediaType == PHAssetMediaTypeVideo) {
    
        NSLog(@"video");
    }
    
    __weak typeof(self)weakSelf = self;
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;

        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:self.asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            
            NSLog(@"%d", weakSelf.asset.duration);
            
            weakSelf.url = urlAsset.URL;
//            NSData *data = [NSData dataWithContentsOfURL:urlAsset.URL];
//            weakSelf.data = data;
//            NSLog(@"%@",data);
            
            [weakSelf prepareUI];
        }];
    
}

- (void)prepareUI
{
    //1 创建AVPlayerItem
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:self.url];
    
    //2.把AVPlayerItem放在AVPlayer上
    AVPlayer * player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
    self.player = player;
    //3 再把AVPlayer放到 AVPlayerLayer上
    AVPlayerLayer *avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    avplayerLayer.frame = CGRectMake(kScreenWidth * 0.375, 0, kScreenWidth * 0.25 , kScreenHeight);
    
    //4 最后把 AVPlayerLayer放到self.view.layer上(也就是需要放置的视图的layer层上)
    [self.view.layer addSublayer:avplayerLayer];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight *0.8, kScreenWidth, kScreenHeight * 0.2)];
    bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self.view addSubview:bottomView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20, 0, 50, bottomView.hd_height);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:cancelBtn];
    
    /**
     *   视频播放按钮
     */
    UIButton *bofang = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 15, bottomView.hd_height / 2 - 15, 30, 30)];
    //    [bofang setTitle:@"播放" forState:UIControlStateNormal];
    [bofang setImage:[UIImage imageNamed:@"arrows_up_green"] forState:UIControlStateNormal];
    [bofang setImage:[UIImage imageNamed:@"listen_suspend_icon"] forState:UIControlStateSelected];
    [bofang setBackgroundColor:[UIColor brownColor]];
    [bofang addTarget:self action:@selector(bofang:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview: bofang];
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(kScreenWidth - 70, 0, 50, bottomView.hd_height);
    [selectBtn setTitle:@"选取" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:selectBtn];
    
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn addTarget:self action:@selector(selectAction ) forControlEvents:UIControlEventTouchUpInside];
}

-(void)bofang:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        [self.player play];
    }else
    {
        [self.player pause];
    }
}


- (void)cancelAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)selectAction
{
    if (self.SelectBlock) {
        self.SelectBlock();
    }
    [self dismissViewControllerAnimated:NO completion:nil];
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
