//
//  ImageProductModel.h
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageProductModel : NSObject

@property (nonatomic, strong)NSString * imageModelId;// 图片id
@property (nonatomic, strong)UIImage * textImage; // 文字截图
@property (nonatomic, strong)UIImage * originImage;// 原图
@property (nonatomic, strong)NSString * originImageUrl;// 原图路径

@property (nonatomic, strong)NSString * musicPath;// 本地录音路径
@property (nonatomic, strong)NSString * audioUrl;// 录音链接

@property (nonatomic, strong)UIImage * fanleImage;// 最终图片
@property (nonatomic, strong)NSString * fanleImageUrl;// 最终图片链接

@property (nonatomic, strong)NSString * text;
//@property (nonatomic, strong)NSDictionary * attribute;
@property (nonatomic, strong)NSString *colorStr;

@property (nonatomic, assign)CGRect backRect;
@property (nonatomic, assign)CGPoint textPoint;
@property (nonatomic, assign)CGRect tetRect;

@property (nonatomic, assign)float   textTop;
@property (nonatomic, assign)float   textLeft;

@end
