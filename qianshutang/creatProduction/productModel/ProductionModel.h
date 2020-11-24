//
//  ProductionModel.h
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductModelType_nomal,
    ProductModelType_music,
    ProductModelType_text,
    ProductModelType_video,
    ProductModelType_photo
} ProductModelType;

@interface ProductionModel : NSObject

@property (nonatomic, strong)NSString * modelId;
@property (nonatomic, assign)ProductModelType modelType;
@property (nonatomic, strong)NSString * name;
@property (nonatomic, strong)UIImage * image;
@property (nonatomic, strong)NSString * imageUrl;
@property (nonatomic, assign)int userWorkId;

@property (nonatomic, assign)BOOL isPad;

@property (nonatomic, strong)NSString * musicPath;
@property (nonatomic, strong)NSString * audioUrl;// 上传录音后获得的录音链接

@property (nonatomic, strong)NSMutableArray * textProductArray;

@property (nonatomic, strong)NSMutableArray * imageProductArray;

// 视频信息
@property (nonatomic, strong)PHAsset * phAsset;// 相册视频数据源
@property (nonatomic, strong)NSURL * assetFilePath;// 相册视频路径，不能用于直接上传
@property (nonatomic, strong)NSData * fileData;
@property (nonatomic, strong)NSString * filename;
@property (nonatomic, strong)NSString * sandBoxFilePath;// 相册视频保存在沙盒缓存的路径，用于上传
@property (nonatomic, strong)NSString * videoUrl;// 上传后获得的视频链接

- (void)getUrl:(PHAsset *)phasset;
+ (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName;

+ (ProductionModel *)getProductModelWith:(NSDictionary *)infoDic;
+ (ProductionModel *)getRecordProductModelWith:(NSDictionary *)infoDic;
@end
