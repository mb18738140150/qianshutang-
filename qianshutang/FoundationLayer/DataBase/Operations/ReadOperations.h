//
//  ReadOperations.h
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "JSONKit.h"

@interface ReadOperations : NSObject

@property (nonatomic,weak)  FMDatabase      *dataBase;

- (BOOL)isTextSavedWithId:(NSDictionary *)videoInfo;

- (NSArray *)getDownloadTextInfos;




- (NSDictionary *)getTextWithTextId:(NSDictionary *)infoDic;

- (BOOL)isAudioSavedWithInfo:(NSDictionary *)audioInfo;

- (NSArray *)getDownloadAudioInfos:(NSDictionary *)infoDic;

- (NSArray *)getDownloadAudioList:(NSDictionary *)infoDic;

- (NSArray *)getMoerduoDownloadAudioList:(NSDictionary *)infoDic;

- (BOOL)isAudioListSavedWithInfo:(NSDictionary *)audioInfo;

- (NSArray *)getDownloadAudioInfosWith:(NSDictionary *)infoDic;// 获取某个课文下全部音频

@end
