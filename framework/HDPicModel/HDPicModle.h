//
//  HDPicModle.h
//  TeamsHit
//
//  Created by 仙林 on 16/7/7.
//  Copyright © 2016年 仙林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDPicModle : NSObject
/**
 *  上传的图片的名字
 */
@property (nonatomic, copy) NSString *picName;

/**
 *  上传的图片的本地路径
 */
@property (nonatomic, copy) NSString *picFile;

/**
 *  上传的图片
 */
@property (nonatomic, strong, nullable) UIImage *pic;

/**
 *  上传的二进制文件
 */
@property (nonatomic, strong) NSData *picData;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSString *url;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSURL *videoUrl;
@end
NS_ASSUME_NONNULL_END
