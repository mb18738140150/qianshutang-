//
//  DBManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface DBManager : NSObject

+ (instancetype)sharedManager;

- (void)intialDB;

- (void)saveDownloadAudioInfo:(NSDictionary *)dic;
- (void)saveDownloadAudioListInfo:(NSDictionary *)dic;

- (NSArray *)getDownloadAudios:(NSDictionary *)infoDic;
- (NSArray *)getDownloadAudioList:(NSDictionary *)infoDic;// 获取账户下音频列表
- (NSArray *)getMoerduoDownloadAudioList:(NSDictionary *)infoDic;// 获取账户下磨耳朵音频列表

- (BOOL)deleteAllAudios:(NSDictionary *)infoDic;// 删除账户所有音频
- (BOOL)deleteAudioWith:(NSDictionary *)audioInfo;// 删除账户某一课文下音频

- (BOOL)deleteAudioListWith:(NSDictionary *)audioInfo;// 删除账户某一课文
- (BOOL)deleteAllAudioList:(NSDictionary *)infoDic;// 删除全部课文

- (BOOL)deleteMoerduoAudioListWith:(NSDictionary *)audioInfo;// 删除磨耳朵某一课文
- (BOOL)deleteMoerduoAllAudioList:(NSDictionary *)infoDic;// 删除磨耳朵全部课文

- (NSArray *)getDownloadAudioInfosWith:(NSDictionary *)infoDic;// 获取某个课文下全部音频


@end
