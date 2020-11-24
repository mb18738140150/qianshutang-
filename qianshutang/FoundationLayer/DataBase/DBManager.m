//
//  DBManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "DBManager.h"
#import "PathUtility.h"
#import "FMDB.h"
#import "ReadOperations.h"
#import "WriteOperations.h"
#import "CommonMacro.h"

@interface DBManager ()

@property (nonatomic,strong) FMDatabase         *dataBase;

@property (nonatomic,strong) ReadOperations     *readOperation;
@property (nonatomic,strong) WriteOperations    *writeOperation;

@end

@implementation DBManager

+ (instancetype)sharedManager
{
    static DBManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[DBManager alloc] init];
    });
    return __manager__;
}

- (void)intialDB
{
    NSString *DBPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"1.db"];
    self.dataBase = [FMDatabase databaseWithPath:DBPath];
    if (![self.dataBase open]) {
        NSLog(@"数据库打开错误");
        return;
    }
    [self initalTables];
    self.readOperation = [[ReadOperations alloc] init];
    self.readOperation.dataBase = self.dataBase;
    self.writeOperation = [[WriteOperations alloc] init];
    self.writeOperation.dataBase = self.dataBase;
}

- (void)initalTables
{
    NSString *initalTablesSql = @"CREATE TABLE IF NOT EXISTS TextBook (id integer PRIMARY KEY autoincrement,textBookName text(128) NOT NULL,textBookId text(128) NOT NULL,textBookCoverImage text(128) NOT NULL,path text(32) NOT NULL,type integer(32) NOT NULL);"
    "CREATE TABLE IF NOT EXISTS Unit (id integer PRIMARY KEY autoincrement,unitId text(128) NOT NULL,unitName text(128) NOT NULL,textBookId text(128) NOT NULL,path text(32) NOT NULL,type integer(32) NOT NULL);"
    "CREATE TABLE IF NOT EXISTS Text (id integer PRIMARY KEY autoincrement,textId text(128) NOT NULL,textName text(128) NOT NULL,path text(32) NOT NULL,type integer(32) NOT NULL);"
    "CREATE TABLE IF NOT EXISTS Moerduo (id integer PRIMARY KEY autoincrement,audioName text(128) NOT NULL,audioId text(128) NOT NULL,userId text(32) NOT NULL,number integer(32) NOT NULL);"
    "CREATE TABLE IF NOT EXISTS MoerduoList (id integer PRIMARY KEY autoincrement,partName text(128) NOT NULL,partId text(128) NOT NULL,userId text(32) NOT NULL,type integer(32) NOT NULL);";
    BOOL isCreate = [self.dataBase executeStatements:initalTablesSql];
    if (!isCreate) {
        NSLog(@"***********创建表失败********");
    }
}

// 磨耳朵
- (void)saveDownloadAudioInfo:(NSDictionary *)dic
{
    if (![self.readOperation isAudioSavedWithInfo:dic]) {
        NSLog(@"开始插入数据，\n******* %@", dic);
        
        if ([self.writeOperation writeDownloadAudioInfo:dic]) {
            NSLog(@"写入成功,%@", [dic objectForKey:kAudioId]);
        }else
        {
            NSLog(@"写入失败,%@", [dic objectForKey:kAudioId]);

        }
        ;
    }
}

- (NSArray *)getDownloadAudios:(NSDictionary *)infoDic
{
    return [self.readOperation getDownloadAudioInfos:infoDic];
}

- (BOOL)deleteAllAudios:(NSDictionary *)infoDic
{
    return [self.writeOperation deleteAllAudios:infoDic];
}

- (BOOL)deleteAudioWith:(NSDictionary *)audioInfo
{
    return [self.writeOperation deleteAudioWith:audioInfo];
}

- (NSArray *)getDownloadAudioList:(NSDictionary *)infoDic
{
    return [self.readOperation getDownloadAudioList:infoDic];
}

- (NSArray *)getMoerduoDownloadAudioList:(NSDictionary *)infoDic
{
    return [self.readOperation getMoerduoDownloadAudioList:infoDic];
}

- (void)saveDownloadAudioListInfo:(NSDictionary *)dic
{
    if (![self.readOperation isAudioListSavedWithInfo:dic]) {
        NSLog(@"开始插入数据，\n******* %@", dic);
        
        if ([self.writeOperation writeDownloadAudioListInfo:dic]) {
            NSLog(@"写入成功,%@", [dic objectForKey:kpartName]);
        }else
        {
            NSLog(@"写入失败,%@", [dic objectForKey:kpartName]);
        }
        ;
    }
}
- (BOOL)deleteAudioListWith:(NSDictionary *)audioInfo// 删除全部
{
    return [self.writeOperation deleteAudioListWith:audioInfo];
}
- (BOOL)deleteAllAudioList:(NSDictionary *)infoDic
{
    return [self.writeOperation deleteAllAudioList:infoDic];
}

- (BOOL)deleteMoerduoAudioListWith:(NSDictionary *)audioInfo// 删除磨耳朵
{
    return [self.writeOperation deleteMoerduoAudioListWith:audioInfo];
}
- (BOOL)deleteMoerduoAllAudioList:(NSDictionary *)infoDic;
{
    return [self.writeOperation deleteMoerduoAllAudioList:infoDic];
}


- (NSArray *)getDownloadAudioInfosWith:(NSDictionary *)infoDic
{
    // 获取某个课文下全部音频
    
    return [self.readOperation getDownloadAudioInfosWith:infoDic];
    
}

@end
