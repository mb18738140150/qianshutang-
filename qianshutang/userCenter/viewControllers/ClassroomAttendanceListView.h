//
//  ClassroomAttendanceListView.h
//  qianshutang
//
//  Created by aaa on 2018/11/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassroomAttendanceListView : UIView

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * titleArray;
@property (nonatomic, strong)NSMutableArray * imageArray;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)refreshUIWith:(NSDictionary *)infoDic andDataArray:(NSArray *)dataArray andPage:(int)day;

@end
