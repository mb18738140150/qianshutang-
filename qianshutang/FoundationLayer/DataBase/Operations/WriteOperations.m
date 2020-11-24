//
//  WriteOperations.m
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "WriteOperations.h"
#import "CommonMacro.h"

@implementation WriteOperations


- (BOOL)writeTextInfo:(NSDictionary *)dic;
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into Text (textId,textName,path,type) values (?,?,?,?)",[dic objectForKey:kTextId],[dic objectForKey:kTextName],[dic objectForKey:kAudioPath],[dic objectForKey:@"type"]];
    
    return isSuccess;
}


- (BOOL)deleteTextInfo:(NSDictionary *)dic;
{
    BOOL isSuccess = NO;
    /*    if ([dic objectForKey:kIsSingleChapter]) {
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Chapter where chapterId = ?",[dic objectForKey:kVideoId]];
     }else{
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Video where videoId = ?",[dic objectForKey:kVideoId]];
     }*/
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Text where textId = ? and type = ?",[dic objectForKey:kTextId], [dic objectForKey:@"type"]];
    return isSuccess;
}

- (BOOL)deleteAllText
{
    BOOL isSuccess = NO;
    /*    if ([dic objectForKey:kIsSingleChapter]) {
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Chapter where chapterId = ?",[dic objectForKey:kVideoId]];
     }else{
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Video where videoId = ?",[dic objectForKey:kVideoId]];
     }*/
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Text"];
    return isSuccess;
}

- (BOOL)writeDownloadAudioInfo:(NSDictionary *)dic
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into Moerduo (audioName,audioId,userId,number) values (?,?,?,?)",[dic objectForKey:kAudioName],[dic objectForKey:kAudioId],[dic objectForKey:kUserId],[dic objectForKey:@"number"]];
    
    return isSuccess;
}

- (BOOL)deleteAllAudios:(NSDictionary *)infoDic
{
    BOOL isSuccess = NO;

    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Moerduo where userId = ?",[infoDic objectForKey:kUserId]];
    return isSuccess;
}

- (BOOL)deleteAudioWith:(NSDictionary *)audioInfo
{
    BOOL isSuccess = NO;
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Moerduo where audioName = ? and userId = ?",[audioInfo objectForKey:kAudioName],[audioInfo objectForKey:kUserId]];
    return isSuccess;
}

- (BOOL)writeDownloadAudioListInfo:(NSDictionary *)dic
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into MoerduoList (partName,partId,userId,type) values (?,?,?,?)",[dic objectForKey:kpartName],[dic objectForKey:kpartId],[NSString stringWithFormat:@"%@", [dic objectForKey:kUserId]],[dic objectForKey:@"type"]];
    
    return isSuccess;
}

- (BOOL)deleteAudioListWith:(NSDictionary *)audioInfo
{
    BOOL isSuccess = NO;
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM MoerduoList where partId = ? and userId = ?",[audioInfo objectForKey:kpartId],[audioInfo objectForKey:kUserId]];
    return isSuccess;
}

- (BOOL)deleteAllAudioList:(NSDictionary *)infoDic
{
    BOOL isSuccess = NO;
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM MoerduoList where userId = ?",[infoDic objectForKey:kUserId]];
    return isSuccess;
}

- (BOOL)deleteMoerduoAudioListWith:(NSDictionary *)audioInfo// 删除磨耳朵
{
    BOOL isSuccess = NO;
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM MoerduoList where partId = ? and userId = ? and type = ?",[audioInfo objectForKey:kpartId],[audioInfo objectForKey:kUserId],[audioInfo objectForKey:@"type"]];
    return isSuccess;
}
- (BOOL)deleteMoerduoAllAudioList:(NSDictionary *)infoDic
{
    BOOL isSuccess = NO;
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM MoerduoList where type = ? and userId = ?",[infoDic objectForKey:@"type"],[infoDic objectForKey:kUserId]];
    return isSuccess;
}

@end
