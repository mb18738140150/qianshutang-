//
//  TextPositionView.h
//  qianshutang
//
//  Created by aaa on 2018/8/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextPositionView : UIView

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text andColor:(NSString *)colorStr andImage:(UIImage *)image;


@property (nonatomic, copy)void(^textPositionBlock)(CGPoint positionPoint,NSDictionary * infoaDic,UIImage * image);

@property (nonatomic, copy)void(^textPositionRectBlock)(CGRect positionRect,CGRect imageRect,NSDictionary * infoaDic,UIImage * image);

@property (nonatomic, strong)UIImage * image;
@property (nonatomic, strong)NSString * text;
@property (nonatomic, strong)UIColor * color;
@property (nonatomic, strong)NSString * colorStr;

- (void)cancelAction;

@end
