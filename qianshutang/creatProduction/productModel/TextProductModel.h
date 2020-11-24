//
//  TextProductModel.h
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextProductModel : NSObject

@property (nonatomic, strong)NSString * textModelId;
@property (nonatomic, strong)UIImage * textImage;
@property (nonatomic, strong)NSString * textImageUrl;

@property (nonatomic, strong)NSString * text;
//@property (nonatomic, strong)NSDictionary * attribute;
@property (nonatomic, strong)NSString * colorStr;

@end
