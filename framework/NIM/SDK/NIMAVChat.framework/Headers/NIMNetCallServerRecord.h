//
//  NIMNetCallServerRecord.h
//  NIMAVChat
//
//  Created by fanghe's mac on 2018/8/13.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMAVChatDefs.h"

/**
 * 服务端录制参数
 */
@interface NIMNetCallServerRecord : NSObject <NSCopying>

/**
 *  启用服务器录制音频 (该开关仅在服务器开启录制功能时才有效)，代表是否会有音频文件AAC生成
 */
@property (nonatomic, assign) BOOL enableServerAudioRecording;

/**
 *  启用服务器录制视频 (该开关仅在服务器开启录制功能时才有效)，代表是否会有视频文件MP4生成
 */
@property (nonatomic, assign) BOOL enableServerVideoRecording;

/**
 *  录制模式，0：参与混合录制也录制单人文件 1：参与混合录制 2：只录制单人文件
 */
@property (nonatomic, assign) NIMNetCallServerRecordMode  serverRecordingMode;

/**
 *  是否为录制主讲人, 视频画面作为主画面的那个人称为录制主讲人
 */
@property (nonatomic, assign) BOOL enableServerHostRecording;

@end
