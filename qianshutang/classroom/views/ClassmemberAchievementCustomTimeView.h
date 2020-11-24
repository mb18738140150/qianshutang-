//
//  ClassmemberAchievementCustomTimeView.h
//  qianshutang
//
//  Created by aaa on 2018/9/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassmemberAchievementCustomTimeView : UIView


@property (nonatomic, copy)void(^continueBlock)(NSDictionary * infoDic);
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end
