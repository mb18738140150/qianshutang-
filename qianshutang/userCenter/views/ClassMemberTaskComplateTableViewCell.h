//
//  ClassMemberTaskComplateTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassMemberTaskComplateTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * memberLB;
@property (nonatomic, strong)UILabel * progressLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
