//
//  MessageDetailTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * contentLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
