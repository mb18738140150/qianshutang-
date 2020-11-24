//
//  Teacher_classroomTaskListCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teacher_classroomTaskListCell : UITableViewCell
@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * checkBtn;

@property (nonatomic, copy)void (^teacher_ClassroomTaskOperationBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, strong)NSDictionary * infoDic;
- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
