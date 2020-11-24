//
//  CourseTimePickerView.h
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTimePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)appearWithTitle:(NSString *)title subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle;

@end
