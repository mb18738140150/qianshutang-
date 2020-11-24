//
//  StudentTaskComplateProgressTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTaskComplateProgressTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * studentNameLB;
@property (nonatomic, strong)UILabel * classroomLB;
@property (nonatomic, strong)UILabel * progressLB;

- (void)refreshWith:(NSDictionary *)infoDic;
@end
