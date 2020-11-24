
//
//  GetPhassetUrl.m
//  qianshutang
//
//  Created by aaa on 2018/9/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "GetPhassetUrl.h"

@implementation GetPhassetUrl

+ (instancetype)shareSoftManager
{
    static GetPhassetUrl * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GetPhassetUrl alloc]init];
    });
    
    return manager;
}


- (void)getPHAssetwith:(PHAsset *)assetNew Url:(void(^)(NSURL* url))UrlBlk
{
    [[PHImageManager defaultManager] requestExportSessionForVideo:assetNew options:nil exportPreset:AVAssetExportPresetPassthrough resultHandler:^(AVAssetExportSession *exportSession, NSDictionary *info) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yy_MM_dd_HH:mm"];
        
        NSString *fileName = [NSString stringWithFormat:@"LocalRecord_%@.mp4",[formatter stringFromDate:[NSDate date]]];
        
        NSString* videoPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
        
        NSMutableArray *videoList = [[NSMutableArray alloc] initWithCapacity:100];
        
        for (NSString *file in fileList) {
            
            if ([file rangeOfString:@"LocalRecord_"].location != NSNotFound) {
                
                [videoList addObject:file];
                
            }
            
        }
        
        NSLog(@"videoList %@",videoList);
        
        for (NSString *deleteFileName in videoList) {
            
            NSString *deletaPath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,deleteFileName];
            
            NSLog(@"deletaPath %@",deletaPath);
            
            NSError *error;
            
            BOOL success = [manager removeItemAtPath:deletaPath error:&error];
            
            NSLog(@"error is %@   seccessy is %d",error,success);
            
        }
        
        NSURL *outputURL = [NSURL fileURLWithPath:videoPath];
        
        NSLog(@"this is the final path %@",outputURL);
        
        exportSession.outputFileType=AVFileTypeMPEG4;
        
        exportSession.outputURL=outputURL;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            if (exportSession.status == AVAssetExportSessionStatusFailed) {
                
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
            } else if(exportSession.status == AVAssetExportSessionStatusCompleted){
                
                NSLog(@"completed!");
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    
                    UrlBlk(outputURL);
                    
                });
                
            }
            
        }];
        
    }];
    
}


@end
