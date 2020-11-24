//
//  NTESMeetingNetCallManager.m
//  NIMEducationDemo
//
//  Created by fenric on 16/4/24.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "NTESMeetingNetCallManager.h"
#import "NTESMeetingRolesManager.h"
#import "NTESBundleSetting.h"

#define NTESNetcallManager [NIMAVChatSDK sharedSDK].netCallManager

@interface NTESMeetingNetCallManager()<NIMNetCallManagerDelegate>
{
    UInt16 _myVolume;
}

@property (nonatomic, strong) NIMNetCallMeeting *meeting;
@property (nonatomic, weak) id<NTESMeetingNetCallManagerDelegate>delegate;

@end

@implementation NTESMeetingNetCallManager

- (void)joinMeeting:(NSString *)name delegate:(id<NTESMeetingNetCallManagerDelegate>)delegate
{
    if (_meeting) {
        [self leaveMeeting];
    }
    
    [NTESNetcallManager addDelegate:self];
    
    _meeting = [[NIMNetCallMeeting alloc] init];
    _meeting.name = name;
    _meeting.type = NIMNetCallTypeVideo;
    _meeting.actor = [NTESMeetingRolesManager sharedInstance].myRole.isActor;
    
    [self fillNetCallOption:_meeting];
    
    NTESMeetingRole *myRole = [NTESMeetingRolesManager sharedInstance].myRole;
    _meeting.option.videoCaptureParam.startWithCameraOn = myRole.videoOn;
    
    _delegate = delegate;
    
    __weak typeof(self) wself = self;
    
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:_meeting completion:^(NIMNetCallMeeting *meeting, NSError *error) {
        if (error) {
            DDLogError(@"Join meeting %@error: %zd.", meeting.name, error.code);
            _meeting = nil;
            if (wself.delegate) {
                [wself.delegate onJoinMeetingFailed:meeting.name error:error];
            }
        }
        else {
            DDLogInfo(@"Join meeting %@ success, ext:%@", meeting.name, meeting.ext);
            _isInMeeting = YES;
            NTESMeetingRole *myRole = [NTESMeetingRolesManager sharedInstance].myRole;
            DDLogInfo(@"Reset mute:%d, camera disable:%d",!myRole.audioOn,!myRole.videoOn);
            [NTESNetcallManager setMute:!myRole.audioOn];
            
            if (wself.delegate) {
                [wself.delegate onMeetingConntectStatus:YES];
            }
            NSString *myUid = [NTESMeetingRolesManager sharedInstance].myRole.uid;
            DDLogInfo(@"Joined meeting.");
            [[NTESMeetingRolesManager sharedInstance] updateMeetingUser:myUid
                                                               isJoined:YES];

        }
    }];

}

- (void)leaveMeeting
{
    if (_meeting) {
        [NTESNetcallManager leaveMeeting:_meeting];
        _meeting = nil;
    }
    [NTESNetcallManager removeDelegate:self];
    _isInMeeting = NO;
}

#pragma mark - NIMNetCallManagerDelegate
- (void)onUserJoined:(NSString *)uid
             meeting:(NIMNetCallMeeting *)meeting
{
    DDLogInfo(@"user %@ joined meeting", uid);
    if ([meeting.name isEqualToString:_meeting.name]) {
        [[NTESMeetingRolesManager sharedInstance] updateMeetingUser:uid isJoined:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNTESJoinWhiteBoardNotification object:nil];
    }
}

- (void)onUserLeft:(NSString *)uid
           meeting:(NIMNetCallMeeting *)meeting
{
    DDLogInfo(@"user %@ left meeting", uid);

    if ([meeting.name isEqualToString:_meeting.name]) {
        [[NTESMeetingRolesManager sharedInstance] updateMeetingUser:uid isJoined:NO];
    }
}

- (void)onMeetingError:(NSError *)error
               meeting:(NIMNetCallMeeting *)meeting
{
    DDLogInfo(@"meeting error %zd", error.code);
    _isInMeeting = NO;
    [_delegate onMeetingConntectStatus:NO];
}



- (void)onMyVolumeUpdate:(UInt16)volume
{
    _myVolume = volume;    
}

