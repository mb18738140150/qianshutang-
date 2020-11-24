//
//  GenderSelectView.h
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderSelectView : UIView

@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void(^genderSelectBlock)(NSString * gender);

- (instancetype)initWithFrame:(CGRect)frame andGender:(NSString *)gender;

@end
