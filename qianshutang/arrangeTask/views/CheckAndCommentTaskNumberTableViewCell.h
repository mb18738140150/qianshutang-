//
//  CheckAndCommentTaskNumberTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckAndCommentTaskNumberTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UILabel * nameLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
