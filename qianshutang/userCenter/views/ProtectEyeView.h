//
//  ProtectEyeView.h
//  qianshutang
//
//  Created by aaa on 2018/8/9.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProtectEyeView : UIView

@property (nonatomic, copy)void(^changeProtectTimeBlock)(NSString *time);

@end
