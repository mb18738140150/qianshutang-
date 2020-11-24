//
//  StudentProductTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentProductTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * bookNameLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * commentLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
