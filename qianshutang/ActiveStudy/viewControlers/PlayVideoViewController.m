//
//  PlayVideoViewController.m
//  qianshutang
//
//  Created by aaa on 2018/9/19.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()

@property (nonatomic, strong) ZXVideoPlayerController           *videoController;
@property (nonatomic,strong) ZXVideo                            *playingVideo;

@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self playVideo:self.infoDic];
    
}

#pragma mark - playVideo
- (void)playVideo:(NSDictionary * )videoInfo
{
    self.playingVideo = [[ZXVideo alloc] init];
    self.playingVideo.playUrl = [videoInfo objectForKey:@"mp4Src"];
    self.playingVideo.title = [videoInfo objectForKey:kpartName];
    
    if (self.videoController) {
        [self.videoController changePlayer];
    }
    self.videoController = [[ZXVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.playingVideo.playTime = 0;
    self.videoController.video = self.playingVideo;
    
    __weak typeof(self) weakSelf = self;
    self.videoController.videoPlayerGoBackBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.videoController stop];
        strongSelf.videoController = nil;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"ZXVideoPlayer_DidLockScreen"];
        
    };
    self.videoController.videoPlayerGoBackWithPlayTimeBlock = ^(double time){
        [SoftManager shareSoftManager].isCamera = NO;
    };
    
    self.videoController.informalBlock = ^{
        
    };
    [SoftManager shareSoftManager].isCamera = YES;
    [self.videoController showInView:self.view];
    
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
