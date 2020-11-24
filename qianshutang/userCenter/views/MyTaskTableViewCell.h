//
//  MyTaskTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * checkBtn;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
