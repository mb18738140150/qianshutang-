//
//  NTESDemoConfig.m
//  NIM
//
//  Created by amao on 4/21/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESDemoConfig.h"

@interface NTESDemoConfig ()

@end

@implementation NTESDemoConfig
+ (instancetype)sharedConfig
{
    static NTESDemoConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESDemoConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _appKey = @"31b1372756cba59207fcdbbe27061f46";//1ee5a51b7d008254cd73b1d4369a9494 5bb125fe38a5b6ef89874fef6295a895
        _apiURL = @"https://app.netease.im/api";
        _apnsCername = @"ENTERPRISE";
        _pkCername = @"DEMO_PUSH_KIT";
    }
    return self;
}

- (void)registerConfig:(NSDictionary *)config
{
    if (config[@"red_packet_online"])
    {
        _redPacketConfig.useOnlineEnv = [config[@"red_packet_online"] boolValue];
    }
}



@end

@implementation NTESRedPacketConfig

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _useOnlineEnv = YES;
        _aliPaySchemeUrl = @"alipay052969";
        _weChatSchemeUrl = @"wx2a5538052969956e";
    }
    return self;
}
@end

