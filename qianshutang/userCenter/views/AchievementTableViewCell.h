//
//  AchievementTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * starLB;
@property (nonatomic, strong)UILabel * flowerLB;
@property (nonatomic, strong)UILabel * goldLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