- (void)onSpeakingUsersReport:(nullable NSArray<NIMNetCallUserInfo *> *)report
{
    NSString *myUid = [[NIMSDK sharedSDK].loginManager currentAccount];

    NSMutableDictionary *volumes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self volumeLevel:_myVolume], myUid, nil];

    for (NIMNetCallUserInfo *info in report) {
        [volumes setObject:[self volumeLevel:info.volume] forKey:info.uid];
    }
    
    [[NTESMeetingRolesManager sharedInstance] updateVolumes:volumes];
}

- (void)onNetStatus:(NIMNetCallNetStatus)status user:(NSString *)user
{
    DDLogInfo(@"Net status of %@ is %zd", user, status);
}

#pragma mark - private
- (void)fillNetCallOption:(NIMNetCallMeeting *)meeting
{
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    
    option.autoRotateRemoteVideo = [[NTESBundleSetting sharedConfig] videochatAutoRotateRemoteVideo];
    
    NIMNetCallServerRecord *serverRecord = [[NIMNetCallServerRecord alloc] init];
    serverRecord.enableServerAudioRecording     = [[NTESBundleSetting sharedConfig] serverRecordAudio];
    serverRecord.enableServerVideoRecording     = [[NTESBundleSetting sharedConfig] serverRecordVideo];
    serverRecord.enableServerHostRecording      = [[NTESBundleSetting sharedConfig] serverRecordHost];
    serverRecord.serverRecordingMode            = [[NTESBundleSetting sharedConfig] serverRecordMode];
    option.serverRecord = serverRecord;
    
    NIMNetCallSocks5 *socks5Info =  [[NIMNetCallSocks5 alloc] init];
    socks5Info.useSocks5Proxy    =  [[NTESBundleSetting sharedConfig] useSocks];
    socks5Info.socks5Addr        =  [[NTESBundleSetting sharedConfig] socks5Addr];
    socks5Info.socks5Username    =  [[NTESBundleSetting sharedConfig] socksUsername];
    socks5Info.socks5Password    =  [[NTESBundleSetting sharedConfig] socksPassword];
    socks5Info.socks5Type        =  [[NTESBundleSetting sharedConfig] socks5Type];
    option.socks5Info            =  socks5Info;
    
    option.preferredVideoEncoder = [[NTESBundleSetting sharedConfig] perferredVideoEncoder];
    option.preferredVideoDecoder = [[NTESBundleSetting sharedConfig] perferredVideoDecoder];
    option.videoMaxEncodeBitrate = [[NTESBundleSetting sharedConfig] videoMaxEncodeKbps] * 1000;
    option.autoDeactivateAudioSession = [[NTESBundleSetting sharedConfig] autoDeactivateAudioSession];
    option.audioDenoise = [[NTESBundleSetting sharedConfig] audioDenoise];
    option.voiceDetect = [[NTESBundleSetting sharedConfig] voiceDetect];
    option.preferHDAudio = [[NTESBundleSetting sharedConfig] preferHDAudio];
    option.scene = [[NTESBundleSetting sharedConfig] scene];
    option.videoCaptureParam = [self videoCaptureParam];
    _meeting.option = option;
}

- (NIMNetCallVideoCaptureParam *)videoCaptureParam
{
    NIMNetCallVideoCaptureParam *param = [[NIMNetCallVideoCaptureParam alloc] init];
    
    param.videoCrop = [[NTESBundleSetting sharedConfig] videochatVideoCrop];

    param.startWithBackCamera   = [[NTESBundleSetting sharedConfig] startWithBackCamera];

    param.preferredVideoQuality = [[NTESBundleSetting sharedConfig] preferredVideoQuality];
    
    if ( [[NTESBundleSetting sharedConfig] provideLocalProcess]) {
        param.videoProcessorParam = [[NIMNetCallVideoProcessorParam alloc] init];
    }
    
    BOOL isManager = [NTESMeetingRolesManager sharedInstance].myRole.isManager;
    
    //会议的观众这里默认用低清发送视频
    if (param.preferredVideoQuality == NIMNetCallVideoQualityDefault) {
        if (!isManager) {
            param.preferredVideoQuality = NIMNetCallVideoQualityLow;
        }
    }
    return param;
}



-(NSNumber *)volumeLevel:(UInt16)volume
{
    int32_t volumeLevel = 0;
    volume /= 40;
    while (volume > 0) {
        volumeLevel ++;
        volume /= 2;
    }
    if (volumeLevel > 8) volumeLevel = 8;
    
    return @(volumeLevel);
}

@end
