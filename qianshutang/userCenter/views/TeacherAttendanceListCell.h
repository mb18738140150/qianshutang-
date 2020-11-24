//
//  TeacherAttendanceListCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAttendanceListCell : UITableViewCell

@property (nonatomic, strong)UILabel * studentLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * costLB;
- (void)resetWithInfoDic:(NSDictionary *)infoDic;
@end
