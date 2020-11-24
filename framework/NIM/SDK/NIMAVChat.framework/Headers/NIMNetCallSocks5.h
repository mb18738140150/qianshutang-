//
//  NIMNetCallSocks5.h
//  NIMAVChat
//
//  Created by fanghe's mac on 2018/8/14.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NIMNetCallSocks5 : NSObject <NSCopying>
/**
 *  是否使用全局socks5代理, 代理无认证格式：socks5://ip:port; 代理有认证格式：socks5://username:password@ip:port
 */
@property (nonatomic, assign) BOOL useSocks5Proxy;

/**
 * 代理类型，如socks5
 */
@property (nullable, nonatomic, copy) NSString *socks5Type;

/**
 *  socks5服务地址, 格式：ip:port
 */
@property (nonatomic, copy) NSString *socks5Addr;

/**
 *  socks5服务用户名，
 */
@property (nullable, nonatomic, copy) NSString *socks5Username;

/**
 *  socks5服务密码
 */
@property (nullable, nonatomic, copy) NSString *socks5Password;

@end

NS_ASSUME_NONNULL_END
