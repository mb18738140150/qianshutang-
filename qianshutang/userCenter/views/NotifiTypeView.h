//
//  NotifiTypeView.h
//  qianshutang
//
//  Created by aaa on 2018/8/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifiTypeView : UIView

@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void(^NotifySelectBlock)(NSString * notifyType);

- (instancetype)initWithFrame:(CGRect)frame andType:(NSString *)type;

@end
