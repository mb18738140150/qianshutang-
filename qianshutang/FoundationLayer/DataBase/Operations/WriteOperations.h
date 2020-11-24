//
//  WriteOperations.h
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "JSONKit.h"
@interface WriteOperations : NSObject

@property (nonatomic,weak)  FMDatabase      *dataBase;

- (BOOL)writeTextInfo:(NSDictionary *)dic;

- (BOOL)deleteTextInfo:(NSDictionary *)dic;

- (BOOL)deleteAllText;// 删除全部下载

- (BOOL)writeDownloadAudioInfo:(NSDictionary *)dic;

- (BOOL)deleteAllAudios:(NSDictionary *)infoDic;

- (BOOL)deleteAudioWith:(NSDictionary *)audioInfo;

- (BOOL)writeDownloadAudioListInfo:(NSDictionary *)dic;

- (BOOL)deleteAudioListWith:(NSDictionary *)audioInfo;
- (BOOL)deleteAllAudioList:(NSDictionary *)infoDic;

- (BOOL)deleteMoerduoAudioListWith:(NSDictionary *)audioInfo;// 删除磨耳朵
- (BOOL)deleteMoerduoAllAudioList:(NSDictionary *)infoDic;

@end
