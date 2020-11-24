//
//  ProtectEyeTimeView.h
//  qianshutang
//
//  Created by aaa on 2018/8/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProtectEyeTimeView : UIView

@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void(^NotifySelectBlock)(NSString * notifyType);

- (instancetype)initWithFrame:(CGRect)frame andTime:(NSString *)time;

@end
