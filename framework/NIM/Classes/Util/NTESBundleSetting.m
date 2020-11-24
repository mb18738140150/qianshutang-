//
//  NTESBundleSetting.m
//  NIM
//
//  Created by chris on 15/7/1.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESBundleSetting.h"

@implementation NTESBundleSetting

+ (instancetype)sharedConfig
{
    static NTESBundleSetting *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESBundleSetting alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if(self = [super init]) {
        [self checkSocks5DefaultSetting];
    }
    return self;
}

- (void)checkSocks5DefaultSetting {
    NSString *settingBundlePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSString *plistPath = [settingBundlePath stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *preferences = [plistDict valueForKey:@"PreferenceSpecifiers"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    for(NSDictionary *setting in preferences) {
        // 如果NSUserDefaults里有，则优先使用UserDefaults里的
        NSString *key = [setting valueForKey:@"Key"];
        
        if (key && key.length>0 && [key containsString:@"socks5"]) {
            // 从Plist中获取值填充
            id value = [setting valueForKey:@"DefaultValue"];
            if(value) {
                [userDefaults setObject:value forKey:key];
                NSLog(@"默认设置 %@ %@", key, value);
            }
        }
    }
}

- (BOOL)serverRecordAudio
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"server_record_audio"] boolValue];
}

- (BOOL)serverRecordVideo
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"server_record_video"] boolValue];
}

- (BOOL)serverRecordHost
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"server_record_host"] boolValue];
}

- (int)serverRecordMode
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"server_record_mode"] intValue];
}

- (BOOL)useSocks
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"use_socks5"] boolValue];
}

- (NSString *)socks5Addr
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"socks5_addr"]? : @"";
}

- (NSString *)socks5Type
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"socks5_type"]? : @"";
}

- (NSString *)socksUsername
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"socks5_username"]? : @"";
}

- (NSString *)socksPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"socks5_password"] ?: @"";
}

- (NIMNetCallVideoCrop)videochatVideoCrop
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_video_crop"];
    
    return setting ? [setting integerValue] : NIMNetCallVideoCrop1x1;
}

- (UIViewContentMode)videochatRemoteVideoContentMode
{
    NSInteger setting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_remote_video_content_mode"] integerValue];
    return (setting == 0) ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleAspectFit;
}

- (BOOL)videochatAutoRotateRemoteVideo
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_auto_rotate_remote_video"] boolValue];
}

- (NIMNetCallVideoQuality)preferredVideoQuality
{
    NSInteger videoQualitySetting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_preferred_video_quality"] integerValue];
    if ((videoQualitySetting >= NIMNetCallVideoQualityDefault) &&
        (videoQualitySetting <= NIMNetCallVideoQuality720pLevel)) {
        return (NIMNetCallVideoQuality)videoQualitySetting;
    }
    return NIMNetCallVideoQualityDefault;
}


- (BOOL)startWithBackCamera
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_start_with_back_camera"] boolValue];
}

- (NIMNetCallVideoCodec)perferredVideoEncoder
{
    NSInteger videoEncoderSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_preferred_video_encoder"] integerValue];
    
    if ((videoEncoderSetting >= NIMNetCallVideoCodecDefault) &&
        (videoEncoderSetting <= NIMNetCallVideoCodecHardware)) {
        return (NIMNetCallVideoCodec)videoEncoderSetting;
    }
    return NIMNetCallVideoCodecDefault;
}

- (NIMNetCallVideoCodec)perferredVideoDecoder
{
    NSInteger videoDecoderSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_preferred_video_decoder"] integerValue];
    
    if ((videoDecoderSetting >= NIMNetCallVideoCodecDefault) &&
        (videoDecoderSetting <= NIMNetCallVideoCodecHardware)) {
        return (NIMNetCallVideoCodec)videoDecoderSetting;
    }
    return NIMNetCallVideoCodecDefault;
    
}
- (NSUInteger)videoMaxEncodeKbps
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_video_encode_max_kbps"] integerValue];
}

- (NSUInteger)localRecordVideoKbps
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_local_record_video_kbps"] integerValue];
}

- (BOOL)autoDeactivateAudioSession
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_auto_disable_audiosession"];
    
    if (setting) {
        return [setting boolValue];
    }
    else {
        return YES;
    }
}

- (BOOL)audioDenoise
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_audio_denoise"];
    
    if (setting) {
        return [setting boolValue];
    }
    else {
        return YES;
    }

}

- (BOOL)voiceDetect
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_voice_detect"];
    
    if (setting) {
        return [setting boolValue];
    }
    else {
        return YES;
    }

}

- (BOOL)preferHDAudio
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"videochat_prefer_hd_audio"];
    
    if (setting) {
        return [setting boolValue];
    }
    else {
        return NO;
    }
}

- (NIMAVChatScene)scene
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"avchat_scene"];
    
    if (setting) {
        return [setting unsignedIntegerValue];
    }
    else {
        return NIMAVChatSceneDefault;
    }
}


- (BOOL)serverRecordWhiteboardData
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"server_record_rts_data"] boolValue];
}

- (BOOL)testerToolUI
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"tester_tool_ui"] boolValue];
}

- (BOOL)provideLocalProcess
{
    id setting = [[NSUserDefaults standardUserDefaults] objectForKey:@"local_video_process"];
    
    if (setting) {
        return [setting boolValue];
    }
    else
    {
        return YES;
    }
}

- (NSInteger)beautifyType
{
    NSInteger localBeautifyType = [[[NSUserDefaults standardUserDefaults] objectForKey:@"video_beautify"] integerValue];
    
    return localBeautifyType;
}

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"\n\n\n" \
            "server_record_audio %d\n" \
            "server_record_video %d\n" \
            "videochat_video_crop %zd\n" \
            "videochat_auto_rotate_remote_video %d \n" \
            "videochat_preferred_video_quality %zd\n" \
            "videochat_start_with_back_camera %zd\n" \
            "videochat_preferred_video_encoder %zd\n" \
            "videochat_preferred_video_decoder %zd\n" \
            "videochat_video_encode_max_kbps %zd\n" \
            "videochat_local_record_video_kbps %zd\n" \
            "videochat_auto_disable_audiosession %zd\n" \
            "videochat_audio_denoise %zd\n" \
            "videochat_voice_detect %zd\n" \
            "videochat_prefer_hd_audio %zd\n" \
            "avchat_scene %zd\n" \
            "server_record_rts_data %zd\n" \
            "tester_tool_ui %zd\n" \
            "\n\n\n",
            [self serverRecordAudio],
            [self serverRecordVideo],
            [self videochatVideoCrop],
            [self videochatAutoRotateRemoteVideo],
            [self preferredVideoQuality],
            [self startWithBackCamera],
            [self perferredVideoEncoder],
            [self perferredVideoDecoder],
            [self videoMaxEncodeKbps],
            [self localRecordVideoKbps],
            [self autoDeactivateAudioSession],
            [self audioDenoise],
            [self voiceDetect],
            [self preferHDAudio],
            [self scene],
            [self serverRecordWhiteboardData],
            [self testerToolUI]
            ];
}
@end
