//
//  LibraryVideoPlayViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface LibraryVideoPlayViewController : BasicViewController

@property (nonatomic, strong)PHAsset * asset;
@property (nonatomic, copy)void(^SelectBlock)();

@end
