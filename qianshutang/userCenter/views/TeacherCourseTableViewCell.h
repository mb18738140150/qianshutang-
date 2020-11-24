//
//  TeacherCourseTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCourseTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * courseLB;
@property (nonatomic, strong)UILabel * classroomLB;
@property (nonatomic, strong)UILabel * progressLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UILabel * stateLB;

@property (nonatomic, assign)BOOL isCourse;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
