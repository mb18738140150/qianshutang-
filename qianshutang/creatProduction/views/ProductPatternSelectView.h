//
//  ProductPatternSelectView.h
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProDuctPatternType_recoard,
    ProDuctPatternType_text,
    ProDuctPatternType_film,
    ProDuctPatternType_video,
    ProDuctPatternType_photo,
    ProDuctPatternType_photograph,
    ProDuctPatternType_graffiti,
    ProDuctPatternType_Metarial
} ProDuctPatternType;

@interface ProductPatternSelectView : UIView

@property (nonatomic, copy)void(^ProductPatternSelectBlock)(ProDuctPatternType type);

@property (nonatomic, copy)void(^textBlock)(NSDictionary * infoDic);

- (instancetype)initWithFrame:(CGRect)frame withPhoto:(BOOL)isPhoto;

- (instancetype)initWithFrame:(CGRect)frame withPhoto:(BOOL)isPhoto andDoTask:(BOOL)isDoTask;

-(instancetype)initWithFrame:(CGRect)frame withText:(NSString *)text;

- (instancetype)initWithFrame:(CGRect)frame andVideoPhoto:(BOOL)isVideoPhoto;

- (instancetype)initWithFrame:(CGRect)frame andVideo:(BOOL)isVideo;

- (void)resetTextColor:(NSString *)colorStr;

- (void)preparePhotoProductSelectView;

- (void)dismiss;

@end
