//
//  SelectDayView.h
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDayView : UIView

@property (nonatomic, copy)void(^SelectDayBlock)(NSDate * date);

@property (nonatomic, copy)void(^nextWeekBlock)(NSDate * date, NSDate * currentDate);
@property (nonatomic, copy)void(^previousWeekBlock)(NSDate * date, NSDate * currentDate);

- (void)resetTiday;

- (void)refreshCurrentWeekCourse;

@end
