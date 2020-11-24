//
//  MessageOfRequestTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageOfRequestTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UIButton * agreeBtn;
@property (nonatomic, strong)UIButton * rejectBtn;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
