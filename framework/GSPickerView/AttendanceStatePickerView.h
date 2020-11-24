//
//  AttendanceStatePickerView.h
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/5.
//  Copyright © 2018 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceStatePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)appearWithTitle:(NSString *)title subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle;


@end


