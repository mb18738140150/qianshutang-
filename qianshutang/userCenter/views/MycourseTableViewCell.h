//
//  MycourseTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycourseTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * courseLB;
@property (nonatomic, strong)UILabel * teacherLB;
@property (nonatomic, strong)UILabel * classroomLB;
@property (nonatomic, strong)UILabel * progressLB;
@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, assign)BOOL isCourse;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
