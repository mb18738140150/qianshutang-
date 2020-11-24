//
//  ReadOperations.m
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "ReadOperations.h"
#import "CommonMacro.h"

@implementation ReadOperations

- (BOOL)isTextSavedWithId:(NSDictionary *)textInfo
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Text WHERE textId = ? and type = ?",[textInfo objectForKey:kTextId],[textInfo objectForKey:@"type"]];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (NSArray *)getDownloadTextInfos
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Text"];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"textName"] forKey:kTextName];
        [dic setObject:@([s intForColumn:@"textId"]) forKey:kTextId];
        [dic setObject:@([s intForColumn:@"type"]) forKey:@"type"];
        [dic setObject:[s stringForColumn:@"path"] forKey:kAudioPath];
        [arry addObject:dic];
    }
    return arry;
}

- (NSDictionary *)getTextWithTextId:(NSDictionary *)infoDic
{
    NSMutableDictionary *textInfo = [[NSMutableDictionary alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Text WHERE textId = ? and type = ?",[infoDic objectForKey:kTextId], [infoDic objectForKey:@"type"]];
    while ([s next]) {
        [textInfo setObject:[s stringForColumn:@"textName"] forKey:kTextName];
        [textInfo setObject:[s stringForColumn:@"textId"] forKey:kTextId];
        [textInfo setObject:@([s intForColumn:@"type"]) forKey:@"type"];
        [textInfo setObject:[s stringForColumn:@"path"] forKey:kAudioPath];
    }
    return textInfo;
}

// 磨耳朵
- (BOOL)isAudioSavedWithInfo:(NSDictionary *)audioInfo
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Moerduo WHERE audioId = ? and userId = ?",[audioInfo objectForKey:kAudioId],[audioInfo objectForKey:kUserId]];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (NSArray *)getDownloadAudioInfos:(NSDictionary *)infoDic
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Moerduo where userId = ?",[infoDic objectForKey:kUserId]];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"audioId"] forKey:kAudioId];
        [dic setObject:@([s intForColumn:@"number"]) forKey:@"number"];
        [dic setObject:[s stringForColumn:@"audioName"] forKey:kAudioName];
        [dic setObject:[s stringForColumn:@"userId"] forKey:kUserId];
        [arry addObject:dic];
    }
    return arry;
}

- (NSArray *)getDownloadAudioInfosWith:(NSDictionary *)infoDic
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Moerduo where audioName = ? and userId = ?",[infoDic objectForKey:kpartName],[infoDic objectForKey:kUserId]];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"audioId"] forKey:kAudioId];
        [dic setObject:@([s intForColumn:@"number"]) forKey:@"number"];
        [dic setObject:[s stringForColumn:@"audioName"] forKey:kAudioName];
        [dic setObject:[s stringForColumn:@"userId"] forKey:kUserId];
        
        [arry addObject:dic];
    }
    return arry;
}

- (NSArray *)getDownloadAudioList:(NSDictionary *)infoDic
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM MoerduoList where userId = ?",[infoDic objectForKey:kUserId]];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"partId"] forKey:kpartId];
        [dic setObject:[s stringForColumn:@"partName"] forKey:kpartName];
        [dic setObject:[s stringForColumn:@"userId"] forKey:kUserId];
        [dic setObject:@([s intForColumn:@"type"]) forKey:@"type"];
        NSArray * audioInfos = [self getDownloadAudioInfosWith:@{kpartName:[s stringForColumn:@"partName"],kUserId:[s stringForColumn:@"userId"] }];
        [dic setObject:audioInfos forKey:@"audioInfos"];
        [arry addObject:dic];
    }
    return arry;
}

- (NSArray *)getMoerduoDownloadAudioList:(NSDictionary *)infoDic
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM MoerduoList where type = ? and userId = ?",[infoDic objectForKey:@"type"],[infoDic objectForKey:kUserId]];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"partId"] forKey:kpartId];
        [dic setObject:[s stringForColumn:@"partName"] forKey:kpartName];
        [dic setObject:[s stringForColumn:@"userId"] forKey:kUserId];
        [dic setObject:@([s intForColumn:@"type"]) forKey:@"type"];
        NSArray * audioInfos = [self getDownloadAudioInfosWith:@{kpartName:[s stringForColumn:@"partName"],kUserId:[s stringForColumn:@"userId"] }];
        [dic setObject:audioInfos forKey:@"audioInfos"];
        [arry addObject:dic];
    }
    return arry;
}

- (BOOL)isAudioListSavedWithInfo:(NSDictionary *)audioInfo
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM MoerduoList WHERE partId = ? and type = ? and userId = ?",[audioInfo objectForKey:kpartId],[audioInfo objectForKey:@"type"],[audioInfo objectForKey:kUserId]];
    while ([s next]) {
        return YES;
    }
    return NO;

}

@end
