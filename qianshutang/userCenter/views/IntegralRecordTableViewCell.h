//
//  IntegralRecordTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralRecordTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * integralLB;
@property (nonatomic, strong)UILabel * wayLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * remarkLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
