//
//  GraffitiView.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraffitiView : UIView

@property (nonatomic, strong)UIImage * image;
@property (nonatomic, copy)void(^backBlock)();
@property (nonatomic, copy)void(^GetLibraryImageBlock)();
@property (nonatomic, copy)void(^SavaGraffitiBlock)(UIImage * image);


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

- (void)resetWithImage:(UIImage *)image;

- (UIImage *)getGraffitiImage;

@end
