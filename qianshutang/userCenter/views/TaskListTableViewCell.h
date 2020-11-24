//
//  TaskListTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListTableViewCell : UITableViewCell


@property (nonatomic, strong)UILabel * taskTypeLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * bookNameLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * doBtn;

@property (nonatomic, copy)void(^DotaskBlock)(DoTaskType type,NSDictionary * infoDic);
@property (nonatomic, strong)NSDictionary * infoDic;

- (void)refreshWith:(NSDictionary *)infoDic;

@end
