//
//  GetPhassetUrl.h
//  qianshutang
//
//  Created by aaa on 2018/9/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPhassetUrl : NSObject

+ (instancetype)shareSoftManager;

- (void)getPHAssetwith:(PHAsset *)assetNew Url:(void(^)(NSURL* url))UrlBlk;

@end
