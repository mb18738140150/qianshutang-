//
//  WXApiShareManager.m
//  qianshutang
//
//  Created by aaa on 2018/11/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "WXApiShareManager.h"

typedef enum : NSUInteger {
    WXApiShareType_Session,
    WXApiShareType_Timeline,
    WXApiShareType_Favorite,
} WXApiShareType;

@interface WXApiShareManager()<WXApiManagerDelegate>


@end

@implementation WXApiShareManager

+(instancetype)shareManager
{
    static dispatch_once_t once;
    static WXApiShareManager * shareMagager;
    dispatch_once(&once, ^{
        shareMagager = [[WXApiShareManager alloc]init];
    });
    return shareMagager;
}

- (void)shareToSessionWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate
{
    [self shareWithType:WXApiShareType_Session andContent:infoDic];
}
- (void)shareToTimelineWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate
{
    [self shareWithType:WXApiShareType_Timeline andContent:infoDic];
}
- (void)shareToFavoriteWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate
{
    [self shareWithType:WXApiShareType_Favorite andContent:infoDic];
}

- (void)shareComplate
{
    [SVProgressHUD showSuccessWithStatus:@""];
}

- (void)shareWithType:(WXApiShareType)shareType andContent:(NSDictionary *)infoDic
{
    WXMediaMessage * message = [WXMediaMessage message];
    message.title = [infoDic objectForKey:@"title"];
    message.description = [infoDic objectForKey:@"description"];
    [message setThumbImage:[UIImage imageNamed:[infoDic objectForKey:@"image"]]];
    
    WXWebpageObject * webObject = [WXWebpageObject object];
    webObject.webpageUrl = [infoDic objectForKey:@"html"];
    message.mediaObject = webObject;
    
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    switch (shareType) {
        case WXApiShareType_Session:
            req.scene = WXSceneSession;
            break;
        case WXApiShareType_Timeline:
            req.scene = WXSceneTimeline;
            break;
        case WXApiShareType_Favorite:
            req.scene = WXSceneFavorite;
            break;
            
        default:
            break;
    }
    [WXApi sendReq:req];
}

- (void)shreSuccess:(SendMessageToWXResp *)response
{
    NSLog(@"分享成功");
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareSuccess)]) {
        [self.delegate shareSuccess];
    }
}

@end
