//
//  XilieTaskYulanSelectDayView.h
//  qianshutang
//
//  Created by aaa on 2018/10/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XilieTaskYulanSelectDayView : UIView

@property (nonatomic, copy)void(^SelectDayBlock)(int day);

@property (nonatomic, copy)void(^nextWeekBlock)(NSDate * date, NSDate * currentDate);
@property (nonatomic, copy)void(^previousWeekBlock)(NSDate * date, NSDate * currentDate);

- (void)resetTaskCount:(NSInteger)count;

- (void)refreshCurrentWeekCourse;

@end
