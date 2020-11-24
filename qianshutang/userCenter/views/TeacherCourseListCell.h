//
//  TeacherCourseListCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCourseListCell : UITableViewCell

@property (nonatomic, strong)UILabel * sectionLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * rateLB;
@property (nonatomic, strong)UIButton * operationBtn;
@property (nonatomic, strong)UIButton * deleteBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, assign)BOOL isDelete;

@property (nonatomic, copy)void(^editBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^deleteCourseBlock)(NSDictionary * infoDic);

- (void)resetWithInfoDic:(NSDictionary *)infoDic;
@end
