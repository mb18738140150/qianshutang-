//
//  ProductionModel.m
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductionModel.h"
#import<AssetsLibrary/AssetsLibrary.h>
#import "GetPhassetUrl.h"

@implementation ProductionModel

- (NSMutableArray *)imageProductArray
{
    if (!_imageProductArray) {
        _imageProductArray = [NSMutableArray array];
    }
    return _imageProductArray;
}

- (NSMutableArray *)textProductArray
{
    if (!_textProductArray) {
        _textProductArray = [NSMutableArray array];
    }
    return _textProductArray;
}

- (void)setPhAsset:(PHAsset *)phAsset
{
    _phAsset = phAsset;
    CGSize imageSize;
    if (self.isPad) {
        imageSize = CGSizeMake(CELL_COLLECTION_WIDTH*1.5, CELL_COLLECTION_WIDTH*1.5);
    }else{
        imageSize = CGSizeMake(CELL_COLLECTION_WIDTH_IPHONE*1.5, CELL_COLLECTION_WIDTH_IPHONE*1.5);
    }
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.networkAccessAllowed = YES;//允许从icloud 下载
    /*
     1.Opportunistic表示尽可能的获取高质量图片
     2.HighQualityFormat表示不管花多少时间也要获取高质量的图片(慎用)
     3.FastFormat快速获取图片,(图片质量低,我们通常设置这种来获取缩略图)
     */
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    __weak typeof(self)weakSelf = self;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;//提供精准大小的图片
    [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.image = result;
        });
        
    }];
    [self getUrl:phAsset];
}

+ (ProductionModel *)getProductModelWith:(NSDictionary *)infoDic
{
    ProductionModel * model = [[ProductionModel alloc]init];
    model.name = [infoDic objectForKey:kProductName];
    model.modelId = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kProductId]];
    model.imageUrl = [infoDic objectForKey:kProductIcon];
    model.modelType = [[infoDic objectForKey:@"type"] integerValue];
    NSArray * groupList = [infoDic objectForKey:@"groupList"];
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 1:
        {
            // 音频
            for (int i = 0; i < [groupList count]; i++) {
                NSDictionary * groupInfo = [groupList objectAtIndex:i];
                NSArray * groupFileList = [groupInfo objectForKey:@"groupFileList"];
                for (NSDictionary * infoDic in groupFileList) {
                    if ([[infoDic objectForKey:@"fileType"] intValue] == 3) {
                        model.audioUrl = [infoDic objectForKey:kfileContent];
                    }
                }
            }
        }
            break;
        case 2:
        {
            // 写作
            for (int i = 0; i < [groupList count]; i++) {
                TextProductModel * textModel = [[TextProductModel alloc]init];
                textModel.textModelId = [NSString stringWithFormat:@"%d",i];
                NSDictionary * groupInfo = [groupList objectAtIndex:i];
                NSArray * groupFileList = [groupInfo objectForKey:@"groupFileList"];
                for (NSDictionary * infoDic in groupFileList) {
                    if ([[infoDic objectForKey:@"fileType"] intValue] == 2) {
                        textModel.textImageUrl = [infoDic objectForKey:kfileContent];
                    }else if ([[infoDic objectForKey:@"fileType"] intValue] == 1)
                    {
                        textModel.text = [infoDic objectForKey:kfileContent];
                        textModel.colorStr = [infoDic objectForKey:@"textColor"];
                    }
                }
                [model.textProductArray addObject:textModel];
            }
        }
            break;
        case 3:
        {
            // 视频
            for (int i = 0; i < [groupList count]; i++) {
                NSDictionary * groupInfo = [groupList objectAtIndex:i];
                NSArray * groupFileList = [groupInfo objectForKey:@"groupFileList"];
                for (NSDictionary * infoDic in groupFileList) {
                    if ([[infoDic objectForKey:@"fileType"] intValue] == 4) {
                        model.videoUrl = [infoDic objectForKey:kfileContent];
                    }
                }
            }
        }
            break;
        case 4:
        {
            // 绘本
            for (int i = 0; i < [groupList count]; i++) {
                ImageProductModel * imageModel = [[ImageProductModel alloc]init];
                imageModel.imageModelId = [NSString stringWithFormat:@"%d", i];
                NSDictionary * groupInfo = [groupList objectAtIndex:i];
                imageModel.fanleImageUrl = [groupInfo objectForKey:@"fileIcon"];
                NSArray * groupFileList = [groupInfo objectForKey:@"groupFileList"];
                
                for (NSDictionary * infoDic in groupFileList) {
                    if ([[infoDic objectForKey:@"fileType"] intValue] == 1) {
                        imageModel.text = [infoDic objectForKey:kfileContent];
                        imageModel.colorStr = [infoDic objectForKey:@"textColor"];
                        imageModel.textTop = [[infoDic objectForKey:ktextTop] intValue];
                        imageModel.textLeft = [[infoDic objectForKey:ktextTop] intValue];
                    }else if ([[infoDic objectForKey:@"fileType"] intValue] == 2)
                    {
                        imageModel.originImageUrl = [infoDic objectForKey:kfileContent];
                    }else if ([[infoDic objectForKey:@"fileType"] intValue] == 3)
                    {
                        imageModel.audioUrl = [infoDic objectForKey:kfileContent];
                    }
                }
                [model.imageProductArray addObject:imageModel];
            }
        }
            break;
            
        default:
            break;
    }
    
    return model;
}

