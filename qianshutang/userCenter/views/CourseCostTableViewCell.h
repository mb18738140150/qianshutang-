//
//  CourseCostTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCostTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * classroomLB;
@property (nonatomic, strong)UILabel * courseCostLB;
@property (nonatomic, strong)UILabel * surplusLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
