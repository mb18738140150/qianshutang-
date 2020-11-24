//
//  NVSAudioCustomInputTask.h
//  nvs
//
//  Created by Simon Blue on 2018/8/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVSAudioCustomInputTask : NSObject

//是否需要通过SDK播放
@property (nonatomic) BOOL needPlay;

//是否需要通过SDK发送
@property (nonatomic) BOOL needSend;

//采样率
@property (nonatomic) Float64 sampleRate;


- (BOOL)isValid;
@end
