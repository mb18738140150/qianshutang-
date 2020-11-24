//
//  MtTaskAttendanceTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MtTaskAttendanceTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * sectionLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UILabel * costLB;
@property (nonatomic, strong)UIButton * checkbtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^CheckCourseBlock)(NSDictionary *infoDic);

- (void)refreshWithInfo:(NSDictionary *)infoDic;

@end