+ (ProductionModel *)getRecordProductModelWith:(NSDictionary *)infoDic
{
    ProductionModel * model = [[ProductionModel alloc]init];
    model.name = [infoDic objectForKey:kProductName];
    model.modelId = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kProductId]];
    model.imageUrl = [infoDic objectForKey:kProductIcon];
    model.modelType = ProductModelType_photo;
    NSArray * groupList = [infoDic objectForKey:@"partFileList"];
    
    // 绘本
    for (int i = 0; i < [groupList count]; i++) {
        ImageProductModel * imageModel = [[ImageProductModel alloc]init];
        NSDictionary * groupInfo = [groupList objectAtIndex:i];
        NSArray * groupFileList = [groupInfo objectForKey:@"pageFile"];
        
        for (NSDictionary * infoDic in groupFileList) {
            if ([[infoDic objectForKey:@"fileType"] intValue] == 3) {
                
            }else if ([[infoDic objectForKey:@"fileType"] intValue] == 1)
            {
                imageModel.originImageUrl = [infoDic objectForKey:kfileSrc];
                imageModel.fanleImageUrl = [infoDic objectForKey:kfileSrc];
            }else if ([[infoDic objectForKey:@"fileType"] intValue] == 2)
            {
                imageModel.audioUrl = [infoDic objectForKey:kfileSrc];
            }
        }
        [model.imageProductArray addObject:imageModel];
    }
    
    return model;
}


- (void)getUrl:(PHAsset *)phasset
{
    __weak typeof(self)weakSelf = self;
    
    [[GetPhassetUrl shareSoftManager] getPHAssetwith:phasset Url:^(NSURL *url) {
        weakSelf.sandBoxFilePath = [url path];
        
        NSLog(@"%@\nsandBoxFilePath = %@", url, weakSelf.sandBoxFilePath);
    }];
    
    return;
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:phasset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        AVURLAsset *urlAsset = (AVURLAsset *)asset;
        
        weakSelf.assetFilePath = urlAsset.URL;
        
        NSData *data = [NSData dataWithContentsOfURL:weakSelf.assetFilePath];
        weakSelf.fileData = data;
        NSLog(@"weakSelf.assetFilePath = %@", weakSelf.assetFilePath);
        
        weakSelf.filename = [NSString stringWithFormat:@"%@.mp4",[self getCurrentTime:@"YYYYMMddHHmmss"]];
        NSLog(@"weakSelf.filename = %@", weakSelf.filename);
        
    }];
}

+ (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        if (url) {
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *imagePath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
                NSString *dbFilePath = [imagePath stringByAppendingPathComponent:fileName];
                char const *cvideoPath = [dbFilePath UTF8String];
                FILE *file = fopen(cvideoPath, "a+");
                if (file) {
                    const int bufferSize = 11024 * 1024;
                    // 初始化一个1M的buffer
                    Byte *buffer = (Byte*)malloc(bufferSize);
                    NSUInteger read = 0, offset = 0, written = 0;
                    NSError* err = nil;
                    if (rep.size != 0)
                    {
                        do {
                            read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                            written = fwrite(buffer, sizeof(char), read, file);
                            offset += read;
                        } while (read != 0 && !err);//没到结尾，没出错，ok继续
                    }
                    // 释放缓冲区，关闭文件
                    free(buffer);
                    buffer = NULL;
                    fclose(file);
                    file = NULL;
                }
            } failureBlock:nil];
        }
    });
}

+ (void) convertVideoWithModel:(ProductionModel *) model
{
    
    model.filename = [NSString stringWithFormat:@"222.mp4"];
    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
    model.sandBoxFilePath = [videoPath stringByAppendingPathComponent:model.filename];
    
    
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:model.assetFilePath options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:model.sandBoxFilePath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        NSLog(@"%d",exportStatus);
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
                NSData *data = [NSData dataWithContentsOfFile:model.sandBoxFilePath];
                model.fileData = data;
            }
        }
    }];
}

// 系统时间
- (NSString*)getCurrentTime:(NSString*)formatter{
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
@end
