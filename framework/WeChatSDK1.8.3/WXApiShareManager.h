//
//  WXApiShareManager.h
//  qianshutang
//
//  Created by aaa on 2018/11/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXApiShareManagerDelegate <NSObject>

@optional
- (void)shareSuccess;


@end

@interface WXApiShareManager : NSObject

@property (nonatomic, assign)id<WXApiShareManagerDelegate>delegate;

- (void)shareToSessionWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate;
- (void)shareToTimelineWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate;
- (void)shareToFavoriteWithcotent:(NSDictionary *)infoDic andDelegate:(id<WXApiShareManagerDelegate>)delegate;

+(instancetype)shareManager;
- (void)shreSuccess:(SendMessageToWXResp *)response;
@end
